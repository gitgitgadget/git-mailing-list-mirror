Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38890C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C35611AC
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFWRvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFWRuy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA671C061756
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f15so3571015wro.8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+Tb91shET96jRFlTsk35ACQzF64xjpFyo71+i8iXzE=;
        b=mJkcZ4EuXwH4oq7iBd7QsaMrXXOeY1YCBrNAsA2gbU68qO9ahYRXn7UEPb9yvVzoAY
         la9dj2OU+FQPmnLUh5PvrQjzrnCCwLeXorUWdzEjgcGxaErqh3MeJunkNpvL2f3Yka8Y
         oVmeHW8G2T6hJNeoetjN37l9nzxO/L9c38Fy7/uB/7POCZELFEzsylWUueZtdc1csdFv
         tibu4YxiV0sEuRdRtpC/XYgl6f3rIcU8A6ihmnVtqv581eC4PX+KZfBUGGp24UCKploY
         wFs63xtsdj+TFs8aMFFPnEhh1l535jGbDV6/XF7zoUKfriq4fYJVsai3j5+6qnhCaZVu
         c6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+Tb91shET96jRFlTsk35ACQzF64xjpFyo71+i8iXzE=;
        b=mAH9z1Oq7+y9QhlaQ30k8v68i/42X3NzdnXUXgCbJPAFyXElNXAPpn+DXgWmqu7MZJ
         7E3FjItLNFv5kRvqGHkaFibkt03jqz5vOf5hR+QLFNnhesk4pi89mwqyG+4CsickMqJm
         6rpfIKoBTC59KQBmzsHsnByhXQYuJvvV4KBMu6l4knuXsbo/QU39pkMtDFRSuVIyVY1p
         UDceVRu1BnMlGrlFtURyKCijT7uYxEmrmn2gDq6R+jigh3ao8U8uH1Ft5FnZCCWSbYai
         ghVXDcVmg0mzNwO5mpbkpgpnlFl7ig8KJGSbVeAfjN+krxefGCmnQt8953FI/uPoTMGx
         DlqA==
X-Gm-Message-State: AOAM5310A7o5vaom2i88NUjQW7PFiKi2haT24G8TrwENUySz3zWgAUSa
        nVPZbyfmx7KMYreYMN1rqqtS1MwaYQWbjA==
X-Google-Smtp-Source: ABdhPJwkYDZCNhLnVZ/w9/F+AUp2idsnss0OhBHTJjT6C2HxasPvuWxhUPqcQXTFpVtw/B0kDRgj2w==
X-Received: by 2002:a5d:6dae:: with SMTP id u14mr1493086wrs.148.1624470514196;
        Wed, 23 Jun 2021 10:48:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/25] progress.c: stop eagerly fflush(stderr) when not a terminal
Date:   Wed, 23 Jun 2021 19:48:07 +0200
Message-Id: <patch-07.25-02e6edd4b7a-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's the clear intention of the combination of 137a0d0ef56 (Flush
progress message buffer in display()., 2007-11-19) and
85cb8906f0e (progress: no progress in background, 2015-04-13) to call
fflush(stderr) when we have a stderr in the foreground, but we ended
up always calling fflush(stderr) seemingly by omission. Let's not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 7fcc513717a..1fade5808de 100644
--- a/progress.c
+++ b/progress.c
@@ -91,7 +91,8 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	}
 
 	if (show_update) {
-		if (is_foreground_fd(fileno(stderr)) || done) {
+		int stderr_is_foreground_fd = is_foreground_fd(fileno(stderr));
+		if (stderr_is_foreground_fd || done) {
 			const char *eol = done ? done : "\r";
 			size_t clear_len = counters_sb->len < last_count_len ?
 					last_count_len - counters_sb->len + 1 :
@@ -115,7 +116,8 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 				fprintf(stderr, "%s: %s%*s", progress->title,
 					counters_sb->buf, (int) clear_len, eol);
 			}
-			fflush(stderr);
+			if (stderr_is_foreground_fd)
+				fflush(stderr);
 		}
 		progress_update = 0;
 	}
-- 
2.32.0.599.g3967b4fa4ac

