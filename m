Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC5DC54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 22:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiI0WMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiI0WMh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 18:12:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C961CFE5
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:12:36 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ru14-20020a17090b2bce00b00205cc5a4e8eso1922525pjb.6
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=PcgPkF2Skhvroxa9wJGm+8ilYe7YHGLhPpdLKZ9oSfQ=;
        b=ETE8Bl86cgV9VQRLADYlaybZ+Qg1J7eHTF6AxBh9sbef7SJ+Nxqp93nrdvKEaGhHd6
         QE3oqAMpSBbyt5dUbpUtK60eUJUEHOkzN9CRBRgDFxRMlqeKjACJo1V2exO2llS2S6DE
         Jdk3KXE3AtFHzC6TBWHe7SqZ1hTro8jR6vl+NevJbHdgAoSv9HD5SqOOp77Rm80VMBzj
         2X2UcKa/rJlkrDlJ/6BvaBKK378DRxNbLiK+Mg6o/cR4aDmn2qzzSHQiC3cSI871ucDa
         tiEBa7m8UcaqYtxeDRKpKRKmVirntnPvVsbrtkY1TvtM+BLHMOzUteWAaOjtKt5NLgtn
         RObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=PcgPkF2Skhvroxa9wJGm+8ilYe7YHGLhPpdLKZ9oSfQ=;
        b=Krne41XBmFZ/C2wupwrhxXoI5NuwtpagmU1tJTBSgxzzLCTGOiUZt3ri/Vqf3m2RL4
         Gq78/en7IdlGmmI4ivS4H1unVIwlTDkx74V5wP2YvfxnYdj4bsbIpQFpwmZc5lX2EgB8
         1i1e7qFodD5TBCN5Nq2sDFiwEjAF5FjUUee5qsZiDcAdexk+Tg1uDahtFg/Owrq7D1qk
         uEkDfyQbuqACOHPBnruDuXL6kBHlkD65k4NRhap0rMgbRHufGoWbeM5ofLnq0BnBk9iR
         qlaJGibpbMKUc6rmzhdlI1C66SPo8SosJqqnR8FUGDJVD87bXm2Hu3gcUHg1O8WM2V6F
         wUpg==
X-Gm-Message-State: ACrzQf33ZlqueyxzXPI6cAyjZKrf+BCKdEBzDjvZ3sYmtWdDztFi1WIa
        40nVZIFVkXqdQ7bx4kh7Rs3aIwpju9OKBoW5hY6xUQ6eNwMQFRkpsdx7pCqrtFR/uKECUm+5F/6
        fPPx0XElgEJmfiq3SGcotEH20TnfRh/kvnhgVRWr6JRinrwc85r8DLy/n5gCWaOncycoGl14vs3
        oJ
X-Google-Smtp-Source: AMsMyM4FNOeR6vZSLBuj4iLDcDvzm/MoYKL2dCYk6ktuF/PqOdcVFJkD117XSG/LJxJTgpkDCZNswFWxRLf0qAZeezgx
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1d8f:b0:203:bb53:62b5 with
 SMTP id pf15-20020a17090b1d8f00b00203bb5362b5mr6970259pjb.74.1664316756366;
 Tue, 27 Sep 2022 15:12:36 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:12:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <cover.1664316642.git.jonathantanmy@google.com>
Subject: [PATCH 0/2] Fail early when partial clone prefetch fails
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes something we noticed at $DAYJOB, when a partial clone
prefetch intermittently fails but all subsequent fetches work. More
details are in patch 2's commit message.

Jonathan Tan (2):
  promisor-remote: remove a return value
  promisor-remote: die upon failing fetch

 object-file.c     |  4 ----
 promisor-remote.c | 23 ++++++++++++++---------
 promisor-remote.h | 11 +++++------
 3 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.37.3.998.g577e59143f-goog

