Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D134C20323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdCRKeg (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:34:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33177 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdCRKeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:34:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11so6810797wma.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wR2QehdjJC+R8qeSZmEP9G2I4z4FJalU9nz08GUQwnE=;
        b=qNW/cqgG6aUyjbGEF8oSTZd/SOQu6Pu5Kpnr36oxtwTnKaqjsSGsHcPvvvI61BdXe8
         eNsDgl4TniB3KT2xfbxIX/mnjkmxqubJqfVoxRbmfDoh0oUhnWvXa4vq/zuj1TGO4kJq
         QGwYwqtGhUKvNWf+5rb855iOgMzd3fYWdO1hRuOfP5ISxjiVzRA5B2OV+w4VSPvQzsaB
         KatSbbKTwaroinrcuqexEDo8BGXYk16lAeEXoLjMi6ua0wCun1HGHPMTx1Ort6MiYsZs
         kqs921uhhYVS7w82vBIEDwSnNoaP++RoPERY/r0dZ18bLdILTyPDlfLfRfeCjC6SQ6sn
         x5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wR2QehdjJC+R8qeSZmEP9G2I4z4FJalU9nz08GUQwnE=;
        b=LHaa6RktIlUe0clRnycibpvX9qMTS9lXMxz4RAI68Zdm3hYiFEd1gMNykaviOGWoA9
         5fL/7SBt3J5zeDtvHmJtwqDjCDzYNelP3c9I7ZMX1pkwUVKqhOm/+dD1TYwdRJLyBC/G
         YkS3Hun4nnkUd8SbM8drxmAn5DI6PrXP8OosqM2CS9T4LWJtAt2ehMp4kfSXRcv3MhDv
         T+d2JTvMwHr1bclyyXTkUR0uTbwDEBTKBY8h4hiqnLwsLhSQIz+3pcCyYk4oocg91yi3
         omzdNUr/B9RT7p+ighpNTKEgaZX3D61zVLns/snFegluuu0q0Xs2DRvr+E4vekXUuRVv
         IYJw==
X-Gm-Message-State: AFeK/H3PYmubaBJWK2lnFRyVnBNodNxj5XSCXhzsy9U0zfrYoqrPpIru1npD/Ku9ErvOPg==
X-Received: by 10.28.182.10 with SMTP id g10mr2151803wmf.123.1489833208262;
        Sat, 18 Mar 2017 03:33:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j34sm13007928wre.7.2017.03.18.03.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 03:33:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] tag: Refactor the options handling code to be less bizarro
Date:   Sat, 18 Mar 2017 10:32:50 +0000
Message-Id: <20170318103256.27141-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318103256.27141-1-avarab@gmail.com>
References: <20170318103256.27141-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the options handling code so that "cmdmode = 'l'" isn't set
on the likes of "tag -a". This change introduces no functional
changes, but makes subsequent patches easier to reason about, as both
"annotate = 1" "cmdmode = 'l'" won't be unexpectedly set if "tag" is
merely invoked as "tag -a", "tag -s" etc.

Before this the cmdmode variable would be set to 'l' indicating that
"tag" was operating in list mode, this was then used a couple of lines
later by e.g. the codepath for "tag -a" where the command would only
bail out with usage_with_options() if the likes of "-a" were
set, *and* some cmdmode (i.e. 'l' in this case) had been set.

This behavior was an emergent property of other earlier changes,
starting with commit 6fa8342b12 (tag: Check that options are only
allowed in the appropriate mode, 2008-11-05), to its present form in
commit e6b722db09 ("tag: use OPT_CMDMODE", 2013-07-30).

Change the test suite to more exhaustively assert that already
existing behavior related to this option parsing is kept.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/tag.c  |  4 ++--
 t/t7004-tag.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index ad29be6923..0bba3fd070 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -454,10 +454,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
 
-	if (argc == 0 && !cmdmode)
+	if (argc == 0 && !cmdmode && !create_tag_object)
 		cmdmode = 'l';
 
-	if ((create_tag_object || force) && (cmdmode != 0))
+	if ((create_tag_object || force) && (cmdmode || (!cmdmode && !argc)))
 		usage_with_options(git_tag_usage, options);
 
 	finalize_colopts(&colopts, -1);
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 876ccfc830..74fc82a3c0 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1455,6 +1455,19 @@ test_expect_success 'checking that initial commit is in all tags' "
 
 test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -a &&
+	test_must_fail git tag -a -l &&
+	test_must_fail git tag -s &&
+	test_must_fail git tag -s -l &&
+	test_must_fail git tag -m &&
+	test_must_fail git tag -m -l &&
+	test_must_fail git tag -m "hlagh" &&
+	test_must_fail git tag -m "hlagh" -l &&
+	test_must_fail git tag -F &&
+	test_must_fail git tag -F -l &&
+	test_must_fail git tag -f &&
+	test_must_fail git tag -f -l &&
+	test_must_fail git tag -a -s -m -F &&
+	test_must_fail git tag -a -s -m -F -l &&
 	test_must_fail git tag -l -v &&
 	test_must_fail git tag -n 100 &&
 	test_must_fail git tag -l -m msg &&
-- 
2.11.0

