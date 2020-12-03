Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E37C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7739221F2
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgLCUW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 15:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLCUW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 15:22:58 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16270C061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 12:22:18 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d20so4583191lfe.11
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 12:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EKogXTHcOo4PuycGPhWeg6JHIgmyHO5VqucG4p/zCrA=;
        b=KnZBcI3p+01FiVcL9UK8Hn9q3akdrBdymSg8XCYZl9PPsXFs0H6Wh/H70NOBig/Alq
         s29ZolVB0iKY7GSR5xh0/O5e96UUmVAPvHxeEfp6CZA5MXzfbrosO8v9iioh+MPZcvbL
         Ir6S3sWW9J4BUlK1h+eaoeRMUaxRHCgwpwfoMzLvWSS0+nC18y1yiEHL6QoB9dhJwjx+
         WzvGMmSWbC5WZa2eWtj92Be45KnUBiu7btJ4ZBaa8aWD1J9++wb+zEM3qXOBEOusGLPY
         /cIA7u9KlTVGWtmm6nhOo3wZpGmrqG6XIQ3il0aR+ENwxlwyIZMBFr58vb9IoMSiYkD8
         Y7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=EKogXTHcOo4PuycGPhWeg6JHIgmyHO5VqucG4p/zCrA=;
        b=tB4uXQ1bwAtIBgiaMM+2Mib7cnmgkJwazVDGE7ibemQNayom80o/9KV0l1yIlKHiNB
         zZJhme5q782faJJpViERwTVUdzbdSSDM+rcq6D10plR3N1JIZ/0uRYkDofb9hD7Dejum
         Vr+ZAcEBWLqHyAlOcfo+2lV03di+ZNTczGnLJv5+M+eRYf2tMteF3aF+bt89ZfDDT7KV
         vKiu+8Tza3IkIGux8ZuD0NiRSYnmpr/UkXtM/xo5cITU1IPDYhDDhsNFU/M8w6YPrzjT
         8oPW///cch37Dxv1JTy9fAQyFd1SFIN79PG4Tp77ekYEp0o2pE3Ctsm0qfxL2rzpV6tB
         XH1Q==
X-Gm-Message-State: AOAM531WIb6cJol96PM2uqzXdUaD6qZHsZN+s57fNEnW2NjPap+995vO
        FTq8AbSa358zygpceWhkP7bFqmW90+4=
X-Google-Smtp-Source: ABdhPJwBKyIkEZQnpk+X13eSxjb+oy2XMvoCeALKOxiotmsBhxetbzzE97Dd2mJMbACuWfuaV2sODw==
X-Received: by 2002:a05:6512:1056:: with SMTP id c22mr1917919lfb.179.1607026936172;
        Thu, 03 Dec 2020 12:22:16 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t12sm768394ljk.74.2020.12.03.12.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 12:22:15 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 07/27] diff-merges: move checks for first_parent_only
 out of the module
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-8-sorganov@gmail.com>
        <xmqq360nk859.fsf@gitster.c.googlers.com>
Date:   Thu, 03 Dec 2020 23:22:14 +0300
In-Reply-To: <xmqq360nk859.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 Dec 2020 17:09:22 -0800")
Message-ID: <87blfafxmx.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> The checks for first_parent_only don't in fact belong to this module,
>> as the primary purpose of this flag is history traversal limiting, so
>> get it out of this module and rename the
>>
>> diff_merges_first_parent_defaults_to_enable()
>>
>> to
>>
>> diff_merges_default_to_enable()
>
> Again, neither is a great name.
>
> More importantly, I do not think that I agree with the reasoning
> given in the first paragraph.  The first-parent-only traversal means
> that we pretend there is no second and later parents, so it makes
> quite a lot of sense that the choice of that option affects how a
> merge commit discovered during the traversal is show by default
> (namely, as if it is just a single-parent commit).

I have no objections against this behavior, nor did I change it, so I
don't understand what reasoning you disagree with.

The code that handles --first-parent now explicitly says it needs
corresponding format of diff output by default, exactly as you describe,
so what's the problem?

>
> If there are other reasons why we want to force the callers to check
> for first-parent option (for example, it may make it easier to tweak
> how each caller makes its decisions separately in later steps of
> this series), the changes proposed by this step may be a right
> solution, so I am not outright opposed to this patch, but the
> rationale given above is not a strong enough justification for the
> change, at least to me.
>
>> +void diff_merges_default_to_enable(struct rev_info *revs) {
>
> Perhaps "show_merges_by_default()".

Doesn't sound good to me either. We usually do show merges. We only
don't show any kind of diffs for them.

>
>> +	if (revs->ignore_merges < 0)		/* No -m */
>>  		revs->ignore_merges = 0;
>
> Perhaps "show_merges_in_cc_by_default()" (or "cc" spelled out as
> "dense_combined").

Well, I think it's better to discuss final names instead of intermediate
refactoring ones that will disappear anyway. At least as a fist step. If
we get them right, intermediates could be fixed accordingly more
easily, I think.


[...]

Thanks,
-- Sergey Organov
