Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48646C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 20:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjDQU6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDQU5j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 16:57:39 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006DA10277
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:55:21 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54fa9da5e5bso232126077b3.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681764880; x=1684356880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IlRk2Cyq1ILCTYojEJhxP5kHxinVdRACLgFFvc3slZY=;
        b=B8ECsnTrq8la1EtMLsYLmKbxHiIm4HuJ2Sa7jQYcgoY2/ja6drrIki5El09Fze2l0G
         HXHlGcWU2X4uJjypV6JTy2EzzsrFOlxtmcvgyY5tPhiKxE+uwdVjHkoUJdYcX0SPOM6C
         RXDIaiVMcxUBgBoWgHNAlQBFfKNOsE0eakPYBQX6Lv7dxBCjXpO1y/3i+CdE2yPZO8+u
         2yJfaZD2Ud1rVSKpixYX/+5gABZkJoYmOba21TESp/RJt89fhpm7xkevqMGWSpf8+15t
         AeOiaQlJMOhnsG+IEef6FtJXEDIW8ytfNKuLX5/nsYf7npIbWtn3YWn1IgAperguVSGq
         3j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764880; x=1684356880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlRk2Cyq1ILCTYojEJhxP5kHxinVdRACLgFFvc3slZY=;
        b=JmhsN6WYfpM8ozB33Lrl+ZqBl4bySRjcOcqfo6324UEsyAnKjmENXl6EE8c4ra5Nh6
         dL4nidG/BySf/aT2k2plcaL6z4LYnT/g76O1AZTefkSpMUwU+7Llj7usczqldWCYf5Kl
         0OWOR+2JKOB0d0lDsG6GKph/xOKktoa+Gn4STP8gNTSDxIU5RVnk5PzIkIUMDwMRdMoe
         fjyIVRZweRM5rwAW8HIeIR5GTZPXTHMhTKUcPCpmm6AtllBv1Lk1NYOr7M5rk8kppNCv
         +c+dwxRXjQ6/qcAdnsx4U450H3H4MGMzOi8KDjb5nsh7Rulz2R0Dv0dJEEg50yFl1XLD
         DR+Q==
X-Gm-Message-State: AAQBX9dx7y4Hxt7In8by36llT9tOUqf/bPDJUJ406tOKtBC9tzAAQiZC
        5ReYO7h40rXAJp8Nfs/cF60PsnxfNPo9Qo5MOVSUwg==
X-Google-Smtp-Source: AKy350ZFuuF0ixiQ/qeue9fm8XFUpsg3Kq9fcPePorw8MeovXHSP+gbOaGp9qfUq9acE6eT0Jt0WoQ==
X-Received: by 2002:a81:748b:0:b0:54f:cc36:2fae with SMTP id p133-20020a81748b000000b0054fcc362faemr14873700ywc.41.1681764878373;
        Mon, 17 Apr 2023 13:54:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v16-20020a81b710000000b0054fb931adefsm3337665ywh.4.2023.04.17.13.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:54:38 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:54:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/10] t/t6501-freshen-objects.sh: prepare for `gc --cruft`
 by default
Message-ID: <4ccc525c39dd23db1136681bc0ffd572db0ed2f2.1681764848.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, prepare for `gc --cruft`
becoming the default by ensuring that the tests in t6501 explicitly
cover the case of freshening loose objects not using cruft packs.

We could run this test twice, once with `--cruft` and once with
`--no-cruft`, but doing so is unnecessary, since the object rescuing and
freshening behavior is already extensively tested via t5329.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t6501-freshen-objects.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 3968b47ed5..dbfa8a4d4c 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -101,7 +101,7 @@ do
 	'
 
 	test_expect_success "simultaneous gc ($title)" '
-		git gc --prune=12.hours.ago
+		git gc --no-cruft --prune=12.hours.ago
 	'
 
 	test_expect_success "finish writing out commit ($title)" '
@@ -131,7 +131,7 @@ do
 	'
 
 	test_expect_success "simultaneous gc ($title)" '
-		git gc --prune=12.hours.ago
+		git gc --no-cruft --prune=12.hours.ago
 	'
 
 	# tree should have been refreshed by write-tree
@@ -151,7 +151,7 @@ test_expect_success 'do not complain about existing broken links (commit)' '
 	some message
 	EOF
 	commit=$(git hash-object -t commit -w broken-commit) &&
-	git gc -q 2>stderr &&
+	git gc --no-cruft -q 2>stderr &&
 	verbose git cat-file -e $commit &&
 	test_must_be_empty stderr
 '
@@ -161,7 +161,7 @@ test_expect_success 'do not complain about existing broken links (tree)' '
 	100644 blob $(test_oid 003)	foo
 	EOF
 	tree=$(git mktree --missing <broken-tree) &&
-	git gc -q 2>stderr &&
+	git gc --no-cruft -q 2>stderr &&
 	git cat-file -e $tree &&
 	test_must_be_empty stderr
 '
@@ -176,7 +176,7 @@ test_expect_success 'do not complain about existing broken links (tag)' '
 	this is a broken tag
 	EOF
 	tag=$(git hash-object -t tag -w broken-tag) &&
-	git gc -q 2>stderr &&
+	git gc --no-cruft -q 2>stderr &&
 	git cat-file -e $tag &&
 	test_must_be_empty stderr
 '
-- 
2.38.1

