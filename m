Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22C9C4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C82161212
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhHXQRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhHXQRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C411C0617AE
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:35 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a21so27066042ioq.6
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EiDGZ/YjEwrBF8MU75wdKIksLOVBYJ6qMZ9IydcqelI=;
        b=y5lTMAjiF3xqZBm8NHRSbbzvlOhNUT9fW+5vkx939qeYbhNdy3cYLqnktKs7RX62vq
         QWbkjwNvL7UYtDT76f/9GyIZrKCSlQDxCR1C4RnIlmoCTKFcBrABrAjTeTK7BwRpMlkd
         yhNtP2PGsd/9q9j5r20TTDdtGZuAZtC19exlBJaKDiGAhM7qC52DQDKzpNyI2zuKE/uu
         NYyoWA8Cf3V3QYxzCCdVz6eMCXi2HiPyhHGYYc3uEVTjE1oXYv2B5xv2PL29rWG7TucA
         njggKbrGnioGBPwUyFHeqJ0kDbH0tOEHrl8Id5jX3AhQXjv0zTAogY2GMZIx4vWLAcbi
         eHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EiDGZ/YjEwrBF8MU75wdKIksLOVBYJ6qMZ9IydcqelI=;
        b=n2qEkAF5/uF8a+aIBuYM28DDL31Ls2lSzxzf+TAXQynXDuXMj9cIXb4G19mJAmJXjA
         xWeTbOMi5O+wA2TJhPk76DApN8QCiS/kjRySrM+5NhNTNwO6j5Y1pb02EWRD+4M89h1X
         2hHzYkBE7JR63PSSCIb/a6in6T4NYCz351APpbBG/YEiYO9/ccrk5fn2Iaa4bmsBGGLz
         JBLM5Rifwx3hBhUnX68HflNKRZmBnBvCDBjHkhq5jwxnujHEVHCwssysyFimVVu8rND8
         BmObQz7GVTNj/+MOby3Ni3A9NEU88+1/a3IFWatPv1pGkPfiwLYDvwWEy5RDu0X8lz5E
         Fg9g==
X-Gm-Message-State: AOAM5300kqm778wcXVp+LwOSwNcnOqxPt/vdIvNGHNri44uV/yj14nxQ
        sFyMcA/tvZyxFDaAAfrHK8QvZFXAjxRqergN
X-Google-Smtp-Source: ABdhPJwQa1QIuLlprwt+bDilBGnKH8h1Og82Lix5vEFGCN2ZD+QBdEcXsIb+M5TyXENjDEpHDATkWA==
X-Received: by 2002:a05:6638:25c3:: with SMTP id u3mr35556877jat.52.1629821794664;
        Tue, 24 Aug 2021 09:16:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a6sm10046671ilb.59.2021.08.24.09.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:34 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 17/25] t/helper/test-read-midx.c: add --checksum mode
Message-ID: <d47aa4a91933b7424bf720be7ec4911a398833b1.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subsequent tests will want to check for the existence of a multi-pack
bitmap which matches the multi-pack-index stored in the pack directory.

The multi-pack bitmap includes the hex checksum of the MIDX it
corresponds to in its filename (for example,
'$packdir/multi-pack-index-<checksum>.bitmap'). As a result, some tests
want a way to learn what '<checksum>' is.

This helper addresses that need by printing the checksum of the
repository's multi-pack-index.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-midx.c | 16 +++++++++++++++-
 t/lib-bitmap.sh           |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 7c2eb11a8e..cb0d27049a 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -60,12 +60,26 @@ static int read_midx_file(const char *object_dir, int show_objects)
 	return 0;
 }
 
+static int read_midx_checksum(const char *object_dir)
+{
+	struct multi_pack_index *m;
+
+	setup_git_directory();
+	m = load_multi_pack_index(object_dir, 1);
+	if (!m)
+		return 1;
+	printf("%s\n", hash_to_hex(get_midx_checksum(m)));
+	return 0;
+}
+
 int cmd__read_midx(int argc, const char **argv)
 {
 	if (!(argc == 2 || argc == 3))
-		usage("read-midx [--show-objects] <object-dir>");
+		usage("read-midx [--show-objects|--checksum] <object-dir>");
 
 	if (!strcmp(argv[1], "--show-objects"))
 		return read_midx_file(argv[2], 1);
+	else if (!strcmp(argv[1], "--checksum"))
+		return read_midx_checksum(argv[2]);
 	return read_midx_file(argv[1], 0);
 }
diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index 77464da6fd..21d0392dda 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -260,3 +260,7 @@ have_delta () {
 	echo $1 | git cat-file --batch-check="%(deltabase)" >actual &&
 	test_cmp expect actual
 }
+
+midx_checksum () {
+	test-tool read-midx --checksum "$1"
+}
-- 
2.31.1.163.ga65ce7f831

