Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A553DC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888F2604AC
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhKEOLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbhKEOK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 10:10:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA6C061205
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 07:08:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i5so13970810wrb.2
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/ajsvLRN/yRVKwwMu8NtlOfTsePNbBuQmiec8zLV60=;
        b=Uk6OnAW7O/QGHd3HwWsbLrDgr18t80/iOimo52oDf1xMc3VXJiho94X2yRnowoP54p
         AKhVEvNgtHCkviqUCjWS0B84PqMPHFSASmLhTJ0AuaNyEFSimcMj1HFy8BkP0KlXLEry
         rofrd84y6guya81eGriVKVCnKlB0RqcarMpwGkufgUuDpF5Ii+eICrgiucx/XDJQ1tua
         87iq00SLRI1IbT4aJ3Mg5hn7mVoQePswce5Vh9XlzzmgRsn1B3CShYGxO1lrj5ImUg36
         py9+fxB9trnB1xdvZsjJFQjPC/AAJJyFTZHykQAxsROx+dQkF1DB2xg52BNtmyyCG+oT
         sjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/ajsvLRN/yRVKwwMu8NtlOfTsePNbBuQmiec8zLV60=;
        b=kF007JZe8bDN5imbEEGa1JO15SXBsUTnv3j+tPoaB/O+WHhUS0RuurASypMSSOZNay
         a9Qw5kpr+kHIJ66eBXnTJt+WhPNHmDlq5ln5s4uxoiBBfno0RmwkXqWnNK9HdMpnV3EJ
         7znG8lW6E0/yjhBt48+wTKIjW1Q5X+wKCAv5mGgC6c+Z1fx1Q2srbIx7sUYBGGCWPEOx
         qNiHvjJ26o3l2NCzlY7AtAhOfXu811tlpQHsig13KKOrEaIcHY3mnL45O4rV8YXoOD8w
         njpOfxEiVx2sQ5EE1EaZRKuGLByZ7IIa+U9t04Gmi/13ONPDq+3xYGMiruhIDySIfcgH
         BOEQ==
X-Gm-Message-State: AOAM530JVSAYu/trAjcDGNVm9G47gDC2A7/qYk3FB7XRpNH6b5dc6MXU
        Un6SfajdQlcDQgwTDElAE+ztR06hXy7Hkw==
X-Google-Smtp-Source: ABdhPJzvHfNYPCD6ZA4btaZYPEselzXIehIWlviedtSOLPqrf39H9jKDlFknc71BPkzKdQxQ4HB8Pg==
X-Received: by 2002:adf:8b41:: with SMTP id v1mr75805546wra.255.1636121295408;
        Fri, 05 Nov 2021 07:08:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7821556wrs.19.2021.11.05.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:08:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/10] generate-cmdlist.sh: replace for loop by printf's auto-repeat feature
Date:   Fri,  5 Nov 2021 15:08:04 +0100
Message-Id: <patch-v3-06.10-646363db11f-20211105T135058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

This is just a small code reduction. There is a small probability that
the new code breaks when the category list is empty. But that would be
noticed during the compile step.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index e517c33710a..a1ab2b1f077 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -67,10 +67,7 @@ print_command_list () {
 	while read cmd rest
 	do
 		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
-		for cat in $(echo "$rest" | get_category_line)
-		do
-			printf " | CAT_$cat"
-		done
+		printf " | CAT_%s" $(echo "$rest" | get_category_line)
 		echo " },"
 	done
 	echo "};"
-- 
2.34.0.rc1.721.ga0c1db665bc

