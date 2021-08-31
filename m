Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116DFC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF90261026
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbhHaUxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241330AbhHaUxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:32 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66603C0617AF
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:30 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id j18so766541ioj.8
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yG/JDN1Qp48z4r4jiHxdtCZXIj9giIJW34Xgsm0vA2s=;
        b=Jd536pFRzVyoUiu2NGJNyChA5012e9IwkHYtj3t6U1IFTCcAFqCL2+B6NkFGALa1zu
         +1+5FHQj2o8BrBU1UBytdTlE9MTQWb9bxdA8V58ZE1/jOCE330kE1pT3dS3M/FF8+FO+
         FSAboLAc06lqLKcR4zn9HinhhipMrn2EY7p6DEG1qVpBDTV/jZ471TpeVKquL/0/7K8G
         w64oyMwMGhRXh7GM4ch+EJCOIv0aYHbIOG89Try76XeyIW1iPrEOBQi97f7GKAjgxGze
         1ueYUGjbOqTQStR9yihyzStP7oKwWKAulEJ7hZQ71OqDXcJesPFLpR6FUOQfDCwzD+sG
         9vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yG/JDN1Qp48z4r4jiHxdtCZXIj9giIJW34Xgsm0vA2s=;
        b=cdX6ywHjWAHLViU+38hUhqJC98juAqQOJBU9B301zlbxS732NrOS1QPP61NSlbzoVa
         SjGTaY7maqd8KRPDcQI7OCXQS9/OKBR02r5ucgNFqvAf0/EkIk3Om6DZygvAnBQCXre0
         ycf22xuB3yqbP8CQY+sLX25YYc1JYMFFBZh46BnkNrFKzfDbs++VEuE2o01Yy5jBygrO
         SS6aPB09OCcEvrbt2r2bkuz3rI3atZV2FAt6A9vvfXfgWycZ8KiB9yO+6llfdsMkiq7+
         oTRZlTKjlgd6iLcgRtmcYNgHXxoRlmforX8c4bliusJIS2z2bKlZGQD85EW48KHMOtJP
         sJSQ==
X-Gm-Message-State: AOAM531TU5cEfYgw1e90ysdMv3SEE0LWMA4rvFYd3dWtOAYWH/gBTcjr
        o2N6tTZmNEF56fkYcysAPaDkOIt5jKj3dUhp
X-Google-Smtp-Source: ABdhPJzKSAmZ3fHBLWxSd+gkm9bySlSmTZ9p9junZZSQys5UkllYDeJPv9ZZ6GsbtVz5mzr2iECrZQ==
X-Received: by 2002:a02:7348:: with SMTP id a8mr4582425jae.116.1630443149786;
        Tue, 31 Aug 2021 13:52:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d14sm11407457iod.18.2021.08.31.13.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:29 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 19/27] t/helper/test-read-midx.c: add --checksum mode
Message-ID: <1a9c3538dbb7b7077e4a34b1d40628a770e44af8.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
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
2.33.0.96.g73915697e6

