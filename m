Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C71C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78AB20737
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gNA/XqY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389511AbgDBRrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:47:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62817 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389166AbgDBRrK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 13:47:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1EB84CBD6F;
        Thu,  2 Apr 2020 13:47:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jhXxN8/7EGx4
        IFtIRv8dHFszQbM=; b=gNA/XqY0+W1gdWnhHLZZwcysevNGZ5pLrh+43mhAlISS
        VW/XdWALHpm9Dp5ucytk14VAz04b2Pe/folMQ2yJm8KOmGthiCQUwEOZ9eMNp1FZ
        5uV++b71T7qvGlK79/HClfR/VWuSjGgZKvW2ZZZEiseiPAmikNJa90OsmjptjDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IlNAtA
        lENIEX8qGrlNun6Et11Ny+Zbxh4JNCJuh+dwbhnx6q/PD360xKH4u2fikh+Js215
        wFdeQQ2wXqIcJNUR4vXdJ9wgCDPaLEFoYd5KgojjxiXR7BFtu3pxl5i1Xer4ROqC
        Um0mIz/g/ftDY4swKB7gA+E8EAwEUZF6RzvMM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 154ECCBD6E;
        Thu,  2 Apr 2020 13:47:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 581A8CBD6D;
        Thu,  2 Apr 2020 13:47:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        ch <cr@onlinehome.de>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [REGRESSION] gitk can't be run from non-worktree folders
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
        <20200123163151.GC6837@szeder.dev>
        <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
Date:   Thu, 02 Apr 2020 10:47:00 -0700
In-Reply-To: <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 23 Jan 2020 11:36:49 -0500")
Message-ID: <xmqqwo6x3hm3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F5983DD8-7509-11EA-98E5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> [cc:+peff]
>
> On Thu, Jan 23, 2020 at 11:32 AM SZEDER G=C3=A1bor <szeder.dev@gmail.co=
m> wrote:
>> On Thu, Jan 23, 2020 at 05:04:09PM +0100, ch wrote:
>> > I recently updated my Git installation from 2.24.1.windows.2 to
>> > 2.25.0.windows.1 and from the looks of it the included version of gi=
tk does not
>> > support being run from non-worktree folders of a repository anymore =
(like the
>> > .git folder for example).
>> I've stumbled upon the same issue when I tried to run 'gitk' in a bare
>> repository a while ago, but it refused to run with the same error
>> message.
>>
>> Are you sure it's a recent regression?  I have no experience with
>> 'gitk' in Git for Windows, but on Linux this has been broken for quite
>> some time, namely since 784b7e2f25 (gitk: Fix "External diff" with
>> separate work tree, 2011-04-04) in the v1.7 era.  FWIW, reverting that
>> commit on top of v2.25.0 makes 'gitk' work again in bare repositories.
>
> It's a new regression introduced by 2d92ab32fd (rev-parse: make
> --show-toplevel without a worktree an error, 2019-11-19), as far as I
> can tell. I have many times used gitk on bare repositories as an
> interactive replacement for git-log, so this is a unfortunate bit of
> fallout from that change. That's not to say that 2d92ab32fd should be
> reverted, though... perhaps gitk itself needs a bit of a fix.

I thought we already saw a patch to do so?

    https://lore.kernel.org/git/20200123192638.GA3177@flurp.local/

perhaps?

Paul?
