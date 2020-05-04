Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FFBC4724C
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D079206B8
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4zpa9Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgEDTEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727821AbgEDTD6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:03:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F84C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:03:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so704993wme.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gP2mKurovl5RI1/nfB8JPBDqHhvSxbSjyPMBXIBnAvA=;
        b=f4zpa9Q25hVtNIT/4CunjPmScLCjsVgrdNFNFktyT4HsaSKP1WHj//q5FqOevnfqUH
         FmEjaA5UGWqLj+UdJLLyV0BQrIQswIMkNLPoTWuTummoTuxbSQBTwbHvDuhw2sohfYPM
         xhaHsePzvdBunz7WMPic/3dhlVvEOeZ57T0t2g31nZWXxJYWEGsFU0oddo0n54gwDXtO
         ewIJzn1Cv8zshTU2nj5GaVFv5ID4u29xgatZBK1P83bgAMzn6iNbK9yFyX6Y3U5EsyXh
         d18IdLggUUxScI5BD2KSLHoJ0+f6Lv4B5d3ly6YNo+VBa+M0rKFJIO/iyLwLpfz4C97R
         62Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gP2mKurovl5RI1/nfB8JPBDqHhvSxbSjyPMBXIBnAvA=;
        b=iDhPnkGwH5hyG+1EERWNnPob9e8pw5BJrwitEzKckaouGWSdxwL516HuMtirVCXlED
         pRtXVHvQunE7i/8HSkHHNutU56U1NYL2fQJqtS6eHQuUKI4WVElK7SDKnqZNTV+CRqMc
         sPO0MZgVDctQCHQ73B1+x6wLcCjwP5t6omIMKPtNLEkkLecPhUBaxwWqCsFYNFp3M/NF
         vs+BqSledD2YU12w0vj4BlP0xbdbOuhOF2ZZ46lfZG8LBPyRnFHtXLSRmKYLvkDwfl8x
         srCNkmMkgescZkRSWo5qcK8QwppSqFFv2GHgjsDOeecfEw5+W2qw5Bgukozri/SKKqo6
         Fhew==
X-Gm-Message-State: AGi0PubqQjMsV7e2mW1gHGyLjxzDp8jkjZkcAw+URKlGR8Zg1DmrQqcD
        bdWskqH4yrX2FDEEgxzNxjZyLC9P
X-Google-Smtp-Source: APiQypLtQRuMxVyI31bSxDg69fxRvEaYm5U86Xw+5H16agkqjpy0mwTUiOxcEK1g/Xto8GK/wbE7XQ==
X-Received: by 2002:a05:600c:2a52:: with SMTP id x18mr15655170wme.37.1588619036559;
        Mon, 04 May 2020 12:03:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 88sm2507980wrq.77.2020.05.04.12.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:03:56 -0700 (PDT)
Message-Id: <6d9031372ce23a3ab25e504e4a0294b68844e27a.1588619028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
References: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
        <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 19:03:43 +0000
Subject: [PATCH v11 07/12] reftable: clarify how empty tables should be
 written
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The format allows for some ambiguity, as a lone footer also starts
with a valid file header. However, the current JGit code will barf on
this. This commit codifies this behavior into the standard.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/technical/reftable.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index ee3f36ea851..df5cb5f11b8 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -731,6 +731,13 @@ version)
 
 Once verified, the other fields of the footer can be accessed.
 
+Empty tables
+++++++++++++
+
+A reftable may be empty. In this case, the file starts with a header
+and is immediately followed by a footer.
+
+
 Varint encoding
 ^^^^^^^^^^^^^^^
 
-- 
gitgitgadget

