Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E18C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 09:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiBYJFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiBYJFN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 04:05:13 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB00A7DABE
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u1so3363804wrg.11
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tUK8o3c8knoHDrlSPKgjqaziIRubwr4mtpdE+NjCyFA=;
        b=G5LD8QBJ0HpRv7/OpIb6ROaIwBMh7f36oF+xdKuetuIygR2zn9wsyOih4etk4M12iU
         yV/5yCQs71/g71O6kCmzwrGclL83+1ht+c4bgxUBEdEWANkm6qOAgW03AEkaq1ALlsEZ
         SyfVunZwB+JHERL48yuQfCPPhECpxobDf5er0Fcst9juyVevh9WLkL2YrjgtQn034PB7
         NOIOF+BLTF6e7NPcgAg6SnewVbx3so/icIJRXJ/WdqKDkQ4GCiVso6TYn4GNG+OaVyKZ
         W/Mxp1X/1x8e4FLf4FsWB5wzLoNXdmu/NIHzdJ5XnXsdUVSIAc848C9oMr1L+8URbcFI
         iIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tUK8o3c8knoHDrlSPKgjqaziIRubwr4mtpdE+NjCyFA=;
        b=sLtEu6eD3RooVNTFDO6Hnt0hsrcyvKvSaMUjN3p5+Np6Mef9bCfdrbGXaRk2+IZBi7
         CEid1JLttVfTTQkgIwZBF91f1n9BsIfUC7wwIIRdjQH3eZc6C0z1/L1IXxRAEo3j2mfh
         V2DjZ5vgy72sXysfF8QgCmMSsxxqTNUWxh7Qg1G9FKdCJLIsgvYkttLHqjj0rmUYgjL/
         pRkNLfLBW8wBlmjJ3cgh+YTb0zPCtetQoLgJwmCRccD+hwF8MkwoDUWziuUGbN368lpt
         Xlxr+Z4HvnWdzYU/LCabwHHH2DeGyfKbCTsSHuB6EA16zV4oosoXoxU4O6vSy48RooAW
         gOZw==
X-Gm-Message-State: AOAM532nCKiFP10Qpzmd0Ndtaq6I9JTFrECf9GpxL7/w6mKzy1zU4SHZ
        mu6kYjAUmFqU2SZwWjDMyz/l8aBZrLCtrg==
X-Google-Smtp-Source: ABdhPJxHQxphtOOSsD37dIw8CsCMzt5t362mO1N+x2n5xOm+rfy9mhNNYan/IJhV3uqXbOaEffWEEg==
X-Received: by 2002:a05:6000:2aa:b0:1e3:d43:f5c with SMTP id l10-20020a05600002aa00b001e30d430f5cmr5130793wry.178.1645779879913;
        Fri, 25 Feb 2022 01:04:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0037e9090fb1esm5636657wms.24.2022.02.25.01.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:04:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/9] scalar Makefile: set the default target after the includes
Date:   Fri, 25 Feb 2022 10:04:27 +0100
Message-Id: <patch-v3-1.9-2404c4d8b96-20220225T090127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1175.gf9e1b23ea35
In-Reply-To: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make have the "contrib/scalar/Makefile" be stylistically consistent
with the top-level "Makefile" in including other makefiles before
setting the default target.

This adjusts code added in 0a43fb22026 (scalar: create a rudimentary
executable, 2021-12-03), it's a style-only change, in a subsequent
commit the "QUIET" boilerplate at the beginning of this file will be
retrieved via an include, and having an "all:" between the two set of
"include"'s after that change would look odd.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/scalar/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index 231b1ee1796..5b12a437426 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -12,12 +12,12 @@ else
 endif
 endif
 
-all:
-
 include ../../config.mak.uname
 -include ../../config.mak.autogen
 -include ../../config.mak
 
+all:
+
 TARGETS = scalar$(X) scalar.o
 GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
 
-- 
2.35.1.1175.gf9e1b23ea35

