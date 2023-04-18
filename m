Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBC9C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjDRUk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjDRUkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:40:47 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942ECC1B
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:45 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54c12009c30so581297737b3.9
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681850445; x=1684442445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PD6rXkq70FqXYe/Y3zZYy5XGdBSlQTwqEFYec7m9f0=;
        b=2jwbGWn4ZxpYYGwbBNlSjEVPqDMJZIArqeZA/Q2jyf+tDuatfm2zGWXFQz8qj9qg7D
         84HpmvujzQ9s34VvmMVl+L+LS2XirmUhZREs1MuVf4KueQLLLV6UvDKP4y5QvXH7yzCg
         TX7wYuIdQZDgOFX12CxyeqBBzBqm/ldlh4xzT6iGYKC9mrJC/iBhIB2xZhZmI2oqYXG9
         9eABenf7d31I1/N5m9pxWccxq+0Z5U8DRWgi7MXR7y810I1nEbH1C1BnaVXmq6rQ21zs
         xJAHYmVeC6+IEWVz7+YrvvSwvQyZ6hk8rno3ZGp3sypqjj2/qpPT9fWOK59kn6kMEQmB
         QjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850445; x=1684442445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PD6rXkq70FqXYe/Y3zZYy5XGdBSlQTwqEFYec7m9f0=;
        b=izmZuoc04yGntw55W2n6zrGM5H6UM0gxnOcO/gDrXCEmRr/bEUgE+sh5ToKm1QTVy9
         yQHceuMLEALxdeRNEQaG4zLULn+58Kk6sLQOoEeFTArhgdavkINOlgKLUJ/m5HtTMtv5
         5I4uDgGi7Isi7gmYsNC1VjDXRuOfVxE+WTOUX85dYZz0hz/S+ymQG1z85a0vvc4ND63N
         4hfZUP09trMvxYMBxxlV4F61MidqYy0VvzwRoCTpelvGhoYRk55VZ5+0t7NxpMjHk4DZ
         nPpBA7BDBdo5rbUjOOHCDT12jSgCe8cV8snMtCSh7OCDcrLMb8KxlxJsxHuviqOrL9RV
         0Itg==
X-Gm-Message-State: AAQBX9cU5IGPQ807+zTMe6uYHa+ACouesgavNtIbIlYz15VKs+ctODnZ
        e3wKmrzKhcmyAeS+sC3TN0G2ty65e9MIjiFDiu3S6Q==
X-Google-Smtp-Source: AKy350azd9Dp4NHI7TbhcoBN4L/9exe2J6CrW0GL3mlF0c7fSEtZKMpsf0EWacGZsjJNnHH0cPpLhg==
X-Received: by 2002:a0d:d6c9:0:b0:54f:c657:d80c with SMTP id y192-20020a0dd6c9000000b0054fc657d80cmr1014605ywd.50.1681850444978;
        Tue, 18 Apr 2023 13:40:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e6-20020a811e06000000b0054640a352f2sm4040547ywe.20.2023.04.18.13.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:40:44 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:40:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/10] t/t6501-freshen-objects.sh: prepare for `gc
 --cruft` by default
Message-ID: <fa6eafb1fecc0956f846487af0ad0bd243c0ff3f.1681850424.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681850424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, prepare for `gc --cruft`
becoming the default by ensuring that the tests in t6501 explicitly
cover the case of freshening loose objects not using cruft packs.

We could run this test twice, once with `--cruft` and once with
`--no-cruft`, but doing so is unnecessary, since we already test object
rescuing, freshening, and dealing with corrupt parts of the unreachable
object graph extensively via t5329.

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
2.40.0.362.gc67ee7c2ff

