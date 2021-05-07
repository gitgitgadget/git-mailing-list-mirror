Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490CCC433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 02:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1439361029
	for <git@archiver.kernel.org>; Fri,  7 May 2021 02:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhEGCMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 22:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbhEGCMr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 22:12:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF18EC061761
        for <git@vger.kernel.org>; Thu,  6 May 2021 19:11:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b3so4363470plg.11
        for <git@vger.kernel.org>; Thu, 06 May 2021 19:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hS1pMBPWqkfWwL92CSrGhfOvxvte32xZmlNmOtpY1gk=;
        b=PPCFVdMUtsPp6qwmNy5/UNHHUCV0Vfk6Y4tWQkdWydq4OLSpymDW4RNhozxiuDierF
         rhvZJnPIqXYjRkMEMDOKUraivAViU0X/Ae559B3Lb5hJwLf65oBbKVa5AudotkEd3zGG
         1WurgwWYvsfykIXNt85ZKGYfP2IENPfwIBkDWJSmf6N0J+rmz5GqJm2Vb7Dxwl961Aaw
         kepcHWyjSEjES2uTgKiUvAyvmHrTCWRvGdKL5nlK5Ap+XJgSHBXLmRSlywAXGp9V+XFe
         0sfzOUQmrSaaN+GigG14YfidlSNzoJtAM5wm/iFsraHGIIhdBReuPHImjZ1Nh6y6PHIN
         Cptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hS1pMBPWqkfWwL92CSrGhfOvxvte32xZmlNmOtpY1gk=;
        b=WmM9KbrYWFNW9ILr483AvMJfloZm4hSNLEIC+ua2EaPZVWXkzUQQIBGMy55OimOn48
         h+k5fyAVjcU7WaonMKUBwupk34txnHdQEeYw2g0aK2gr79amtGB4O2j1GUZN2CHVb+Kr
         bC9G+up+vIwzJPpp6Srevec/+buPcZLznpkTrV1e23KGuKYosd7VFVVKVQofG9TgMC36
         3TObLecY9vHgNeYmxvQ2TRrsvzqxSXHNzsM8q2FfMQIA/gqvUL5MX6Y3pS3/ws82tJAg
         J7BFX6KbIGQ+Lb6KOTzVhUT7+Hi8YLuVe2P8gNPby66IaT52WU5gC/nyNETfU9wp45vN
         oRPw==
X-Gm-Message-State: AOAM530YFAlRpPsBmgXS27n7BrgS8ciXe44RTMov5wSZw/DUxt1G7l5u
        edyjnFh214X6wbTLDEmKkTdjC41BUyfBsJyRKy0Uyg==
X-Google-Smtp-Source: ABdhPJyJjCZ/uJTiTlB33VcBEcUU5pk75M+acKWFaKpzFhkuf4wNRWvqBsJ4/y/yoH8ClKx9R2dNFQ==
X-Received: by 2002:a17:902:f686:b029:ee:fa93:95af with SMTP id l6-20020a170902f686b02900eefa9395afmr7495819plg.83.1620353508165;
        Thu, 06 May 2021 19:11:48 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.95])
        by smtp.gmail.com with ESMTPSA id l35sm2933363pgm.10.2021.05.06.19.11.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 19:11:47 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH] Packfile-uris support excluding commit objects
Date:   Fri,  7 May 2021 10:11:40 +0800
Message-Id: <20210507021140.31372-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g7e39198978.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On the server, more sophisticated means of excluding objects should be
supported, such as commit object. This commit introduces a new
configuration `uploadpack.commitpackfileuri` for this.

This patch only pack the commit object, not including the that commit
and all objects that it references. This work will be done in a further
patch recently.

Similarly, there are related documents that will be included in
subsequent patches.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c |  8 ++---
 fetch-pack.c           |  8 +++++
 t/t5702-protocol-v2.sh | 71 +++++++++++++++++++++++++++++++++---------
 upload-pack.c          |  7 +++--
 4 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d13cd3e1a..2f1817fe28 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2985,7 +2985,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			pack_idx_opts.flags &= ~WRITE_REV;
 		return 0;
 	}
-	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
+    if (!strcmp(k, "uploadpack.blobpackfileuri") || !strcmp(k, "uploadpack.commitpackfileuri")) {
 		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
 		const char *oid_end, *pack_end;
 		/*
@@ -2998,11 +2998,11 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		    *oid_end != ' ' ||
 		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||
 		    *pack_end != ' ')
-			die(_("value of uploadpack.blobpackfileuri must be "
-			      "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
+            die(_("value of uploadpack.blobpackfileuri or upload.commitpackfileuri must be "
+                  "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
 		if (oidmap_get(&configured_exclusions, &ex->e.oid))
 			die(_("object already configured in another "
-			      "uploadpack.blobpackfileuri (got '%s')"), v);
+			      "uploadpack.blobpackfileuri or uploadpack.commitpackfileuri (got '%s')"), v);
 		ex->pack_hash_hex = xcalloc(1, pack_end - oid_end);
 		memcpy(ex->pack_hash_hex, oid_end + 1, pack_end - oid_end - 1);
 		ex->uri = xstrdup(pack_end + 1);
diff --git a/fetch-pack.c b/fetch-pack.c
index 2318ebe680..24a947835b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -23,6 +23,7 @@
 #include "fetch-negotiator.h"
 #include "fsck.h"
 #include "shallow.h"
+#include "strmap.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -1677,6 +1678,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
+	struct strset uris;
+	strset_init(&uris);
 	for (i = 0; i < packfile_uris.nr; i++) {
 		int j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1684,6 +1687,11 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		const char *uri = packfile_uris.items[i].string +
 			the_hash_algo->hexsz + 1;
 
+        if (strset_contains(&uris, uri)) {
+            continue;
+        }
+
+        strset_add(&uris, uri);
 		strvec_push(&cmd.args, "http-fetch");
 		strvec_pushf(&cmd.args, "--packfile=%.*s",
 			     (int) the_hash_algo->hexsz,
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 2e1243ca40..d444177fb5 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -824,12 +824,22 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 '
 
 configure_exclusion () {
-	git -C "$1" hash-object "$2" >objh &&
-	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
-	git -C "$1" config --add \
-		"uploadpack.blobpackfileuri" \
-		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
-	cat objh
+    if test "$1" = "blob"
+        then
+            git -C "$2" hash-object "$3" >objh &&
+            git -C "$2" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+            git -C "$2" config --add \
+            		"uploadpack.blobpackfileuri" \
+            		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+            cat objh
+        else
+            echo "$3" > objh &&
+            git -C "$2" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+            git -C "$2" config --add \
+            		"uploadpack.commitpackfileuri" \
+            		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+            cat objh
+    fi
 }
 
 test_expect_success 'part of packfile response provided as URI' '
@@ -845,8 +855,8 @@ test_expect_success 'part of packfile response provided as URI' '
 	git -C "$P" add other-blob &&
 	git -C "$P" commit -m x &&
 
-	configure_exclusion "$P" my-blob >h &&
-	configure_exclusion "$P" other-blob >h2 &&
+	configure_exclusion blob "$P" my-blob >h &&
+	configure_exclusion blob "$P" other-blob >h2 &&
 
 	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
 	git -c protocol.version=2 \
@@ -881,7 +891,7 @@ test_expect_success 'part of packfile response provided as URI' '
 	test_line_count = 6 filelist
 '
 
-test_expect_success 'packfile URIs with fetch instead of clone' '
+test_expect_success 'blobs packfile URIs with fetch instead of clone' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	rm -rf "$P" http_child log &&
 
@@ -892,7 +902,7 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
 	git -C "$P" add my-blob &&
 	git -C "$P" commit -m x &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob >h &&
 
 	git init http_child &&
 
@@ -902,6 +912,37 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
 		fetch "$HTTPD_URL/smart/http_parent"
 '
 
+test_expect_success 'commits packfile URIs with fetch instead of clone' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+
+	mycommit=$(git -C "$P" rev-parse HEAD) &&
+    echo other-blob >"$P/other-blob" &&
+    git -C "$P" add other-blob &&
+    git -C "$P" commit -m x &&
+	othercommit=$(git -C "$P" rev-parse HEAD) &&
+	configure_exclusion commit "$P" "$mycommit" >h &&
+	configure_exclusion commit "$P" "$othercommit" >h2 &&
+
+	git init http_child &&
+
+	GIT_TRACE=1 GIT_TEST_SIDEBAND_ALL=1 \
+	git -C http_child -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		fetch "$HTTPD_URL/smart/http_parent" &&
+	ls http_child/.git/objects/pack/*.pack \
+    	    http_child/.git/objects/pack/*.idx >filelist &&
+    	test_line_count = 6 filelist
+'
+
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	rm -rf "$P" http_child log &&
@@ -915,7 +956,7 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	git -C "$P" add other-blob &&
 	git -C "$P" commit -m x &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob >h &&
 	# Configure a URL for other-blob. Just reuse the hash of the object as
 	# the hash of the packfile, since the hash does not matter for this
 	# test as long as it is not the hash of the pack, and it is of the
@@ -944,7 +985,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
 	git -C "$P" add my-blob &&
 	git -C "$P" commit -m x &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -978,7 +1019,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
 	git -C "$P" add my-blob &&
 	git -C "$P" commit -m x &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -1000,7 +1041,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
 	git -C "$P" add .gitmodules &&
 	git -C "$P" commit -m x &&
 
-	configure_exclusion "$P" .gitmodules >h &&
+	configure_exclusion blob "$P" .gitmodules >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -1026,7 +1067,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 	git -C "$P" add .gitmodules &&
 	git -C "$P" commit -m x &&
 
-	configure_exclusion "$P" .gitmodules >h &&
+	configure_exclusion blob "$P" .gitmodules >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
diff --git a/upload-pack.c b/upload-pack.c
index 5c1cd19612..34f8bb81a8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1744,9 +1744,12 @@ int upload_pack_advertise(struct repository *r,
 		     allow_sideband_all_value))
 			strbuf_addstr(value, " sideband-all");
 
-		if (!repo_config_get_string(the_repository,
+		if ((!repo_config_get_string(the_repository,
 					    "uploadpack.blobpackfileuri",
-					    &str) &&
+					    &str) ||
+            !repo_config_get_string(the_repository,
+                        "uploadpack.commitpackfileuri",
+                        &str)) &&
 		    str) {
 			strbuf_addstr(value, " packfile-uris");
 			free(str);
-- 
2.31.1.442.g7e39198978.dirty

