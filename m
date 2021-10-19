Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FD1C433FE
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF96613A1
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhJSLmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhJSLmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:42:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715F5C061779
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y1so13458917plk.10
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fiArQ1yQVGbHOqJST1guSHQiHUQpAWMT+0Npi8y5QOM=;
        b=QR26m74Euch7+msf8Pwv0veHd+3K0CkYnGKKq1pupj0i3l5gkX7WJqM2nSjbstqPKP
         uwtbiYwWmVU6Xfds5GWverhb2bNobE90gz/m/XeS19yd0DLPvXA+jd5W/c7akvKpppc0
         FFrcWp9pYqb2ae2ht3bIwSUBsOiimlXGxeDwNB5uUqKE8uG5ZlJm5gw9VQ+Gc4pR2wrQ
         aQOx5onRu903bIWiP8TL4WsAp+GmebwbaMnf6owX1nzpAvsyz2QUCYmpnFU6kgcY9+qW
         tNNzE95m+PSor7uLStrzdZOsSvba3x3pNDZ5XHWomlGQB+lRaf8uGa/mjJl1tzlPcnPJ
         m+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fiArQ1yQVGbHOqJST1guSHQiHUQpAWMT+0Npi8y5QOM=;
        b=cjhf1mFOFjA+aCjyw3zdX4qZKlyeJ7XOI0OVbeXmiNBkFNQP9BfBKOsKexQ72QmzOg
         mvYNQJEaQtWYJStde/Lx0CqVeXkZ37fNFbKe+qFeaEl11mlIaKOaKjSer7wTULtvRL4k
         BTnqW2hGfSctqU+we14aGd9MmLIJi9pJ5uuSu3OkiYnNydCEUr8LcAp49ajop6GWi/Ii
         W+Gk6Pc/p+YWI9imrEwHSUHqJDkeUkBPahJwmc2G/aBsnufpWtFeWLxOaGgQCyxuRp1k
         XBCAlcp1ZL+Ap2wGb9kzbxgES9grDzHMyOAKEzV330tSwMkecoMlzLpYdLicHRr3IUYr
         2jlQ==
X-Gm-Message-State: AOAM531yEUn8LF4lCl49q8aXcx91ZQFYEwjNSIYPSBxbrDPOa8vfq1AN
        jurlqPy5gcpRrns9rcxVNKPrHwjHFME=
X-Google-Smtp-Source: ABdhPJziyDJw6LkpNYzDMIxzkZkrjyMnBrHRLO6ncJ6cBOONOrl6wh4xiM6DvuNCGkdYt1SZCZ+OVQ==
X-Received: by 2002:a17:903:246:b0:13f:2ff9:8b93 with SMTP id j6-20020a170903024600b0013f2ff98b93mr33118807plh.54.1634643574709;
        Tue, 19 Oct 2021 04:39:34 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:34 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <tenglong@alibaba-inc.com>
Subject: [PATCH v6 09/12] t5702: test cases for excluding trees
Date:   Tue, 19 Oct 2021 19:38:33 +0800
Message-Id: <5fc79a9a3213a17f1648dda9ee17d5fd82b0f979.1634634814.git.tenglong@alibaba-inc.com>
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
 t/t5702-protocol-v2.sh | 213 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 6e323253f7..762a9c2505 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1267,6 +1267,219 @@ test_expect_success 'commit-exclusion(excluding_type=ET_REACHABLE): part of pack
 	test_line_count = 4 filelist
 '
 
+test_expect_success 'tree-exclusion(excluding_type=ET_SELF): part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_when_finished "rm -rf \"$P\" http_child log *found" &&
+	excluding_type="0" &&
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+	# Dir struct
+	# 	.
+	#     |-- A.t
+	#     |-- my-tree
+	#     |   `-- my-blob
+	#     `-- other-tree
+	#         |-- other-blob
+	#         `-- sub-tree
+	#             `-- sub-blob
+	mkdir "$P"/my-tree  &&
+	echo my-blob >"$P"/my-tree/my-blob &&
+	git -C "$P" add my-tree &&
+	mkdir "$P"/other-tree &&
+	echo other-blob >"$P"/other-tree/other-blob &&
+	mkdir "$P"/other-tree/sub-tree &&
+	echo sub-blob >"$P"/other-tree/sub-tree/sub-blob &&
+	git -C "$P" add other-tree &&
+ 	test_commit -C "$P" A &&
+ 	commith=$(git -C "$P" rev-parse A) &&
+ 	roottreeh=$(git -C "$P" rev-parse A:) &&
+	ah=$(git -C "$P" hash-object A.t) &&
+	mytreeh=$(git -C "$P" ls-tree HEAD my-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	othertreeh=$(git -C "$P" ls-tree HEAD other-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	subtreeh=$(git -C "$P" ls-tree HEAD other-tree/sub-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	myblobh=$(git -C "$P" hash-object my-tree/my-blob) &&
+	otherblobh=$(git -C "$P" hash-object other-tree/other-blob) &&
+	subblobh=$(git -C "$P" hash-object other-tree/sub-tree/sub-blob) &&
+
+	configure_exclusion tree "$P" "$mytreeh" new 0 >h &&
+	configure_exclusion tree "$P" "$othertreeh" new 0 >h2 &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+# 	Ensure that my-tree and other-tree and theirs complementary set are in separate packfiles.
+	for idx in http_child/.git/objects/pack/*.idx
+	do
+		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 1 out.objectlist
+		then
+			if grep $mytreeh out
+			then
+				>mytreehfound
+			fi &&
+			if grep $othertreeh out
+			then
+				>othertreehfound
+			fi
+		elif test_line_count = 7 out.objectlist
+		then
+			if grep $commith out
+			then
+				>commithfound
+			fi &&
+			if grep $roottreeh out
+			then
+				>roottreehfound
+			fi &&
+			if grep $subtreeh out
+			then
+				>subtreehfound
+			fi &&
+			if grep $ah out
+			then
+				>ahfound
+			fi &&
+			if grep $myblobh out
+			then
+				>myblobhfound
+			fi &&
+			if grep $otherblobh out
+			then
+				>otherblobhfound
+			fi &&
+			if grep $subblobh out
+			then
+				>subblobhfound
+			fi
+		fi
+	done &&
+	test -f mytreehfound &&
+	test -f myblobhfound &&
+	test -f othertreehfound &&
+	test -f otherblobhfound &&
+	test -f subtreehfound &&
+	test -f subblobhfound &&
+	test -f commithfound &&
+	test -f roottreehfound &&
+	test -f ahfound &&
+	# Ensure that there are exactly 3 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+		http_child/.git/objects/pack/*.idx >filelist &&
+	test_line_count = 6 filelist
+'
+
+test_expect_success 'tree-exclusion(excluding_type=ET_INCLUDE), part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_when_finished "rm -rf \"$P\" http_child log *found" &&
+	excluding_type="1" &&
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true"  &&
+	# Dir struct
+	# 	.
+	#     |-- A.t
+	#     |-- my-tree
+	#     |   `-- my-blob
+	#     `-- other-tree
+	#         |-- other-blob
+	#         `-- sub-tree
+	#             `-- sub-blob
+	mkdir "$P"/my-tree  &&
+	echo my-blob >"$P"/my-tree/my-blob &&
+	git -C "$P" add my-tree &&
+	mkdir "$P"/other-tree &&
+	echo other-blob >"$P"/other-tree/other-blob &&
+	mkdir "$P"/other-tree/sub-tree &&
+	echo sub-blob >"$P"/other-tree/sub-tree/sub-blob &&
+	git -C "$P" add other-tree &&
+ 	test_commit -C "$P" A &&
+
+ 	commith=$(git -C "$P" rev-parse A) &&
+ 	roottreeh=$(git -C "$P" rev-parse A:) &&
+	ah=$(git -C "$P" hash-object A.t) &&
+	mytreeh=$(git -C "$P" ls-tree HEAD my-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	othertreeh=$(git -C "$P" ls-tree HEAD other-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	subtreeh=$(git -C "$P" ls-tree HEAD other-tree/sub-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	myblobh=$(git -C "$P" hash-object my-tree/my-blob) &&
+	otherblobh=$(git -C "$P" hash-object other-tree/other-blob) &&
+	subblobh=$(git -C "$P" hash-object other-tree/sub-tree/sub-blob) &&
+
+	configure_exclusion tree "$P" "$mytreeh" new $excluding_type >h &&
+	configure_exclusion tree "$P" "$othertreeh" new $excluding_type >h2 &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+	# Ensure that my-tree and other-tree and theirs complementary set are in separate packfiles.
+	for idx in http_child/.git/objects/pack/*.idx
+	do
+		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 3 out.objectlist
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
+			fi
+		elif test_line_count = 2 out.objectlist
+		then
+			if grep $mytreeh out
+			then
+				>mytreehfound
+			fi &&
+			if grep $myblobh out
+			then
+				>myblobhfound
+			fi
+		elif test_line_count = 4 out.objectlist
+		then
+			if grep $othertreeh out
+			then
+				>othertreehfound
+			fi &&
+			if grep $otherblobh out
+			then
+				>otherblobhfound
+			fi &&
+			if grep $subtreeh out
+			then
+				>subtreehfound
+			fi &&
+			if grep $subblobh out
+			then
+				>subblobhfound
+			fi
+		fi
+	done &&
+	test -f mytreehfound &&
+	test -f myblobhfound &&
+	test -f othertreehfound &&
+	test -f otherblobhfound &&
+	test -f subtreehfound &&
+	test -f subblobhfound &&
+	test -f commithfound &&
+	test -f roottreehfound &&
+	test -f ahfound &&
+	# Ensure that there are exactly 3 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+		http_child/.git/objects/pack/*.idx >filelist &&
+	test_line_count = 6 filelist
+'
+
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_when_finished "rm -rf \"$P\" http_child log" &&
-- 
2.31.1.453.g945ddc3a74.dirty

