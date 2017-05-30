Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C492027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdE3Rbw (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:52 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35394 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbdE3Rbs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:48 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so78337303pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gPOF8792pAodFZ89Hcyn7vZCI9fDT8d3Vp/YneyP9cc=;
        b=DPdRKh1RhaSSJ50wGgLbPpD1RilJIZQp7bNxHYUULFQKAEHfxXHMTSFphWr0qtFkF5
         m4YspQqNPTaHRcU4tAT6KktbyAR2la0BmfhekMjhmS57nYbroJI5nADGBanXu9NYPjNZ
         d7IHoV4ES2EbnSBvg2duqnxvTvRye8OOBQPUraEeb2Oc10/2bLC3SLH8R1cHFE7rhXS+
         +EdSM/r42lySYpYAmSABNS4HOcrqvHZMvUv4dsDFVhZuEmr09kbrr8PvBQDiwrR0V6AA
         fIJkpIQ1iiMCkAbqgNI/jb+9dFurLhwaN8qOaLeUAo8RiarOf3FKuXDOfPSspWRv/mEH
         mXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gPOF8792pAodFZ89Hcyn7vZCI9fDT8d3Vp/YneyP9cc=;
        b=gbxVpgx9DDAYt3CcJLuMOZ++TlJeHYxLjle1T8QFbGH4sXefAzwKfpj0x8jXh6Y0lc
         yzDEP212ZfA2P9UugprGPKkx6+piW85haZTHjPGFSBgOt/CLjXL1rFXXsdm/5ufyBKhQ
         6kalp3Vs75I1YAIt3CQVbxljbdIJM8QMFsxaZWxCrZxlSrKj3Ogiienpo4aazP7awVx/
         XfXU5u+sEagFajpBlNAB4oCtwQgJcfP1LIMia+koub8QTQhD6WR8bY3p2Kqcgc+0Xf22
         hNlVmDj8un3PKZP8HEvSqjbNvx1MGUb3y8XRRx+EeU+4RwNZfmd7Hh9s9WvXTeQSaBFx
         9N7Q==
X-Gm-Message-State: AODbwcBK+WRGfdWsMu3WFWJjymHDoHraErAWEA4xgbo7cNgUWIDLn1BD
        tQZWXTDKVqkEppjZkJ4epw==
X-Received: by 10.99.178.19 with SMTP id x19mr22160897pge.89.1496165502561;
        Tue, 30 May 2017 10:31:42 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:41 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 18/33] diff: convert diff_flush_patch_id to struct object_id
Date:   Tue, 30 May 2017 10:30:54 -0700
Message-Id: <20170530173109.54904-19-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff.c      | 12 ++++++------
 diff.h      |  2 +-
 patch-ids.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index a8ceeb024..dd325e616 100644
--- a/diff.c
+++ b/diff.c
@@ -4584,7 +4584,7 @@ static void patch_id_add_mode(git_SHA_CTX *ctx, unsigned mode)
 }
 
 /* returns 0 upon success, and writes result into sha1 */
-static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1, int diff_header_only)
+static int diff_get_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -4656,9 +4656,9 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 		if (diff_filespec_is_binary(p->one) ||
 		    diff_filespec_is_binary(p->two)) {
 			git_SHA1_Update(&ctx, oid_to_hex(&p->one->oid),
-					40);
+					GIT_SHA1_HEXSZ);
 			git_SHA1_Update(&ctx, oid_to_hex(&p->two->oid),
-					40);
+					GIT_SHA1_HEXSZ);
 			continue;
 		}
 
@@ -4671,15 +4671,15 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 				     p->one->path);
 	}
 
-	git_SHA1_Final(sha1, &ctx);
+	git_SHA1_Final(oid->hash, &ctx);
 	return 0;
 }
 
-int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1, int diff_header_only)
+int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	int result = diff_get_patch_id(options, sha1, diff_header_only);
+	int result = diff_get_patch_id(options, oid, diff_header_only);
 
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
diff --git a/diff.h b/diff.h
index fcf334bb6..150f1c5a1 100644
--- a/diff.h
+++ b/diff.h
@@ -354,7 +354,7 @@ extern int run_diff_files(struct rev_info *revs, unsigned int option);
 extern int run_diff_index(struct rev_info *revs, int cached);
 
 extern int do_diff_cache(const struct object_id *, struct diff_options *);
-extern int diff_flush_patch_id(struct diff_options *, unsigned char *, int);
+extern int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
 
 extern int diff_result_code(struct diff_options *, int);
 
diff --git a/patch-ids.c b/patch-ids.c
index aab26cbbb..a70a291d8 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -22,7 +22,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 	else
 		diff_root_tree_sha1(commit->object.oid.hash, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, oid->hash, diff_header_only);
+	return diff_flush_patch_id(options, oid, diff_header_only);
 }
 
 /*
-- 
2.13.0.219.gdb65acc882-goog

