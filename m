Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694BEC2D0C0
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 00:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF09206D3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 00:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p34um6uC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfLXA7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 19:59:11 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36489 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfLXA7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 19:59:10 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so497469pjb.1
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 16:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJi83eK0PE0bMQ1QC1teAIvoLPJNbnFRLVbcsSfdH6o=;
        b=p34um6uC7FaBJxulyt25ob8nDARx6J/vAobHUVvvtKswT745lfV3bozmdS5RXH066K
         wQVnzOgOJCSS8AwJn/3+KpX/q5+8lnSapanqhATr+BH7KDG1pWqfdqG7s7mpAGasG/zk
         k4Sdg0AMTBoj4V4P+81l4dm6xtH5XWfRCXy/kmxwe7Ck54c+5BFBBTpTtYeV+6lW6+MA
         Ui9gYxwrajWHOIcAJo5D6E6jafL/6lNrCOs2Iy+6WCGD4dGLA7GUFhbvyZ5y8Juc0NSt
         BEGWup+mAP+34lZfSxA57++cg22wJ3mBiVGPNGFLf9WqkEPjDd64pXQVRkuYut/XKQWx
         zLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJi83eK0PE0bMQ1QC1teAIvoLPJNbnFRLVbcsSfdH6o=;
        b=NKKgLEdRlvO4hhXjBrzH+Icbi7u7kvvrFnDmAYdHed/5skIbw1aG81LBAYL53bKXGJ
         qrs172dI+VprPPhcXBYxYQPL48wiXPErsAl+/vvEF+8aKTx1Jov9Iur3hRNDfx44sORd
         hztK9zTJ92mTc8m6KwpDXh1533nusSX73pGx7JRvLSZeV4miIKc2UiIGjnZHDopbSSea
         QyjL7QDGjxf7SVsfE9kFtVr/2o55aatFL0AAveXwixQW1aFDI/LsV6gMNJiFMupBwvJt
         OarQlWBQ2eOP5OUIenP+e+A6IjcSOBwYZ2pRu4nigvpe3+Wf29ZLhpUZp/d55LtiMh16
         UxRA==
X-Gm-Message-State: APjAAAWkpabiHBHgWozuSJVo09HFTZPubibf5WplbWqA+8nxmQ3srOOy
        sj7gLB5j1gTHmFaOmoAKDmHXcZSL
X-Google-Smtp-Source: APXvYqwtBpcMInWHcpGNjdJUR39iqERbCTFqV3fgFLxnvOa9AdI/kIqLc0Dlnp5Ii57G3mACttJSBg==
X-Received: by 2002:a17:90a:a798:: with SMTP id f24mr2500495pjq.27.1577149149958;
        Mon, 23 Dec 2019 16:59:09 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id r66sm26553492pfc.74.2019.12.23.16.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 16:59:09 -0800 (PST)
Date:   Mon, 23 Dec 2019 16:59:07 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 1/5] fetch test: use more robust test for filtered objects
Message-ID: <20191224005907.GD38316@google.com>
References: <20191224005816.GC38316@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224005816.GC38316@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git cat-file -e" uses has_object_file, which can fetch from promisor
remotes when an object is missing.  These tests end up checking that
that fetch fails instead of for the object being missing.

By luck, the tests pass anyway:

- in one of these tests ("filtering by size"), the fetch fails because
  (in protocol v0) the server does not support fetches by SHA-1

- in the second, the object is present but the test could pass even if
  it weren't if the fetch succeeds

- in the third, the test sets extensions.partialClone to "arbitrary
  string" so that when it tries to fetch, it looks up the "arbitrary
  string" remote which does not exist

Use "git rev-list --objects --missing=allow-any", so that the tests
pass for the right reason.

Noticed while testing with protocol v2, which allows fetching by sha1
by default, causing the first fetch to succeed and the test to fail.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t5500-fetch-pack.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 6b97923964..964930b2d2 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -917,7 +917,10 @@ test_expect_success 'filtering by size' '
 	git -C client fetch-pack --filter=blob:limit=0 ../server HEAD &&
 
 	# Ensure that object is not inadvertently fetched
-	test_must_fail git -C client cat-file -e $(git hash-object server/one.t)
+	commit=$(git -C server rev-parse HEAD) &&
+	blob=$(git hash-object server/one.t) &&
+	git -C client rev-list --objects --missing=allow-any "$commit" >oids &&
+	! grep "$blob" oids
 '
 
 test_expect_success 'filtering by size has no effect if support for it is not advertised' '
@@ -929,7 +932,10 @@ test_expect_success 'filtering by size has no effect if support for it is not ad
 	git -C client fetch-pack --filter=blob:limit=0 ../server HEAD 2> err &&
 
 	# Ensure that object is fetched
-	git -C client cat-file -e $(git hash-object server/one.t) &&
+	commit=$(git -C server rev-parse HEAD) &&
+	blob=$(git hash-object server/one.t) &&
+	git -C client rev-list --objects --missing=allow-any "$commit" >oids &&
+	grep "$blob" oids &&
 
 	test_i18ngrep "filtering not recognized by server" err
 '
@@ -951,9 +957,11 @@ fetch_filter_blob_limit_zero () {
 	git -C client fetch --filter=blob:limit=0 origin HEAD:somewhere &&
 
 	# Ensure that commit is fetched, but blob is not
-	test_config -C client extensions.partialclone "arbitrary string" &&
-	git -C client cat-file -e $(git -C "$SERVER" rev-parse two) &&
-	test_must_fail git -C client cat-file -e $(git hash-object "$SERVER/two.t")
+	commit=$(git -C "$SERVER" rev-parse two) &&
+	blob=$(git hash-object server/two.t) &&
+	git -C client rev-list --objects --missing=allow-any "$commit" >oids &&
+	grep "$commit" oids &&
+	! grep "$blob" oids
 }
 
 test_expect_success 'fetch with --filter=blob:limit=0' '
-- 
2.24.1.735.g03f4e72817

