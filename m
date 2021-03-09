Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECEC433E6
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7636528A
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 07:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhCIHNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 02:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCIHN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 02:13:29 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FCBC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 23:13:29 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q204so8758951pfq.10
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 23:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yNgkhTk5N3/1XBaUfFj0L3aNmitJC75/v7ciBvlE9+o=;
        b=PR4RtuX63+EN+9rguFQaV2kaaOjegx6RzQdJFS6tbcq8XrQHH0008yZf+Qxpw9uM81
         lqcmizYiG1lzpO0XuSFhzGiL6Q41CaiQFfBW9O2bJnnH4PBT8el/LmEL6mlJbG2ePwPB
         rLpDIphlhYgLYj07YPntLlv5403G+xAhmWfem6CyMTXWIxal+gdQHgeABiUA+Jl38Qdh
         xiq/QMDYn9j3BvcO4MwogGXFzVwtPU0VSNG8GOsbIq6TNsK1PF1huR92hWLbRTKDv99T
         2UW6Yr/jffJ48E3EVY18fYA0uVelFAR5WN5iCm8AYQ3gGRxubkCY6Lnj4HWi5HlXyzqb
         UEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yNgkhTk5N3/1XBaUfFj0L3aNmitJC75/v7ciBvlE9+o=;
        b=GwAFeFAT4QbWu7M41YZ6w2d4qriUOWiOHYbj5sn4GjurQLM/mXVfjFaMVwTrVlPdSP
         PK78CNYWivaLQcSNwu26rCdaK2Pp8AYQgiNEsqF/bOmBmTd3GlKoMbM71sjSm1fvo1Fp
         yMkYZNINjWNqO6yRSbR3b8GkF8JkA5fL6q6ZyGZnSZIs85MU67WXakqaTuYkBy7wZnrY
         LpeAplFd6elM2Fi9xzXkQcn15vVlJEvm6Z4wyD37o1FQ5r2WLG3HAngV8juh4f3IykYY
         ANJUA8PeiyXbLlXCXATMUoAmtOdI1Cuj1KX7Aq1sYXOgXV9zGPRva/u1aP1Ka7Uu7MDw
         PGhA==
X-Gm-Message-State: AOAM533dTtL1Rwy29nNaM+AzQi70s5vSE4P2gn423LqkFFNS3UJwLAX8
        xINGUxBCJ2YoztrOZJw7h4s=
X-Google-Smtp-Source: ABdhPJyOlKb4xGoVQuqLbqvxm4AH3F5n9vbsxV0WdH8NBafC6TUqAeLSthJKiUDRojiKebaib3iRgQ==
X-Received: by 2002:a62:1ad5:0:b029:1fa:c667:2776 with SMTP id a204-20020a621ad50000b02901fac6672776mr915928pfa.6.1615274009159;
        Mon, 08 Mar 2021 23:13:29 -0800 (PST)
Received: from konoha ([14.139.233.131])
        by smtp.gmail.com with ESMTPSA id b3sm11147231pgd.48.2021.03.08.23.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 23:13:28 -0800 (PST)
Date:   Tue, 9 Mar 2021 12:43:24 +0530
From:   Shourya Shukla <periperidip@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v2 1/1] rm: stage submodule removal from '.gitmodules'
 when using '--cached'
Message-ID: <20210309071324.GA14404@konoha>
References: <20210218184931.83613-1-periperidip@gmail.com>
 <20210222172623.69313-1-periperidip@gmail.com>
 <20210222172623.69313-2-periperidip@gmail.com>
 <xmqqo8gb7vf9.fsf@gitster.g>
 <20210307164644.GA8702@konoha>
 <xmqqblbu907p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqblbu907p.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/03 12:29, Junio C Hamano wrote:
> Shourya Shukla <periperidip@gmail.com> writes:
> 
> > On 22/02 11:29, Junio C Hamano wrote:
> >> Shourya Shukla <periperidip@gmail.com> writes:
> >> 
> >> > +	if (git_config_rename_section_in_file(index_only ? GITMODULES_INDEX :
> >> > +					      GITMODULES_FILE, sect.buf, NULL) < 0) {
> >> 
> >> Also, is it really sufficient to pass GITMODULES_INDEX as the first
> >> argument to this function to tweak what is in the index?
> >> 
> >> git_config_copy_or_rename_section_in_file() which is the
> >> implementation of that helper seems to always want to work with a
> >> file that is on disk, by making unconditional calls to
> >> hold_lock_file_for_update(), fopen(), fstat(), chmod(), etc.
> >> 
> >> So I suspect that there are much more work needed.  
> >
> > I am not able to comprehend _why_ we need so much more work. To me it
> > seems to work fine.
> 
> > The flow now is something like:
> >
> > 1. If !index_only i.e., '--cached' is not passed then remove the entry
> > of the SM from the working tree copy of '.gitmodules' i.e.,
> > GITMODULES_FILE. If there are any unstaged mods in '.gitmodules', we do
> > not proceed with 'git rm'.
> 
> That side is fine, especially if we are extending the "when doing
> 'git rm PATH' (without '--cached'), PATH must match between the
> index and the working tree" to "when doing 'git rm SUBMODULE', not
> just SUBMODULE but also '.gitmodules' must match between the index
> and the working tree", then adjusting the entry for SUBMODULE in
> '.gitmodules' in the working tree and adding the result to the index
> would give the same result as editing '.gitmodules' both in the
> index and in the working tree independently.
> 
> But the problem is that there is no way "--cached" case would work
> with your code.
> 
> > What exactly do we need to change then?
> 
> Have you traced what happens when you make this call
> 
> >> > +	if (git_config_rename_section_in_file(index_only ? GITMODULES_INDEX :
> >> > +					      GITMODULES_FILE, sect.buf, NULL) < 0) {
> 
> with index_only set?  i.e. GIT_MODULES_INDEX passed as the
> config_filename argument?
> 
> The first parameter to the git_config_rename_section_in_file() names
> a filename in the working tree to be edited.  Writing ':.gitmodules'
> does not make the function magically work in-core without touching
> the working tree.  It will make it update a file (likely not
> tracked) whose name is ":.gitmodules" in the working tree, no?
> 
> Presumably you want to edit in-index .gitmodules without touching
> the working tree file, but the call is not doing that---and it would
> take much more work to teach it do so.
> 
> And a cheaper way out would be how I outlined in the message you are
> responding to, i.e. write out the in-index .gitmodules to a
> temporary file, let git_config_rename_section_in_file() tweak that
> temporary file, and add it back into the index.

Ahhh. Understood and will work on it. BTW then when does
GITMODULES_INDEX even fulfill its purpose? Its name can confuse anyone
into thinking what it made me think: it is the index copy of the
gitmodules.

Is it something which is to be changed in the near future?

