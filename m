Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA42C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD87464E85
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhBXTM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbhBXTLs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:11:48 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA06DC061793
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:53 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id q85so3258450qke.8
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fK8WEtc2GFHptLJs2Vl6B9J5BbpyrxE1ckawIMUyd9Y=;
        b=bBUfxyD7Y8ZA9yGZ9XMWaZLUX8ZYC5s+sIQUdeHPVkyVWWkipDGbcVIKvOzqlWkkqc
         49vhPrCd275nO/H0dqdq31FcI+JWaRocFp9WIqAx68fLumFmStz7HvqtAQhTiflKFST3
         1C1jy3KTSkeSzPrr3H8yXQH0NfCljMW9UERSbPu/v0Vn+ULlXvkgGqN+5uZqQrglKNGK
         SMNoQ0DFwCW53I0VYOFtNjdaFimAr+Alw4h0yRhqHkser6CncUMHUtMqSxShO+bt5w5I
         KX57XN3uknvxQwenx6kujcPn8W8obhQ6mNvgyPQP3si9KjELFOTfyt04SzLshG3CMWd7
         w0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fK8WEtc2GFHptLJs2Vl6B9J5BbpyrxE1ckawIMUyd9Y=;
        b=CkCZN3VpqHXKq3mZEAsSYyiggR9fPJDGJgzKMokHtFid7WcAmVl3epgo50AHWxSRM2
         Bvt74q3VO4Hn8UKgknDG9G2CwMjywmyOk4c400+lnL7QBFNCpxkE9CItNbqtRTAvQtfu
         GTrYLTHw2VbIvMJSx1+d32h3mJ+AmOPNTg8UtcnUkpd6oQ1muMiiMrXlcctR/op7Xfwi
         xFUH2G2UhZUybSDF+SBBMlgTEuJGTdIfeuHwzTb6AVULx2fFZk4ZPxVuUhjriC4/1uoc
         g4GlPfYMJZnkZkvx/z/QA/ESKRYBacAYjgVFiV8sO2YxUN0eBpIh3YMfgJWnI3D7O7It
         zC0g==
X-Gm-Message-State: AOAM5323lze36tRnTkQjx1BAKoWNm8Mym2nS7QycqUt6XqKKGIJ+OIJO
        iLdfd2EBn8C5xdwW1m2MIQHUGdMgtyELFwlX
X-Google-Smtp-Source: ABdhPJwF8rSkp84nw3CZOLxSJagTk3/zXdWKAUZ+7MOrKmEk8DS05JNPYO32q3t2zdO4xbtxHjm+zw==
X-Received: by 2002:a37:a654:: with SMTP id p81mr32033854qke.354.1614193792833;
        Wed, 24 Feb 2021 11:09:52 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id z5sm2179439qkc.61.2021.02.24.11.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:09:52 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:09:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 07/15] t/helper/test-read-midx.c: add '--show-objects'
Message-ID: <2fd9f4debff480e18c902a919750cb7b7aba66bf.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1614193703.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614193703.git.me@ttaylorr.com>
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

