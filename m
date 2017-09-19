Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 693EC2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 22:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbdISWKK (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 18:10:10 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:51086 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbdISWKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 18:10:09 -0400
Received: by mail-pg0-f42.google.com with SMTP id p5so578559pgn.7
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 15:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xKFncASGSlgopO/reQKxD6Sfgk68tQ+ACcdcXF8sYyQ=;
        b=H9rYFwdgjgvBBaa1GbdkmhzHUZtn0ZPVZY1xXUYZmdFrb7qcU6//tAaRuS3qURLotn
         vG57aUat3t66W5KOD0N1s3e2VL/t+ah4vprfLqDywVjVXXUzTBLqa3xCWpwKemPTV+9z
         vaXr0kNkYdCD1MYNXC1mcX0Ukf2OqzVJZvKQzqVyaZayzkIzDmpa2I1Q3GeRi6vbTRiv
         0SkiV3gmQrRYmuXgkq0m3tYNr+xZXm0Gf27AAYT5F/t+REVAdfMRFrAEyNT7V4l2r2C/
         7d2ywFxAvE9N12TKtMvwXS7nV8ynzthMU/VW41zEtghJ/0+iYzvFMoscUtXCeZT7w3Kj
         T+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xKFncASGSlgopO/reQKxD6Sfgk68tQ+ACcdcXF8sYyQ=;
        b=KpM5qfe5y51aukh3ga1lyGNPXwWPOHnNRNgFKrVMgLhnYrfVtRf1HOiBAiVpFGi7ws
         /dYVIjwKR2p/XbJcKuDPDGVkpVqc8qLxqYqaJZEIXA2rpYBjxh6kTlsNpwHNm8aF8py7
         Xc3a9PfLrlYaKDS7wrT8G1EPl1Ow8vAhbwp5tfF7FaWJMwiGM4x70hjlSdeNdj5yHtty
         xryhSqNoOSxclcViV+mdEdyll/CUhGyceBkw1r60nqF/HDQWOtZPS65kjT2VZhZ8ogEL
         jpGGoQvNkt+2SC9FXyGk9Ded0OhosBT+kkkkejprOP/3eveomIRxI92BAczusGqOn4OW
         Djvg==
X-Gm-Message-State: AHPjjUikOLydl1NumxfxQiNHr+KkT48FJiX6JU08hsgaWIOklWJ5YDfL
        l/Y7z+DNE85MlscO96O9roYFJ4bUbnU=
X-Google-Smtp-Source: AOwi7QAYyi4Pwyiq7Xnwcp+a16TqkSCjys1dtpNyYDLDRZS1hb/+LC5vvftz3qrzQWaQMz6DwrhbZA==
X-Received: by 10.99.175.14 with SMTP id w14mr59491pge.365.1505859008273;
        Tue, 19 Sep 2017 15:10:08 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id p10sm5083981pfd.152.2017.09.19.15.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 15:10:07 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH for jk/leak-checkers v2] git-compat-util: make UNLEAK less error-prone
Date:   Tue, 19 Sep 2017 15:10:04 -0700
Message-Id: <20170919221004.19047-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170919214609.beair2zraemibai2@sigill.intra.peff.net>
References: <20170919214609.beair2zraemibai2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0e5bba5 ("add UNLEAK annotation for reducing leak false
positives", 2017-09-08) introduced an UNLEAK macro to be used as
"UNLEAK(var);", but its existing definitions leave semicolons that act
as empty statements, which may cause some tools to complain.

Therefore, modify its definitions to not leave these semicolons.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
OK, here is the same patch with an updated commit message.
---
 git-compat-util.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 003e444c4..9bc15b036 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1184,9 +1184,9 @@ extern int cmd_main(int, const char **);
  */
 #ifdef SUPPRESS_ANNOTATED_LEAKS
 extern void unleak_memory(const void *ptr, size_t len);
-#define UNLEAK(var) unleak_memory(&(var), sizeof(var));
+#define UNLEAK(var) unleak_memory(&(var), sizeof(var))
 #else
-#define UNLEAK(var)
+#define UNLEAK(var) do {} while (0)
 #endif
 
 #endif
-- 
2.14.1.821.g8fa685d3b7-goog

