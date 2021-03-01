Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549EDC433E9
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4EB601FA
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbhCAU7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 15:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbhCAU4I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 15:56:08 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E070C061788
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 12:55:27 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id o2so11958771pfd.1
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 12:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=X7E0S/iebJm50ZIDzo8uwopymdfUV1G/aZSXmIeLyx4=;
        b=eOxIdnfCOF9VGjjmZBNVsWLc7B0QbqtZBNz4pBa/ewg49GiFXHElX7KWF9T32RqZjv
         /2+pHiol1Ko9qU/sR5GPSIJ8bsuq34jzMoLSl+r8YHip84rBAgE/ikmHZP12r07j2aTL
         3cFWGvEP3/ZJqeOUQHSUpyUuVdJfd3aZoZGkYTYd4hVcCGyc0mnyL0OMXj9aF9r2Fcwc
         8rjxrCuvrsug+sDF7DlfYoVeyN+sRO99Gqqph908yqgpy0toVuUKNR26KbTpqtsW5yeN
         Dy5grVJgg19CYEBRGg9T+uaOlZjxYfe5w0K5yyotuBYJfzJuUyOdIapeZGY7C0OXLN5W
         YSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X7E0S/iebJm50ZIDzo8uwopymdfUV1G/aZSXmIeLyx4=;
        b=F0/vLIzn15kjhj/+ri5UetLhVcSH/e2xP7+QytmPA5rQj18mR/rhuf9enhBXZVQ0Bz
         xOUA18sFTCTA9XU1A2FTPq6yFYpUxQQXQ15wdt9lJ+QEL/lmzShh8R4lt23/gQoZxw5s
         MPy9u/dNG4YtEvloi07xZ18ArrgLrOrcPugUCbXJKoQV7LJH0hgONOYUXDM1eoNY8KCx
         R71I37MQ1fQaLvE+BFbtI4U1UTH2Menk241mj2gYy5wBmM928JwmA6DsfxeKDY9/6o7N
         /jjgoXwYodLHwJGtOp9YkyQTlbChN1lP/lT9keuhJmm2KuIQREWELX1yYdyphFabIw87
         C8aA==
X-Gm-Message-State: AOAM533YQT3VJD99sZTHAgx68ykoDrD8rSbL96rpVFq0Stp9fj/aYunl
        3xi8m1SC7Rr+agIhIlngIFbFwhvUoMz/F/5sgdLa
X-Google-Smtp-Source: ABdhPJxL+Hi8bIPqyuV1I8C7gcSQkVTOvGcgJmFCw+2iLoIL/Rwk0WPWQwz7KO1TVagYPCSB1CAG685+7aXxVcvuKk8a
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:a63:: with SMTP id
 o90mr796020pjo.90.1614632126695; Mon, 01 Mar 2021 12:55:26 -0800 (PST)
Date:   Mon,  1 Mar 2021 12:55:21 -0800
In-Reply-To: <CAFLLRpLoy6c_WSt1RR2-SPMzKK-MaBpkrCPuGqGGf8SwpCiSEA@mail.gmail.com>
Message-Id: <20210301205521.3415173-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAFLLRpLoy6c_WSt1RR2-SPMzKK-MaBpkrCPuGqGGf8SwpCiSEA@mail.gmail.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: partial clone: promisor fetch during push (pack-objects)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     robert.coup@koordinates.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > 3. But push doesn't pass --missing= to pack-objects anyway, so that
> > > wouldn't actually solve the original issue. Should it?
> >
> > If we fix the bug I described above, I think it's still OK if push
> > doesn't pass --missing=.
> 
> I'll have a go at a patch. Any suggestions on how to approach
> writing/expanding a test to cover this?

I think the main thing is to test that such a push doesn't also fetch.
The most straightforward and reliable way I can think of is to run "git
count-objects -v" before and after the push. There are other ways like
using GIT_TRACE_PACKET and then grep-ping for the absence of "fetch>
done" (or something like that) (but I don't like this approach because
grep-ping for absence is not robust in the face of typos) or checking
the number of files in .git/objects/pack before and after (but that is
not robust if Git decides to GC in between).
