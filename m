Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A303C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 17:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF9420758
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 17:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CjIISTnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIBRtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBRts (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 13:49:48 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD344C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 10:49:47 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id g6so30214pfi.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MrJDuUDrdFNscSsuXx1QvvG/ZTJdBSwjpjjY/vvgIAc=;
        b=CjIISTnTUtF70l9b8hlL3dvyuMT4j1zEZNnvLJtXmwhokBb6DA7Pj/wZHjiVCGjLw5
         UwcIIc84m9KvFSuV6RqOlm/RPQCjcL4v6RX0yZIzPGKme/C2hDUgLOetyEj4oMhH42N+
         SzroNeD+DRon+1B4CrYBEDgkkUTzAne4avHuVRxkh6RCAjYOAvdIA/4O2Xo9aUUQ8iiO
         ywX3G0/x9c+j8ZWdc3h4Uoog9PHjZP9Ka+X23GGL6F0VLdFcZjqT9saiUnNIPkwpoO4t
         85RUNS+YhlFgjdIlU25SoEnOXrwX+8ZTGRQWHuX35QlVy5I9qrNUR7j2m+GTeCO3cBga
         FQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MrJDuUDrdFNscSsuXx1QvvG/ZTJdBSwjpjjY/vvgIAc=;
        b=N7OCDKxXWOmrtvcgvM+GXnjv2jZlIefG4wW7opPTe+LgZtXamIelBXKsf341of0kdC
         ki7euK/xNlCLJBy20SbplQ8XlQO8DW4h7JRPvGVDF0ZiUurF7thyRBLGyn+4wvQco7mO
         FvJSEPaTHqIbMy11mx9kszU53YGSfYc9M3468G3cOF/9j8fHQP8gwSDmtkaaseAE2MFQ
         iO5MvZZg3CPwGTaeTN7g5z4+V1yefdfIYgUUFJQcMQNTgyLn2lm5Qh7LpRHw7zvLAMLs
         h9ra2e+00Fj71uS8qP59sVAlENvt8Nfkmvs+SpZDKJ7ep2FaeG+yy2M1aO0bUyda8HAW
         5HiA==
X-Gm-Message-State: AOAM530c8seWmyfgqc/Mfv7NE4MST0M1LG4K+nqLltOBkvXDQoo7ZPN8
        WsLPw/H+eoI/8v8vacRTPetno0UYKOA+QkeHUzm8
X-Google-Smtp-Source: ABdhPJyPQp7mKbW3EznRx5N3/cftmsN6ZQuMibjhYO7opOmAfxLDlQ/m8haoykuSewa9jN0w6pfSfSp5ypPTKf/USf5T
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7689:b029:cf:85aa:69f4 with
 SMTP id m9-20020a1709027689b02900cf85aa69f4mr4547528pll.1.1599068986893; Wed,
 02 Sep 2020 10:49:46 -0700 (PDT)
Date:   Wed,  2 Sep 2020 10:49:39 -0700
In-Reply-To: <pull.713.git.1598628529512.gitgitgadget@gmail.com>
Message-Id: <20200902174939.3391882-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <pull.713.git.1598628529512.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: Re: [PATCH] RFC: refs: add GIT_DEBUG_REFS debugging mechanism
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwenn@gmail.com, hanwen@google.com,
        git@jeffhostetler.com, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This should be integrated with the trace2 sub-system, and I would appreciate
> pointers on how to start.

The trace2 subsystem seems to be designed to detect errors coarsely
(e.g. by looking at process invocations) and log timings. It currently
doesn't seem to be made for this kind of fine debugging information -
and perhaps this is by design, because such logging information would
not be useful to most users and would just clutter up the logs.

But I think there is a place for this in Git - in particular, we have
packet tracing (GIT_TRACE_PACKET), and this has been useful both in
automated tests (t/????-*.sh) and in manual tests. Ref backend tracing
seems to be similar. But this would be best if we had an additional
option that could control whether ref backend tracing was on or off,
independent from other things like the trace2 target.

Is the plan to migrate all usages of "trace" to "trace2" or for both to
exist simultaneously? If the latter, then ref backend tracing could just
use "trace", but if the former, we'd have to designing this additional
option.
