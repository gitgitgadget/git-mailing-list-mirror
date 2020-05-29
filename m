Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E4C433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10206207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic0DH/Xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgE2IvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2Iu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:50:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA6C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:50:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so2515001wrt.9
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPvBaxVdZRHaGysXicN82lxe6K1U2p0UZtACd6nto4g=;
        b=ic0DH/XnsO4rILAaHKqPeC0OiP/hJFqb2xGQ803zPFaqYmAOamVIHrU1gNQS3YljzT
         p2PBL6xC7Im+jbGWsaezFLwk+mY+PRWu9WFISXBXoZ1aPtxrsVceARelL7ck1OHyzcTP
         1oJtxd2OvxP4+wZKbRJSNK/Md9BjOnquGMV0wVXUI+Wkij2NShh+qM/bwPLuH8mcrwmn
         bmcL2iRASCVbF3D0i8iKAgOkVAegrP/fO/5Ci8LQU+h6lSn44HyOy5yRdt1vgLkkFg+s
         0esqVEb4X83midS/ixvooz2fsaeyKEkgAeXu73n1sHbdaPTWoZZjq0uV0qMC0Swbl5ov
         642w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPvBaxVdZRHaGysXicN82lxe6K1U2p0UZtACd6nto4g=;
        b=ORSYjRAdOXtrsaA+QkeQc316d8BnUwHjGABg59mRpNg641Fd0ORHUGNpCG23Z5jZog
         uSM3WksV5frnwprNnGV6/V2v/1Pahd529ltTjA6GHb1G5Npg4eZF28T8vTVNDcAwtQw+
         gkNjOcapPTM95Ye96KEyYSd6XhnBseLPPFBav859abzSwIvkC9N9wu3el2XrA8CD7+E+
         yq7TofV+/mnlxV2Jg1S5/ahx6Qo7l4TV3CUNGRBe93T4uM2MR9Y2bH9wqHjpAMpFow18
         2kavoBq331HoBLPql0WEAElfFMY4r9MBwtXSgnZYwXT9C6n4Ub4v1ytpOn77D2Osj+s3
         H2DQ==
X-Gm-Message-State: AOAM530Ih3bh9nSTT9cSK8Y+2qupFWrYCkE5JlTJqmS5lD3hzw1qk64T
        Q045BoEmycZ9bFHpd8R5LkxotLXk
X-Google-Smtp-Source: ABdhPJyz3hCVzsTpL1VGFMS9LpmtzOvE3ute/XWca7XzTmywfoQ+0Tm4i1LUahChOnRQYmusGv6Bpw==
X-Received: by 2002:adf:fb0f:: with SMTP id c15mr8138918wrr.410.1590742257942;
        Fri, 29 May 2020 01:50:57 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.50.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:50:56 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 01/34] tree-walk.c: don't match submodule entries for 'submod/anything'
Date:   Fri, 29 May 2020 10:50:05 +0200
Message-Id: <20200529085038.26008-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodules should be handled the same as regular directories with
respect to the presence of a trailing slash, i.e. commands like:

  git diff rev1 rev2 -- $path
  git rev-list HEAD -- $path

should produce the same output whether $path is 'submod' or 'submod/'.
This has been fixed in commit 74b4f7f277 (tree-walk.c: ignore trailing
slash on submodule in tree_entry_interesting(), 2014-01-23).

Unfortunately, that commit had the unintended side effect to handle
'submod/anything' the same as 'submod' and 'submod/' as well, e.g.:

  $ git log --oneline --name-only -- sha1collisiondetection/whatever
  4125f78222 sha1dc: update from upstream
  sha1collisiondetection
  07a20f569b Makefile: fix unaligned loads in sha1dc with UBSan
  sha1collisiondetection
  23e37f8e9d sha1dc: update from upstream
  sha1collisiondetection
  86cfd61e6b sha1dc: optionally use sha1collisiondetection as a submodule
  sha1collisiondetection

Fix this by rejecting submodules as partial pathnames when their
trailing slash is followed by anything.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t4010-diff-pathspec.sh | 4 +++-
 tree-walk.c              | 9 ++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index e5ca359edf..65cc703c65 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -125,7 +125,9 @@ test_expect_success 'setup submodules' '
 test_expect_success 'diff-tree ignores trailing slash on submodule path' '
 	git diff --name-only HEAD^ HEAD submod >expect &&
 	git diff --name-only HEAD^ HEAD submod/ >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	git diff --name-only HEAD^ HEAD -- submod/whatever >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'diff multiple wildcard pathspecs' '
diff --git a/tree-walk.c b/tree-walk.c
index d5a8e096a6..7fbb150312 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -849,7 +849,14 @@ static int match_entry(const struct pathspec_item *item,
 	if (matchlen > pathlen) {
 		if (match[pathlen] != '/')
 			return 0;
-		if (!S_ISDIR(entry->mode) && !S_ISGITLINK(entry->mode))
+		/*
+		 * Reject non-directories as partial pathnames, except
+		 * when match is a submodule with a trailing slash and
+		 * nothing else (to handle 'submod/' and 'submod'
+		 * uniformly).
+		 */
+		if (!S_ISDIR(entry->mode) &&
+		    (!S_ISGITLINK(entry->mode) || matchlen > pathlen + 1))
 			return 0;
 	}
 
-- 
2.27.0.rc1.431.g5c813f95dc

