Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530B6C433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE406137D
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhJSLmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbhJSLmA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:42:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE18C061772
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso2430486pjw.2
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikrrlh13K1mgZ435whYcNFo5qkKACD6jnoPIS8qPH7Q=;
        b=Gv3FtEehxNLT0Oc6NHzySvQPmknadV4jtY570Z8BfnaPgkxXeEyInAL7XJzkTIsumh
         ugzbdc74Wytvdl1HAoVLUgeOFy561BkRn5lohxrnNyThmguzBaJD1UrmSHWZExXJN4Bk
         EBpaot+60J2BYEzWEhHwZLYIBTaOB0MkjOl/g8d7H27a71FrhCNVslxpqxqWOFPuIDKf
         132n680GpLn11kNsEycEQLbycxZFy/Urfcs89VaaTu+1HfFUdDB8WAVwV0D3S7ZYepCH
         WW8yl5/uuQ/t1aMnmRIuwP5QUK3erlqNIyi39uA4406L/7ZsSP6jac37uE61XzaCCBfT
         ZPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikrrlh13K1mgZ435whYcNFo5qkKACD6jnoPIS8qPH7Q=;
        b=Yt6CqWmvwNsFiYHO16d2PWyf6/x0vKn4BaYJLboBmjYvhuiEv54SymDrPXYBOUlUC9
         KFRg2OBteyjMpGaUhYy8XgmFzD8UrQs1veOYqr+1Yi1Calphb0Ci9xxGtjwjYZglNyNx
         8TIbZcLS/r6FChVWcH/LtO7VYweDsi6NmGA9WrDHSjhD3yu1uCyX95AE/ovvkvmztxQ/
         YpPg95xwFNIiG7aoAAR5X5DvJP9yQUCMDiI+eQ1dFjrUYkBzvSYQ48+iigViPsbjLsI2
         y6VcA6Yueu+zv2EZZhT1/0euqY3Lg3uI/3nW/Y7ByRpaT5vEhCzT6qmt0aIPRUhgTFD3
         GHTg==
X-Gm-Message-State: AOAM530oWLsNRjgIcJysH63tOJour0z63qADxrn4l+OXt636OvfDGc4z
        +Zd33su9yLSyHQrl6YJEw+U/7Q3TwUg=
X-Google-Smtp-Source: ABdhPJxZvMA/Z5v+0E9sMtYU3dS9XbEwxmXZBxNXzRoB/orjuh47tsHAQu6/eBncQg9KbtlbYXN/8A==
X-Received: by 2002:a17:902:e884:b0:13f:19bf:fc16 with SMTP id w4-20020a170902e88400b0013f19bffc16mr32775250plg.67.1634643569994;
        Tue, 19 Oct 2021 04:39:29 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:29 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <tenglong@alibaba-inc.com>
Subject: [PATCH v6 07/12] t5702: test cases for excluding commits
Date:   Tue, 19 Oct 2021 19:38:31 +0800
Message-Id: <ca72efd22ef6a11d8cdbf48912818ea7edbcf73f.1634634814.git.tenglong@alibaba-inc.com>
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
 t/t5702-protocol-v2.sh | 300 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 300 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index ccd3678311..6e323253f7 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -967,6 +967,306 @@ test_expect_success 'blob-exclusion (using uploadpack.excludeobject): packfile U
 	blobpackfileuri_fetch new
 '
 
+test_expect_success 'commit-exclusion(excluding_type=ET_SELF): part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_when_finished "rm -rf \"$P\" http_child log *found" &&
+	excluding_type="0" &&
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+	mkdir "$P"/my-tree  &&
+	echo my-blob >"$P"/my-tree/my-blob &&
+	git -C "$P" add my-tree &&
+	mkdir "$P"/my-tree/sub-tree &&
+	echo sub-blob >"$P"/my-tree/sub-tree/sub-blob &&
+	git -C "$P" add my-tree &&
+	test_commit -C "$P" A &&
+ 	commith=$(git -C "$P" rev-parse A) &&
+ 	roottreeh=$(git -C "$P" rev-parse A:) &&
+	mytreeh=$(git -C "$P" ls-tree HEAD my-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	subtreeh=$(git -C "$P" ls-tree HEAD my-tree/sub-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	ah=$(git -C "$P" hash-object A.t) &&
+	myblobh=$(git -C "$P" hash-object my-tree/my-blob) &&
+	subblobh=$(git -C "$P" hash-object my-tree/sub-tree/sub-blob) &&
+	configure_exclusion commit "$P" "$commith" new "$excluding_type" >h &&
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child
+'
+
+test_expect_success 'commit-exclusion(excluding_type=ET_INCLUDE): part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_when_finished "rm -rf \"$P\" http_child log *found" &&
+	excluding_type="1" &&
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+	mkdir "$P"/my-tree  &&
+	echo my-blob >"$P"/my-tree/my-blob &&
+	git -C "$P" add my-tree &&
+	mkdir "$P"/my-tree/sub-tree &&
+	echo sub-blob >"$P"/my-tree/sub-tree/sub-blob &&
+	git -C "$P" add my-tree &&
+	test_commit -C "$P" A &&
+ 	commith=$(git -C "$P" rev-parse A) &&
+ 	roottreeh=$(git -C "$P" rev-parse A:) &&
+	mytreeh=$(git -C "$P" ls-tree HEAD my-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	subtreeh=$(git -C "$P" ls-tree HEAD my-tree/sub-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	ah=$(git -C "$P" hash-object A.t) &&
+	myblobh=$(git -C "$P" hash-object my-tree/my-blob) &&
+	subblobh=$(git -C "$P" hash-object my-tree/sub-tree/sub-blob) &&
+	configure_exclusion commit "$P" "$commith" new "$excluding_type" >h &&
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+	for idx in http_child/.git/objects/pack/*.idx
+	do
+		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 7 out.objectlist
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
+			if grep $mytreeh out
+			then
+				>mytreehfound
+			fi &&
+			if grep $myblobh out
+			then
+				>myblobhfound
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
+	test -f subtreehfound &&
+	test -f subblobhfound &&
+	test -f commithfound &&
+	test -f roottreehfound &&
+	test -f ahfound &&
+	# Ensure that there are exactly 2 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+		http_child/.git/objects/pack/*.idx >filelist &&
+	test_line_count = 4 filelist
+'
+
+test_expect_success 'commit-exclusion(excluding_type=ET_REACHABLE):  hitten a full packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+ 	test_when_finished "rm -rf \"$P\" http_child log *found" &&
+	excluding_type="2" &&
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+	mkdir "$P"/my-tree  &&
+	echo my-blob >"$P"/my-tree/my-blob &&
+	git -C "$P" add my-tree &&
+	test_commit -C "$P" A &&
+ 	commith=$(git -C "$P" rev-parse A) &&
+  	roottreeh=$(git -C "$P" rev-parse A:) &&
+ 	mytreeh=$(git -C "$P" ls-tree HEAD my-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+ 	ah=$(git -C "$P" hash-object A.t) &&
+ 	myblobh=$(git -C "$P" hash-object my-tree/my-blob) &&
+	configure_exclusion commit "$P" "$commith" new "$excluding_type" >h &&
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+	for idx in http_child/.git/objects/pack/*.idx
+	do
+		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 5 out.objectlist
+		then
+			if grep $commith out
+			then
+				>commithfound
+			fi &&
+			if grep $roottreeh out
+			then
+				>roottreehfound
+			fi &&
+			if grep $mytreeh out
+			then
+				>mytreehfound
+			fi &&
+			if grep $ah out
+			then
+				>ahfound
+			fi &&
+			if grep $myblobh out
+			then
+				>myblobhfound
+			fi
+		elif test_line_count = 0 out.objectlist
+		then
+				>emptypackfound
+		fi
+	done &&
+	test -f emptypackfound &&
+	test -f mytreehfound &&
+	test -f myblobhfound &&
+	test -f commithfound &&
+	test -f roottreehfound &&
+	test -f ahfound &&
+	# Ensure that there are exactly 2 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+		http_child/.git/objects/pack/*.idx >filelist &&
+	test_line_count = 4 filelist
+'
+
+test_expect_success 'commit-exclusion(excluding_type=ET_REACHABLE): part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+ 	test_when_finished "rm -rf \"$P\" http_child log *found" &&
+	excluding_type="2" &&
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+	mkdir "$P"/my-tree  &&
+	echo my-blob >"$P"/my-tree/my-blob &&
+	git -C "$P" add my-tree &&
+	test_commit -C "$P" A &&
+	mkdir "$P"/other-tree  &&
+	echo other-blob >"$P"/other-tree/other-blob &&
+	git -C "$P" add other-tree &&
+	test_commit -C "$P" B &&
+    ah=$(git -C "$P" hash-object A.t) &&
+    bh=$(git -C "$P" hash-object B.t) &&
+	myblobh=$(git -C "$P" hash-object my-tree/my-blob) &&
+	otherblobh=$(git -C "$P" hash-object other-tree/other-blob) &&
+	rm -rf "$P"/my-tree "$P"/other-tree "$P"/A.t "$P"/B.t &&
+	mkdir "$P"/another-tree  &&
+	echo another-blob >"$P"/another-tree/another-blob &&
+	git -C "$P" add . &&
+	test_commit -C "$P" C &&
+ 	commitAh=$(git -C "$P" rev-parse A) &&
+ 	commitBh=$(git -C "$P" rev-parse B) &&
+ 	commitCh=$(git -C "$P" rev-parse C) &&
+ 	roottreeAh=$(git -C "$P" rev-parse A:) &&
+ 	roottreeBh=$(git -C "$P" rev-parse B:) &&
+ 	roottreeCh=$(git -C "$P" rev-parse C:) &&
+    mytreeh=$(git -C "$P" ls-tree A my-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+    othertreeh=$(git -C "$P" ls-tree B other-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+    anothertreeh=$(git -C "$P" ls-tree C another-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+    ch=$(git -C "$P" hash-object C.t) &&
+	anotherblobh=$(git -C "$P" hash-object another-tree/another-blob) &&
+	configure_exclusion commit "$P" "$commitBh" new "$excluding_type" >h &&
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+	for idx in http_child/.git/objects/pack/*.idx
+	do
+		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 5 out.objectlist
+		then
+			if grep $commitCh out
+			then
+				>commitChfound
+			fi &&
+			if grep $roottreeCh out
+			then
+				>roottreeChfound
+			fi &&
+			if grep $anothertreeh out
+			then
+				>anothertreehfound
+			fi &&
+			if grep $anotherblobh out
+			then
+				>anotherblobhfound
+			fi &&
+			if grep $ch out
+			then
+				>chfound
+			fi
+		elif test_line_count = 10 out.objectlist
+		then
+			if grep $commitAh out
+			then
+				>commitAhfound
+			fi &&
+			if grep $commitBh out
+			then
+				>commitBhfound
+			fi &&
+			if grep $roottreeAh out
+			then
+				>roottreeAhfound
+			fi &&
+			if grep $roottreeBh out
+			then
+				>roottreeBhfound
+			fi &&
+			if grep $mytreeh out
+			then
+				>mytreehfound
+			fi &&
+			if grep $othertreeh out
+			then
+				>othertreehfound
+			fi &&
+			if grep $myblobh out
+			then
+				>myblobhfound
+			fi &&
+			if grep $otherblobh out
+			then
+				>otherblobhfound
+			fi &&
+			if grep $ah out
+			then
+				>ahfound
+			fi &&
+			if grep $bh out
+			then
+				>bhfound
+			fi
+		fi
+	done &&
+	test -f commitChfound &&
+	test -f roottreeChfound &&
+	test -f anothertreehfound &&
+	test -f anotherblobhfound &&
+	test -f chfound &&
+	test -f commitAhfound &&
+	test -f commitBhfound &&
+	test -f roottreeAhfound &&
+	test -f roottreeBhfound &&
+	test -f mytreehfound &&
+	test -f othertreehfound &&
+	test -f myblobhfound &&
+	test -f otherblobhfound &&
+	test -f ahfound &&
+	test -f bhfound &&
+	# Ensure that there are exactly 2 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+		http_child/.git/objects/pack/*.idx >filelist &&
+	test_line_count = 4 filelist
+'
+
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_when_finished "rm -rf \"$P\" http_child log" &&
-- 
2.31.1.453.g945ddc3a74.dirty

