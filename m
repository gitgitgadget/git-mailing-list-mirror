Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D928920401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbdFOVHR (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:07:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36301 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdFOVHP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:07:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id d17so1752752wme.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JIxqvNfGQ7sT/cF6JSb2PnhCRsx4n6sQVOs3gyXwa24=;
        b=vG1z5YFx8mLRO3P5q+4lW2Vbdoc1EJlE2nRbf261WgaSsJmlXaBcUy2qNaVt59fzur
         GaUq990E6lRTKw/uajquKi5sHMJziraKu8li4RMR39Yy1vLDh/wF8gO8+1E3TEp8kLDf
         SDV0XX+gxz03wvRBUypM62j1UhvLg6BZvSgbs6cqjT+14h4XF9H+hfuG12ga7Q218xeV
         RlQSLR63kr5Fi42yZasS6fZgOV895RFDqOKpW0cUsCGuISO5T9VIlfU54K3i4ZMzVtTg
         xKKd7+xRiKRLsLNwnN0/2JT7yTpe7gRdL1EzAyH2wSHuhz701WAMlKDv2cfl7Do0tajb
         rkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JIxqvNfGQ7sT/cF6JSb2PnhCRsx4n6sQVOs3gyXwa24=;
        b=PgYD47qnL49/vVeNDg9iE2V0kSo5jafS+5eUUrDyV+tg7b/MJjb34QHfiuWFzFYAnW
         qURcAY+fSP0EtLtbgK2PwZgVXLyDwGMkF0WLBgYrBBiVvZcR9RD4NgA6IdCTO7StdG90
         A2Fmjkta17aeswE2hLYUgVlRbl4eLJAR9cW6wuSJ2xaWJdjdtlTOLw/y9dvl2V5GEq+T
         XhnxeIFudWYNdbEbzFn3wv1RYJKN4c0F/sCwtmGYv+5r7EeWCGD6c0dpePTewsxmpISh
         s43f0/F+J2AijUBxR/SLdQPtA+nksHOKHCzx2h/XputH8UDUE7xB0ebURp+5R0i65NP2
         okzA==
X-Gm-Message-State: AKS2vOx2b9TCaI4OXNeX5mdrS/3u9W4XpgcKtQsjwe+EwJtyNYFvOcwN
        2YAE4hNxVKKY72XD4Lk=
X-Received: by 10.80.146.154 with SMTP id k26mr5037131eda.23.1497560833442;
        Thu, 15 Jun 2017 14:07:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o1sm267230edc.22.2017.06.15.14.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 14:07:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/2] git-compat-util: add a FREE_AND_NULL() wrapper around free(ptr); ptr = NULL
Date:   Thu, 15 Jun 2017 21:06:59 +0000
Message-Id: <20170615210700.16310-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <20170615210700.16310-1-avarab@gmail.com>
References: <20170615210700.16310-1-avarab@gmail.com>
In-Reply-To: <CACBZZX7S9A=mPSgqtmVyZbLdR3GVH+ux3tGN1QXBMEzbg8Ffog@mail.gmail.com>
References: <CACBZZX7S9A=mPSgqtmVyZbLdR3GVH+ux3tGN1QXBMEzbg8Ffog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a FREE_AND_NULL() wrapper marco for the common pattern of freeing
a pointer and assigning NULL to it right afterwards.

The implementation is similar to the (currently unused) XDL_PTRFREE
macro in xdiff/xmacros.h added in commit 3443546f6e ("Use a *real*
built-in diff generator", 2006-03-24). The only difference is that
free() is called unconditionally, see [1].

See [2] for a suggested alternative which does this via a function
instead of a macro. As covered in replies to that message, while it's
a viable approach, it would introduce caveats which this approach
doesn't have, so that potential change is left to a future follow-up
change.

This merely allows us to translate exactly what we're doing now to a
less verbose & idiomatic form using a macro, while guaranteeing that
we don't introduce any functional changes.

1. <alpine.DEB.2.20.1608301948310.129229@virtualbox>
   (http://public-inbox.org/git/alpine.DEB.2.20.1608301948310.129229@virtualbox/)

2. <20170610032143.GA7880@starla>
   (https://public-inbox.org/git/20170610032143.GA7880@starla/)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 51ba4e6b3b..047172d173 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -808,6 +808,12 @@ extern char *xgetcwd(void);
 extern FILE *fopen_for_writing(const char *path);
 extern FILE *fopen_or_warn(const char *path, const char *mode);
 
+/*
+ * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
+ * that ptr is used twice, so don't pass e.g. ptr++.
+ */
+#define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
+
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
 
-- 
2.13.1.508.gb3defc5cc

