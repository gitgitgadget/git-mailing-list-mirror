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
	by dcvr.yhbt.net (Postfix) with ESMTP id C13811F461
	for <e@80x24.org>; Thu, 29 Aug 2019 18:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfH2S2N (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 14:28:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39077 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbfH2S2N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 14:28:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so4429159wra.6
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hcA0Bspg3f8ygchyDR4io5pI04x1+XX1RvPobfl6o48=;
        b=QzqpSxE6+8G6mkhLyurcco9GgvvVFhn6yJXkE3Q3AP4adje6Tw/zgS5SKEdZeISN++
         X3uAqmO7ISiEyzeqEmCptFhq1DXME7nhnzV/b8LdbJDdN8a+6MPduLttIx9cgWGzcHlJ
         NG+cZxrnuxOZnP7exrSIt9dGvLg8SwluZ1/jT46jRwGErM66dCZzskne4RRNuPI5340t
         6RaVHTbltvSzS0HcMTjpqJeMLe1UpiEEIG3bFdTxwPtvq7fYDRI69S5ZA7C0EmnjGmKE
         /KQ9ELmtjzRtKNxbMBsEo1Jvd9AIXXf+KFq4Aif9gCs3DuMW/QHHD0JRljxFXfd6LAXY
         BVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hcA0Bspg3f8ygchyDR4io5pI04x1+XX1RvPobfl6o48=;
        b=XoLrkBebVRYGMtfE2/4S/go8Mkgm9QZrM1kPbDqSewkbZny4BGkgAjmYinZE/MYK7Z
         8UqCE1YtprpguNCDMTnIFNZnYRL+iq8xDHzB/JG23F2jD1T8YBENl1YhXbhghy223tGs
         kJOY47u1HY1hsC/vWoUzKJ3SuQaixbUlgjSOPr671YuxQToNOIomwqF3r6pJ2N15xgYH
         dSu3isWfVjOzw/tfKz8bH0mcHkYjyaMYB0aeb9F+TzAE7dgJonS5eNv1lUz60eMIkUpS
         PR0g0pdkHhm65AjxPCY/YEhJMc61AyJNXuK+l/D8FXNP23UZ88iWxRQCWQcS/Ca4PIqi
         KBeg==
X-Gm-Message-State: APjAAAV7lOultUogScHYSHJzGog+BHoA8Fz0qZVv3ihMVV63tN79TGL3
        Ii/sGJ898O0ivg+OIBsWt1bf6i3z
X-Google-Smtp-Source: APXvYqwjdfJXox3DSytuorklFvhJhmOuht8lZPssWOPfVZVeB8dw8+Rzf9O5K7emcIGr9eXMCwc1bQ==
X-Received: by 2002:a5d:4245:: with SMTP id s5mr14275333wrr.334.1567103290647;
        Thu, 29 Aug 2019 11:28:10 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id h125sm5582926wmf.31.2019.08.29.11.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 11:28:09 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/3] stash: make sure to write refreshed cache
Date:   Thu, 29 Aug 2019 19:27:48 +0100
Message-Id: <20190829182748.43802-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190829182748.43802-1-t.gummerer@gmail.com>
References: <20190827101408.76757-1-t.gummerer@gmail.com>
 <20190829182748.43802-1-t.gummerer@gmail.com>
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

