Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA94C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BA261027
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243471AbhJHVs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbhJHVs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:48:26 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D291C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:46:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r134so1075657iod.11
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lp1JX8ap6gt7iNehfUEuY6/IwkA5y8cES4y/SXJPefg=;
        b=AXmKbQoMXCc3teXOhJN6rxOfzFa9K6n2Yx8HQY4Gm62M4UZhtuXVDhPXofmCZhXDdn
         bzmqZjFn1yVrL8wiGazo42OB5CQvt1ivzgT7tgniuHdFoGgGiEzPaNJn5Y1LQR8YXAcL
         2PuhghZWyaM6Yat3Pto5/RTvU5AbtH2Y7FVHAO1eMmNqga4jRxLcLgdh5gk9IFCEkq8M
         6/c6mUUI79z4jDuecO3kHvePL3HRyNC9p60PbMFGx7E32HzJoWD933pKeq/SN3aYYHCa
         K7z7msk1kxufdrQ9Mn4Vtl8RBuR1IVCinlGwFvEFnuBwFXQiJ6k9Ra4xliCtMETgJKuy
         uYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lp1JX8ap6gt7iNehfUEuY6/IwkA5y8cES4y/SXJPefg=;
        b=2apgVYO04a8TK9bgMFWk1PThRKmAIoWlfnERN4cha4Pj7egce5Gd2vS09+zKHGQ0hi
         BHn9ShWAH0TseKF1RMiT/f9cyvukrmnUW8yFB39s60FWeVRHYzMsJ+QNOaED/Hopz1Ua
         dw051kdk84fp+gKhgltkwgkWiVdzQKYlLIBFUtOWDynJh3pQ1/Tj0NvpVaLQ7MXFr1lM
         A5xYJjobu/SzkEF+09f0zqeeetWvLZipfCbsIs3sriZTWI9zJfDSblSytAah9iULLNfO
         HPvu2bgl97f+yR195A2h25s8LFrZzZQvxtuDO7ekYD0XmmjF7c3n0yBCxm3PAiLRSTDU
         /41Q==
X-Gm-Message-State: AOAM531gH2veXL9Wut7IJQVCKmoABuI34p/9P63KWpL00tWEJLbNibtI
        7tbUEHFzIQATS+gfgpRjHQm/RrMEvgEFsg==
X-Google-Smtp-Source: ABdhPJxZxzmwF7Fm4RUfRWDocowJadZOZY0iV9lGJb0t9Ta7f5ClFCSPDfRSf5Q/ZmWQ9FSCOLkTdw==
X-Received: by 2002:a6b:8d8a:: with SMTP id p132mr4540396iod.96.1633729590443;
        Fri, 08 Oct 2021 14:46:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a4sm221347ilj.35.2021.10.08.14.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:46:30 -0700 (PDT)
Date:   Fri, 8 Oct 2021 17:46:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, dstolee@microsoft.com,
        jeffhost@microsoft.com, peff@peff.net
Subject: [PATCH 1/4] midx.c: extract MIDX lookup by object_dir
Message-ID: <ecb454233a4fcc88e1ca142b633a5785b6776a2e.1633729502.git.me@ttaylorr.com>
References: <cover.1633729502.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1633729502.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first thing that write_midx_internal() does is load the MIDX
corresponding to the given object directory, if one is present.

Prepare for other functions in midx.c to do the same thing by extracting
that operation out to a small helper function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/midx.c b/midx.c
index 18a4f25aa3..b66b75a3cd 100644
--- a/midx.c
+++ b/midx.c
@@ -1118,6 +1118,22 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 	return ret;
 }
 
+static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
+							const char *object_dir)
+{
+	struct multi_pack_index *cur;
+
+	/* Ensure the given object_dir is local, or a known alternate. */
+	find_odb(r, object_dir);
+
+	for (cur = get_multi_pack_index(r); cur; cur = cur->next) {
+		if (!strcmp(object_dir, cur->object_dir))
+			return cur;
+	}
+
+	return NULL;
+}
+
 static int write_midx_internal(const char *object_dir,
 			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
@@ -1131,15 +1147,11 @@ static int write_midx_internal(const char *object_dir,
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
-	struct multi_pack_index *cur;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
 	struct chunkfile *cf;
 
-	/* Ensure the given object_dir is local, or a known alternate. */
-	find_odb(the_repository, object_dir);
-
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name))
 		die_errno(_("unable to create leading directories of %s"),
@@ -1151,12 +1163,7 @@ static int write_midx_internal(const char *object_dir,
 		 * packs to include, since all packs and objects are copied
 		 * blindly from an existing MIDX if one is present.
 		 */
-		for (cur = get_multi_pack_index(the_repository); cur; cur = cur->next) {
-			if (!strcmp(object_dir, cur->object_dir)) {
-				ctx.m = cur;
-				break;
-			}
-		}
+		ctx.m = lookup_multi_pack_index(the_repository, object_dir);
 	}
 
 	if (ctx.m && !midx_checksum_valid(ctx.m)) {
-- 
2.33.0.96.g73915697e6

