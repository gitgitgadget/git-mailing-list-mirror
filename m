Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8649C433E2
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99086206E6
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn6owTYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgFENAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgFENAj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:00:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4690C08C5C3
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:00:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c71so8344869wmd.5
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=hfAWl+d0E00LStrOS05jPHsQ3rRuDqDxiOji5yY/OJg=;
        b=kn6owTYV0bVXfIo2685XtGg/5DcZqNcvt7MBI8YUhuJzfVo2lro+yFEpfxLA1NPf5+
         EaYkQRgOmoP3ieSeOv/KbEYxRGnoAwFhSB9d/ubWMS0GYdahUQMKTcmLzIi8/q7FuZqJ
         jP+DfpmrYpKcPxzFWnOhQW900cP00fOJx2raTmfh5Ol2AIi6E1JCNyI8JVkJDBjNNe/Y
         4gyP4W0MA1ewpVnfT3Ip2ohrV29jCc3uCSBYnqvAIsqI3egg4qxq5qZ73NsBj7PkXgPY
         OpKLuunyx53jP+YOEZKDFcj1UZnqZTVjEbvQeYXoke5tbh8xIGyZSLzmKZ9M7rxOQUYW
         5qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=hfAWl+d0E00LStrOS05jPHsQ3rRuDqDxiOji5yY/OJg=;
        b=LUlzFO5PJopraUDDws+FJLP8dRqr4A5xcJpZZr6K7pakFN90JnwMlCVxDjXSRb+895
         1u1kB9gT4GUkj/XuoW9xuBdaJv8farvD821/shsSjUddGHyqJ2g3AeuvhpjRDUpUtcxm
         ifSIs/f6nYSYs3AnEUlcpUO6mKR/+/PGs54xj2LCiaPIsbTwYiepQqrMLbLw54LHNwmk
         j/WHxNKZ9WyA38kl4ZZ2SieNJTf0ZCAWPZykd20q/QzK3AMv3ZNhgA9p4SjaW3anLJ8O
         5DSdfZqs9TRA++TvHTr0ykKQWamlLI/Gu+t43Rx+zNVZUYI2BW3Nkv9PTGW8Q7SBnEFK
         LQfg==
X-Gm-Message-State: AOAM533IOKWbMR6lX2q5dxnCpJaUiak0Ch/fP8lyW/UVBxHQNITLjA1m
        Rumu7ioLljvTcUziJb4wYRd9Zv1v
X-Google-Smtp-Source: ABdhPJwm2uQpFyFyMhcNcCDoU6VepqueAyMOTlbdYXAMd9koJOzJyITlKkhd3C2RmlpWZzrQhqn+LA==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr2526733wma.168.1591362036414;
        Fri, 05 Jun 2020 06:00:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm10877477wmc.15.2020.06.05.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:00:35 -0700 (PDT)
Message-Id: <af84c253b243656f74707e4ea44d13b1d9a464d1.1591362032.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 13:00:23 +0000
Subject: [PATCH 01/10] tree-walk.c: don't match submodule entries for
 'submod/anything'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

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
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t4010-diff-pathspec.sh | 4 +++-
 tree-walk.c              | 9 ++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index e5ca359edfa..65cc703c659 100755
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
index bb0ad34c545..0160294712b 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -851,7 +851,14 @@ static int match_entry(const struct pathspec_item *item,
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
gitgitgadget

