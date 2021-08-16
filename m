Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B20DC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 19:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D1960F41
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 19:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhHPTpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPTpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 15:45:09 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD35AC061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 12:44:37 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 61-20020a17090a09c3b029017897f47801so182143pjo.8
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k43MSX3EDxD+GcpqsTMUXpUEIeVlag5RbszEd0IyHi0=;
        b=YOKH28LxDzXPihWB0ILgjecFJ07GSvTTCDOxYcayVXP8gZdbVd5z1ucUMLGjyyUtWR
         yV7zKjmlb0JQNP/ADVcaSaVfnxO61XrVP4CA2DkoygfoyrKfMwBK7J0aB3KnLIiGnyXM
         MZyp2j0l4p4+i9M61o+/yaxc6xowKYpze3buFruEz8zYoQFyC4XbOQelpCUGJC3Q/VdB
         5FaEyNfkdiqEfkhco2n5SHwB3P1VFK6dXQ4iVQ5U1chPXpoNTmK0kY7RojpQ1FzNa3jd
         5QlNM8knX6Gkv0NCWrsldSzOrf/1vaya8rdSyOgzPEoAlbR+SYeFDlDYcvXa86HPzsbm
         HImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k43MSX3EDxD+GcpqsTMUXpUEIeVlag5RbszEd0IyHi0=;
        b=QmSvOdnDpDF+M/DSF98mixaBf7PhSEF9ZqdtnsLLdwyjaw7p4/i6V0hnWAqAqBD3YC
         6Vs6yJ1sFphnep1jya4Kj7wcqx5XPb75dOrSssqRBjO8kjE/xYgIi3VR1cpMAKEHEh8H
         VjTeEGAL6dIstgkhFfZnolXNcDUHHv4rl2l2LiMrmQ4aCUIjfqMYZucVGI5HDEYAIGMH
         0mIgAV3G8MNQuy8yt3Dp7zFJgY8YOnhj/dDbCbptjOy/aH0rBRuEiRg0KDCclAsKw1Xf
         E/9m4I0lwLGLJSaZSn8avZh/lw9nq1xQDlwKUII2VxEF0gZZhIAo0uLhwAttoLZ6tCQ+
         Wavw==
X-Gm-Message-State: AOAM532F3VIRutJ7NOhKJUDu3l/+imDY2aOdr8ABKU//dRs+r/jMKt1b
        LoDpY/wUIvJfgeHwfGYeOIjhMOkog3SRmI+efuMT
X-Google-Smtp-Source: ABdhPJwN6EWcn1jbte3zWh+htUrrKIFuxx6jmPRCS0fpyAIn+MkqRoa1vfaTNFh3BVyHmCLfrGCnlRhPeXTzHWZucbvL
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:2aa:b0:3e1:367:a8b0 with
 SMTP id q10-20020a056a0002aa00b003e10367a8b0mr237633pfs.37.1629143077411;
 Mon, 16 Aug 2021 12:44:37 -0700 (PDT)
Date:   Mon, 16 Aug 2021 12:44:35 -0700
In-Reply-To: <CAHd-oW7cLgZZhGdvONfujDBpNtG1xXfECE=1hLeUzCm8U-N9QQ@mail.gmail.com>
Message-Id: <20210816194435.1636117-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAHd-oW7cLgZZhGdvONfujDBpNtG1xXfECE=1hLeUzCm8U-N9QQ@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH v2 6/8] grep: add repository to OID grep sources
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matheus.bernardino@usp.br
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -120,7 +120,16 @@ struct grep_opt {
> >         struct grep_pat *header_list;
> >         struct grep_pat **header_tail;
> >         struct grep_expr *pattern_expression;
> > +
> > +       /*
> > +        * NEEDSWORK: See if we can remove this field, because the repository
> > +        * should probably be per-source, not per-repo.
> 
> Hmm, I think the "not per-repo" part is a bit confusing, as it refers
> to "the repository" ("the repository should not be per-repo"?) Could
> we remove that part?
> 
> Maybe we could also be a bit more specific regarding the suggested
> conversion:  "See if we can remove this field, because the repository
> should probably be per-source. That is, grep.c functions using
> `grep_opt.repo` should probably start using `grep_source.repo`
> instead." (But that's nitpicking from my part, feel free to ignore
> it.)

Thanks - your suggestion is much clearer, so I'll use it.
