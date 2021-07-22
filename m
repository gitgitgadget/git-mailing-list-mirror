Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A97C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 23:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BB560EB2
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 23:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhGVW05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 18:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhGVW04 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 18:26:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BF4C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 16:07:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t21so908876plr.13
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 16:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zj0DVCXb8vuQMt2fqWVLZgngUkir10L81gQsYlcZNxc=;
        b=uMtxeoLU1HstA57vBmm93lYN9i73A06HZFWhPSuwMLV9AQ+oREfYyAge9wBYO4GYJC
         Zq28j4Fty1bSoIDLgjHP0C1UI2Bj/jAdjeummh4e6r1LxYCvA8EEV5E2HFjaJFLRIgym
         MqC3gMf+MKygIaz69+b2WYbBufNb8i6tf1GdPoCDjFeJyyUk9lRW2DsdiUNAb39XlZoL
         j1KXwj+Gji9oiXp0ffGcUZ8dhVCfpntNu+8dlqacwXxUDwJPwYDzduDMHlpfRd9Asoa/
         z15Sk7CQuF+JZShgdyps9LjzNiFGt4HyFDcTGb9lPykDFU1hmrE6DS6CYlI3onXeMP7h
         /wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zj0DVCXb8vuQMt2fqWVLZgngUkir10L81gQsYlcZNxc=;
        b=QB6cIUgjg1uIUzRSM7W39xzpKFu3OH78zirfnPV2UKHLrJTTRmGXMoz3k/WQ3SulC9
         ded3sl4q5sDn+XlCLaYVfqF2Xv8h7k8k4BqKORht3O7RtvfxZDW+PaAWjlxeLR3iXjSm
         IeAsFJy3O71OJP/JDAscPf3S6ehh+A7qn+cZKKx0HmnY1EjnLlr0DHBNCdYzpFeSeitG
         NIVNH72un1DjzEEyBbAqGq3EeyiMaas0iP7nH6PFBnZz1u87EuPMnHPVIaZcjUNrrZUd
         /MUDxmhK0ZdoEw9Hh9uiNSe2hfNpiamSZIcoLFR3QvRZNoJZvb4YeUTIo3/yxtIzPHCv
         H09Q==
X-Gm-Message-State: AOAM533bWEkAskoHEROVJ8JE62FeexEwKK41t2EyBEVa1q68JV4BIpnA
        D/GoXRVVqKhyAZE4zeuXUHNzN8ySqwaeGA==
X-Google-Smtp-Source: ABdhPJyrgZ1FqCn78fP64gQbQ7C+nJicTXbYixyCqyPW/rXnjPGW5C5g+I7/aZV1kTU8d9Bh5y7/fQ==
X-Received: by 2002:a17:90a:d305:: with SMTP id p5mr10762778pju.96.1626995250037;
        Thu, 22 Jul 2021 16:07:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3c03:6226:e12f:afc9])
        by smtp.gmail.com with ESMTPSA id ev20sm26793110pjb.43.2021.07.22.16.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 16:07:29 -0700 (PDT)
Date:   Thu, 22 Jul 2021 16:07:24 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/9] hook: allow out-of-repo 'git hook' invocations
Message-ID: <YPn6LInRNmpfffuC@google.com>
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-8-emilyshaffer@google.com>
 <87tukuy7vc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tukuy7vc.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 10:33:25AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Jul 15 2021, Emily Shaffer wrote:
> 
> > Since hooks can now be supplied via the config, and a config can be
> > present without a gitdir via the global and system configs, we can start
> > to allow 'git hook run' to occur without a gitdir. This enables us to do
> > things like run sendemail-validate hooks when running 'git send-email'
> > from a nongit directory.
> >
> > It still doesn't make sense to look for hooks in the hookdir in nongit
> > repos, though, as there is no hookdir.
> 
> Hrm, I haven't tested but re the discussion we had about
> RUN_SETUP_GENTLY on my re-rolled base topic is this really just a
> regression in my changes there?
> 
> I.e. I assumed we could do RUN_SETUP for the bug-for-bug compatibility
> step, but send-email runs out of repo hooks and we just didn't have
> tests for it, or am I missing something?

I'm not sure. I could see a case for you including RUN_SETUP_GENTLY on
your series and adding a test for sendemail-validate + core.hooksPath in
global config. I think I also don't have support for that case here,
actually....

Anyway, it looks like right now git-send-email.perl:validate_patch()
doesn't bother if it's out-of-repo, so this wouldn't have worked before (and
still won't work even after this change). So either I can add a patch to
my series to allow that, or you can modify your patch converting
sendemail-validate to 'git hook run' to drop the 'if $repo' line and
teach your series to behave correctly with nongit+hooksPath. It looks
like in my earlier attempt at the series, I did drop that check and run
'git hook run' no matter what kind of directory we're in.

 - Emily
