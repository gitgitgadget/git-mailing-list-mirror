Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C3BC433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 22:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D1164DE4
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 22:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhCEW2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 17:28:45 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53432 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEW2f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 17:28:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E85B1216B2;
        Fri,  5 Mar 2021 17:28:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zf9krmuq8npiemgHtoWRoK0lD1o=; b=YA+HX+
        IBAtzOF4hVI/mBqsoW9mGVMptfBL1UHTZ7NM5v8dXgDnq+sDIzEuffN0iqlqxjGh
        gsRgjgfMKEFJ/U1FgIxZM1Wx4csDRaVOWHc6zexU8V1ElxEYO8Odf56LqcbJVlvc
        cEhFJNqBnHW7xMNOehaSZQpuP6Krsg5K0g/Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t0st8UwHMKv72hYhOZo4j+vTAgBOYo7T
        jie6XGU83iy6EI75y2yA5dTPe6H/VxyVRLm7b7PHfUY3P8VbcB97y2i6ksBcrGp1
        mncCIsnT55huvsrImtCHYdXmQfM0oqIJ1JnfVHur5O/hxoghKRTwJcZfgUg8V5TP
        QYI9acCfKOQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 985CE1216B1;
        Fri,  5 Mar 2021 17:28:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C6A8C1216B0;
        Fri,  5 Mar 2021 17:28:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Michael Brown <michael.brown@discourse.org>,
        Git List <git@vger.kernel.org>
Subject: Re: "git diff-files" command reports differences that don't exist
References: <4210f5f1-dd7e-f425-6ab2-e220a33e82bf@discourse.org>
        <xmqqa6rh9sph.fsf@gitster.c.googlers.com>
        <CAPig+cSRKJUhwMagx_h21pJbBiX9paA5cvDbudDNcRVea6g3Mg@mail.gmail.com>
Date:   Fri, 05 Mar 2021 14:28:30 -0800
In-Reply-To: <CAPig+cSRKJUhwMagx_h21pJbBiX9paA5cvDbudDNcRVea6g3Mg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 5 Mar 2021 17:18:13 -0500")
Message-ID: <xmqq1rct9qwh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DB323D0-7E02-11EB-8D43-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Mar 5, 2021 at 4:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>> This is totally expected behaviour.  In general when you are working
>> with plumbing commands like diff-files and diff-index, you are
>> expected to do "update-index --refresh" upfront.
>>
>> A plumbing command "git diff" has an equivalent of "update-index
>> --refresh" built into it, but the plumbing commands are designed
>> to be used in scripts, and in order to allow scripting programmers
>> to avoid making unnecessary "update-index --refresh", e.g.
>
> Did you mean:
>
>     A porcelain command "git diff" has an equivalent...

Yes.
