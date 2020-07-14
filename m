Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DF9C433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 15:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4712A22285
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 15:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oiT7KayS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgGNPf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:35:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59420 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgGNPf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 11:35:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D3976ECA0;
        Tue, 14 Jul 2020 11:35:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C/FSIKLhybG03BI7audaLG4qNCk=; b=oiT7Ka
        ySAvKFO0nejLKKAyKS/DvvczmAkoT1RuBAL3syDyTp8IktiozvoOjkHSAs/UpBXN
        ifO0bbJjY7ctF/sxV5NkAwFVqvd1Ty0yVry9kpHL7SmmC2XiOcVUqqXrAdYvAhrF
        JQXbhaI06mXCp49jOWRUs7/2/kc599nreWikE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EldF0sugvQapOHkI8fsMaYYbYyUwtjl+
        zNM+p91a84Hy0vrO2GDny9/InKAkzSAR8rydZSPTRKV017XTyHjChb+QZPCQn6Mw
        9YgQHaB1ZYYZz6rJBA5D4kkVtQ5Yq5ecqL+GAWlHJ1xWrNcFVqplkey9xn1w/Hem
        azUStzoFAD8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35F526EC9F;
        Tue, 14 Jul 2020 11:35:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD4AF6EC9E;
        Tue, 14 Jul 2020 11:35:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jason Xu <jasonx98@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Force git diff to create a binary patch?
References: <CAGPh-qNrjQ5xwbPcfJdBqrqOJQsVpa2hy-XHwN-8rhPPZe4Vpg@mail.gmail.com>
        <20200713223906.GH8360@camp.crustytoothpaste.net>
        <CAGPh-qPyTNidqT=K-U8iYtG3udFZVFBhE1RyA1AZ1qEqN_NnZw@mail.gmail.com>
        <xmqq4kqan290.fsf@gitster.c.googlers.com>
        <CAGPh-qPH+gGYHCy+rQJvzwr-Vp71UJxwr+w-G9GaV_o40K8P-Q@mail.gmail.com>
Date:   Tue, 14 Jul 2020 08:35:54 -0700
In-Reply-To: <CAGPh-qPH+gGYHCy+rQJvzwr-Vp71UJxwr+w-G9GaV_o40K8P-Q@mail.gmail.com>
        (Jason Xu's message of "Tue, 14 Jul 2020 00:56:07 -0400")
Message-ID: <xmqqv9iqkt2d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B54A77E4-C5E7-11EA-AF92-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Xu <jasonx98@gmail.com> writes:

>> The "--binary" option was invented as a way to tell Git to
>> produce something that can be applied, where Git stopped at
>> saying "binary files differ".
>
> Doesn't `--text` already do that? Albeit with whitespace warnings.

I do not think so.  --text is about forcing everything to be treated
text, so you'll not see binary patches but the patch-looking thing
with binary garbage you wrote in the message that started this
thread.  IOW, that is the opposite of what you want.  And I agree
that such a "diff -a" output is prone to corruption during transfer
(e.g. over e-mail) and a way to tell exactly which paths should be
shown as binary patches is a good thing to have.

> That's why I propose better binary file detection, instead of (what I
> understand to be) "make all patches in a patch file GIT binary
> patches, regardless if a file is text".

Oh, I agree that "treat everything as binary and produce binary
patch for all paths" is a nonsense option no sane person would want
to use.  The users are better off exchanging bundles at that point,
as such a binary-only patches are unreadable anyway.

There is no "better detection"; the only thing you could get is
"better heuristics" and there will always be a limit to what
heuristics can do for you.  

And that is why you were given gitattributes very early in the
discussion ;-)  That is the mechanism to tell exactly which paths
should be treated as binary.
