Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62D2C43461
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB746142F
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbhDUKQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbhDUKP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:15:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04E3C06138D
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so948204wmh.0
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3ms9FL4S7h+c5nnu94IsH521pWT6s4BJQPtgKMVb6I=;
        b=Pp6NWHWljzJ4fGT4UWftZpDgCQ3WgNIxVcf5fCEyftElFkVRpD9mE4Rpk3mUOJjF3O
         4O6GR7ksMRUjZMWsBo9VTsgSNqWmc6A5+ZWh8+yeje5Og1voLRMQNkfBqznZhwm0g7bS
         1owtxBPJgoo3u1e6hwoxkjOD+kk+aHCt+3Y0AaxgtEv+zP8DtcyXXFmEy4lfw7WzYXFl
         o1I20Il+m+cHf0iAfKe+sSMrq//Kh/Fnj5ulpG7YugG5qOWXfg/pTJO5iq3HcC+qUIxZ
         P1WZqssSjoRrldXN4kN3KUnAYo+B8ubLw0WAvG6lhL+Tri1cutTyYWw4WCyo37QNzEhh
         pOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3ms9FL4S7h+c5nnu94IsH521pWT6s4BJQPtgKMVb6I=;
        b=bjhrOd/zT5zeLsg6i8c5eD0fsQcDOgySKaNQkHt6CNhRNRiAcdqaTmxu9Al4XVeHnP
         XJx5nrav6zYs+GYYHFDbO5t4T1g29GLHtLntzVtwRpep6O5LqHAVrOAlMck52uryGJYe
         eBJDhoFA3G1RGTDqSmSQ0NBCxIAkSfQE2eL5BIM8PbypP3pmtDXnQH/cV5VbfZAeMlK4
         E4SazikXTLj9dqa9OGE9pdfLgn0LtjFJH5TA0qgCXPN/J+eUBbOh8XY724hpeZPMEBGM
         +XHmtd36ZYIGtZ3X25tQ0S6Vs2OEw7DX08gF9iZHdD2i7rJLol2QFfFSFzg6jes/Gt+M
         dSiw==
X-Gm-Message-State: AOAM533KE8+urg+3q/cX9Umo+/+yD917rOBjq8mWp9j+0ezZWKS1c5it
        TT97vRT4KwPLgqPZk6TDMi5DnfordeE+FQ==
X-Google-Smtp-Source: ABdhPJzIt2XneMCccsXRB1so32qW+OfNCAw/E8uWVaQ5jHeq33W0hIzG4CbKjr5sqHROkcWTvGkefA==
X-Received: by 2002:a1c:a54a:: with SMTP id o71mr9210646wme.172.1619000123448;
        Wed, 21 Apr 2021 03:15:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i9sm1843084wmg.2.2021.04.21.03.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:15:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/11] test-lib functions: add an --annotated option to "test_commit"
Date:   Wed, 21 Apr 2021 12:15:10 +0200
Message-Id: <patch-05.11-3a166c9206-20210421T101156Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.721.gbeb6a21927
In-Reply-To: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com> <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an --annotated option to test_commit to create annotated tags. The
tag will share the same message as the commit, and we'll call
test_tick before creating it (unless --notick) is provided.

There's quite a few tests that could be simplified with this
construct. I've picked one to convert in this change as a
demonstration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1403-show-ref.sh     |  6 ++----
 t/test-lib-functions.sh | 27 ++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 6ce62f878c..17d3cc1405 100755
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
index d0f4f3885d..6e2332a324 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -179,6 +179,10 @@ debug () {
 #	Invoke "git commit" with --author <author>
 #   --no-tag
 #	Do not tag the resulting commit
+#   --annotate
+#	Create an annotated tag with "--annotate -m <message>". Calls
+#	test_tick between making the commit and tag, unless --notick
+#	is given.
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
@@ -191,7 +195,7 @@ test_commit () {
 	author= &&
 	signoff= &&
 	indir= &&
-	no_tag= &&
+	tag=light &&
 	while test $# != 0
 	do
 		case "$1" in
@@ -219,7 +223,10 @@ test_commit () {
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
@@ -243,10 +250,20 @@ test_commit () {
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
+		if test -z "$notick"
+		then
+			test_tick
+		fi &&
+		git ${indir:+ -C "$indir"} tag -a -m "$1" "${4:-$1}"
+		;;
+	esac
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
2.31.1.721.gbeb6a21927

