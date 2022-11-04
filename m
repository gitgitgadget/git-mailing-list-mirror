Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D848C43219
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiKDN0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiKDNZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7CE2F650
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:25:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i21so7554669edj.10
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFiQ1B/BRrFmQP4PSVNSTKt0/dSAUUl0tWnwjTzPlkA=;
        b=dHE+1d6wKhGKIUkdFqrttR2bjB17sovHkEfwW3BlpgWCwbqCGYOiKA76ZEUqSyTmPb
         7eI586DyOEA4UAGFGyZFwO3xeWrqlIO3wZ+2FWHEu+owS3hw0kGeoAFhFHDPXjtTdoQV
         RD1DEqfJarea+YzBe9kNPEcNWgW+R+67SZ1tzuS7nTRFs3YCeowiqnaG3z8MT0Oqwvjf
         dE7z4wXVuwW98IH7wLUfnbyRGn8UKmc6zxpVb4DPC4bD7sovQDKNB6ZQlJeyJYvKsoPW
         kOyexUlh8DQOivpULKXOUngflPHE9L7d4mVp+uynK5nb5ebCz+iQBFEvZQmrY7f54/vJ
         mFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFiQ1B/BRrFmQP4PSVNSTKt0/dSAUUl0tWnwjTzPlkA=;
        b=4O/crHVFnWcoBhRpTV/Ta7dA9Pg0afq0NWXRNXpzRvygkHKvIZszhB14wUsAbVr6jN
         XS7ydKWCEqcQSCuPceiFQlS59MOJNt8wDrSLXNqCYiNb0+6USnGvl3cogctjta9QGv+G
         UKRPRkPnAyVMxQVbNyAcBdapM+Cypg69QyMykwqqw/G+pim5wlJHmoFitcH74kAhVJY7
         +kj4zoLGbr1p6YoOokxq+mRI6ixnPHKjRjZdmCGype2UGF79wQ0B+rLPe2tQC9QzYljK
         AL5OLNy+qJAt6qj8pJU/vhNk1AQx13hcItvB8PbJRxs+hh1DjxH5jgbMLvaNqknsBw/L
         CzCg==
X-Gm-Message-State: ACrzQf0+ydUpHRnwB1PWN9xTIEQ8T06tW46wJ7CNl7M2BwZH9EhaIjz3
        GKHye3J8V5MSYIHopyYqf4VCzQ5eLI7MdQ==
X-Google-Smtp-Source: AMsMyM4K9e0myizxc5qQQkCSmMipUoIWIoWnfa/SucpKIv7MmtVfNscuDqlbUbiA0lrp5OOXcCVmCQ==
X-Received: by 2002:a05:6402:51a:b0:461:970e:2adc with SMTP id m26-20020a056402051a00b00461970e2adcmr35375247edv.44.1667568304146;
        Fri, 04 Nov 2022 06:25:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:25:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/13] bisect--helper: make `state` optional
Date:   Fri,  4 Nov 2022 14:22:49 +0100
Message-Id: <patch-12.13-13745e3f18f-20221104T132118Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for making `git bisect` a real built-in, let's prepare
the `bisect--helper` built-in to handle `git bisect--helper good` and
`git bisect--helper bad`, i.e. do not require the `state` subcommand to
be passed explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c | 21 ++++++++++++++++++---
 git-bisect.sh            | 17 +----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index b62d3f4d418..c92197b0ea5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1348,10 +1348,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 
 	argc = parse_options(argc, argv, prefix, options, git_bisect_usage,
-			     0);
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
 
-	argc--;
-	argv++;
+	if (fn) {
+		argc--;
+		argv++;
+	}
 
 	if (fn == bisect_reset) {
 		if (argc > 1)
@@ -1386,6 +1388,19 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 	}
 
+	if (!fn) {
+		if (!argc)
+			usage_msg_opt(_("need a command"), git_bisect_usage,
+				      options);
+
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		if (check_and_set_terms(&terms, argv[0]))
+			usage_msg_optf(_("unknown command: '%s'"),
+				       git_bisect_usage, options, argv[0]);
+		fn = bisect_state;
+	}
+
 	res = fn(&terms, argc, argv, prefix);
 	free_terms(&terms);
 
diff --git a/git-bisect.sh b/git-bisect.sh
index e19847eba0d..c6e12f60f83 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -34,33 +34,18 @@ Please use "git help bisect" to get the full man page.'
 OPTIONS_SPEC=
 . git-sh-setup
 
-TERM_BAD=bad
-TERM_GOOD=good
-
-get_terms () {
-	if test -s "$GIT_DIR/BISECT_TERMS"
-	then
-		{
-		read TERM_BAD
-		read TERM_GOOD
-		} <"$GIT_DIR/BISECT_TERMS"
-	fi
-}
 
 case "$#" in
 0)
 	usage ;;
 *)
 	cmd="$1"
-	get_terms
 	shift
 	case "$cmd" in
 	help)
 		git bisect -h ;;
 	start)
 		git bisect--helper start "$@" ;;
-	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper state "$cmd" "$@" ;;
 	skip)
 		git bisect--helper skip "$@" || exit;;
 	next)
@@ -79,6 +64,6 @@ case "$#" in
 	terms)
 		git bisect--helper terms "$@" || exit;;
 	*)
-		usage ;;
+		git bisect--helper "$cmd" "$@" ;;
 	esac
 esac
-- 
2.38.0.1452.g710f45c7951

