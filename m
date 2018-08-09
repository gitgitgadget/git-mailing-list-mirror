Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86A741F405
	for <e@80x24.org>; Thu,  9 Aug 2018 15:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbeHISVg (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 14:21:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44683 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbeHISVg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 14:21:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so5553633wrt.11
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfHQxCHCu2abG8yMBIA+jrcC95vHzyucLWTD2A3MBY4=;
        b=MMxU6NCYpHOqBZQ786zIerNCx1aaMUQojUa0MIYamRIRsDmKzNOtjet0RKhOgmiOaB
         PmNMbD8o+WBywqzZTS5WPCntHfZmOaxPAlnz/as5FBoiLfMoaMnfYU1HjBTCnCRvNcPz
         9EsQmV0mDvokcQR/wVmprPdwJlthH7SBAB6QQSyV0wJtdojtqNfKuNk7RDOm/I7NoAxw
         lblShSp+IiabEZI78Htr/1GMAvbhR6IeQrAolSn8BqUaBni4+wYcDKHUBIL0I94f3pzq
         ibR9qLEQM3K0eEy731I4i0ZVyZqD8HsbXER/vvxB9W3uk1Klzr61NbZ6m07ii8pdqBnT
         +/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfHQxCHCu2abG8yMBIA+jrcC95vHzyucLWTD2A3MBY4=;
        b=FD5ZywiwVi+02XGumk3QM6WnuJzWRLwc4/gxJ2+4pzSTejBU/QnMKh4alCFvTBR7Ut
         fLlVKwFin4Ck+0G7xBMPtCrdQx0bZPiHA/T1bWppUNS7ojv/54mcSReDnRwa7Xa860vi
         ccyvZWWp1AxH+KocTwu/Zkvg2GA49jwt2EAxYrlQVe2vMXdi6Fqqo2zPCxuO0tT49NuD
         iXhyrrbPzCSILQvuK8jwW0ixpgzJsAKNjp70gQczAZQNmbidzwFjWwSnUBo9r7KXcD5y
         6lXpqRI9DCiZ0w2fKVHAHPC9ZniKuZ97viezXCppxQsMdJC1dgx1vNegKaUy7s3Jlu9B
         VyfQ==
X-Gm-Message-State: AOUpUlEJAyQSLxcQu2BLWsqytDu2Wp29WsKQ+e7OtMoWhwGIOxz2NnjV
        cV8VKglBwsYGH0QXyikk8NMRCAtG
X-Google-Smtp-Source: AA+uWPyh7gAmsaX7yNdxotCGjH3arcnysBGfcwCuI57DCra7YpxEuOH13JJ6x+W95q7uzX9KNCY41Q==
X-Received: by 2002:a5d:48c7:: with SMTP id p7-v6mr1975462wrs.0.1533830163882;
        Thu, 09 Aug 2018 08:56:03 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t69-v6sm10913762wmt.40.2018.08.09.08.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 08:56:03 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/8] repack: add delta-islands support
Date:   Thu,  9 Aug 2018 17:55:29 +0200
Message-Id: <20180809155532.26151-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.555.g17f9c4abba
In-Reply-To: <20180809155532.26151-1-chriscool@tuxfamily.org>
References: <20180809155532.26151-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Implement simple support for --delta-islands option and
repack.useDeltaIslands config variable in git repack.

This allows users to setup delta islands in their config and
get the benefit of less disk usage while cloning and fetching
is still quite fast and not much more CPU intensive.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt     | 4 ++++
 Documentation/git-repack.txt | 5 +++++
 builtin/repack.c             | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27bb77f9e7..2bd31078b2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3145,6 +3145,10 @@ repack.packKeptObjects::
 	index is being written (either via `--write-bitmap-index` or
 	`repack.writeBitmaps`).
 
+repack.useDeltaIslands::
+	If set to true, makes `git repack` act as if `--delta-islands`
+	was passed. Defaults to `false`.
+
 repack.writeBitmaps::
 	When true, git will write a bitmap index when packing all
 	objects to disk (e.g., when `git repack -a` is run).  This
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d90e7907f4..a8b2d4722f 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -155,6 +155,11 @@ depth is 4095.
 	being removed. In addition, any unreachable loose objects will
 	be packed (and their loose counterparts removed).
 
+-i::
+--delta-islands::
+	Pass the `--delta-islands` option to `git-pack-objects`, see
+	linkgit:git-pack-objects[1].
+
 Configuration
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159e..5ab9ee69e4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -12,6 +12,7 @@
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
 static int write_bitmaps;
+static int use_delta_islands;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -40,6 +41,10 @@ static int repack_config(const char *var, const char *value, void *cb)
 		write_bitmaps = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "repack.usedeltaislands")) {
+		use_delta_islands = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -194,6 +199,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("pass --local to git-pack-objects")),
 		OPT_BOOL('b', "write-bitmap-index", &write_bitmaps,
 				N_("write bitmap index")),
+		OPT_BOOL('i', "delta-islands", &use_delta_islands,
+				N_("pass --delta-islands to git-pack-objects")),
 		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
 				N_("with -A, do not loosen objects older than this")),
 		OPT_BOOL('k', "keep-unreachable", &keep_unreachable,
@@ -267,6 +274,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_pushf(&cmd.args, "--no-reuse-object");
 	if (write_bitmaps)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
+	if (use_delta_islands)
+		argv_array_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
-- 
2.18.0.555.g17f9c4abba

