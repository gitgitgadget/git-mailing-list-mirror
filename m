Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C37DC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D38F2075F
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbisoWlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgETRgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgETRgU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:36:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D299EC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so4058257wru.0
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wFgf7jyAxBDwDS6vOJ5d7sPrE/sfbalJdIjfASXHSD8=;
        b=XbisoWlTKYcbudwy0UMQonstVCx7dbiHMGNXbC7Tika5c8AfT7ZyOeRFP0fO5J+VHT
         22DvK91uX3prIKN7t31sKZfnrGVGdyzWPXqfFAGwiNEiZS0bYTF//6ys0ssIBUStmRcG
         VXrQbX+k5Zswwm1AFXs0Hvnxx3n1dqmyDwJtt3Gfd867ypBDTgGzDzRFWjAv22AXmihm
         KrdS8IZxwYAHcGKHmchUGSD7L7UCj7sr5yRCYyJEUCr2AyijxHY/VS65xaSIs1gHIfIV
         wvlu/smlzNS0B28k4qTyiIDoRppSJp590NFaKqf2WSEH6+8sGoI3PooZic3cTm6vROjc
         tzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wFgf7jyAxBDwDS6vOJ5d7sPrE/sfbalJdIjfASXHSD8=;
        b=pN7dMMV7ZdWpouoVXPq7QdpXhFuMd4BDGrI/XKS/vwxtK0r6qb1gXEH3YI0DLM+yQ3
         EuLWODsjx5/2qS6HBm/QkROOwiR753mw9A/uNJIIDE19j99VqcuKyDE9aufQ2HV9ZaIb
         N7c3s/+zM5ZkoTfki/23Jtk1MNrpifWSM4sJ9WoHJDT0V1QhqLAOK7gpKehluLc6gFox
         +qkwnkymu7/7+5h9lS1Y6jenAvaLFO1KumjZi1bPwDcm8y7e+TvMDIy4YeCzhO4k0vcW
         R5GRPR+gYaI6bo1R7x8TBBlkPTQj2U39dEFoo+4RNfQe/5rAEBqVMUMEOOOjnzlkgbtk
         MwSQ==
X-Gm-Message-State: AOAM530zvaKm4NJ7rqOR7WHdoKUCz5dlH0BQcBJbw6ND2TEGI98ZioUA
        TQbQ2kYxB2NtRV8nPeA5N3CrTJIy
X-Google-Smtp-Source: ABdhPJzkzvwPiXboX/fpIy1hzmlm2nCK4MtC3RC4Aea9jC2ZfTh3Z/m9Qfs0k71boq6meSOR//UUIQ==
X-Received: by 2002:adf:fdd0:: with SMTP id i16mr5024755wrs.389.1589996178512;
        Wed, 20 May 2020 10:36:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm3773526wrc.35.2020.05.20.10.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:36:18 -0700 (PDT)
Message-Id: <c645298ef024ac30617e66fa7ab879875aca1d2f.1589996173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.638.git.1589996173.gitgitgadget@gmail.com>
References: <pull.638.git.1589996173.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 May 2020 17:36:11 +0000
Subject: [PATCH 5/6] reftable: clarify how empty tables should be written
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/reftable.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index c5ed127b188..e53823c9bfb 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -733,6 +733,12 @@ version)
 
 Once verified, the other fields of the footer can be accessed.
 
+Empty tables
+++++++++++++
+
+A reftable may be empty. In this case, the file starts with a header
+and is immediately followed by a footer.
+
 Binary search
 ^^^^^^^^^^^^^
 
-- 
gitgitgadget

