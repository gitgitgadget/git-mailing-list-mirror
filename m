Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F902C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315EE6134F
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbhDLLJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbhDLLJe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863A5C06138F
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x15so12496312wrq.3
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gkj/RqucwxRWIB1UtAk33REd9QSuCQEKy+Zm0v5G4jM=;
        b=XrTd5BSYxcKGUZXLawdI5mCY9aFKD4V1SF238dCIqNczdjnsCgjT2pEDxCsK8Qj3wJ
         7DUdnO60viuH4wxheOXFdwQPIxySma14X8OvCXbSo8j6X0aqrXieDgFKcOKm9WxqRaCD
         /AxrDaW33bOvSPVAYhEKAlXoQZKEcJOYUs7qNey8ASsQi/wCyejvHYwZPPbVx7VNeEXg
         tX7OVWzqeWgX4ctos79TMaDXJCHmlrpmw4Nez6i6btwz/64en2vhF54iCCXuPd6XrrU1
         7RuuISXqHE0ARGHDz8bkPXsiqoBUnTk5JWGKRliHigzxFJrBIsvCrBVIRZJnNHm+9ORk
         MWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkj/RqucwxRWIB1UtAk33REd9QSuCQEKy+Zm0v5G4jM=;
        b=dYXDQ1oavvVWN4Py1af0+xTkH8kXZ4nWpx41IxXziYDplY1MNsYyMojTVtDzDOOJHS
         9ugelMymzS5LhqHQ7+nV1q7ptYSWvxRB2/r9S9cgXL/hBWPxM/wRHf2kfwImUONRHMxD
         85M/pmsPYc1bI8qJS6JgVi7L0Roo0B/T3xsDlVNJy1FxyA164P2rPH1QqkiRbWETAKj7
         xs0BhU0XXpL5KBhvlNx8/jGFFXw22USgyJcrHNMjJTWccFvuxOCWdUBE0fSTaMQVRT42
         Ex3uR7TGnVbVWdnBcyCu8Z0NdkZ3OGndu+/XpkPLSZXttOL/PXa/SmAyriBKwkQUVTaH
         Mxqg==
X-Gm-Message-State: AOAM530PQHKxztQ9MwEx9yBz0gkpMxFrxY8BubtOeBaSJFj/mHDwTXQT
        G7elGpSLeGeckSV0zdsaaCrsQ/o8YaXthA==
X-Google-Smtp-Source: ABdhPJxha4ZVlSsqLZj4+XO3nfuXg5BbP5uOl8da5rhwgbnWfbhaT3vWXNCBMi+jf88FiCvVsfSKnQ==
X-Received: by 2002:adf:fdc7:: with SMTP id i7mr14774970wrs.350.1618225755045;
        Mon, 12 Apr 2021 04:09:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/16] test-lib functions: add an --annotated-tag option to "test_commit"
Date:   Mon, 12 Apr 2021 13:08:55 +0200
Message-Id: <patch-06.16-8d43fdd5865-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an --annotated-tag option to test_commit. The tag will share the
same message as the commit, and we'll call test_tick before creating
it (unless --notick) is provided.

There's quite a few tests that could be simplified with this
construct. I've picked one to convert in this change as a
demonstration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1403-show-ref.sh     |  6 ++----
 t/test-lib-functions.sh | 27 ++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 6ce62f878c3..17d3cc14050 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -7,11 +7,9 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-	test_commit A &&
-	git tag -f -a -m "annotated A" A &&
+	test_commit --annotate A &&
 	git checkout -b side &&
-	test_commit B &&
-	git tag -f -a -m "annotated B" B &&
+	test_commit --annotate B &&
 	git checkout main &&
 	test_commit C &&
 	git branch B A^0
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fa3e3e975fd..a0fcc383d0b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -180,6 +180,10 @@ debug () {
 #   --no-tag
 #	Do not tag the resulting commit, if supplied giving the
 #	optional "<tag>" argument is an error.
+#   --annotate
+#	Create an annotated tag with "--annotate -m <message>". Calls
+#	test_tick between making the commit and tag unless --notick is
+#	given.
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
@@ -192,7 +196,7 @@ test_commit () {
 	author= &&
 	signoff= &&
 	indir= &&
-	no_tag= &&
+	tag=light &&
 	while test $# != 0
 	do
 		case "$1" in
@@ -220,7 +224,10 @@ test_commit () {
 			shift
 			;;
 		--no-tag)
-			no_tag=yes
+			tag=none
+			;;
+		--annotate)
+			tag=annotate
 			;;
 		*)
 			break
@@ -244,10 +251,20 @@ test_commit () {
 	git ${indir:+ -C "$indir"} commit \
 	    ${author:+ --author "$author"} \
 	    $signoff -m "$1" &&
-	if test -z "$no_tag"
-	then
+	case "$tag" in
+	none)
+		;;
+	light)
 		git ${indir:+ -C "$indir"} tag "${4:-$1}"
-	fi
+		;;
+	annotate)
+		if test "$tag$notick" = "annotate"
+		then
+			test_tick
+		fi &&
+		git ${indir:+ -C "$indir"} tag -a -m "$1" "${4:-$1}"
+		;;
+	esac
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
2.31.1.634.gb41287a30b0

