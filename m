Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F611F461
	for <e@80x24.org>; Tue,  3 Sep 2019 19:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfICTKw (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 15:10:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33879 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfICTKv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 15:10:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18so18698887wrn.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hcA0Bspg3f8ygchyDR4io5pI04x1+XX1RvPobfl6o48=;
        b=clqxaEVsWsRI7C9Hv7QQHOQBIWRn1WhfiBIkir/DC5HlspBrTx8DevLJyiul64mZxp
         CgmH57cqtox7V1M5XCjNAc1jsMixEjnpj8dbZVNPaPaJjT1twnj0CUQnsmM61nCyFUqw
         HSW1Y1lk5PvsNcHfk9KCUyEv5Ds82YWV+VQsQihpqHwRD+L7Px2ts5zYskwRhJ6N3pCz
         vrIZaHhcKbjIBqXHPeRosHK087Aa2HUSzsiRNsLiKzZfumRLRWwSJimpHh5mWMVlR7h1
         5AVVt6H+ZJIvMK10HnYOsqv1lh5rs9MZSn/ofiCv/dOg5c1WkMS6qQpRFC+PTX5Kvno+
         J7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hcA0Bspg3f8ygchyDR4io5pI04x1+XX1RvPobfl6o48=;
        b=MDETcRE3LDANDjuoZeYmwYAG4481JsZctfSrJSbKGPoQEeBbx6biT6eyV9KONP8Ty6
         oAL82GkDQavMkzcqsRwE5gZFbHKC3SHLyPfWBvPtb1M8Yn1VqGKKb/y7/kCIt45P8AH0
         J5NedbveHbU+XW2GhiRQhD33caVxHOXAJn3MoQkftV6n1ONXazp4Hc9W4lsnD1r43e9s
         sYlC17YDy71y8XAvBJicQTDGZ9tY3glQPjn86ErKMYOlqL6g1K8uW+Lb1dEllLgfA86N
         sOETMOhBHoIM4MqxYM76mFdpVHSj5ugzRJlSh28ZbxmElo0+t0mNzVhw3aFhkX43cbiP
         165Q==
X-Gm-Message-State: APjAAAXJzIU1srL7Q3S2pDKQWQxF8dCOEizEGb38Fks8Ae4wG26H3FuC
        h1flCDp7PcNqWnB4rULbQ/qz23bT
X-Google-Smtp-Source: APXvYqyX0UcutCBdh3RsFZ5x2Dz3kyG1aPjM37BBZn1nHhU+VNWMMVMsqdwM0HBngTLt88ZI6W8QGQ==
X-Received: by 2002:adf:ee4a:: with SMTP id w10mr29873940wro.138.1567537849351;
        Tue, 03 Sep 2019 12:10:49 -0700 (PDT)
Received: from localhost ([95.148.214.9])
        by smtp.gmail.com with ESMTPSA id g73sm593503wme.10.2019.09.03.12.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 12:10:48 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/3] stash: make sure to write refreshed cache
Date:   Tue,  3 Sep 2019 20:10:41 +0100
Message-Id: <20190903191041.10470-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190903191041.10470-1-t.gummerer@gmail.com>
References: <20190829182748.43802-1-t.gummerer@gmail.com>
 <20190903191041.10470-1-t.gummerer@gmail.com>
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
index b5a301f24d..da1260ca8e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -396,7 +396,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	const struct object_id *bases[1];
 
 	read_cache_preload(NULL);
-	if (refresh_cache(REFRESH_QUIET))
+	if (refresh_and_write_cache(REFRESH_QUIET, 0))
 		return -1;
 
 	if (write_cache_as_tree(&c_tree, 0, NULL))
@@ -485,7 +485,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	}
 
 	if (quiet) {
-		if (refresh_cache(REFRESH_QUIET))
+		if (refresh_and_write_cache(REFRESH_QUIET, 0))
 			warning("could not refresh index");
 	} else {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -1129,7 +1129,10 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	prepare_fallback_ident("git stash", "git@stash");
 
 	read_cache_preload(NULL);
-	refresh_cache(REFRESH_QUIET);
+	if (refresh_and_write_cache(REFRESH_QUIET, 0) < 0) {
+		ret = -1;
+		goto done;
+	}
 
 	if (get_oid("HEAD", &info->b_commit)) {
 		if (!quiet)
@@ -1290,7 +1293,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		free(ps_matched);
 	}
 
-	if (refresh_cache(REFRESH_QUIET)) {
+	if (refresh_and_write_cache(REFRESH_QUIET, 0)) {
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

