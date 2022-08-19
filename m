Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C67C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352550AbiHSVaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352544AbiHSVaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:30:16 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5775E104B3A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:15 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b9so4187943qka.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tuvUAhGRN5xXKXxLp64O3OCnHzZvI5R33q/Tv4ZPE2c=;
        b=vb7MzyRsXrxNcF9tIaSCExnmj6WysKDgOO348zGlDhMyLYFqL61xgI1J1yLjMXth5w
         CJ+Mh9lw4Ez08+RcOpPusrlqcluP5FPveaMSYqo1/ey/qkp61H/12MsWeVSkXvVm19Uk
         /NnGxDL7m4B1sg59BeF07ugBXQRroRGmavHUOsdRMzkO62DtZjRRuYXwqRKcvcn0J0T0
         OUzfCTlnK6or5usmtd34Kch0y06bPQrlvPNatpUITV7a6hxL//s/v7wesFMxUOAORQ12
         kWlE6+MHd7FKVyzke1bOfQwe7NcP6eDA9jB6xTRcuVyGZ3EwymKiLBF2CTSJ8Lj+n/a5
         JYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tuvUAhGRN5xXKXxLp64O3OCnHzZvI5R33q/Tv4ZPE2c=;
        b=A8o/8s053Bh2HrE5giyM1aRGW/GlyMabfADBE78PzoTCatehUh+70e9Ja8qeyfb94w
         D2jG7R9b3eOxHixiOyQuCJheAIsXkp8EB9vlsVOSsa0uZagNwlbhlfHzMvQFgM1wfPM7
         ZcZncF/Fiu42+Wqs1ute56fXIazIGOb5k9naFhkURfNyWuakGvtaCk7bVLJ7Sebr1yWJ
         +bog8buyK2AWl4bvlroGRo7qOM/n09+AjKmQEUtxy2mdFYVqWtOJ9RBE0lOqY8PE/Dl0
         tenaMyTpS+O8h8zH7+/yoTz0dlV4IS+JXzq5Zz3s+mcJpANK9vD2nJks0sQz+bqNSTnF
         e/UQ==
X-Gm-Message-State: ACgBeo3nqtLzkS492GbVCAFksQBYd1rAP3iiAd2v7r2Ba+e1YVOyeFfZ
        IoQ/pFAsdqRlhATuycTAPoffnOvafMS/pQWm
X-Google-Smtp-Source: AA6agR7kKCdT9IgQdvYabugRSka8T0NfVZSahPlO4t+cRUlihxG+cfBRkg0wIS+Fezm6lRVDHRRDWQ==
X-Received: by 2002:a37:27c2:0:b0:6ba:ed29:9f3b with SMTP id n185-20020a3727c2000000b006baed299f3bmr6522395qkn.635.1660944614401;
        Fri, 19 Aug 2022 14:30:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bi24-20020a05620a319800b006b9d4f45c83sm4426350qkb.97.2022.08.19.14.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:30:14 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:30:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH 2/6] t/lib-bitmap.sh: avoid silencing stderr
Message-ID: <053045db1459812a1baec8771ff22dcac6f9ad47.1660944574.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1660944574.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The midx_bitmap_partial_tests() function is responsible for setting up a
state where some (but not all) packs in the repository are covered by a
MIDX (and bitmap).

This function has redirected the `git multi-pack-index write --bitmap`'s
stderr to a file "err" since its introduction back in c51f5a6437 (t5326:
test multi-pack bitmap behavior, 2021-08-31).

This was likely a stray change left over from a slightly different
version of this test, since the file "err" is never read after being
written. This leads to confusingly-missing output, especially when the
contents of stderr are important.

Resolve this confusion by avoiding silencing stderr in this case.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-bitmap.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index a95537e759..f595937094 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -440,7 +440,7 @@ midx_bitmap_partial_tests () {
 		test_commit packed &&
 		git repack &&
 		test_commit loose &&
-		git multi-pack-index write --bitmap 2>err &&
+		git multi-pack-index write --bitmap &&
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
 	'
-- 
2.37.0.1.g1379af2e9d

