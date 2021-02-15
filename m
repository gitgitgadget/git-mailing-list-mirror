Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9E6C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F1561494
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhBOPwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhBOPsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:48:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F2C061A28
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:08 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id n8so9431180wrm.10
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bJ9p47VAvCuHwObZqI+X793m+ItFOMlSpQXIHQEi28=;
        b=QbYpKoI2SoGVUQnSiSh+fFpTPbdZv+BmQ5QZx3Ie0IQ6QKJ+FsQbAkOpvVbW22jPMX
         WmanJjhR3YOYRK26BugbTQSzTdl2ZC4XBYhyWGJRUWNzY+Zbw9UIUJ+URBo/RBSU9J8G
         cA0KnTBa1Y+vho1+saH1tIVJmJylbdYSk2fsNcscmJtFaYCfezmQksoLUqX/6KnHmxsF
         u/GdAS8eTL+Q4ccb+G/OTxnNy6UUsaLf0aQujuz+IdrTWHlpRMvTRoW9BFO82QKKHSht
         H/1UQB4DGThhjBWEGNrrBHu9+PcFCXgBbtP7P/MRZDTURjguo+T/B11yrHAmvMX+RZAN
         TLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bJ9p47VAvCuHwObZqI+X793m+ItFOMlSpQXIHQEi28=;
        b=tSroqo5pTiC747cHAkMXXm0kiTrBran9CenHNRXhUxQrNBtSuoJoLDzrYAg4421Cnv
         eCF4K02IfDJzgjuq24FHpm/1iBlXPFE5c1WvgFMQc3ggJLpPvKJGqRib5B1iCKoFVzU+
         qS3rrfg6sBim9WSkuhN1Iw48AlDlTEYs3WCJd6xrxg7fbVXZDVpucEVR5HULG8g2E229
         OxcPqcIVgNWQLhz6hkqru+5brun5QF5t/YppHHdbzkVmi7VXKIFWjBAln23K/b16H3yB
         ayi/g1SmwwWDUjPsvC+p7KI9GepYS7LpP1//x9S2Cb/U5uce3/nrDhNGv1Ky4UGLsamW
         oLCA==
X-Gm-Message-State: AOAM530QBb/+T4ginODSXK+81jk+8PGhIbUV0bdLXst6W1dOUqGDJmXL
        T9OoOMJCKMFDPCuJMduCUvVfQpFZTz0mFA==
X-Google-Smtp-Source: ABdhPJyePYP2SJcP/gthSQw+Cy6EDfxcrFUHSNyz5/RHvzZ68aXtGRIqggyblJJ0GlOe7MbCGSc7yA==
X-Received: by 2002:adf:dd87:: with SMTP id x7mr19793092wrl.389.1613403907119;
        Mon, 15 Feb 2021 07:45:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:45:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 25/27] userdiff: match "package" in diff=golang
Date:   Mon, 15 Feb 2021 16:44:25 +0100
Message-Id: <20210215154427.32693-26-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the "golang" built-in pattern to match "package" lines, as
they weren't matched before changing e.g. the imports would commonly
result in an empty hunk header, now we'll instead show the package
name.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/golang.sh | 10 ++++++++++
 userdiff.c        |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/t/t4018/golang.sh b/t/t4018/golang.sh
index bf22f58c12..cdf9d6f8aa 100755
--- a/t/t4018/golang.sh
+++ b/t/t4018/golang.sh
@@ -3,6 +3,16 @@
 # See ../t4018-diff-funcname.sh's test_diff_funcname()
 #
 
+test_diff_funcname 'golang: package' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+package main
+EOF_HUNK
+package main
+
+import "fmt"
+// ChangeMe
+EOF_TEST
+
 test_diff_funcname 'golang: complex function' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
 func (t *Test) RIGHT(a Type) (Type, error) {
diff --git a/userdiff.c b/userdiff.c
index 55f4f769bd..f975aac8fe 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -128,6 +128,8 @@ IPATTERN("fountain",
 	 /* -- */
 	 "[^ \t-]+"),
 PATTERNS("golang",
+	 /* Packages */
+	 "^[ \t]*(package[ \t]*(.*))\n"
 	 /* Functions */
 	 "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"
 	 /* Structs and interfaces */
-- 
2.30.0.284.gd98b1dd5eaa7

