Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA98C43603
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267F464FE9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCKRF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCKRFH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:05:07 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B7CC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:07 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l13so1661904qtu.9
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fK8WEtc2GFHptLJs2Vl6B9J5BbpyrxE1ckawIMUyd9Y=;
        b=Dkl8ezAWk/lfIMP7SrSigLIGx7AJaPOZnTwFqFvYxX+j05HfHoy+uhtJXF20iOQcd3
         UIajWd+E/VVA+J8Az8bJLdk7GKTmAAgdPihu6E1a9j5oJByDv2VFvU0/ySH6kEEJr1xz
         kEumDJl+7oNIN1Q7ybp9ny/TmL5att9Ls7ouB9FqC+UQkqtRgDElZLgWyF5ZIGI/kXxG
         WusulMd9+kB7ccfdlJ9wy9itKLj5GEEFSUM/2WS8UEvmkQ4SRnroXFZeSGtPRJKdiCuC
         ftvf8dgYdvfjrIj7Er03uk7a8OGRujMi3KqUPNE/58nNoZfztnK4kEi8iTwnVKdSHBNW
         1hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fK8WEtc2GFHptLJs2Vl6B9J5BbpyrxE1ckawIMUyd9Y=;
        b=rVrodFlSoIOo9V9eLLH7BfmorZt1MeXbMYeGQefNXX8RA+XjHs3j8n0e6/3+CPn0hl
         7M+yZUoG3aodsf+UwuxOiPaSVNeMU4/st6KE6MleaQr2SNEM12fA3F14pq+ln6wztYcW
         wUrnJVH7fHTrgFXvy7TXBPGEkJkCGQluHegBi9lAsP/LlA0y7Gwb6gS0eL3zGgk8rkAc
         T/eTztILJqrlCTaoDXwpGdWja66NBKKtfMrbAjGidoH41CT42Dp6tzAQWWVw3gMVhtEO
         //GrbYUAPDv47xkZH1eEZtoslJm9eNJY0RTSpqT/26lOmRXIyqKcq71CZfMe7nKgmdHt
         2I/Q==
X-Gm-Message-State: AOAM532dLlVkI0z/Esvi/QyIuk29a/CO0UtcYefwqK7Qyc4Vyz7wKGuK
        G9s8LUW9650iDn9EuDZAyUrRaLERyzGwlwIK
X-Google-Smtp-Source: ABdhPJzH0RIwKD44rTo3fuCGb98F3wrqbwmkEeDRrzdbX/qLTILcowIHNGg8sD68av5cNVe7uwvL2Q==
X-Received: by 2002:ac8:6e9c:: with SMTP id c28mr8176175qtv.117.1615482305913;
        Thu, 11 Mar 2021 09:05:05 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id p8sm2185940qtu.8.2021.03.11.09.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:05:05 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:05:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 07/16] t/helper/test-read-midx.c: add '--show-objects'
Message-ID: <ae85a68ef2791edd5661890d69e2399fe3f07b44.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'read-midx' helper is used in places like t5319 to display basic
information about a multi-pack-index.

In the next patch, the MIDX writing machinery will learn a new way to
choose from which pack an object is selected when multiple copies of
that object exist.

To disambiguate which pack introduces an object so that this feature can
be tested, add a '--show-objects' option which displays additional
information about each object in the MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-midx.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 2430880f78..7c2eb11a8e 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -4,7 +4,7 @@
 #include "repository.h"
 #include "object-store.h"
 
-static int read_midx_file(const char *object_dir)
+static int read_midx_file(const char *object_dir, int show_objects)
 {
 	uint32_t i;
 	struct multi_pack_index *m;
@@ -43,13 +43,29 @@ static int read_midx_file(const char *object_dir)
 
 	printf("object-dir: %s\n", m->object_dir);
 
+	if (show_objects) {
+		struct object_id oid;
+		struct pack_entry e;
+
+		for (i = 0; i < m->num_objects; i++) {
+			nth_midxed_object_oid(&oid, m, i);
+			fill_midx_entry(the_repository, &oid, &e, m);
+
+			printf("%s %"PRIu64"\t%s\n",
+			       oid_to_hex(&oid), e.offset, e.p->pack_name);
+		}
+		return 0;
+	}
+
 	return 0;
 }
 
 int cmd__read_midx(int argc, const char **argv)
 {
-	if (argc != 2)
-		usage("read-midx <object-dir>");
+	if (!(argc == 2 || argc == 3))
+		usage("read-midx [--show-objects] <object-dir>");
 
-	return read_midx_file(argv[1]);
+	if (!strcmp(argv[1], "--show-objects"))
+		return read_midx_file(argv[2], 1);
+	return read_midx_file(argv[1], 0);
 }
-- 
2.30.0.667.g81c0cbc6fd

