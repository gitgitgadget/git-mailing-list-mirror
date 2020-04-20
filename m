Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8A0C55183
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587D920782
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeO4soPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgDTVPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727928AbgDTVPG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 17:15:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1B1C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:15:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j1so8569521wrt.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gP2mKurovl5RI1/nfB8JPBDqHhvSxbSjyPMBXIBnAvA=;
        b=SeO4soPDQymsyvuLxfgIU2DKsiCC3WZdUjDVhpDFyeehHu1RbCn5SpRbx+6bgdf8c9
         7oHSxFbyd7nC1AXFBkVOGC/35LumM38XGcRaNdm9Q1ffwDyBxPTwCMGVdeVpp9HS6R/S
         gVPoQ+uzsLQ9OBj3jwtIYjW0xMmiem3hBRTOfDpqvgUdYjJLxdjrtlWsWlC/PsBpd4ci
         pXZSf4SjvluvmyUYqXO+60lTr/wBOyajIHcvRqMk7cBq4Z/yw5rYAt6whwUeI/105COu
         F3vNwXkH31mrPt7PeCjkPE3DEeAP1dM4EsYZqPWxCSkXxMmp04hB3rH0GG+JRujczaeX
         IkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gP2mKurovl5RI1/nfB8JPBDqHhvSxbSjyPMBXIBnAvA=;
        b=fTc5Uu25sQ83lasczl7qck77Ld5yjoFNADgpnc1sLLU5QsAA+TwKXt8rBTYHY1pfIG
         J6ZvHau/UytJ7RBYGY7QSuzXJFX3WfEOGpCntvhVWiJkvzDZsLLGyhbngpUeO10chslh
         cpHr9s4M4YQ20VfZ1opVQl7J8ftbIulg5098e6DMzfsN0MINR7pi9jCGHShK4Hb62nkm
         oNIc5sNTHFz5IKGr7cekiM5jsxuWi3Sv5a74XazOlXZ1FNX+lCmFpGeO8aBXiejM5vX+
         Tkn380jS+rMyDcxzuwujEVkNOziF6+2QVLOP5swetXlq71TWaYWaHEYraappOUZsOAh6
         fBEQ==
X-Gm-Message-State: AGi0PuaLx90qfFJCKW7pDmZDP4t1kWt6zszRq+ZoMMufDbI+YwWKCsKq
        8DJ818y8Djcty6LJ9Y+nvmpwIkHK
X-Google-Smtp-Source: APiQypK4oNCPzKZTCaOWTucmegef8ZR5o9XrWoHZrSdujFQkHkB2KLMmTe79osi3nPJrxUSqBNRoWQ==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr20304169wrm.404.1587417303643;
        Mon, 20 Apr 2020 14:15:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm892823wro.21.2020.04.20.14.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:15:03 -0700 (PDT)
Message-Id: <6f62be4067b9403808c5cc1baabaabfc9d6d22df.1587417295.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 21:14:53 +0000
Subject: [PATCH v9 08/10] reftable: clarify how empty tables should be written
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

