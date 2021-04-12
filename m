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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A364C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F686134F
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbhDLLWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbhDLLWU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B143C06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:22:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x15so12537252wrq.3
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNsTKfG6Mbz+J0oTrYX4gPvZMwK5kh1Dp0TgqEEfhW0=;
        b=DB/Y7AdWOUgZdoVw5vM3OBZO+Dm539Z/cd380MrTzXThTs+HjtyhH55EFQ1CHWLrTe
         5WzE04hTs0ufsuZpDdWdsW/8T7eMxYl/wNy00hevpXfVX0aEvWcqL0SKLlBeO6IlBpzb
         AsY34IK1GMiUKtDERE1aMmVv2vpVK3rbXgTZKz4QH5mKeYElDc4Gk6Wf9swcfrhSNRo2
         75rnB4voUmWEGDD8zG3ujXy357QoUNstDfg0wEhujRHvqqabJr9M7uFlMGUquDKzR4gK
         07LFqsa72GrCKCZaSCdLEG++25nrdID7KWaxAtAuzHNcmCQNgAK0CyWn2L2cmguuLmIj
         fXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNsTKfG6Mbz+J0oTrYX4gPvZMwK5kh1Dp0TgqEEfhW0=;
        b=Mwr6XtssEOZFYN5cCZyQX93fqPx+7/IIqPj8MULXRGMia7To8R+qckStzbMedP9EjG
         NH/Lbai+rFOQad/jQ2rWvAA+IUfr+kNlU2XjQxOwKNcB6i+ToipVfWP/RTIkeynaM2Tt
         Z1jULMYyEK3ndzbfFil0runG0MEFgu1Rk6X46BpzwhuY8tal5XhmCzRrSaEWMhS6e5wW
         7Sv30rYPmYHF9lfOYL3EvcDYrRKpRhFZJsreXY/p1FkuUpvDE7aM4Et19n1R6kxuyVov
         xR65dqwispLy7kheju00aC4XlN0uZ4WBQYQyPQKVDN7ilS24IKAClEWlEE2CrJcQng2+
         DkQg==
X-Gm-Message-State: AOAM533tZKx60LMTtyaXxtamgpk4mr2E1tx22GeqoIoP0S410g4Jin5v
        d8W7ZFurd4neLuclAEAq3CXGqD4rHF2bjQ==
X-Google-Smtp-Source: ABdhPJwMUIwEcqnm8h9VKmCHDoM8VfsX5xNc29lV4Md+lrkcyowubsyLzfhaxcQi0jvDC7ITt+BU/w==
X-Received: by 2002:adf:f041:: with SMTP id t1mr30179001wro.377.1618226520724;
        Mon, 12 Apr 2021 04:22:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v185sm14580907wmb.25.2021.04.12.04.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:22:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] describe tests: support -C in "check_describe"
Date:   Mon, 12 Apr 2021 13:21:47 +0200
Message-Id: <patch-5.5-798f6cd63c8-20210412T111601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-0.5-00000000000-20210412T111601Z-avarab@gmail.com>
References: <20210228195414.21372-1-avarab@gmail.com> <cover-0.5-00000000000-20210412T111601Z-avarab@gmail.com>
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
index 9dc07782ea6..1a501ee09e1 100755
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
-		git describe $describe_opts >raw &&
+		git ${indir:+ -C "$indir"} describe $describe_opts >raw &&
 		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&
 		echo "$expect" >expect &&
 		test_cmp expect actual
@@ -486,10 +501,7 @@ test_expect_success 'setup: describe commits with disjoint bases' '
 	)
 '
 
-(
-	cd disjoint1 &&
-	check_describe "A-3-gHASH" HEAD
-)
+check_describe -C disjoint1 "A-3-gHASH" HEAD
 
 #           B
 #   o---o---o------------.
@@ -515,9 +527,6 @@ test_expect_success 'setup: describe commits with disjoint bases 2' '
 	)
 '
 
-(
-	cd disjoint2 &&
-	check_describe "B-3-gHASH" HEAD
-)
+check_describe -C disjoint2 "B-3-gHASH" HEAD
 
 test_done
-- 
2.31.1.634.gb41287a30b0

