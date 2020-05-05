Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD38C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6EA20735
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agE/hJ3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbgEEQ0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730282AbgEEQ0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:26:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA9C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:26:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j21so1235246pgb.7
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqOjS1KodYwbR2ebpXCCcLKULLVtqNE4y8rQGSef0go=;
        b=agE/hJ3TQi8slXt32fyZGfmY5e21xTmTFKCXoRRuZD3QcGWGeL7egWXQ/2wUsQ/Lwn
         NxJEcs4L70a6ywUw74fNrkHEL1a9iYuXVFVrjRon3fHpLFuYE22VjxFsX1L5BticipB7
         y5Df8zU+5RvNiMJU17HJdQmnPA+6LzaLl3+rj/+E9ExUtVdFABC+0sH308MM+O0aUJnJ
         H3XmVpu970p7VJfPBlOsRKBZJ8WJKwXL1Qd0cjbGGffqx7rvtIgnGmK8xblhSJwifLZa
         aOA/f4YQtBSNEKLUSOKbkvMl4iW5hVvC2Z1U1nk/Y7nFi3lQ3FvQBl9yE3lGf5pLWJGc
         IK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqOjS1KodYwbR2ebpXCCcLKULLVtqNE4y8rQGSef0go=;
        b=PH0CBkBjKKukkAwZuTOF6CHLa3MoQAnSOxIIvSpQaoQhDyFd3C54UcGpLak1OEYdNt
         vwSAkwp60juFNuqknJ1AKksmhMYFhZPUkE47aKEC1RDMlBl4mBku1TTe4P/KoMjFOsaT
         4INBQrvg7BPMs2JEHW3detIlxyF/fvOo7U7oXgQlhYGALl23Xnn7EbAgiz6SOYEF5DA1
         ucpzoM+rXyE6b4rMYZnFxr9e5On1Kqa/PYmHzlirnXkiHrBCYJcYEElIAiuFETQFOusd
         F35TmDV3xS5JyfFoo9GflUg1uamWFo1L2yKt2mJrTckFc/Sp8EvtHrrmx7jNR1iPz8kB
         uQgQ==
X-Gm-Message-State: AGi0PuZcCP0oBccyIwLzoFxOW9I/Wl38TkHJ0q+Lio0PunPDersVbeeU
        pDKrqlEMKoDrjkAFTp15M4jPvmwE
X-Google-Smtp-Source: APiQypLINcbewXBq1k82TT0+PV2RDvS00n0TAJwN3k4k3UNzDm2xuE8BkOdOJ0UcrMiWGPJnTro6Dw==
X-Received: by 2002:aa7:8bd3:: with SMTP id s19mr4202858pfd.143.1588696009487;
        Tue, 05 May 2020 09:26:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id l37sm2508996pje.12.2020.05.05.09.26.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 09:26:48 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/3] SubmittingPatches: advertise GitHub Actions CI
Date:   Tue,  5 May 2020 23:26:39 +0700
Message-Id: <48752d8b164bc0b11f4d82016415811a0b2bf08b.1588695295.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
In-Reply-To: <cover.1588695295.git.congdanhqx@gmail.com>
References: <cover.1588607262.git.congdanhqx@gmail.com> <cover.1588695295.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 889cacb689 (ci: configure GitHub Actions for CI/PR, 2020-04-11),
GitHub Actions was introduced as an alternative CI system for Git
project.

Let's advertise it to Git's contributors to help them test Git on
various platforms before submitting to Git.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/SubmittingPatches | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 4515cab519..8686318550 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -78,6 +78,11 @@ on open source projects), you can use their Travis CI integration to
 test your changes on Linux, Mac (and hopefully soon Windows).  See
 GitHub-Travis CI hints section for details.
 
+Alternately, you can use GitHub Actions (which supports testing your changes
+on Linux, macOS, and Windows) by pushing into a branch in your fork
+or opening a GitHub's Pull Request against
+https://github.com/git/git.git or a fork of that repository.
+
 Do not forget to update the documentation to describe the updated
 behavior and make sure that the resulting documentation set formats
 well (try the Documentation/doc-diff script).
-- 
2.26.2.672.g232c24e857

