Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFEBC41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A510D208C7
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8DlhiRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgJFWFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgJFWFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 18:05:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F3BC0613D2
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 15:05:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d3so343855wma.4
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7Vnx6oi5i4zCWbmrw65bCDUY3HsC4utGO4Q4LcSDH20=;
        b=j8DlhiRT6vo+jrcE3zdbqNGgjEUs2zs5fxUBqxFinadV+bSlmgiAN4RTE5iuslAM3F
         CvoprDEQ+ImD9oB9fMadkz7H/epP2klEwAt0pu/zSOJGbB4Kmi1XyqKYSxub/Sc6WzuB
         OViky8Joji9UQlL1YMNf4JE5T96ymx3PSw/kCbVY5E1H3/v5owkU+RWTgpiD8+ashtPx
         3oJw6OyG6LvHUErAe6b8v+2Y47HZVxdTQrFEBfWmymj/6xb42V21tAvsuMGsIIzkm662
         ur7g/Dz4PQJyiaN4AYImJ5Uc9D8qnn480qG6SJQ1OlK6NU5r2BOYX1jsUkf4hsyv/T06
         Vl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7Vnx6oi5i4zCWbmrw65bCDUY3HsC4utGO4Q4LcSDH20=;
        b=cEbr1etTIKq26RXaPyAD7iBcK5NfhxppxylVrwCUWPp0/49XqPOCFQkhV7icHx0/Pj
         Nnw78XfhDuLnhtkPHci7PoYw7ha7HXPV+ve015RlRPj0C+uEsXwRz2fqFpuoYSAR2T61
         VN/JCO6q/LflrcBxN00ilIdXSG9abbYCcy/2D5ISWLp3mgra6slAFsAgtPSpWoEyjprW
         tWWoxb3SiL1bomXiHP75RdJqTYOrAphMqXYVdLIF4es+lz1Yu+YY3n5btQNObyuZYP57
         GF3SFAwSOVEsk1pNUsYZyfyDI/1iTtaWz/fQF/iYvovurjuT+gkAJQoxaprikTYr7sw9
         HsAg==
X-Gm-Message-State: AOAM533aT1eDEQcrpop2xVKkMYMG9moJpEycZHZqutLUQGlbo7njoY24
        nOJM3+XFqXxAMGxxiOuVwbNGHlCcSS0=
X-Google-Smtp-Source: ABdhPJxceWqb7E7UsbhRyv9y74hc1kOIlPHqVb/yRqZpVzJ1Zn0FRD1Ib8SeDjiOPZ7WBiICXc/CxQ==
X-Received: by 2002:a1c:96cf:: with SMTP id y198mr58142wmd.104.1602021915222;
        Tue, 06 Oct 2020 15:05:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm106422wmd.20.2020.10.06.15.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:05:14 -0700 (PDT)
Message-Id: <9cff2a0cf66f037bf10866b7787496c6cf02ad94.1602021913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
        <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 22:05:07 +0000
Subject: [PATCH v2 1/7] subtree: handle multiple parents passed to cache_miss
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>, Ed Maste <emaste@freebsd.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tom Clarkson <tom@tqclarkson.com>

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 868e18b9a1..9867718503 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -238,7 +238,7 @@ cache_miss () {
 }
 
 check_parents () {
-	missed=$(cache_miss "$1")
+	missed=$(cache_miss $1)
 	local indent=$(($2 + 1))
 	for miss in $missed
 	do
-- 
gitgitgadget

