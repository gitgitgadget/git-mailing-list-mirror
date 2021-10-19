Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA5C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C8A6137D
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhJSLmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbhJSLmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:42:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB05CC061746
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t7so4636981pgl.9
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xeU5XF/yxD/YIrF+nKxiwA2RS/Ezk89f5MbGGR2qIz4=;
        b=F6X59cWH8rCm/Q93rBHYsWoxfWWPWlfoRXKAk3vC12UyJXLc9nkjgQjw/yF30jilCt
         zllsRAqkD4jU5QDKCUMxWiiHag7gDIqB6r33mxrSSHeHu5fO888Sc4hlgvcYHt6+0NED
         +JFW9sy8sWBFRrC7b8Nl+g9T1DflmZ/+qXmH3zJiAzxGe3gxZ7RGLa6doQ/4pi8dL0vu
         jWtQtRcY6i3jdKyhuohD5iEV69LMbmYGoO+CKF/t9jKkemjyNc0RK30gGlb0JxTyKxmm
         pSlkGtV2gnYdV4BT+DqX+ZuM3/x4bmPj9+B0hj90HBEoWK+70S+h8YMPA/8/+UPu7ePP
         x5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xeU5XF/yxD/YIrF+nKxiwA2RS/Ezk89f5MbGGR2qIz4=;
        b=0KEIstox6b1ccRpbGqkYiYkSc+udqfRo+wMMyi1Umj/7hFTaINsFmu8GcjCLFT8YOu
         6Jm9FZyc9qc6fe08T7RZG20eKqRGNQJP0lINred+uVkqzdDDB0I0D5ZYx4zB2LQy/w0Y
         /CFg+keokwVkKGHNoWmczmI5+qpbOePjiqwDoTOLkQxgjAx0VGFyeYRKySenFgELcfjo
         rgaHpjoA/2CzeA4auU8yo5ygDDMCUksLQ0gTimiuLpnnkAa/m25HKNQs0rqvot0PElU+
         JQsYZpaDJjNSZTkCVtGQPWzw/44pTt4Mo8KIS1cBKXyQ2b3JdhQPXPvJH5hOhapFONm6
         mB+Q==
X-Gm-Message-State: AOAM530utaHLoRwaQeSDIZCS7IvZqa3GH7NMljJ9ZbG0aVKw4OWl7xQJ
        8HabOByYI0pYl1d2DTIXewgYEY0pwsU=
X-Google-Smtp-Source: ABdhPJyN806i7P4JFvyuD1MRtn1NsvE5ogNcSkkdNrdqCV/BCZzxqYAnat5w6+aoQv/6PP8IccG9og==
X-Received: by 2002:a05:6a00:b94:b0:44c:db51:30cc with SMTP id g20-20020a056a000b9400b0044cdb5130ccmr34850105pfj.47.1634643579758;
        Tue, 19 Oct 2021 04:39:39 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:39 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <tenglong@alibaba-inc.com>
Subject: [PATCH v6 11/12] t5702: test cases for excluding tags
Date:   Tue, 19 Oct 2021 19:38:35 +0800
Message-Id: <171ece533b4aecf270d93f523086a257dd3edb32.1634634814.git.tenglong@alibaba-inc.com>
X-Mailer: git-send-email 2.31.1.453.g945ddc3a74.dirty
In-Reply-To: <cover.1634634814.git.tenglong@alibaba-inc.com>
References: <cover.1634634814.git.tenglong@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <tenglong@alibaba-inc.com>
---
 t/t5702-protocol-v2.sh | 197 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 762a9c2505..f91ae62fd8 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1480,6 +1480,203 @@ test_expect_success 'tree-exclusion(excluding_type=ET_INCLUDE), part of packfile
 	test_line_count = 6 filelist
 '
 
+test_expect_success 'tag-exclusion(excluding_type=ET_SELF): part of packfile response provided as URI' '
+  	test_when_finished "rm -rf \"$P\" http_child log" &&
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	test_commit -C "$P" A &&
+	git -C "$P" tag -a -m "annotated_tag" tagA &&
+
+	tagh=$(git -C "$P" rev-parse tagA) &&
+	commith=$(git -C "$P" rev-parse A) &&
+	roottreeh=$(git -C "$P" rev-parse A:) &&
+	ah=$(git -C "$P" hash-object A.t) &&
+	myblobh=$(git -C "$P" hash-object my-blob) &&
+
+	configure_exclusion tag "$P" "$tagh" new 0 >h2 &&
+	git init http_child &&
+	GIT_TRACE=1 GIT_TRACE_PACKET=`pwd`/log GIT_TEST_SIDEBAND_ALL=1 \
+	git -C http_child \
+		-c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		fetch --tags "$HTTPD_URL/smart/http_parent" &&
+
+	# Ensure that my-tree and other-tree and theirs complementary set are in separate packfiles.
+	for idx in http_child/.git/objects/pack/*.idx
+	do
+		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 1 out.objectlist
+		then
+			if grep $tagh out
+			then
+				>taghfound
+			fi
+
+		elif test_line_count = 4 out.objectlist
+		then
+			if grep $commith out
+			then
+				>commithfound
+			fi &&
+			if grep $roottreeh out
+			then
+				>roottreehfound
+			fi &&
+			if grep $ah out
+			then
+				>ahfound
+			fi &&
+			if grep $myblobh out
+			then
+				>myblobhfound
+			fi
+		fi
+	done &&
+	test -f myblobhfound &&
+	test -f commithfound &&
+	test -f roottreehfound &&
+	test -f ahfound &&
+	test -f taghfound &&
+	# Ensure that there are exactly 3 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+		http_child/.git/objects/pack/*.idx >filelist &&
+	test_line_count = 4 filelist
+'
+
+test_expect_success 'tag-exclusion(excluding_type=ET_INCLUDE): part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+ 	test_when_finished "rm -rf \"$P\" http_child log" &&
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	test_commit -C "$P" A &&
+	git -C "$P" tag -a -m "annotated_tag" tagA &&
+
+	tagh=$(git -C "$P" rev-parse tagA) &&
+	commith=$(git -C "$P" rev-parse A) &&
+	roottreeh=$(git -C "$P" rev-parse A:) &&
+	ah=$(git -C "$P" hash-object A.t) &&
+	myblobh=$(git -C "$P" hash-object my-blob) &&
+
+	configure_exclusion tag "$P" "$tagh" new 1 >h2 &&
+
+	git init http_child &&
+	GIT_TRACE=1 GIT_TRACE_PACKET=`pwd`/log GIT_TEST_SIDEBAND_ALL=1 \
+	git -C http_child \
+		-c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		fetch --tags "$HTTPD_URL/smart/http_parent" &&
+
+	# Ensure that my-tree and other-tree and theirs complementary set are in separate packfiles.
+	for idx in http_child/.git/objects/pack/*.idx
+	do
+		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 5 out.objectlist
+		then
+			if grep $tagh out
+			then
+				>taghfound
+			fi &&
+			if grep $commith out
+			then
+				>commithfound
+			fi &&
+			if grep $roottreeh out
+			then
+				>roottreehfound
+			fi &&
+			if grep $ah out
+			then
+				>ahfound
+			fi &&
+			if grep $myblobh out
+			then
+				>myblobhfound
+			fi
+		fi
+	done &&
+	test -f myblobhfound &&
+	test -f commithfound &&
+	test -f roottreehfound &&
+	test -f ahfound &&
+	test -f taghfound &&
+	# Ensure that there are exactly 3 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+		http_child/.git/objects/pack/*.idx >filelist &&
+	test_line_count = 4 filelist
+'
+
+test_expect_success 'tag-exclusion(excluding_type=ET_REACHABLE): part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+ 	test_when_finished "rm -rf \"$P\" http_child log" &&
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+
+	mkdir "$P"/my-tree  &&
+	echo my-blob >"$P"/my-tree/my-blob &&
+	git -C "$P" add my-tree &&
+	test_commit -C "$P" A &&
+
+	mkdir "$P"/other-tree &&
+	echo other-blob >"$P"/other-tree/other-blob &&
+	git -C "$P" add other-tree &&
+	test_commit -C "$P" B &&
+
+	git -C "$P" tag -a -m "tag X" tagX &&
+
+	tagh=$(git -C "$P" rev-parse tagX) &&
+ 	commitAh=$(git -C "$P" rev-parse A) &&
+ 	commitBh=$(git -C "$P" rev-parse B) &&
+ 	roottreeAh=$(git -C "$P" rev-parse A:) &&
+	roottreeBh=$(git -C "$P" rev-parse B:) &&
+	mytreeh=$(git -C "$P" ls-tree HEAD my-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	othertreeh=$(git -C "$P" ls-tree HEAD other-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	ah=$(git -C "$P" hash-object A.t) &&
+	bh=$(git -C "$P" hash-object B.t) &&
+	myblobh=$(git -C "$P" hash-object my-tree/my-blob) &&
+	otherblobh=$(git -C "$P" hash-object other-tree/other-blob) &&
+
+	configure_exclusion tag "$P" "$tagh" new 2 >h &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	# Ensure that my-tree and other-tree and theirs complementary set are in separate packfiles.
+    	for idx in http_child/.git/objects/pack/*.idx
+    	do
+    		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
+    		{
+    			grep "^[0-9a-f]\{16,\} " out || :
+    		} >out.objectlist &&
+    		if test_line_count = 11 out.objectlist
+    		then
+    				>fullpackfound
+    		elif test_line_count = 0 out.objectlist
+    		then
+					>emptypackfound
+    		fi
+    	done &&
+    	test -f fullpackfound &&
+    	test -f emptypackfound &&
+    	# Ensure that there are exactly 3 packfiles with associated .idx
+    	ls http_child/.git/objects/pack/*.pack \
+    		http_child/.git/objects/pack/*.idx >filelist &&
+    	test_line_count = 4 filelist
+'
+
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_when_finished "rm -rf \"$P\" http_child log" &&
-- 
2.31.1.453.g945ddc3a74.dirty

