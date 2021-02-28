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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C859C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9E864E74
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhB1T4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhB1Tz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 14:55:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F854C061793
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:41 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bm21so5471355ejb.4
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=roj+uF4i1Pvj/JKkhW/AB7x2mfdmvJYdxdp6pSZekcs=;
        b=o86fu1HECyRhd02JqMKTtzJ26wuCduASpPXkb96FvNfir6ozUEvByx+yii9UV+rGVE
         9XIN82aEVU+8ACcq02CwOyv4vLkgRiWnoKSP8seuClTjapwEWy0ipFPa3cdeK3c9E0jO
         SGjSja6LIx6fcGwWREjQRTtkfG0vCj1TTx6wlv89yTKTiaipNS03dQPsuNeHnhwJguAo
         Y9RdgsqFwtD7wN8OFxPModj33SWRjuJuV43Mza/jhHJZapy5IFYuz+hyRHsnz8fdqe+3
         /tBHcfWVoEk7vppsQmgDrpjyDENFz3dkOc/x0Zv2+zdXfz0zLhUgLj+vpjM481a1p4rA
         Vqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=roj+uF4i1Pvj/JKkhW/AB7x2mfdmvJYdxdp6pSZekcs=;
        b=gN0zXhGnGnhG3hMK6XgWWkpu6TDPERvPqX4K8Ij/CHQtg06ljJ+AZOpcGU9hdI27En
         o/3ohEoclBXA8c/kIafgmgDQ0V3PwHug2tULBYB7Yd7Bqol9cn4HqxOQsVRXTqZf/q0U
         ikCyzgPY+v/+2bcimUtyW9cHqB9NHFVAY3/cLbYp/OWK4Ww0DGyr4cf7BcdU/IfZVgUC
         vqE3pBfmZjGO9SjluRMU7+GJi+/0DydnRnU4oyejYZBl6wiQE7HZ+Sc/jPjvatcKvgH9
         AlKmFXdGxoNRSJV3Vg8UVPY879Q26/Cl1APRXXtfvSU96jT6C9z42fPyHcdUQq8cHnBe
         WjYg==
X-Gm-Message-State: AOAM533ZDrMePS65NRmobYO7aiaOkSoURxyOyRkRnMFwp2HpSJuoLvrt
        KRQVfrB8k2cWPc9lU5HqfqRzCyjK2KHJ2g==
X-Google-Smtp-Source: ABdhPJzIteSbWLELNkPvh+Y4Ub7VznfYI2mPC6N4QMeMN/EWFzGH1JQ7vxDcAjvoddAQOxhW62MMow==
X-Received: by 2002:a17:906:4146:: with SMTP id l6mr6778698ejk.295.1614542079679;
        Sun, 28 Feb 2021 11:54:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm11295554ejl.1.2021.02.28.11.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:54:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] describe tests: support -C in "check_describe"
Date:   Sun, 28 Feb 2021 20:54:11 +0100
Message-Id: <20210228195414.21372-8-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.116.g45ec00aa00
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de>
References: <20200223125102.6697-1-benno@bmevers.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a subshell added in a preceding commit to instead use a new
"-C" option to "check_describe". The idiom for this is copied as-is
from the "test_commit" function in test-lib-functions.sh

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6120-describe.sh | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index ae801c740b..e48c4f604b 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -17,11 +17,26 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 check_describe () {
+	indir= &&
+	while test $# != 0
+	do
+		case "$1" in
+		-C)
+			indir="$2"
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done &&
+	indir=${indir:+"$indir"/} &&
 	expect="$1"
 	shift
 	describe_opts="$@"
 	test_expect_success "describe $describe_opts" '
-		git describe $describe_opts 2>err >raw &&
+		git ${indir:+ -C "$indir"} describe $describe_opts 2>err >raw &&
 		test_must_be_empty err &&
 		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&
 		echo $expect >expect &&
@@ -487,10 +502,7 @@ test_expect_success 'setup: describe commits with disjoint bases' '
 	)
 '
 
-(
-	cd disjoint1 &&
-	check_describe "A-3-gHASH" HEAD
-)
+check_describe -C disjoint1 "A-3-gHASH" HEAD
 
 #           B
 #   o---o---o------------.
@@ -516,9 +528,6 @@ test_expect_success 'setup: describe commits with disjoint bases 2' '
 	)
 '
 
-(
-	cd disjoint2 &&
-	check_describe "B-3-gHASH" HEAD
-)
+check_describe -C disjoint2 "B-3-gHASH" HEAD
 
 test_done
-- 
2.31.0.rc0.116.g45ec00aa00

