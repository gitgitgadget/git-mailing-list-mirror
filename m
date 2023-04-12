Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D38C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 17:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDLR5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDLR5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 13:57:16 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05BB72A2
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 10:57:07 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54c0c86a436so353435637b3.6
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681322227; x=1683914227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BVq4ki6pcB+eAuEdrWpfm3eKamg4b+JwLsw6hCQGWA=;
        b=H8LqJIOdwdvU0dUQUU5Qr21JN/RBSFXCmaRAy3X9G/zElGZgloA7l1kfxL7+sPpeKy
         1A/DiQQn81X/Qrplh+tyiZV9MR8ZoFVB99F+jecZhZaB9g3Ses8Yg0+gWOcPHsvUUyzs
         GrKbT75y3/8Q/Bmlx6Srv8aQf3BhjjG60Px6/r7UAIfCpIFGKUK9rp5maEcLY5waHym8
         r6KzuPtOSY2JuiJY4mszZhPytgJo9JyxjDBU4cBxE++oDlWn+vukGdAm/dyjpmwn//m7
         7bEaYCpsCAg73bS/Wq7VrW5erfS61sHI3vz+7zINerXvEA4kvmxSOutdv1KPICneEm79
         KxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322227; x=1683914227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BVq4ki6pcB+eAuEdrWpfm3eKamg4b+JwLsw6hCQGWA=;
        b=dO+PHazRjt+LtrYP74GOTu88cGqtUPL/Vft3g2EwynabtaJd9iDzAGdgGWO2Q66Jd2
         oUjHk79KLDAct3eIiS72p9RNnbWSRLgOYF3ALo0zCe1BBoeif2CSgMSvVjgRLr4ZNuNl
         zUm6SYA1sLMBsQy+ZR9+Ejc68YUSUstizgZG2X82EpElOC97uIrCXRWjSUcb4CPpdrpL
         52c6gk1omDX8VCL2cOHvakCuWaYJb6ApAjTfLs9a+xAmePvsBuh4a6XSTZP9gpiaEM3Z
         jaIAwpeICR9XYsnLqD7gCXjBlxQRqq5CHzcZDBOU6NxrGoOiSIGsz//gVFbkzTtTiP/u
         SXzw==
X-Gm-Message-State: AAQBX9crydq7P1huvQT9zvLOc6+7bztgZXMnpUVTlGC2M16ePREhmCfm
        Ie5Pd+OrBgCOan0vehwFC8AKlw==
X-Google-Smtp-Source: AKy350YMmmF3X9pnvR2rfMNXpeQbN3iLnLkiOHDYMBuDy7d88ZGA3b/yIErcXmm8aqSh3e2aOkDxNg==
X-Received: by 2002:a81:7bc3:0:b0:54f:8eda:9616 with SMTP id w186-20020a817bc3000000b0054f8eda9616mr2936985ywc.26.1681322226991;
        Wed, 12 Apr 2023 10:57:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o10-20020a81ef0a000000b0054605c23114sm4285889ywm.66.2023.04.12.10.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:57:06 -0700 (PDT)
Date:   Wed, 12 Apr 2023 13:56:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v2 1/8] midx: fix segfault with no packs and invalid
 preferred pack
Message-ID: <ZDbw6v8r89zciE3q@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
 <5ecad306b42441fa7d4f50bdfb9c09ccce22b6c9.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ecad306b42441fa7d4f50bdfb9c09ccce22b6c9.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 12:22:31PM +0200, Patrick Steinhardt wrote:
> Fix this bug by exiting early in case we have determined that the MIDX
> wouldn't have any packfiles to index. While the request itself does not
> make much sense anyway, it is still preferable to exit gracefully than
> to abort.

Interesting. This reminded me quite a bit of eb57277ba3 (midx: prevent
writing a .bitmap without any objects, 2022-02-09) which tackled a
similar problem of trying to write a MIDX bitmap without any objects.

We may want to consider moving that conditional further up, since this
makes the conditional added in eb57277ba3 dead code AFAICT. Here's a
patch on top of this one that I think would do the trick.

It has the added benefit of sticking a:

    warning: unknown preferred pack: 'does-not-exist'

in the output before dying, which might be nice (though I doubt anybody
will ever see it ;-)). The main difference is that we unset the bitmap
related bits from `flags`, which avoids us trying to compute a preferred
pack in the first place.

For it to work, though, we need to make sure that ctx.preferred_pack_idx
is set to -1, and not zero-initialized, since we'll segfault otherwise
when trying to read into an empty array.

--- 8< ---
diff --git a/midx.c b/midx.c
index 22ea7ffb75..dc4821eab8 100644
--- a/midx.c
+++ b/midx.c
@@ -1263,6 +1263,7 @@ static int write_midx_internal(const char *object_dir,
 	ctx.nr = 0;
 	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
 	ctx.info = NULL;
+	ctx.preferred_pack_idx = -1;
 	ALLOC_ARRAY(ctx.info, ctx.alloc);

 	if (ctx.m) {
@@ -1307,10 +1308,10 @@ static int write_midx_internal(const char *object_dir,
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);

-	if (!ctx.nr) {
-		error(_("no pack files to index."));
-		result = 1;
-		goto cleanup;
+	if (!ctx.entries_nr) {
+		if (flags & MIDX_WRITE_BITMAP)
+			warning(_("refusing to write multi-pack .bitmap without any objects"));
+		flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
 	}

 	if ((ctx.m && ctx.nr == ctx.m->num_packs) &&
@@ -1488,12 +1489,6 @@ static int write_midx_internal(const char *object_dir,
 		goto cleanup;
 	}

-	if (!ctx.entries_nr) {
-		if (flags & MIDX_WRITE_BITMAP)
-			warning(_("refusing to write multi-pack .bitmap without any objects"));
-		flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
-	}
-
 	cf = init_chunkfile(f);

 	add_chunk(cf, MIDX_CHUNKID_PACKNAMES, pack_name_concat_len,
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index be7f3c1e1f..8a17361272 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -188,10 +188,9 @@ test_expect_success 'write with no objects and preferred pack' '
 	git init empty &&
 	test_must_fail git -C empty multi-pack-index write \
 		--stdin-packs --preferred-pack=does-not-exist </dev/null 2>err &&
-	cat >expect <<-EOF &&
-	error: no pack files to index.
-	EOF
-	test_cmp expect err
+		cat err &&
+	grep "warning: unknown preferred pack: .does-not-exist." err &&
+	grep "error: no pack files to index." err
 '

 test_expect_success 'write progress off for redirected stderr' '
--- >8 ---

Thanks,
Taylor
