Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F368FC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D614361354
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhJUW2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhJUW2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:28:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22334C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:25:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p16so160829lfa.2
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHhpCrKb9ZW4ERaTuo/ADfYH0kGsTnqTvfRcoP597Jc=;
        b=iGzLX9qFXSfjw+X+LlxME3DCRD0T9UB4zZtoTwwi5OIRLdoe1/5a+Acgu+cWOA8use
         nd2wZ4x5F/Kq2SaMtzbeWnJ3OTToVmUQsKotut2Hg+10Jx/er7iqzKVS80LAA07ogW3J
         MMASFb1V/c57LwqAG2q514R9SzVj7GQOfs/ZCkAMryxTdcCVdv8UcixBBH3sIoawEwz1
         XuXssYMkkreIfjNDT2CT+QhEtIQnKp8mXrVW3fivvKNBkQiFa7WW/Q0Tk7aj0F9Vo53t
         j0Hk96EBbf4tbptuzID5pcFKfY/ZFTMGY+ogNcfnInhc184w9pT2yvnZd72ECiLMc9/G
         jKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHhpCrKb9ZW4ERaTuo/ADfYH0kGsTnqTvfRcoP597Jc=;
        b=I7dkYiceurGrDAJBJ1uqfAH2Jt23ZeUBw0KgL4HURTTy9dB7/GKK8xaeJG8/Ox92oK
         fv8NavQCgVmCghJqZB1RMI5diIHiVf9MzzaUzUPJ8J2JdNbCP9gn05Pamum3xrvMtjz5
         GmCLXiYfDnd5mNjCZExHFPzJfKW5siE5aqeS0SEeILtmEvJD8eP9uZ3or6ci94pIRub7
         /oXejcgfrpYCnn0KxoeMZJgdNqbVX1Wr7m6CkzQcw9wRHypg9y3LnasI5AWVNaAoZGlO
         ApN83gYSBPEYRxgE/IzIgt3N6dMrfgP/XzcFMWHKZ/8VjJ3l2UhKXBmVq3Ea0KzENr/Q
         8f/g==
X-Gm-Message-State: AOAM533HFp1kNPfAYIIKlcMl1S0B4359GqQgSb+6RGT8FJxgo0d/TFw5
        1v96bDdpHN3/WBxj+fVBXRTe+z3v9PcKkA==
X-Google-Smtp-Source: ABdhPJzfrSHZTAkDv0+gvxEzJLz5LCR966mfCm1hDTtF777jfJjIycbr06OW7wU41v3YNNDAwKHajg==
X-Received: by 2002:a05:6512:214b:: with SMTP id s11mr7796585lfr.296.1634855143253;
        Thu, 21 Oct 2021 15:25:43 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id o22sm608875lfr.250.2021.10.21.15.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 15:25:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH 2/2] status: print stash info with --porcelain=v2 --show-stash
Date:   Fri, 22 Oct 2021 00:25:32 +0200
Message-Id: <20211021222532.463375-3-oystwa@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211021222532.463375-1-oystwa@gmail.com>
References: <20211021222532.463375-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The v2 porcelain format is very convenient for obtaining a lot of
information about the current state of the repo, but does not contain
any info about the stash. git status already accepts --show-stash but
it's silently ignored when --porcelain=v2 is given.

Let's add a simple line to print the number of stash entries but in a
format similar in style to the rest of the format.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
 Documentation/git-status.txt |  8 ++++++++
 t/t7064-wtstatus-pv2.sh      | 15 +++++++++++++++
 wt-status.c                  | 15 +++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 4a2c3e0408..54a4b29b47 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -314,6 +314,14 @@ Line                                     Notes
 ------------------------------------------------------------
 ....
 
+Stash Information
+^^^^^^^^^^^^^^^^^
+
+If `--show-stash` is given, one line is printed showing the number of stash
+entries if non-zero:
+
+    # stash <N>
+
 Changed Tracked Entries
 ^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index eeb0534163..47fc21d962 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -113,6 +113,21 @@ test_expect_success 'after first commit, create unstaged changes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'after first commit, stash existing changes' '
+	cat >expect <<-EOF &&
+	# branch.oid $H0
+	# branch.head initial-branch
+	# stash 2
+	EOF
+
+	test_when_finished "git stash pop && git stash pop" &&
+
+	git stash -- file_x &&
+	git stash &&
+	git status --porcelain=v2 --branch --show-stash --untracked-files=no >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'after first commit but omit untracked files and branch' '
 	cat >expect <<-EOF &&
 	1 .M N... 100644 100644 100644 $OID_X $OID_X file_x
diff --git a/wt-status.c b/wt-status.c
index 97230477b2..88c5481e24 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2182,6 +2182,18 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 	}
 }
 
+/*
+ * Print the stash count in a porcelain-friendly format
+ */
+static void wt_porcelain_v2_print_stash(struct wt_status *s)
+{
+	int stash_count = count_stash_entries();
+	char eol = s->null_termination ? '\0' : '\n';
+
+	if (stash_count > 0)
+		fprintf(s->fp, "# stash %d%c", stash_count, eol);
+}
+
 /*
  * Convert various submodule status values into a
  * fixed-length string of characters in the buffer provided.
@@ -2443,6 +2455,9 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 	if (s->show_branch)
 		wt_porcelain_v2_print_tracking(s);
 
+	if (s->show_stash)
+		wt_porcelain_v2_print_stash(s);
+
 	for (i = 0; i < s->change.nr; i++) {
 		it = &(s->change.items[i]);
 		d = it->util;
-- 
2.27.0

