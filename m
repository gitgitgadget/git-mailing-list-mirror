Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0C81F463
	for <e@80x24.org>; Wed, 11 Sep 2019 18:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfIKSVS (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 14:21:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38563 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfIKSVS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 14:21:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so25652247wrx.5
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yw34tZuxF7paVqcDxC9Kwa7pJwDI8PLzsYdCvILdBKk=;
        b=dzn81nZJsKveB55zTH0HjWj+RLpLLjOi/Pr2ZPSX3T6EwtSjTQnKxIdR45czN+Eh1x
         O2e7saY8AjqioQkDFZWbIJ5MUUsY1lgbqtDbmjnavmPSmFStwS1iu4ykR5hb1gLem/6V
         8LIsOCCHpPSESif527RuIa9AxbJ5UmNQVEb5mUvBHvVsR++cDTUSWbm2AmMC2Bt9BzBN
         imoI0KkCR1yZcBexjhriNKkd5sOKoJ0/LkS8YMj3xkbeIISo84m1LpllyP2f24FSs0th
         SaH9vSktZFT/GJ3NAJxShijHoZRtHjASWc/n3jTcV5b+w2idu7DP24eIspz+Nl9rIjR8
         amyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yw34tZuxF7paVqcDxC9Kwa7pJwDI8PLzsYdCvILdBKk=;
        b=tLZB72CxqJ8mQC54kEXeJT0KPf51BStHDJC/S9F4E2H/t3bXlhQUPkXSrBPzlGi6L4
         LRgiIQCthL/oC8mU2mmJm7IJGCihYlOT9gPKxXjcLscK4EsR7hjEK2PiCH1q7onZdH48
         TABJzrss2mdjCeIOO0+DMKST5Xyk4DivYmRmC9uCqDvOK8VmnQxFd4F3e5Nb60Re2ysv
         qhpWEyWONlaI3f96sWlZUg4AuYXkgBMC3gFfMNuY4pxdp1Q3goEs2RDHddeanGD9W5hb
         Yl2lyGAzX5FsobZkVZnRgP1yVzfBZ866LiOlZNGGipzKgCh1bIjb+CRCpXjoJw+c2qY3
         NxHw==
X-Gm-Message-State: APjAAAVBQ8RUnHC0mS2EcdAaosFY7S5kyZmgGPWsZ8Z5WfgJhQ0GI2t0
        7r1m3xSQwKpaUzZL3+oU/6z9CHNH
X-Google-Smtp-Source: APXvYqyfZrBqzWzQVUgwh/+Ab6OHifY9pD+JRrCE4eWS6HKt5acwN+iq/FC274yCWZsBeBnbtxCQSw==
X-Received: by 2002:a5d:6647:: with SMTP id f7mr32006774wrw.170.1568226075833;
        Wed, 11 Sep 2019 11:21:15 -0700 (PDT)
Received: from localhost ([95.148.214.9])
        by smtp.gmail.com with ESMTPSA id l62sm6185935wml.13.2019.09.11.11.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 11:21:15 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 3/3] stash: make sure to write refreshed cache
Date:   Wed, 11 Sep 2019 19:20:27 +0100
Message-Id: <20190911182027.41284-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190911182027.41284-1-t.gummerer@gmail.com>
References: <20190903191041.10470-1-t.gummerer@gmail.com>
 <20190911182027.41284-1-t.gummerer@gmail.com>
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
index b5a301f24d..ab30d1e920 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -396,7 +396,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	const struct object_id *bases[1];
 
 	read_cache_preload(NULL);
-	if (refresh_cache(REFRESH_QUIET))
+	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
 		return -1;
 
 	if (write_cache_as_tree(&c_tree, 0, NULL))
@@ -485,7 +485,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	}
 
 	if (quiet) {
-		if (refresh_cache(REFRESH_QUIET))
+		if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
 			warning("could not refresh index");
 	} else {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -1129,7 +1129,10 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	prepare_fallback_ident("git stash", "git@stash");
 
 	read_cache_preload(NULL);
-	refresh_cache(REFRESH_QUIET);
+	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0) < 0) {
+		ret = -1;
+		goto done;
+	}
 
 	if (get_oid("HEAD", &info->b_commit)) {
 		if (!quiet)
@@ -1290,7 +1293,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		free(ps_matched);
 	}
 
-	if (refresh_cache(REFRESH_QUIET)) {
+	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0)) {
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

