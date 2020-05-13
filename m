Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F2AC433E2
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C5D20659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Jc+VAx9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgEMV7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730305AbgEMV7y (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:59:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3BEC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f23so347976pgj.4
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nNOixw/vyvqlsomm1EMtx40TEtpLG9+fCkSzDKrJP64=;
        b=Jc+VAx9mysny1y7CUdJAWrGMBMLF0Xz0E1faHz8cNnD3DGRNEDA1MEcir6xCATyAA/
         la2CVM33ARrDBrPds+WwY1QJz8p5palBWhtkqRhZs3/FXNMpe6crQcGw6HsS89bAXNIO
         CrMFQ/ntmLhhIfZRNoOATTd2zRFmdwYu9HhN2OPqxKl986f7onuuZZk5jiRQwEA7iXHb
         plHiBOjoPKs7RDreXcCRyZhUCFfMN5gWvPhDgZn4e6+AEfcceZ3gu+CEEOXNohiTfPwW
         0rbi9zGdWJNvDcpiowWBg/YNgrW382Db8RhFBnIroBplyE9nr6h9cQSX+UdP40K6h6ZW
         4HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNOixw/vyvqlsomm1EMtx40TEtpLG9+fCkSzDKrJP64=;
        b=mqO6lpqmmICBy84PNDAfw39x91NBT4MGJRYlzy3dQ8PFhg0dHHkh2QWeP51W3c8sB9
         CjxNs/5ktuK1nI0+QmjC8BFKptp/rhXmz6YkuOj8TtDKEBDJnZRqR7ThwwIV6j1qhCMk
         W0HbK9LDiAED4CqgaWB/A5HuzqFCzLSUAaaSeQDtWeC1KtuolfzBAZQPwatcC2wumMHc
         D0EBO8dBFIYxxNXM76PBBlyxoSqcHa9Q9b9MbIUkCo9RwMIhDSVlp+w9BD3LOtpnuREE
         Bz1YN1QcsadMbu9AvE/8kZjEB0PxjW28/dTC0OukgNlsYkRueDBe2QirY1qxBX3ylgZ1
         4h/w==
X-Gm-Message-State: AOAM5306HLmj8vA6OpM1qpGjjokr0QBSoUDUlFzfS51UdkDY24smfw+U
        MMpFOE+oMQ9UiQ6FeoHx+aw2OgI7Xwk=
X-Google-Smtp-Source: ABdhPJwf4SpD74CVZdI40HILqvtw49iGwwr4PgGRhRyLx58TbZvOMl/KZw5EvWvWuibbbWADC9oMPQ==
X-Received: by 2002:a62:7912:: with SMTP id u18mr1182378pfc.239.1589407193386;
        Wed, 13 May 2020 14:59:53 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x13sm443708pfn.200.2020.05.13.14.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:59:52 -0700 (PDT)
Date:   Wed, 13 May 2020 15:59:51 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 7/8] t5318: reorder test below 'graph_read_expect'
Message-ID: <8fdd2792dfd52bb304762a0faf7849bd55954d68.1589407015.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1589407014.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the subsequent commit, we will introduce a dependency on
'graph_read_expect' from t5318.7. Preemptively move it below
'graph_read_expect()'s definition so that the test can call it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 424599959c..255e3bb1c9 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -46,15 +46,6 @@ test_expect_success 'create commits and repack' '
 	git repack
 '
 
-test_expect_success 'exit with correct error on bad input to --stdin-commits' '
-	cd "$TRASH_DIRECTORY/full" &&
-	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
-	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
-	# valid tree OID, but not a commit OID
-	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
-	test_i18ngrep "invalid commit object id" stderr
-'
-
 graph_git_two_modes() {
 	git -c core.commitGraph=true $1 >output
 	git -c core.commitGraph=false $1 >expect
@@ -95,6 +86,15 @@ graph_read_expect() {
 	test_cmp expect output
 }
 
+test_expect_success 'exit with correct error on bad input to --stdin-commits' '
+	cd "$TRASH_DIRECTORY/full" &&
+	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
+	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
+	# valid tree OID, but not a commit OID
+	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
+	test_i18ngrep "invalid commit object id" stderr
+'
+
 test_expect_success 'write graph' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
-- 
2.26.0.113.ge9739cdccc

