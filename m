Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA8C20D1B
	for <e@80x24.org>; Thu, 15 Jun 2017 23:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbdFOXQI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:16:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33656 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbdFOXQF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:16:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id f90so2095672wmh.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JIxqvNfGQ7sT/cF6JSb2PnhCRsx4n6sQVOs3gyXwa24=;
        b=pUOSQmtQWTu3qa2q/TuM6qlebK/5Zs6AwnuF3zPau6MDsOamSgQ1Zl8+Z7mCCeHZRD
         8/H0Wjp+67t1DRGEaYUTPq17W9OT3ny5+0MEYeul9aOK+V5ugqff/k86m+C+EQOIx30D
         wQyWFBlG2DP1a4l6COOY/wNFdD+tgTEvfy3g8i/WbSB2iAkz2CzZ8JQcIWASFRMhaDoh
         0E5UhOYaCmA9mYzZN5dc2aJbubpx/+wz1EmOM9+kxYMW9MNfXpiGueYeJjHXcHSGFiGW
         kNQOOLKAqhd5QK6asqorsGxeTv6W8Mx+Y9yGUqv985qR8rMnj4mpq8sZmhW4LtiSnR0l
         /Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JIxqvNfGQ7sT/cF6JSb2PnhCRsx4n6sQVOs3gyXwa24=;
        b=OA0C1tCABcGjimkChcVm/a7UeG8SSvBDkytfK2QE74IhUSyQpHcPq8k+jYtMXYP4e/
         bBNw0+AQTwJCfXluNILXibeuu2ijQEQX5SJUF+TyXJl8yU+NRStr0NedORXTM4I7iQ8E
         iyEGJJj7YV+aYA/marLKSi5NZo96KqoDd99HVIdaB/QDabYgpEpl1b52LSKZXnf8x5P/
         8ARCbEpqNHK108p1HNRPb0B9dqKNcCMyRMYIfTfRc1h/F7lL2unCjGw3gyWT4qu5SNxv
         3tW28rosgCvQviRoTqGtKTq9FAN5Ta/8aQNwpjj65HSc45jY/AkKx6JZoQqTHzeuRw60
         joPA==
X-Gm-Message-State: AKS2vOwjFzNNZlRD8yYsf5aEmWzExPizu4tF78khPhARATPD82uw1e+8
        VOWiWsdIXXEnQcCZLIw=
X-Received: by 10.80.167.65 with SMTP id h59mr5174488edc.0.1497568563580;
        Thu, 15 Jun 2017 16:16:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o15sm305130edo.68.2017.06.15.16.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 16:16:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/6] git-compat-util: add a FREE_AND_NULL() wrapper around free(ptr); ptr = NULL
Date:   Thu, 15 Jun 2017 23:15:44 +0000
Message-Id: <20170615231549.20085-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <20170615231549.20085-1-avarab@gmail.com>
References: <20170615231549.20085-1-avarab@gmail.com>
In-Reply-To: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
References: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
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

