Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE57C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CD26108D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbhIGTn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346052AbhIGTnw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:43:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8670C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 12:42:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so2449057wmh.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4ja/DthYVVjk8gR2AfxMJhrIukxcL8H8bW47mNb82k=;
        b=MxHm8+2ewaKgAnie78Sex9/aICKfEAczfWAQXd9Msc0fjikcssn3bfckkc0RDJ6xXl
         qqTqoBWdb2iKLvWQPYZynf9vPlEXpRV6atVjFJI7uKtJUCqMvnbwF+xw0U9WuedKqxPf
         HiAxAekv5pKKM7a/W6UTZA+W1V1nqzzEXXbohb68paxuNE0bHzoiCf90DfhSorf0vAIK
         rPcDlisCZQZGIV2B1OsnaslMXZcqSXNjSE9vQte+rrpNp6Rrq+BUSx9+2XLxPeSl5Ao4
         OAokrEVBiplQWeRIEAeCT8HNX4l3DibqL2weTn3McrtY0NC328lXnE2fmJ/1h99Dgdo3
         r4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4ja/DthYVVjk8gR2AfxMJhrIukxcL8H8bW47mNb82k=;
        b=cGWrgHyesZJlydoNCUaqHWrfMpzkIJ9ncVzKZMBOdtb/vmbh9pv8ebohtI1wA7hGsn
         3fjUhZokYGcLxB8RD5FQJGa9RgaGFWSgw5jm8nh3GZLZPJopcDB3/V+iO9bhb1x8o31u
         6a92mwstuIOn6B53xzcQUpfIn/4KIhYY1f1QrVZO9uRGl7syGICYkTfNRplmkkNYGBc9
         4ELxbYfLCvghz1ApLhcMYxX0czFZ/Ngy6COA7xxJU+sUte/AwYVtjQz/SvE98Zh3K7m5
         44eYk6hY1VU6HOPvH1JlIC0UzVjJ1tnu3BYlNJn0dMiaGv/V6BOot6h2BUC7ogRnYk2C
         BEDg==
X-Gm-Message-State: AOAM531glx2V/ATnFecKCbs3fUkCFDnkfh3RpM69+9bSgh4dAt26m6BV
        m2clBmifEAJRX/s0vWE6SXgRl04PoccybA==
X-Google-Smtp-Source: ABdhPJxnpO0YTk/PvpODColRyrwvvWze74bFB7yzLDIRZjyl3WRIE5OvS0cuQjvSUm8kE2SW753vKw==
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr5670349wmo.41.1631043764058;
        Tue, 07 Sep 2021 12:42:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a10sm12075320wrd.51.2021.09.07.12.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:42:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] pack-write: rename *.idx file into place last (really!)
Date:   Tue,  7 Sep 2021 21:42:38 +0200
Message-Id: <patch-3.3-78976fcb7b2-20210907T193600Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.818.gd2ef2916285
In-Reply-To: <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
References: <cover.1630461918.git.me@ttaylorr.com> <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up a preceding commit (pack-write.c: rename `.idx` file into
place last, 2021-08-16)[1] and rename the *.idx file in-place after we
write the *.bitmap. The preceding commit fixed the issue of *.idx
being written before *.rev files, but did not do so for *.idx files.

See 7cc8f971085 (pack-objects: implement bitmap writing, 2013-12-21)
for commentary at the time when *.bitmap was implemented about how
those files are written out, nothing in that commit contradicts what's
being done here.

While we're at it let's add cross-commentary to both builtin/repack.c
and builtin/pack-objects.c to point out the two places where we write
out these sets of files in sequence.

1. https://lore.kernel.org/git/a6a4d2154e83d41c10986c5f455279ab249a910c.1630461918.git.me@ttaylorr.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 11 ++++++++++-
 builtin/repack.c       |  8 ++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9fa4c6a9be8..fad3fe5651d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1249,7 +1249,6 @@ static void write_pack_file(void)
 			stage_tmp_packfile(&tmp_basename, pack_tmp_name,
 					   written_list, nr_written,
 					   &pack_idx_opts, hash, &idx_tmp_name);
-			rename_tmp_packfile_idx(&tmp_basename, hash, &idx_tmp_name);
 
 			if (write_bitmap_index) {
 				struct strbuf sb = STRBUF_INIT;
@@ -1269,6 +1268,16 @@ static void write_pack_file(void)
 				strbuf_release(&sb);
 			}
 
+			/*
+			 * We must write the *.idx last, so that anything that expects
+			 * an accompanying *.rev, *.bitmap etc. can count on it being
+			 * present.
+			 *
+			 * See also corresponding logic in the "exts"
+			 * struct in builtin/repack.c
+			 */
+			rename_tmp_packfile_idx(&tmp_basename, hash, &idx_tmp_name);
+
 			free(idx_tmp_name);
 			strbuf_release(&tmp_basename);
 			free(pack_tmp_name);
diff --git a/builtin/repack.c b/builtin/repack.c
index c3e47716093..dd438ebb3ee 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -211,6 +211,14 @@ static struct {
 	{".rev", 1},
 	{".bitmap", 1},
 	{".promisor", 1},
+	/*
+	 * We must write the *.idx last, so that anything that expects
+	 * an accompanying *.rev, *.bitmap etc. can count on it being
+	 * present.
+	 *
+	 * See also corresponding logic in write_pack_file() in
+	 * builtin/pack-objects.c
+	 */
 	{".idx"},
 };
 
-- 
2.33.0.818.gd2ef2916285

