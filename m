Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD0BC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E7F2087D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="e//SM7Dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHXTQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHXTQz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:16:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58107C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:16:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a75so11708419ybg.15
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WAgWCog/M71li/iqXqFp42DSqrMFWgPFbLQ8Rkjs3IA=;
        b=e//SM7DkwyeNfM8faeNNIv/eXFuCjvVwro8gKqOb21UTkwwwAX7ahqCN/JChkP9O8X
         UhW7b/Hp9OoM9tmO+Oc32LPdThfRs3IGlBonYBt7bdsLfki8paJC+1DVmnc5jMxF7rkz
         /RCAMYdKiPBq2y6Yl7qr6OanEoe15ofLp2ONm7/vdWO2R6Ww9hM554/Xgill0qMP5GlC
         iXDzr8WJWsfDZEbEnMwD33GbX26IVKBX6hrPEs33oNM7dVqfeKXCc/wwEuyTWIPcod1t
         lS999NKxUnfDsj3QZ62mZW1q2J0CfixaRMRiQZ8tYzDwVKhRc5g056xhvVB3LlWbPaBe
         EPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WAgWCog/M71li/iqXqFp42DSqrMFWgPFbLQ8Rkjs3IA=;
        b=cb+rfkK+l6ONujlx02WJ6zjo63u/lvr2d7dGEKuYCDYe6nrvFkCYhdrEiFiH0c/OHX
         n0TAuwh5/nAm1Xi7qVItwPA1xyK9WPh5dUL07hAjBTVFb6bjMNrxF2gsQwPGFKV8A1Tk
         cHrdwdfHvEizXi4fbWGZXQbnIBeQ8FPf4WkG14PIKzN3FJ+z1qK/Toskq807JZ82ED0v
         UFi3UFq1jPuOh2QmWdvkfBY3v06KnMLSnT6grPx/RxMFJVLrnksPDr4Q82g4xfZavAHh
         22mBKTjdB8rg8mJWoO50LSM+sVmL+pzgalIETM18KIzz4NYROEIhOPh02RfdBWsUBisb
         69EQ==
X-Gm-Message-State: AOAM532CZAg9QiQ30WNzIrp+ni+Q1tFd5z/FZLbgzzOIGrbnkWwYCVK0
        UZAWh1mYwkfuB3l9kGz0MkMDOv4kma3OGa1TozNP/enYiZIkG44eBs2XYJGo6X2LcgdcPqvnjZq
        Nz5aUdRUtiOR9/uuDDtIhPqEgk5EhhIwEzVuzRFOy8Wfp2pRl+VoFsCgU/j5fN7J6CKaqeXSp3d
        fM
X-Google-Smtp-Source: ABdhPJx+yl2u6NDnKOL8AwhOg2cNoBsna/94RAaQmR+wCye0WyAduurVBmpq9tMmKg+BHhJRpASSWnl1QUPHukjxPgPF
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a25:c50d:: with SMTP id
 v13mr9628335ybe.206.1598296614441; Mon, 24 Aug 2020 12:16:54 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:16:30 -0700
Message-Id: <cover.1598296530.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 0/7] Better threaded delta resolution in index-pack (another try)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to resurrect [1] and have rebased it to latest master
(675a4aaf3b ("Ninth batch", 2020-08-19)).

Peff said [2] (of v1) that the overall direction seems reasonable and
Josh Steadmon said [3] (of v2) that it looks mostly good except for
possible improvements to commit messages and comments. Josh did not list
out specific improvements to commit messages but I have taken his
suggestions for comments.

[1] https://lore.kernel.org/git/cover.1571343096.git.jonathantanmy@google.com/
[2] https://lore.kernel.org/git/20191017063554.GG10862@sigill.intra.peff.net/
[3] https://lore.kernel.org/git/20200228000350.GB12115@google.com/

Jonathan Tan (7):
  Documentation: deltaBaseCacheLimit is per-thread
  index-pack: remove redundant parameter
  index-pack: unify threaded and unthreaded code
  index-pack: remove redundant child field
  index-pack: calculate {ref,ofs}_{first,last} early
  index-pack: make resolve_delta() assume base data
  index-pack: make quantum of work smaller

 Documentation/config/core.txt |   2 +-
 builtin/index-pack.c          | 449 ++++++++++++++++++----------------
 2 files changed, 244 insertions(+), 207 deletions(-)

-- 
2.28.0.297.g1956fa8f8d-goog

