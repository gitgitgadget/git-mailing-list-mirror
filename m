Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D213C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D8761166
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347598AbhERIv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 04:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbhERIv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 04:51:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2DAC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:50:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t11so5170986pjm.0
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UOi+WQpEB3KtFsQnJQhMEBa7p6Yx1IcXPN9fzOTT6nU=;
        b=oK3CvGfJDCMn10aStYMaa1RwRgcos/gJ2G73UqUC9GEdh1fLpCcrTNek1txJNem0gj
         aDJEVJA5M6mD4TF6I0rktp29Lxr7yDs8WxmXNMCMAhGLmplOEE8T+45H3DU8dwyb2t/F
         jmN3S45wPW+uXdujAe97dPdceQKaZM9rT5FYZYsUPehtNDHVsJQWXmgKdhRQhyc3MUOn
         Tyu3X2xobaMFc6EJwZYUScvI4YGA88VuhytZQz6ut60wBsVTdp/GezSrZCnrhZXXGNrn
         +HT0aS5AWiUY9JOQntoeo5+5cb17XzVelqAEhMVx4ATgL4z7s2KNVYvWn5vi4vv6h4Ks
         UAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UOi+WQpEB3KtFsQnJQhMEBa7p6Yx1IcXPN9fzOTT6nU=;
        b=a4a3auGbZajC0Jv+NdAfLjHYWJ2m9khwOf2tUcKOYObyUQME6AsZOD9gCg25uzC/nK
         pXn9WM22/FhBD+41jjzwvPJWEgSgWPa5pE9KbJIRuBXSXgIHIzgVIM/HMFJ8CHo4DYea
         ZPHGvbm4IcLZFksl1vW0TfrOfjczUU+7hxDxFVaterL7YMLmoIgx2KFraVK1eoqgD0Ob
         ExhhL53FSbXrekKKOAuCE07Rzyp2d/DSKHA5/xLNUXQAHtFFiKyjwFxqyuPAD3GxpNWy
         CefeuNaZjTQ0dWJ71zG3j4o2jiWlh2G45tGwdidTY8cBl4J/YbyJj/fof5F7IMPxtzyE
         aAlA==
X-Gm-Message-State: AOAM530oxk2quKqmHIcKS7VcHJVDn/I0i7QKNcW0BEk/qxFhvaHEOzUI
        /x7dZxfCl4Il292a6ULKVHt3+nMusbxxgfj0aNo=
X-Google-Smtp-Source: ABdhPJxGpOaMIxPQOn4y8moC0cHCfjofpPya7Ix1IRk79FADoHCUmbWaykXJoeFlfy+oX0UAq1OD/Q==
X-Received: by 2002:a17:90b:a52:: with SMTP id gw18mr4459819pjb.88.1621327838172;
        Tue, 18 May 2021 01:50:38 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.147])
        by smtp.gmail.com with ESMTPSA id t1sm12231076pjo.33.2021.05.18.01.50.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 01:50:37 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, avarab@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v2 3/3] t5702: excluding commits with packfile-uris
Date:   Tue, 18 May 2021 16:49:53 +0800
Message-Id: <e824cc26a7a85673800429fd320279f3b6198576.1621327467.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g7e39198978.dirty
In-Reply-To: <cover.1621327467.git.dyroneteng@gmail.com>
References: <cover.1621327467.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modify the logic of configure_exclusion to support the processing of
commits objects and add test cases for excluding commit objects
(recursive and non-recursive).

Replace "rm..." in the original test with "test_when_finished...".
Replace "git commit..." in the original test with "test_commit...".

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t5702-protocol-v2.sh | 145 +++++++++++++++++++++++++++++++----------
 1 file changed, 111 insertions(+), 34 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 2e1243ca40..2148bfcda1 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -753,7 +753,7 @@ test_expect_success 'ls-remote with v2 http sends only one POST' '
 '
 
 test_expect_success 'push with http:// and a config of v2 does not request v2' '
-	test_when_finished "rm -f log" &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child log" &&
 	# Till v2 for push is designed, make sure that if a client has
 	# protocol.version configured to use v2, that the client instead falls
 	# back and uses v0.
@@ -776,7 +776,7 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 '
 
 test_expect_success 'when server sends "ready", expect DELIM' '
-	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child" &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
@@ -796,7 +796,7 @@ test_expect_success 'when server sends "ready", expect DELIM' '
 '
 
 test_expect_success 'when server does not send "ready", expect FLUSH' '
-	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child log &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child log" &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
@@ -824,17 +824,39 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 '
 
 configure_exclusion () {
-	git -C "$1" hash-object "$2" >objh &&
-	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
-	git -C "$1" config --add \
-		"uploadpack.blobpackfileuri" \
-		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
-	cat objh
+    objt="$1"
+    P="$2"
+    recursive="$4"
+
+    if test "$objt" = "blob"
+    then
+        git -C "$P" hash-object "$3" >objh &&
+        git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+        git -C "$P" config --add \
+                "uploadpack.excludeobject" \
+                "$(cat objh) $recursive $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+        cat objh
+    elif test "$objt" = "commit"
+    then
+        echo "$3" >objh
+        if test "$recursive" = 0
+            then
+                git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh
+        else
+            git -C "$2" pack-objects --revs "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh
+        fi
+        git -C "$P" config --add \
+                "uploadpack.excludeobject" \
+                "$(cat objh) $recursive $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+        cat objh
+    else
+        echo "unsupported object type in configure_exclusion (got $objt)"
+    fi
 }
 
 test_expect_success 'part of packfile response provided as URI' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -843,10 +865,10 @@ test_expect_success 'part of packfile response provided as URI' '
 	git -C "$P" add my-blob &&
 	echo other-blob >"$P/other-blob" &&
 	git -C "$P" add other-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
-	configure_exclusion "$P" other-blob >h2 &&
+	configure_exclusion blob "$P" my-blob 0 >h &&
+	configure_exclusion blob "$P" other-blob 0 >h2 &&
 
 	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
 	git -c protocol.version=2 \
@@ -881,18 +903,18 @@ test_expect_success 'part of packfile response provided as URI' '
 	test_line_count = 6 filelist
 '
 
-test_expect_success 'packfile URIs with fetch instead of clone' '
+test_expect_success 'blobs packfile URIs with fetch instead of clone' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob 0 >h &&
 
 	git init http_child &&
 
@@ -902,9 +924,65 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
 		fetch "$HTTPD_URL/smart/http_parent"
 '
 
+test_expect_success 'commits(not recursively) packfile URIs with fetch instead of clone' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	test_commit -C "$P" A &&
+
+	mycommit=$(git -C "$P" rev-parse A) &&
+	echo other-blob >"$P/other-blob" &&
+	git -C "$P" add other-blob &&
+	test_commit -C "$P" B &&
+	othercommit=$(git -C "$P" rev-parse B) &&
+
+	configure_exclusion commit "$P" "$mycommit" 0 >h &&
+	configure_exclusion commit "$P" "$othercommit" 0 >h2 &&
+
+	git init http_child &&
+
+	GIT_TRACE=1 GIT_TEST_SIDEBAND_ALL=1 \
+	git -C http_child -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		fetch "$HTTPD_URL/smart/http_parent"
+'
+
+test_expect_success 'commits(recursively) packfile URIs with fetch instead of clone' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	test_commit -C "$P" A &&
+
+	mycommit=$(git -C "$P" rev-parse A) &&
+	echo other-blob >"$P/other-blob" &&
+    git -C "$P" add other-blob &&
+	test_commit -C "$P" B &&
+	othercommit=$(git -C "$P" rev-parse B) &&
+
+	configure_exclusion commit "$P" "$mycommit" 1 >h2 &&
+	configure_exclusion commit "$P" "$othercommit" 1 >h2 &&
+
+	git init http_child &&
+
+	GIT_TRACE=1 GIT_TEST_SIDEBAND_ALL=1 \
+	git -C http_child -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		fetch "$HTTPD_URL/smart/http_parent"
+'
+
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -913,9 +991,9 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	git -C "$P" add my-blob &&
 	echo other-blob >"$P/other-blob" &&
 	git -C "$P" add other-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob 0 >h &&
 	# Configure a URL for other-blob. Just reuse the hash of the object as
 	# the hash of the packfile, since the hash does not matter for this
 	# test as long as it is not the hash of the pack, and it is of the
@@ -923,8 +1001,8 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	git -C "$P" hash-object other-blob >objh &&
 	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
 	git -C "$P" config --add \
-		"uploadpack.blobpackfileuri" \
-		"$(cat objh) $(cat objh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+		"uploadpack.excludeobject" \
+		"$(cat objh) 0 $(cat objh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
 
 	test_must_fail env GIT_TEST_SIDEBAND_ALL=1 \
 		git -c protocol.version=2 \
@@ -935,16 +1013,15 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 
 test_expect_success 'packfile-uri with transfer.fsckobjects' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
-
-	configure_exclusion "$P" my-blob >h &&
+	test_commit -C "$P" A &&
+	configure_exclusion blob "$P" my-blob 0 >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -959,7 +1036,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
 
 test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -976,9 +1053,9 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob 0 >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -989,7 +1066,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
 
 test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmodules is separate from tree' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child &&
+	test_when_finished "rm -rf \"$P\" http_child" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -1000,7 +1077,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
 	git -C "$P" add .gitmodules &&
 	git -C "$P" commit -m x &&
 
-	configure_exclusion "$P" .gitmodules >h &&
+	configure_exclusion blob "$P" .gitmodules 0 >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -1015,7 +1092,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
 
 test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodules separate from tree is invalid' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child err &&
+	test_when_finished "rm -rf \"$P\" http_child err" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -1024,9 +1101,9 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 	echo "path = include/foo" >>"$P/.gitmodules" &&
 	echo "url = git://example.com/git/lib.git" >>"$P/.gitmodules" &&
 	git -C "$P" add .gitmodules &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" .gitmodules >h &&
+	configure_exclusion blob "$P" .gitmodules 0 >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
-- 
2.31.1.442.g7e39198978.dirty

