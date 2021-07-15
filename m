Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC0C636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03572613C7
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhGORtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhGORtc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:49:32 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE2AC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:46:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id l26so7590841oic.7
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=CQsj2FjHoiW/u9WKjx5w2gE9YfKyIPg2kVGR+ddJ/B4=;
        b=QiD1N4XxZIjFU4N4ZiFZMH6FxBLkT4xNOne8uqFJmTNUxSI7phJ6adcAYgzo5tuK12
         GBWpKJhxEvbOB4tyvYdxQNYp9hr/Lznqqfh73SV5Z7drvbQjip9TB40nDrpvozFBno+f
         bUHWpVKTvTIXttBGT2DfzwDUuPj3ZHmYSB/isqD7sm63cvpf6ywi3t+KqrxuTAKn1GH0
         x++zSPpBQY7kxXpnqmNrWndmj4ATuF4WH+sBE7Wfm/TqsM5A8NK5jqlRcyFFll6xizi7
         R3L1tzH0r+RTHYwlfFk98mFLzhk3GNnDblNvs9Q0uOPbeTnlOR/kZ9pz4MesxzIKh74c
         Elhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=CQsj2FjHoiW/u9WKjx5w2gE9YfKyIPg2kVGR+ddJ/B4=;
        b=WdHRuTQ6QgtDcQBgr+44W5N/wgTd1kWddANDlO+lck3f++XdwM+ktUrKJa0ypLZQl7
         mD+tkGrm+xGMLmk6IHe6ndEGATjWIpek1s0B2ZBNgm4NMQJwCM+XbRI7dmZs40J4GKck
         z2xlmBSdRpgo56aQxaOdZ++r71HRxR7Ge7vOqifTjSSpVwYbOqIR+jwQ1xCoXF3jBQl4
         zuAv5FvGdpjS2KjFE1VvpIDIzrZ3dK2Jy5fr/iX3SJCeYb827wvoszn1l2cnPSm1zBAl
         Jkgm0yUWDCFmP3MRTWKfLXbg9THp8j6aB/DYqj0b9mAv6RbtK2bdYZcWB6V68pKULPdf
         r3Ew==
X-Gm-Message-State: AOAM530RMoWNoTpwxxK1L2v8mO6+2gipNa1quuRrvqtLMdqGnnaXsqlf
        OMgAE18mSKql3jfaQfG3AC3dONDK9kmgvw==
X-Google-Smtp-Source: ABdhPJwhEGL8Wf/fNqs5Q7SPlNkhzZTZgeA4KtNDEPDD/XEut2XxAGYfbcO90yvZhWM+r7jQhJTijw==
X-Received: by 2002:aca:7589:: with SMTP id q131mr8515268oic.76.1626371197129;
        Thu, 15 Jul 2021 10:46:37 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id g1sm1237251otk.21.2021.07.15.10.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 10:46:36 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:46:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f0747b149eb_4b682084c@natae.notmuch>
In-Reply-To: <xmqq7dhrtrc2.fsf@gitster.g>
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
 <xmqq7dhrtrc2.fsf@gitster.g>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> > --- a/Documentation/config/pull.txt
> > +++ b/Documentation/config/pull.txt

> >  pull.rebase::
> >  	When true, rebase branches on top of the fetched branch, instead
> >  	of merging the default branch from the default remote when "git
> >  	pull" is run. See "branch.<name>.rebase" for setting this on a
> > -	per-branch basis.
> > +	per-branch basis.  Incompatible with pull.ff.
> 
> Likewise.
> 
> I think it technically is OK to say "only ff update is allowed" or
> "ff update is allowed when able" while saying pull.rebase=yes.  
> 
>  - For those who say ff=only, the actual value of pull.rebase would
>    not matter (i.e. the integration immediately finishes by updating
>    to what was obtained from the upstream because there is no new
>    development on our own on top of theirs to either replay or
>    merge).
> 
>  - For those who merely allow ff, an update may fast-forward even
>    when pull.rebase is set to true (or any non-false value), while
>    we'll replay our own development on top of theirs when their
>    history is not descendent of ours.
> 
> So I do not see need to declare these combinations "incompatible".
> But perhaps I am missing some subtle cases?

Doing such a thing would be wrong. As I already explained multiple
times, pull.rebase can be overriden by the command line. When doing
--merge we want to honor pull.ff, when we don't we want to ignore it.

Since both Elijah and Junio have muted me, and they keep making these
mistakes, can anybody else forward this point to them?

Cheers.

-- 
Felipe Contreras
