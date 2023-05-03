Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF400C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjECSnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjECSnT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:43:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BEF8682
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:40:58 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3ef385482e9so8937591cf.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683139252; x=1685731252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0l9OTDlTzd8d3FEtgYfnkSfRk9y1TWkDkfwXuvMPhF4=;
        b=n3rsYPRjuguH5ts7xEvnwUFQiIUCPBFBkLtIfdbJaZM1SbGyfuNpXIyb06fM6phZ6n
         AuEIB3k55qU7hVOoVmMcl/D5Vvmn6kZeHG5Q6NwvDnMxjb98XenoFJ3rzWRYO6mqI2D+
         UyAJwAi6mil0QZGCpCblfyc2Ep8Dy7WKAY3ulSLPQPRxBVGoAEV4vEwo9xOt+i5a89Bk
         1CLcKv+yrm7LEjsuxbosSxyAyNAX+hgEABHWC0lzrCOLbgOezrl2nk+wTqLlGOgqz6P+
         RCXDg9hIlFsZV+RkRs9vrALoPEFbkC5zY5usYovmrMfFApo4EFi3tG3YofoWYbq8jvGj
         x4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139252; x=1685731252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0l9OTDlTzd8d3FEtgYfnkSfRk9y1TWkDkfwXuvMPhF4=;
        b=O4CsEjJh/XnkC8EL1ap0itzfO21gTD9O03F4C0mu/WH5R6gM7XRankCOtjx9avgB8F
         x7L63gnW+6Ofq3ibK9ZNwozBg+uRt4CH3v3rDFp8gwLTdTUkuU6Xo/Lm85WdPrfbeY3R
         9BarRFeBjz1uKKTaYCtTrnsLSRiNHtp7xW1nPNTliaNsODl6NNw9wvcxu0nDu0NsdvDb
         QYdcBr6XcrIwoBxf9dy3yxw38qrW1xvBlRtfe9OjQDQX389LEt1GwFDLP3E7Oxhft9Tu
         i2RUExlCi8ppZ3EzTU/h99wo/eLgdHcs5gp+15MuZRiTsmGqgnsDQp0rSsE9LDXibqXj
         swQQ==
X-Gm-Message-State: AC+VfDz2z5zjuSjZvJoMHoYPB7dNpDhSWyr04F+jBEs/ENYkcjMs54mE
        zeb5z7G7i6VX4aXJ8SfMLQeZpqvmGP/Lpw==
X-Google-Smtp-Source: ACHHUZ6gY6IC6RoSQgqNyVMqHF3Bh7/U4V3KgaEZzS54KcwKkvdiUR2+j+yfCZfdPQlinLfgzbrU3w==
X-Received: by 2002:a05:622a:c1:b0:3c0:40c3:b8fd with SMTP id p1-20020a05622a00c100b003c040c3b8fdmr11458376qtw.6.1683139252373;
        Wed, 03 May 2023 11:40:52 -0700 (PDT)
Received: from localhost (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id x15-20020ac84d4f000000b003ef28a76a11sm11656752qtv.68.2023.05.03.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:40:51 -0700 (PDT)
Date:   Wed, 3 May 2023 14:40:50 -0400
From:   John Cai <johncai86@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] attr: teach "--attr-source=<tree>" global option to
 "git"
Message-ID: <20230503184050.wpouoe533rg2uyyw@pop-os>
References: <pull.1470.v3.git.git.1682707848916.gitgitgadget@gmail.com>
 <pull.1470.v4.git.git.1682822352360.gitgitgadget@gmail.com>
 <CAP8UFD00omU=HiGQyaNx=ZbuH79rCv-eHkCuQ1sf5xv9zu4ffg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD00omU=HiGQyaNx=ZbuH79rCv-eHkCuQ1sf5xv9zu4ffg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On 23/05/03 05:10PM, Christian Couder wrote:
> On Sun, Apr 30, 2023 at 4:39 AM John Cai via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> 
> > diff --git a/Documentation/git.txt b/Documentation/git.txt
> > index 74973d3cc40..b8f4f604707 100644
> > --- a/Documentation/git.txt
> > +++ b/Documentation/git.txt
> > @@ -212,6 +212,11 @@ If you just want to run git as if it was started in `<path>` then use
> >         nohelpers (exclude helper commands), alias and config
> >         (retrieve command list from config variable completion.commands)
> >
> > +--attr-source=<tree-ish>::
> > +       Read gitattributes from <tree-ish> instead of the worktree. See
> > +       linkgit:gitattributes[5]. This is equivalent to setting the
> > +       `GIT_ATTR_SOURCE` environment variable.
> 
> As you talk about GIT_ATTR_SOURCE, I wonder if this variable should
> also be documented in the "Environment Variables" section of this
> Documentation/git.txt doc.
> 
> > diff --git a/environment.h b/environment.h
> > index a63f0c6a24f..758927a689c 100644
> > --- a/environment.h
> > +++ b/environment.h
> > @@ -55,6 +55,7 @@ const char *getenv_safe(struct strvec *argv, const char *name);
> >  #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
> >  #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
> >  #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
> > +#define GIT_ATTR_SOURCE "GIT_ATTR_SOURCE"
> 
> To be similar with the definitions that are just above, I think it
> actually should be:
> 
> #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
> 
> > @@ -314,6 +315,21 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
> >                         } else {
> >                                 exit(list_cmds(cmd));
> >                         }
> > +               } else if (!strcmp(cmd, "--attr-source")) {
> > +                       if (*argc < 2) {
> > +                               fprintf(stderr, _("no prefix given for --attr-source\n" ));
> 
> The example I sent was about '--super-prefix' so it made sense to say
> "no prefix given", but here it makes more sense to say something like
> "no attribute source given for --attr-source".
> 

All good feedback. I'll update the branch with these changes.

> > +                               usage(git_usage_string);
> > +                       }
> > +                       setenv(GIT_ATTR_SOURCE, (*argv)[1], 1);
> > +                       if (envchanged)
> > +                               *envchanged = 1;
> > +                       (*argv)++;
> > +                       (*argc)--;
> > +               } else if (skip_prefix(cmd, "--attr-source=", &cmd)) {
> > +                       set_git_attr_source(cmd);
> > +                       setenv(GIT_ATTR_SOURCE, (*argv)[1], 1);
> > +                       if (envchanged)
> > +                               *envchanged = 1;
> >                 } else {
> >                         fprintf(stderr, _("unknown option: %s\n"), cmd);
> >                         usage(git_usage_string);

thanks
John
