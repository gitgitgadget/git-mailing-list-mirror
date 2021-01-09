Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234B3C433E6
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50892388B
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbhAIWnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:43:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64441 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbhAIWnk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 17:43:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F7C39F01C;
        Sat,  9 Jan 2021 17:42:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=I6P1iUkr1x+g
        pb+mVFxvfna4aOM=; b=NtwU3BQndvZMtrsI5NW3IqYmXoEFN9J5fEKFzGr3gnHQ
        sNuA2qM00U80OJth1rfcslxU56r46HlCmLsTKFRUhwPJvDqlrTTvhjvkV0oD5RG6
        L/cfFsaZ9ECBD6C7sXNJ+t+LvYpbE0sgBlhhla50T5W028s/mIPJWVdMQ2gYuas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AZyTwy
        jLIyZsiwScrF9eau02lH/3azA9L2VFYWllYUrfPlz6GU27wFalJxAFBew6usjsyh
        Jeye8UiR7KkqUYXVk0rHiiJczrVqa17HHh3uS6Onf5r/De8l9dxzUET9r/6nFwKp
        eTBZVKpXIVwo1Fqy6frHe4IIt+HNpr42ZH9rQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06ACC9F01B;
        Sat,  9 Jan 2021 17:42:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 880119F01A;
        Sat,  9 Jan 2021 17:42:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Is t5516 somehow flakey only on macOS?
References: <xmqq35zbgd2a.fsf@gitster.c.googlers.com>
        <CAPig+cQ3U4s0qmzoLL=ZBeSyCZm=QqjWz2P36ZUxMzNAyYn-WQ@mail.gmail.com>
        <X/mGnY3wR1fGoxcf@coredump.intra.peff.net>
        <X/mJ6gHrKVxQqPX4@coredump.intra.peff.net>
        <20210109173336.GS8396@szeder.dev>
Date:   Sat, 09 Jan 2021 14:42:56 -0800
In-Reply-To: <20210109173336.GS8396@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sat, 9 Jan 2021 18:33:36 +0100")
Message-ID: <xmqqo8hxenpr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05017884-52CC-11EB-A818-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> Commit 014ade7484 (upload-pack: send ERR packet for non-tip objects,
>> 2019-04-13) added a test that greps the output of a failed fetch to ma=
ke
>> sure that upload-pack sent us the ERR packet we expected. But checking
>> this is racy; despite the argument in that commit, the client may stil=
l
>> be sending a "done" line when the server exits, causing it to die() on=
 a
>
> Nit: I think using the word "after" would make the problematic
> sequence of events a tad clearer, i.e. "... after the server has
> exited, ...".

Thanks everybody for helping with extra clarity.  I do find it
easier to follow with "after the server has exited" to picture
the sequence of events in my mind.
