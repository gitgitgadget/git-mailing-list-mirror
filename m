Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7C4ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbiIEI3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbiIEI2s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:28:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970BD4D241
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so7343875wme.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FSRPk0utgaaZ4KhwogSS4ItmV5JB5Q8+TAvxIiYVyDA=;
        b=VSUKeYZ/rHOKnAMSJmdKSZg80GH+iLy9uqoOaqbt2g7BzWWgKW0n+VNnPMRjFWLmUk
         wsqt552HMfZqEgwcTLDwHQe/SaPLGp38XKIwlusQAI8nIqL6HDJcsbazlrYeKwat1LQH
         P0MpwkfbypCF/3z8u69SniKduDiYTn7PWEVdUhghLxZp0NSVIOA9sBYIf4l3yQXiPCdM
         l+s9YS70yqJ1qMcoFohfcswjsatrgh9FUO68U/uPd81kQKtnaypiT4Ui/MlFPsfkklHB
         Y5SjxxQcbNsIG8f7Nlp9EtyZDNQ4lVMAhaDl96/IQ/BU64XE2YJC/tybMeE9WzYAUCYp
         Bf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FSRPk0utgaaZ4KhwogSS4ItmV5JB5Q8+TAvxIiYVyDA=;
        b=sPAZXT2lwGNKJ7qaLq3bj30mr7gbKh6zB7fxhlKY52BccRVXc2La/kZ2ZGov6S3kvQ
         1VBPxxSzINFzw3ER5Injt4/TqtWxTXWcVpnMRPrhlx/BM0rbTsilOtLXM75mq4BkWi9i
         pUqho737uMZ90Y2wWS083mkyDVEX17yL2WC6WK/YtBLq8mX5KUju76pDiLvQYzkiDlnZ
         qEcPehLXsF+Pkugn6e6fjKW6puI4qYbUQhw2frsjc1THefJnMhKSGjjsM1PPx4weXmy7
         ojQEUHZeGpIvnOZa/acVShXWlNL+inZ3Zn1q/UQ3dzULJgngb7KGAt919ZgKmF4OnmrS
         na2g==
X-Gm-Message-State: ACgBeo27QjVYtPNYKm3uRCsDW+/LlDuBfXQRSrbcbTxmqmDZ/9Q4UsJK
        uC2PDSGEnBcTAmIZpDTi8m67YXreTi6cFg==
X-Google-Smtp-Source: AA6agR4jv/GpBaK0rtfLBgv7JEcM7CHuyFQpH67y4XfSJDi19hf3DsZiTx3SRfCQ6Dj7YOtVlgZ99g==
X-Received: by 2002:a05:600c:2242:b0:3a8:4007:bc5e with SMTP id a2-20020a05600c224200b003a84007bc5emr9542948wmm.99.1662366441281;
        Mon, 05 Sep 2022 01:27:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 30/34] doc txt & -h consistency: make "commit" consistent
Date:   Mon,  5 Sep 2022 10:26:41 +0200
Message-Id: <patch-30.34-0aea4ee2e03-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "-h" output of "git commit" consistent with the *.txt version
by exhaustively listing the options that it takes.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 21ad4ccbf87..64f420bcbf6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -40,7 +40,14 @@
 #include "pretty.h"
 
 static const char * const builtin_commit_usage[] = {
-	N_("git commit [<options>] [--] <pathspec>..."),
+	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
+	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]\n"
+	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
+	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
+	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
+	   "           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
+	   "           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]\n"
+	   "           [--] [<pathspec>...]"),
 	NULL
 };
 
-- 
2.37.3.1425.g73df845bcb2

