Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6061BC38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiJZO5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbiJZO4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:56:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70276FF8E2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so1719807wmr.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf6O//4dVRpGaDvAxuSK9y56rQ/6FNWtjqvSoedG12s=;
        b=VsRijWAqDiKh2OU1PJpq++wcsWJolesgxw5GfWn3Pxq4VM6nl7A6LSHsovrnq3XCgH
         0vPqW+phivQ2Gq15xYZaTBcexprOPG4/GYfICkTH7DOjJOlAv+oPjBs9Fbe/Owl+CUIC
         Gyxne3G5SS7HD0MluBJx/UWYmDq+IS/47f0rfhejtmamEJA/4Nl8QqmW5nsE7jnWL/P7
         q7mkIalQW9I3KB0bmF/YzprifGS3Trw+5bwcNEZQgo+Qj8elH0RnXkCp80uR+auud3ke
         IeW4yLA81cccOQyB0NrSNHiQiap+dUi+TOgoTIm05DGvhAiTTVWer8ua1qOcNgghmxqX
         iVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf6O//4dVRpGaDvAxuSK9y56rQ/6FNWtjqvSoedG12s=;
        b=pxt4jxZd5aOBgjI8OFEHL5VD6d4wsX2KVxtd8H34Y4m2EjgyNngjt70KqgzY6Za/Va
         b4cuRcKM+v7nnw/LPHcZ0vLR6wRJeEPncKY6YlDJV4e7ODaazryAk+xTpQd0vwHFCGb1
         KmRWua4Zt8RiABWsc0ZkPSEzzKUeRgjCjxU7QCJFK660KWlLJaXOrZuRNh3qmqjhMedJ
         ar8ODZ5sWe+cVdRht4DkAmYCNfWpH75tdtYyirmWdG68wuA7RPpClrYKFToHRHEsywuC
         OBLUCBHOXwrQaTwhfl0D+nuYKZeNU/hnVJSAk0ctyaEVClmyUeHPClbb5xdRuZR6H8q+
         HFCw==
X-Gm-Message-State: ACrzQf3G3ywIdK1xmdatoIFlb4r/6H2AvwNt4fPn7ApWqI3ww9nS6wqL
        1iFgf/m5NAeW8soWtGVFksk3Nzj2tP2alw==
X-Google-Smtp-Source: AMsMyM7/BL5eMVs70RFzMa+IPtUsM6+uiQdTOM4NGRtE+azQt+cxDkxJiYNB0oDRjcfzj0w5NhjZRA==
X-Received: by 2002:a05:600c:3594:b0:3ca:f978:5b97 with SMTP id p20-20020a05600c359400b003caf9785b97mr2885537wmq.64.1666796212665;
        Wed, 26 Oct 2022 07:56:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003c7084d072csm2180351wmb.28.2022.10.26.07.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:56:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/9] INSTALL: remove discussion of SHA-1 backends
Date:   Wed, 26 Oct 2022 16:56:40 +0200
Message-Id: <patch-v4-2.9-abbe25f56b3-20221026T145255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The claim that OpenSSL is the default SHA-1 backend hasn't been true
since e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17),
but more importantly tweaking the SHA-1 backend isn't something that's
common enough to warrant discussing in the INSTALL document, so let's
remove this paragraph.

This discussion was originally added in c538d2d34ab (Add some
installation notes in INSTALL, 2005-06-17) when tweaking the default
backend was more common. The current wording was added in
5beb577db8c (INSTALL: Describe dependency knobs from Makefile,
2009-09-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/INSTALL b/INSTALL
index 89b15d71df5..33447883974 100644
--- a/INSTALL
+++ b/INSTALL
@@ -133,10 +133,6 @@ Issues of note:
 	  you are using libcurl older than 7.34.0.  Otherwise you can use
 	  NO_OPENSSL without losing git-imap-send.
 
-	  By default, git uses OpenSSL for SHA1 but it will use its own
-	  library (inspired by Mozilla's) with either NO_OPENSSL or
-	  BLK_SHA1.
-
 	- "libcurl" library is used for fetching and pushing
 	  repositories over http:// or https://, as well as by
 	  git-imap-send if the curl version is >= 7.34.0. If you do
-- 
2.38.0.1251.g3eefdfb5e7a

