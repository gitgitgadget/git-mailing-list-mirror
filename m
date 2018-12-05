Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AFE3211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 00:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeLEARl (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 19:17:41 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44215 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeLEARk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 19:17:40 -0500
Received: by mail-pf1-f202.google.com with SMTP id b17so15300339pfc.11
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 16:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P1jwEkyFRZ/W+L8QKn+NgrachXaWl7W/TumkEz09oXU=;
        b=ORBuombyu37C27scCO9uGGWTCIT2Ex7jCgQ+7VjWCZhyAO37i3x6uTqALBHcNaPM/3
         aSjPgeDLqQWyJO3+DS8/GINduW5H9rF+ROI/YxfaVsZ3UcS3u6ReaIDzz5wgg1AyXg54
         CAEBMEbFUHVqV4jbmks6tDTWesXpH46n1jk8OS1340culv32j7cCp5jfIfkmcRVL97pa
         mXS47B2L45Wy9OMZjdohDFo2mW3JIyZ2Ci1owgZaRx9Ot2NB8v4ozrqrv6cn37mSL9DH
         uXqYJ0hTeeJ5SPuEI84P9sR4ECXggx/VbVYwWeezyZPRDycB+XtiVyqTZ5BiqtmV11xq
         D/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P1jwEkyFRZ/W+L8QKn+NgrachXaWl7W/TumkEz09oXU=;
        b=oGdnu356bL1ifPIuw+Zd00++b54nwMigoTWjR9KzLcDM5TscQaN3j3i1sjj4puiPn5
         wuU25VwsaCuMftghb68MmUUExrbhBdj6uSS/AlSWWkqtDmCYpjFM3yEcRnyRSutz1uek
         yOxAvniZMWwxt6zdoP5INm55Imqqa9CUPrcvZ0bcHnJPSXHo86gABVuaf+OmPkykA3MC
         y+WWX3u10HGLvtsL1mb51X8BiuT+ZFIeTbfnXqMnpjYXgOOnADV6A/VsuAKEtTctohMh
         QNjduz3cDlMn0oH1poc5G0GsrrSHAJwkauXR2G7ExDiOwYaGYjcryTLGRQrvzTZI5irK
         OQzw==
X-Gm-Message-State: AA+aEWYKiHxYpoAemq5YTsnvH9x7/uFPs+RsLjV/LipCvFkDNhFUibLm
        tgIq+BFXF+xIGoiqI+3SpH3tfsPcBqj9FHkMF4BQ
X-Google-Smtp-Source: AFSGD/XGhh34Wf1BkdJQMAXAtAfCjtCAqtq50/mkIk/KhXa6c+oWv4DHXCv6vIFVRO2nGRtwYlCQaT20ysQ6yhMeZFLn
X-Received: by 2002:a17:902:3084:: with SMTP id v4mr6836302plb.76.1543969060300;
 Tue, 04 Dec 2018 16:17:40 -0800 (PST)
Date:   Tue,  4 Dec 2018 16:17:36 -0800
In-Reply-To: <20181129002756.167615-8-sbeller@google.com>
Message-Id: <20181205001736.72764-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-8-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 7/9] submodule: migrate get_next_submodule to use
 repository structs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> We used to recurse into submodules, even if they were broken having
> only an objects directory. The child process executed in the submodule
> would fail though if the submodule was broken. This is tested via
> "fetching submodule into a broken repository" in t5526.
> 
> This patch tightens the check upfront, such that we do not need
> to spawn a child process to find out if the submodule is broken.

Thanks, patches 4-7 look good to me - I see that you have addressed all
my comments. Not sending one email each for patches 4, 5, and 6 -
although I have commented on all of them, my comments were minor.

My more in-depth review was done on a previous version [1], and I see
that my comments have been addressed. Also, Stefan says [2] (and implements
in this patch):

> > > If the working tree directory is empty for that submodule, it means
> > > it is likely not initialized. But why would we use that as a signal to
> > > skip the submodule?
> >
> > What I meant was: if empty, skip it completely. Otherwise, do the
> > repo_submodule_init() and repo_init() thing, and if they both fail, set
> > spf->result to 1, preserving existing behavior.
> 
> I did it the other way round:
> 
> If repo_[submodule_]init fails, see if we have a gitlink in tree and
> an empty dir in the FS, to decide if we need to signal failure.

This works too.

[1] https://public-inbox.org/git/20181017225811.66554-1-jonathantanmy@google.com/
[2] https://public-inbox.org/git/CAGZ79kbNXD35ZwevjLZcrGsT=2hNcUPmVUWvP1RjsKSH0Gd3ww@mail.gmail.com/
