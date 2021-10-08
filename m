Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFFCC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13AE60F9C
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243496AbhJHVsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243493AbhJHVse (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:48:34 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12279C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:46:38 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id w14so10924610qkf.5
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xVfZXQMqdImuWVGIm4CQDMC4jct+iN9Q30KHfcq4pxU=;
        b=wTKvPg/QSmQ8GBNnUtSz11hgdfXzIcTfyxdNRIUts4+X6VyLmq6cIBR7sslEc1fBuE
         aYoPKO04HQ2VlTHjbqGDobczopNxz6OU9sh5vlNgq4/Nq3s+3nNjbOMdkGf6ZxBtgW5z
         JOfNhkXn6pIIkE9ptbuPhwPAPawXCsH+Py+zN6qFVrZ/WjKREkF9NqtG6aqrSwU4iecs
         tQhFFG75R8c2mLww7TFJWAZsAgDymjmxqDQJcMbT+vQ7UbZpjbm4gn2TMCTN2wvxdHDX
         bTnhCL0CY/eHd7eE6MbJ1MTSKPORG0zm2WKv0kqUqN2/3duly9J2yx986XkYQkKJroak
         i7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVfZXQMqdImuWVGIm4CQDMC4jct+iN9Q30KHfcq4pxU=;
        b=cFch4UO1/cTnbwaQJdh9jVDEyfGOHLWJyNslmLJ9vrIzDVPDnYX18NzRE1nVH8LsIV
         5SOOlQxamvISjwtIvgv6XmnQlrPRSqx3U9zTcVUH1duSgoEtw/cXDftZWGurvI35EScN
         FwU/8Gp13ULmVMIlAhGmvpHUD1zdQseXKWyiuo3txMvNs1QA5bkN5Q2hKrSEBjq45PsL
         z1+zDLDhHL5G9Zm0TBCaTAEMBXwZ0BBhCuqVXH2/rw7xtjPPfwP0dggGuomYzh4O5cLB
         jw8auANKq25N2b6aBH+HWxr1Q9Y3qN5k8I5cXrMQ02onQ09ZXJtRAeLJ1VVXP/8huKNR
         0D+A==
X-Gm-Message-State: AOAM533l+iYVtrhIP5tB5WwM2BzvrRKBO4dYx7dG6yfsfEPwXlhgBIec
        6neLWGRvhld1IL3lTBZJo7MjB/4PmNRnVw==
X-Google-Smtp-Source: ABdhPJwNVI1UB2x1Fv1pOX0imNl2+wnaqCweYXgd0QintEozIYrAoOvSEeAWDhfOHYOh5iJj3Hhczw==
X-Received: by 2002:a37:86c7:: with SMTP id i190mr5216559qkd.384.1633729597168;
        Fri, 08 Oct 2021 14:46:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k19sm515736qko.115.2021.10.08.14.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:46:36 -0700 (PDT)
Date:   Fri, 8 Oct 2021 17:46:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, dstolee@microsoft.com,
        jeffhost@microsoft.com, peff@peff.net
Subject: [PATCH 3/4] midx.c: lookup MIDX by object directory during repack
Message-ID: <0accab9139e095c10bf6f299b77bab048e2b4c77.1633729502.git.me@ttaylorr.com>
References: <cover.1633729502.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1633729502.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply similar treatment as in the last commit to the MIDX `repack`
operation.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index 7f1addf4b6..137af3fc67 100644
--- a/midx.c
+++ b/midx.c
@@ -1872,7 +1872,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *cmd_in;
 	struct strbuf base_name = STRBUF_INIT;
-	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
 
 	/*
 	 * When updating the default for these configuration
@@ -1944,11 +1944,8 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	}
 
 	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
-	m = NULL;
 
 cleanup:
-	if (m)
-		close_midx(m);
 	free(include_pack);
 	return result;
 }
-- 
2.33.0.96.g73915697e6

