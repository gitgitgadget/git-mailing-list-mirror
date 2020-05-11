Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FB8C54E4B
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343DB206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVTDpGbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgEKTqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbgEKTqi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:46:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAB2C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so20767869wma.4
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RNiE8rMONcziRTJ3feBXAjSiPmOYtIxpARaqdrbf1WU=;
        b=IVTDpGbudO/Nv/6NaMKVHVq7Y/U7kyoWK2JfyUHSI2+NUB6lSaFaQRulbxIsCeNRhc
         L8mm1QBnAdfiGw3kHUSeYf4eYFjlOaEso9LO0KTvEnvoN7AC3xX1vNfmeVrjonKuxZrj
         kgs+4mB4MriQHbLwtG6YDXIPHPUIZKfo2jbqKvcjIGhT9JgFARAjCJBoK2FLwXbFGjkT
         m0w3sYqsNrcXRGr2WfqGpnlA6NgcUtaFFB9pyRmRMHgqWNyLUHtscOpUvfsPZhEJLkVM
         84E5AsYpkmRYDzgpQd0yhDfcph3W2xxwQpCWFhunJ+LkfQRfWgyc3V9Rj0DjLujGDOti
         yqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RNiE8rMONcziRTJ3feBXAjSiPmOYtIxpARaqdrbf1WU=;
        b=a6hXAMNzrYEbPGjT4DKpxebiBZeXZCVuySHHR5q/6oZfVvPLXnXSs2IY/PGcHNTwMm
         DMIyj4omJn2GTWMi6iyNiW8RRvH03MWH4ShBoOeUEd0s5xJRgllmBiy9LRZg2QA6yHBV
         AYmRHuI49vq2fGVQY/eJint7UGnEKJVWEyxgKgD81rZe/4ojl+MG8qPt8cUHv005uzlg
         gooNjw/0I7VmkuTKAX1iT6U0K2G26SeRqI6wHpid7q9KK5t70o3tBClKmMBxhu1IirCp
         MHv/a5i2WlAbkDXUf0MYWywhyfj1Sf9YS7NHNZipdM8fiow3KNdIsNGBdLHHVuRnSFI6
         4N5A==
X-Gm-Message-State: AGi0PuacbaQM2PCZRPJY5CTOx7eaw4FG8Rz+8G+USH0vA9SvCMvIjxBh
        gNtV5wfELdQgsB/cpoVKCMQFWsxi
X-Google-Smtp-Source: APiQypIypqUoE7SEgnibio+l8kHpLARTIFtgNbHAlgf2Cd+vZaeR62d5Ys4JKfQ13619CUHr3opBXQ==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr13956938wmi.34.1589226395100;
        Mon, 11 May 2020 12:46:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm26619755wmh.18.2020.05.11.12.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:46:34 -0700 (PDT)
Message-Id: <7aa3f92fca0c33eced848d560272d0b948fd5cf3.1589226388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 19:46:20 +0000
Subject: [PATCH v13 05/13] reftable: clarify how empty tables should be
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
index 8bad9ade256..6223538d64e 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -715,6 +715,13 @@ version)
 
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

