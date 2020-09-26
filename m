Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F35C4741F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AE8207F7
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4rzYIjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgIZVEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIZVE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:04:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24CFC0613D3
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:04:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id s13so2619241wmh.4
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E7AU6LzE5sRKYRdlP9kwd6566qad3+YMkXCuziurIBA=;
        b=W4rzYIjVa402p9CAEsA3zY+x73Dc5FKD3r9C3xd4+Pub6xnhrjulNXM70puN2XQ7NT
         HEqxEfLFatUlv8QLqeiBVko3/xm8fCqfJxx98H/37zipnfidA7K54MnHQuSCKWq/LG68
         K2vNywkK385SUcRsOW6nsAU8/HZI3L1/XJbMSXzmfr9VubeAInl6WHAQ3iCq0D7i5qr8
         JPBE15cJ179rCIt6C9vWH3knQ83KuquwPvYCeKgvOjF69V3R95Cz1zZffG0zaFeSxFSz
         rjgwLbZBfQAivR7xynj2iKHlJ41BxTaUwPcsT5nw/wK6hzYNU72S2Tn8ejAs4vuMgOxY
         SVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E7AU6LzE5sRKYRdlP9kwd6566qad3+YMkXCuziurIBA=;
        b=XfbBcUZlpa77UPtKtJyamLsl9VyPig0fzACq8nz3B+YHTiSo632R94IsrU6heyIsT/
         X+XG3MM+OyTfwyXO64bFe8KnIduMPCVFItSuAgdSlh4bzPHIx2KAHCbPB+AKeYpgHXOV
         hlH7wZ1IEjAx3v1TXo3KKRbVAN6eaTpS0M4ilAjjLbRxzHzk/65slDQDk0OEagtuWPav
         eYLZhwgzBKd7iLojy+wgqcjTd4O10d5wbgswTM3rJYgG9BkYXeckA0nITnmQI5Vc2DKI
         GzH+LXKCtOTk7CH2L/jpa3tiOX4nvudhCNMFkE4DEZC6KK4rg2cRX79xNI/4cmrNAsTW
         jK5Q==
X-Gm-Message-State: AOAM533LqtI/mI3JiAP9CIEXl5ggszGTfl9a6LVarj4ErIhOamlN0zWw
        Jshry5dTLw1z1lLucKc7hj1OwZOKMnc=
X-Google-Smtp-Source: ABdhPJyBqArDh3gypPbSBgg9J/thZnUtNBiIqesXJFz75Ej/iMcfBKOiXxsVuaxdYCCs3VN6R5KmyA==
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr4169874wmj.66.1601154267107;
        Sat, 26 Sep 2020 14:04:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13sm7825222wrr.74.2020.09.26.14.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:04:26 -0700 (PDT)
Message-Id: <a80297f5df1b3ae55716fba6faa6fc30c33f5a11.1601154262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.v3.git.1601154262.gitgitgadget@gmail.com>
References: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
        <pull.734.v3.git.1601154262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:04:22 +0000
Subject: [PATCH v3 5/5] t9902: avoid using the branch name `master`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The completion tests used that name unnecessarily, and it is a
non-inclusive term, so let's avoid using it here.

Since three of the touched test cases make use of the fact that two of
the branch names (`master` and `maint`) start with the same letter (or
even with the same two letters), we choose to replace the use of
`master` by a name that also has that property: `main`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9902-completion.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8425b9a531..7b7bc6e4bd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -542,37 +542,37 @@ test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 '
 
 read -r -d "" refs <<-\EOF
+main
 maint
-master
 next
 seen
 EOF
 
 test_expect_success '__gitcomp_nl - trailing space' '
 	test_gitcomp_nl "m" "$refs" <<-EOF
+	main Z
 	maint Z
-	master Z
 	EOF
 '
 
 test_expect_success '__gitcomp_nl - prefix' '
 	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
+	--fixup=main Z
 	--fixup=maint Z
-	--fixup=master Z
 	EOF
 '
 
 test_expect_success '__gitcomp_nl - suffix' '
 	test_gitcomp_nl "branch.ma" "$refs" "branch." "ma" "." <<-\EOF
+	branch.main.Z
 	branch.maint.Z
-	branch.master.Z
 	EOF
 '
 
 test_expect_success '__gitcomp_nl - no suffix' '
 	test_gitcomp_nl "ma" "$refs" "" "ma" "" <<-\EOF
+	mainZ
 	maintZ
-	masterZ
 	EOF
 '
 
-- 
gitgitgadget
