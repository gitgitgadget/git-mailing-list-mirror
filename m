Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F68AC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjC1Rjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjC1Rjm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:39:42 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BE5AF09
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:41 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id j12-20020a4ab1cc000000b0053e6062a9eeso459860ooo.8
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzAx97jPCNAfA53+aWkTQgMlhYCN1H9FOJiyEb1Qiag=;
        b=Wxj45YDupyncS0z9W/GaH+5iXeiU32knxNPbCQR4PSb38LomZReX4aURLD9KXADhjM
         FSchQXyBoTcGTcfFTN1TSmh2B08O4Z6DfGEnI1q7+FnHyYDHB8FuP6+hyj/Iz131pfgq
         a3U6/Jb8NPt/P1Jj4STmQabQKd1iNETw+7KsF//1yfaAFdOQ91snID2BCzI/c6suMZl9
         dOXQ4xVg22d4foI2503C5UkEwad2diuIm8Fvtr6XwKnZW3cEjWov3olCFxENd9uW1die
         HK3iNuuYtknl+Q1C9X9i6qrWvHyHi5BC9ECCo/Mj7V4MPEgWtGIOdElRNKPd+n7a1APT
         8D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzAx97jPCNAfA53+aWkTQgMlhYCN1H9FOJiyEb1Qiag=;
        b=BBhYU2Z1FdIlcdK2SIKiF2XPvcTP5HDFY4A89e1iz+vIZydzXYOmrdt3XDanuDetkl
         t2pfc+VqbHixFI/1y3Sq+KlKF5D/eLHlcHuP5OPowHY0p9ttihdwQhaE/6GX1ep3JjBW
         /Iml2un8pMqCBw1T36LyZu4DWyy6eSkksjBE9PO65pS5Vc1fc1Re+ID0n5dYG31sXjBz
         zUnPhyRlAANV5GI04qQYKmZpH+L25g884bjQTTV2WJ4BMha69VR0fnkBICpMpZ4lEdHQ
         ErojBJEVNnSmlu0/li3YCVldXOs3w0yGdGEo0SAdeW4BQdL6ydmkQ2vteS6v87yjt/Z6
         hSZg==
X-Gm-Message-State: AO0yUKWV7EHSR8i7ReP+FA7Pti+8H4YQGQu2lUnxyLyoGW0hjY1JElrR
        Uj4bh4RbnJw2KPcETOmyyCLEsbhNDt8=
X-Google-Smtp-Source: AK7set/CTaqwMJzx6oBkKDn7REKB8pQ5gPdctyhDfE0q31Pbw+gGHJK7xtjyuVtL2oJf7M9IoZoB1Q==
X-Received: by 2002:a4a:5554:0:b0:52f:42ed:6d6a with SMTP id e81-20020a4a5554000000b0052f42ed6d6amr8837155oob.6.1680025180451;
        Tue, 28 Mar 2023 10:39:40 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id a31-20020a4a98a2000000b005251f71250dsm12665683ooj.37.2023.03.28.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:39:39 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/6] test: avoid `options` variable
Date:   Tue, 28 Mar 2023 11:39:29 -0600
Message-Id: <20230328173932.3614601-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230328173932.3614601-1-felipe.contreras@gmail.com>
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has a special meaning in zsh.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/annotate-tests.sh              | 10 +++++-----
 t/t4051-diff-function-context.sh |  4 ++--
 t/t9300-fast-import.sh           |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index f1b9a6ce4d..3b57d4dbb5 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -15,19 +15,19 @@ fi
 check_count () {
 	head= &&
 	file='file' &&
-	options= &&
+	args= &&
 	while :
 	do
 		case "$1" in
 		-h) head="$2"; shift; shift ;;
 		-f) file="$2"; shift; shift ;;
-		-L*) options="$options $(sanitize_L "$1")"; shift ;;
-		-*) options="$options $1"; shift ;;
+		-L*) args="$args $(sanitize_L "$1")"; shift ;;
+		-*) args="$args $1"; shift ;;
 		*) break ;;
 		esac
 	done &&
-	echo "$PROG $options $file $head" >&4 &&
-	$PROG $options $file $head >actual &&
+	echo "$PROG $args $file $head" >&4 &&
+	$PROG $args $file $head >actual &&
 	perl -e '
 		my %expect = (@ARGV);
 		my %count = map { $_ => 0 } keys %expect;
diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 725278ad19..3bf4f0b6b0 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -30,10 +30,10 @@ last_context_line () {
 check_diff () {
 	name=$1
 	desc=$2
-	options="-W $3"
+	args="-W $3"
 
 	test_expect_success "$desc" '
-		git diff $options "$name^" "$name" >"$name.diff"
+		git diff $args "$name^" "$name" >"$name.diff"
 	'
 
 	test_expect_success ' diff applies' '
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index aa55b41b9a..c30503870f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3222,7 +3222,7 @@ test_expect_success 'U: validate root delete result' '
 # fast-import process is still running using background_import_still_running
 # *after* evaluating the test conditions.
 background_import_then_checkpoint () {
-	options=$1
+	args=$1
 	input_file=$2
 
 	mkfifo V.input
@@ -3234,7 +3234,7 @@ background_import_then_checkpoint () {
 	rm V.output
 
 	(
-		git fast-import $options <&8 >&9 &
+		git fast-import $args <&8 >&9 &
 		echo $! >&9
 		wait $!
 		echo >&2 "background fast-import terminated too early with exit code $?"
-- 
2.39.2.13.g1fb56cf030

