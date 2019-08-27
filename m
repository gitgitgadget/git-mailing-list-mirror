Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9E11F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfH0KOX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:14:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37581 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfH0KOW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:14:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so18210643wrt.4
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 03:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfm5T3ociK+alscJ3JBn+v125WYhO99IaaXdi4KFHVU=;
        b=s3ampqj7pD98qi8Whz8jMUhpoSGkcIbO+U5YwIsNO9UbIMcGXrKk2BDxjjIaMi9XgM
         VNK4OIAF+8CCfKZsdSWwvB7Pfb39Q6CBUayMPE6uNiFZrvsj4qWhDUWCKaBX8QFw6X56
         dGgHWUAO9lnnsKHqxsCIEFzzdUT9R4THVl6aeo0r4HBCri4ZGnPvOXWUoKVjCWS1JooP
         FyQJM5VQ4nIV2C0MYP1k5AIc2ZR0OpR35np10pEbQBfUgJKaBVPHYY8vATb+7XrsIUVA
         c5DPegzxZenA6xz4zjvpArMPedkptJTVp4Qcn6yppNshPjLnnNJhasqudAk+WqQCL/Mn
         5WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfm5T3ociK+alscJ3JBn+v125WYhO99IaaXdi4KFHVU=;
        b=sU5spp4dd5u49IRB92t/84D3SRF175qo5+5RP5N/UhjnbFtywFCO/XUae+P9sb6oUH
         kQjXimIeFEoVdbDT6RglE3gxYir7pqZ3Y6WV6z/3S/Zubc9ywkiza5zQBWSiU1kl9L4Q
         iJS5gXa8mk21RVcKFvpKKsy2nD2+G2i72yAJh6f/OFJEKpMX+ehYaIvBE9S2CPKFVUg0
         zi5mAxK8tt326UvPox4TQ+KgGTJWcfnh6muNyVB2v3ZnMVsuiBTgj90ZW5L/hw+QdUEe
         Kowh4nSVCBDP3aM85AUOfbNVSuurZs5UQeX2s3j6IRx7x05oQN4qvLTIj0/BfHt9+y1n
         dOMA==
X-Gm-Message-State: APjAAAV+8dk5uAyWJs/bovgDLQYx1xsrxe5VarGKTJ8vsNxYi2X1WOcc
        JZXrMdpOXfmG4h04/CVI4gjOvJ0T
X-Google-Smtp-Source: APXvYqxkzjRPquvZrq9xkn4CXIynwtY+IPB+KNS7iZ98Nn7bGph+TX8oRJgpsLEkQ0Cps/y6IpbZ+w==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr28163411wrn.197.1566900860865;
        Tue, 27 Aug 2019 03:14:20 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id r15sm15442024wrj.68.2019.08.27.03.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 03:14:20 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/3] stash: make sure to write refreshed cache
Date:   Tue, 27 Aug 2019 11:14:08 +0100
Message-Id: <20190827101408.76757-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190827101408.76757-1-t.gummerer@gmail.com>
References: <20190827101408.76757-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When converting stash into C, calls to 'git update-index --refresh'
were replaced with the 'refresh_cache()' function.  That is fine as
long as the index is only needed in-core, and not re-read from disk.

However in many cases we do actually need the refreshed index to be
written to disk, for example 'merge_recursive_generic()' discards the
in-core index before re-reading it from disk, and in the case of 'apply
--quiet', the 'refresh_cache()' we currently have is pointless without
writing the index to disk.

Always write the index after refreshing it to ensure there are no
regressions in this compared to the scripted stash.  In the future we
can consider avoiding the write where possible after making sure none
of the subsequent calls actually need the refreshed cache, and it is
not expected to be refreshed after stash exits or it is written
somewhere else already.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c  | 11 +++++++----
 t/t3903-stash.sh | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index b5a301f24d..b36aada644 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -396,7 +396,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	const struct object_id *bases[1];
 
 	read_cache_preload(NULL);
-	if (refresh_cache(REFRESH_QUIET))
+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK))
 		return -1;
 
 	if (write_cache_as_tree(&c_tree, 0, NULL))
@@ -485,7 +485,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	}
 
 	if (quiet) {
-		if (refresh_cache(REFRESH_QUIET))
+		if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK))
 			warning("could not refresh index");
 	} else {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -1129,7 +1129,10 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	prepare_fallback_ident("git stash", "git@stash");
 
 	read_cache_preload(NULL);
-	refresh_cache(REFRESH_QUIET);
+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK) < 0) {
+		ret = -1;
+		goto done;
+	}
 
 	if (get_oid("HEAD", &info->b_commit)) {
 		if (!quiet)
@@ -1290,7 +1293,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		free(ps_matched);
 	}
 
-	if (refresh_cache(REFRESH_QUIET)) {
+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK)) {
 		ret = -1;
 		goto done;
 	}
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b8e337893f..392954d6dd 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1241,4 +1241,20 @@ test_expect_success 'stash --keep-index with file deleted in index does not resu
 	test_path_is_missing to-remove
 '
 
+test_expect_success 'stash apply should succeed with unmodified file' '
+	echo base >file &&
+	git add file &&
+	git commit -m base &&
+
+	# now stash a modification
+	echo modified >file &&
+	git stash &&
+
+	# make the file stat dirty
+	cp file other &&
+	mv other file &&
+
+	git stash apply
+'
+
 test_done
-- 
2.23.0.rc2.194.ge5444969c9

