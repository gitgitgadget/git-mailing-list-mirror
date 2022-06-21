Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C336C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354509AbiFUWeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354478AbiFUWea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AC3D133
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o16so20853902wra.4
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SKREIOOggaRjJlBPAwycKlciSlmhOQX6RJERnKt+JY=;
        b=bXcqo3wW8FO7zpYJpCaZu1h8AcK8iMtkY81foz67Bf0K4CwKKVXz2/05kiGs4ggxtf
         mAGweLyazzjb1OGxnos2qts71oViGTsaUPgZRSKw98x8wpbZIPrrmgX5/+LV6dgfr6Lv
         ekc6Z01hlQdtcbQBFCBNCFpQeXsBjslDrQYvHjXs96AvRK4GyM3kt3uLZ2KxPpVle5A1
         HbF00m84ynb0UCz7OIPZ7PaIAoc3vpYHyZJQTw2OIWmzaP3w+mn7mcNaifRVV10wDwmg
         oKtTB9pzcef5L8J7KZNYISJyswHn5u+2M4PwKJ91SQchFa6oj5NzNTqB0h4GUU/haXYf
         G6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SKREIOOggaRjJlBPAwycKlciSlmhOQX6RJERnKt+JY=;
        b=sRAGfcCOY7ZJUWgKNEphC7tfkaKiivEO3pLPAZJvqu9yBi1SDkG0YmlrOQWt06Dgce
         rQBnGBwdeN7SQYjc5GwENT+S8QZF4vD07NB05uJrwhJQNTjjadw+2pT8dpCckqKJL3RH
         KzcT1ct2BAxurLzK5Cchg7ArHDOeIXdGyUDPsv0V6wns3iW/3exJV51UGd1P7d26s9k2
         9AZvJPbgYBMewUs6HQuefp6w4+NKUJlK8P5K7qLwdreHR/HeSjdjKJiobuHFSKSDQzTA
         SP6sn04YWCB7sUxS3vozA4cGxcQZfzPbYR+ScVXPHvFfSkgcs2mX1lufcSq2pLigyfCS
         WdUA==
X-Gm-Message-State: AJIora/f87yfNLOIx7a3JLJrly+svSg2KRdBpvO0/PZ05FyesubvRWwS
        XExBex5VwnIHSB63I2z2w0dmO3f0hil5Uw==
X-Google-Smtp-Source: AGRyM1tni6RKwpv27V08Ckim5ZbImh9ctwLvAnlXqApBf6yEYVWyY5GGpxhYfGhjWc1GbdqQh8g5aA==
X-Received: by 2002:a5d:570e:0:b0:21b:8aec:3e69 with SMTP id a14-20020a5d570e000000b0021b8aec3e69mr205154wrv.177.1655850868233;
        Tue, 21 Jun 2022 15:34:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b0039c7c4a542csm19000299wmj.47.2022.06.21.15.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:34:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] fetch tests: use "local", &&-chaining, style etc.
Date:   Wed, 22 Jun 2022 00:34:15 +0200
Message-Id: <patch-03.10-02aad13748e-20220621T222854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
References: <xmqqa6a5g0m3.fsf@gitster.g> <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of &&-chaining, the "local" keyword, the more idiomatic "test
-z" over comparison against "" etc. in the
"test_configured_prune_type()" function.

Let's also move the wrapper function to below the function itself. In
e1790f9245f (fetch tests: fetch <url> <spec> as well as fetch
[<remote>], 2018-02-09) placed in there to minimize the diff
size. While it's not incorrect to define these in this order (this
isn't C), it's less confusing this way.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 37e12de2475..799e69dc1b1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -821,20 +821,15 @@ set_config_tristate () {
 	esac
 }
 
-test_configured_prune () {
-	test_configured_prune_type "$@" "name"
-	test_configured_prune_type "$@" "link"
-}
-
 test_configured_prune_type () {
-	fetch_prune=$1
-	remote_origin_prune=$2
-	fetch_prune_tags=$3
-	remote_origin_prune_tags=$4
-	expected_branch=$5
-	expected_tag=$6
-	cmdline=$7
-	mode=$8
+	local fetch_prune="$1" &&
+	local remote_origin_prune="$2" &&
+	local fetch_prune_tags="$3" &&
+	local remote_origin_prune_tags="$4" &&
+	local expected_branch="$5" &&
+	local expected_tag="$6" &&
+	local cmdline="$7" &&
+	local mode="$8" &&
 
 	if test -z "$cmdline_setup"
 	then
@@ -843,18 +838,18 @@ test_configured_prune_type () {
 			remote_fetch="$(git -C one config remote.origin.fetch)" &&
 			cmdline_setup="\"$remote_url\" \"$remote_fetch\""
 		'
-	fi
+	fi &&
 
 	if test "$mode" = 'link'
 	then
-		new_cmdline=""
+		new_cmdline="" &&
 
-		if test "$cmdline" = ""
+		if test -z "$cmdline"
 		then
 			new_cmdline=$cmdline_setup
 		else
 			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
-		fi
+		fi &&
 
 		if test "$fetch_prune_tags" = 'true' ||
 		   test "$remote_origin_prune_tags" = 'true'
@@ -863,10 +858,10 @@ test_configured_prune_type () {
 			then
 				new_cmdline="$new_cmdline refs/tags/*:refs/tags/*"
 			fi
-		fi
+		fi &&
 
 		cmdline="$new_cmdline"
-	fi
+	fi &&
 
 	test_expect_success "$mode prune fetch.prune=$fetch_prune remote.origin.prune=$remote_origin_prune fetch.pruneTags=$fetch_prune_tags remote.origin.pruneTags=$remote_origin_prune_tags${cmdline:+ $cmdline}; branch:$expected_branch tag:$expected_tag" '
 		# make sure a newbranch is there in . and also in one
@@ -915,6 +910,13 @@ test_configured_prune_type () {
 			esac
 		)
 	'
+
+	return 0
+}
+
+test_configured_prune () {
+	test_configured_prune_type "$@" "name" &&
+	test_configured_prune_type "$@" "link"
 }
 
 # $1 config: fetch.prune
-- 
2.36.1.1239.gfba91521d90

