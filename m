Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EDAC83F15
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 22:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjH1WtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjH1WtO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 18:49:14 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9A311A
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:49:12 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso3388008276.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693262951; x=1693867751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOikyeoGucEsamf00Blvl897MMF/3uizJb60cZn2xCU=;
        b=kzf85jdSjj79TBZkCfGpEP+l838eapC21xt37wX78VTGSosgX/Z3euo+Uv4mtoeKGO
         TSN6P9KrlQoHxXgDr3ELl+CsfZRkfbXDliqzbK2c7/LsbQNnSk3zFCfZYgib8jgJMDpj
         ZfFU2q4yQgfZuwYV5o707bZaz9+Pioq2Twa+PFNSw1GOFbMC/GS2cTvwJZjektTe3otT
         Rfup3aIfUcSQ087MHTwVgleNm5mJOp+gzOI3EwplLo6YP+rz8vw310o/v280NPQ3qZY9
         baqJt4Ca+7Cuf7qocbPAgHfdwciDzsq0E77ENIsC9ZPkJFo/nrAd/6JKwhjPOas2CA29
         uisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693262951; x=1693867751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOikyeoGucEsamf00Blvl897MMF/3uizJb60cZn2xCU=;
        b=L6QTwwrqqdGJD/j8YxMLH4G+GVz0TkXFZeTXxlPZOLjWHt36ovaQd/bTZtaPP2UOnA
         fFI0t0LKxOU/H7z2vyawZVUwkw8TFMf0UKZn3knPWgX9fqm/n+SXiCeFlIGVOFQGMrwj
         WKW9VoiP5jo3Gq0Cfm+L+Mphi/zsy5IW0B4HBjMupjcL90KPTmhxf/se75XvU3Z/4nS6
         MTysPTmZi+mxMPHKARcE6gygwq150nrES00j6Umqs6xbkbMdxoOtZD2E5H0tYfTQFoQk
         AZiUAjCw7imvEyyQSTaaI2y5xVGLjJUnOJQJX8admSagoaD8nsIifWreH5nipi3wY2N7
         8dgA==
X-Gm-Message-State: AOJu0Yzs94Yw2IjKvJSoEAsVbVfZzoJHPn8Wm525xvI+gsvumb2gNUfX
        0hjGzosgM3LLnNwIF3DyP2fC7bzWK3mg7ZXfFjkDng==
X-Google-Smtp-Source: AGHT+IFbKYuigfxT4zQ6526EvPnOIXFP2Aj9Eh9JSd/Vul6hFEagCPD6ocEDlkSnKj0Zdh3cS1VO7w==
X-Received: by 2002:a5b:b4a:0:b0:d71:6b6e:1071 with SMTP id b10-20020a5b0b4a000000b00d716b6e1071mr25583339ybr.32.1693262951085;
        Mon, 28 Aug 2023 15:49:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v124-20020a252f82000000b00d7465a90f0csm1908662ybv.22.2023.08.28.15.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:49:10 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:49:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 3/4] Documentation/gitformat-pack.txt: remove multi-cruft
 packs alternative
Message-ID: <c6ae0716c631ac4a3b5654c50d768d5ea920fa6d.1693262936.git.me@ttaylorr.com>
References: <cover.1693262936.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693262936.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This text, originally from 3d89a8c118 (Documentation/technical: add
cruft-packs.txt, 2022-05-20) lists multiple cruft packs as a potential
alternative to the design of cruft packs.

We have always supported multiple cruft packs (i.e. we use the most
recent mtime for a given object among all cruft packs which contain it,
etc.), but haven't encouraged its use.

We still aren't encouraging users to go out and generate multiple cruft
packs, but let's take a step in that direction by dropping language that
suggests we aren't capable of working with multiple cruft packs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-pack.txt | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index 0c1be2dbe8..49bb09d7df 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -618,21 +618,13 @@ understand cruft packs.
 
 Notable alternatives to this design include:
 
-  - The location of the per-object mtime data, and
-  - Storing unreachable objects in multiple cruft packs.
+  - The location of the per-object mtime data.
 
 On the location of mtime data, a new auxiliary file tied to the pack was chosen
 to avoid complicating the `.idx` format. If the `.idx` format were ever to gain
 support for optional chunks of data, it may make sense to consolidate the
 `.mtimes` format into the `.idx` itself.
 
-Storing unreachable objects among multiple cruft packs (e.g., creating a new
-cruft pack during each repacking operation including only unreachable objects
-which aren't already stored in an earlier cruft pack) is significantly more
-complicated to construct, and so aren't pursued here. The obvious drawback to
-the current implementation is that the entire cruft pack must be re-written from
-scratch.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.42.0.49.g03c54e21ee

