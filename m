Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE8C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 18:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69DB922CB3
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 18:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgLSS1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 13:27:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55630 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgLSS1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 13:27:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A951411625D;
        Sat, 19 Dec 2020 13:26:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sUu9WZfMeJo16Yh3KfiBa7sHo78=; b=FT/46N
        CXg3FnrVVjA45i2N58qD7z8YNk6KgVplAZz5sbvIp4y2SXaCGXCk7qdXATyrl/30
        pOXh8V1zPWxNYWIRjL0wJJ50sk5e/gKVHkbW+ehGLsB8yXHFw3mHQItmP77Gpgtz
        mD46881UADL+69JmeOp1EzLZXgufoE+SwgDOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cGsgA1Uf6Gvig9d6wyubFT3ySUhJhrjK
        yrwZJyxjcWBFS5HSwcHWRAe3zPGvI8JQ6A9GyXHC947rBSuchEd77Wh6a1j57GOd
        P4MUoaEMQknnYYcLHjjvXMFjBf4FY1BPXV1kOb49siGEhtW+OBRcwq3Cn8W0QdgH
        Ro7Z0dS6NmU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A237D11625C;
        Sat, 19 Dec 2020 13:26:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ECB7A11625B;
        Sat, 19 Dec 2020 13:26:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Seth House <seth@eseth.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
References: <5fdaef83a40ba_d0e26208f6@natae.notmuch>
        <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
        <20201217094424.GA75257@ellen> <5fdb3471c6bb7_d6d032087@natae.notmuch>
        <20201217175037.GA80608@ellen>
        <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
        <20201218023534.GA117762@ellen>
        <5fdc18a91c402_f2faf20837@natae.notmuch>
        <20201218054947.GA123376@ellen>
        <5fdc7a7d3a933_f4673208d0@natae.notmuch>
        <20201219001358.GA153461@ellen>
        <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
        <5fdded2523e7e_1de0de208e1@natae.notmuch>
Date:   Sat, 19 Dec 2020 10:26:37 -0800
In-Reply-To: <5fdded2523e7e_1de0de208e1@natae.notmuch> (Felipe Contreras's
        message of "Sat, 19 Dec 2020 06:08:05 -0600")
Message-ID: <xmqqpn35odnm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBFA8C0C-4227-11EB-8ADB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Seth House <seth@eseth.com> writes:
>> 
>> > I think where we're not seeing eye-to-eye is that you're focusing on
>> > potential "negative" consequences whereas I'm talking about having more
>> > information about the merge rather than less.
>> >
>> > There is very likely no negative consequences for most, if not all,
>> > mergetools. I wrote the initial version of diffconflicts ten years ago
>> > and I've been using it nearly every day since. I'm fairly confident in
>> > the end result. What is a fact is there is undisputedly less information
>> > about the merge if we overwrite LOCAL and REMOTE; as I've written,
>> > I think the tradeoff is worthwhile for most tools but a per-tool
>> > configuration will allow people that feel differently to choose
>> > differently.
>> 
>> Thanks for stressing this point.
>> 
>> When a user or developer asks for a reasonable feature (e.g.
>> configurability to suit personal taste), especially when there is no
>> obvious downside for adding it, the burden of proof is on the party
>> who refuses to add it
>
> Sorry, but no.
>
> You may be the final word in the git project, but the burden of proof is
> an essential part of logic, not project-dependent, and that's just not
> the case.
>
> *Anyone* that makes any claim has the burden of proof.

Yes, and in this case, Seth already said he prefers to be able to
see the original, and not necessarily all the users of his mergetool
backend prefer the same thing.  That is enough "proof" to me that
the need exists.  It is your turn to prove your (implicit) claim
that it does more harm than it helps to allow such a preference
expressed by end users.

> Is there a conflict in this example?
>
>   echo Hello > BASE
>   echo Hello > LOCAL
>   echo Hello. > REMOTE
>   git merge-file -p LOCAL BASE REMOTE

Sorry, but I do not see why that example matters.  Would such a case
even come into the picture to be resolved by "git mergetool" in the
first place?

