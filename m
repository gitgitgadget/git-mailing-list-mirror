Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862FEC433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DAC64DEE
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhBOSZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhBOSZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:25:04 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6D5C061756
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:24:24 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id c3so6568890qkj.11
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=On446vB1kX6OsrXY54dxIWGnHu3mD+ojsVWIevhWbRQ=;
        b=nQFIUyQtGYlXyv/5/Px7ofwS8SaCuqHehcL8umP0i2FEBiuEIKLerV7W7RKpk9aNsK
         CwF6ZSFlwgmGW58gillHYmy4ZQ87ZS8/SUTPcbvGZWWFGlLJWuuXke8QifncC0eQjKt8
         2md9FT7UPpdL1Z+Y6AJCRj3N7lCAuzUJRXansFCkqt7w5q6wf8dIxCBKSWQoPqlhC9GX
         wbArY2dElJ3PimiMjLITeC35ATO4aSE2tGcq2B/XB3s0ux/eVP7jbglHib1FbPN6oJ4J
         e5Sb3rUSymEKSheRIA9/JEKX+mn8DO6QCve8DLN4Fg2pbLcLwpnssUCvhMbGWpUpZET5
         LBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=On446vB1kX6OsrXY54dxIWGnHu3mD+ojsVWIevhWbRQ=;
        b=WcrfBLLjMbU3iyT+7nM0LMoIWaM2FbbHHqajxVwcijE0Tgz3s/U0lgZQ1/E4rvrggk
         ZtNPBpbbFYCqN0miML/qwCrgozIrgmYhUqPAErBuMULYUNgBxfYvdhYJlgWOjJe/NQ4R
         gildkDBsfQ2pobT3acuaun9ZY8xhjfU5stOfQ98DO4BM8Vq0JmQ8H2DY/E0ZdPtv8oIk
         SqHlw3OAFLhCq/ZVSsfk+CtF7hHc2X5djKguZ/uxqC8HYLcG4vQwjYR5PF9J3xqNYFOZ
         J6G+6TkzfIugPWZ3vb7vyKPyGcrphHmLWrBZdWzS3o2Bnc1+xu+ccykP13Pahjq611dG
         28Bw==
X-Gm-Message-State: AOAM5305wQ+v3pinyL3WOzK57jYqmECxKWCeHM+jwjEoL3JIh+mLG4/8
        rZb1LQVxhdnW5jVCFIZhW1rFJVsz59ZLFA==
X-Google-Smtp-Source: ABdhPJzeUM4e6pUiZnOqgfoVCGMak7r0B7zZ/0SIJdsNDVmFWQ7L6yCLDq8xpD2W44Bqy2hIaBQ/uQ==
X-Received: by 2002:a37:61cd:: with SMTP id v196mr8647509qkb.341.1613413463065;
        Mon, 15 Feb 2021 10:24:23 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o5sm12305716qkh.59.2021.02.15.10.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:24:22 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 1/2] write_entry(): fix misuses of `path` in error messages
Date:   Mon, 15 Feb 2021 15:24:12 -0300
Message-Id: <bdda5f99d031abad65c296a61b3713f60d22ef16.1613411136.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613411136.git.matheus.bernardino@usp.br>
References: <cover.1613411136.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variables `path` and `ce->name`, at write_entry(), usually have the
same contents, but that's not the case when using a checkout prefix or
writing to a tempfile. (In fact, `path` will be either empty or dirty
when writing to a tempfile.) Therefore, these variables cannot be used
interchangeably. In this sense, fix wrong uses of `path` in error
messages where it should really be `ce->name`, and add some regression
tests. (Note: there doesn't seem to be any misuse in the other way
around.)

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c                         |  8 ++++----
 t/t2006-checkout-index-basic.sh | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index a0532f1f00..7b9f43716f 100644
--- a/entry.c
+++ b/entry.c
@@ -282,7 +282,7 @@ static int write_entry(struct cache_entry *ce,
 		new_blob = read_blob_entry(ce, &size);
 		if (!new_blob)
 			return error("unable to read sha1 file of %s (%s)",
-				     path, oid_to_hex(&ce->oid));
+				     ce->name, oid_to_hex(&ce->oid));
 
 		/*
 		 * We can't make a real symlink; write out a regular file entry
@@ -309,7 +309,7 @@ static int write_entry(struct cache_entry *ce,
 			new_blob = read_blob_entry(ce, &size);
 			if (!new_blob)
 				return error("unable to read sha1 file of %s (%s)",
-					     path, oid_to_hex(&ce->oid));
+					     ce->name, oid_to_hex(&ce->oid));
 		}
 
 		/*
@@ -354,7 +354,7 @@ static int write_entry(struct cache_entry *ce,
 
 	case S_IFGITLINK:
 		if (to_tempfile)
-			return error("cannot create temporary submodule %s", path);
+			return error("cannot create temporary submodule %s", ce->name);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
 		sub = submodule_from_ce(ce);
@@ -365,7 +365,7 @@ static int write_entry(struct cache_entry *ce,
 		break;
 
 	default:
-		return error("unknown file mode for %s in index", path);
+		return error("unknown file mode for %s in index", ce->name);
 	}
 
 finish:
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index 8e181dbf01..d0d7c3f71c 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -32,4 +32,27 @@ test_expect_success 'checkout-index reports errors (stdin)' '
 	test_i18ngrep not.in.the.cache stderr
 '
 
+test_expect_success 'checkout-index --temp correctly reports error on missing blobs' '
+	test_when_finished git reset --hard &&
+	missing_blob=$(git hash-object --stdin </dev/null) &&
+	cat >objs <<-EOF &&
+	100644 $missing_blob	file
+	120000 $missing_blob	symlink
+	EOF
+	git update-index --index-info <objs &&
+
+	test_must_fail git checkout-index --temp symlink file 2>stderr &&
+	test_i18ngrep "unable to read sha1 file of file ($missing_blob)" stderr &&
+	test_i18ngrep "unable to read sha1 file of symlink ($missing_blob)" stderr
+'
+
+test_expect_success 'checkout-index --temp correctly reports error for submodules' '
+	git init sub &&
+	test_commit -C sub file &&
+	git submodule add ./sub &&
+	git commit -m sub &&
+	test_must_fail git checkout-index --temp sub 2>stderr &&
+	test_i18ngrep "cannot create temporary submodule sub" stderr
+'
+
 test_done
-- 
2.29.2

