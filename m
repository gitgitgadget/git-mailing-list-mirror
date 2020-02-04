Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B96C3524D
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9342087E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8HAd3qZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBDU1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:27:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55579 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgBDU1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:27:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so20343wmj.5
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 12:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wNGDZz1ZqCpXmCvb0HnNmy909SX9mnqHH2KZdKl4tJY=;
        b=u8HAd3qZbAeN5wPk9jcQ7cQMf6Nq06/mHuLXM71AZbJixES3UwP4jGvCYjuk8wx7ke
         GQFEDYIO6Lhsa4cnRfxoDt83WUKvsUZJFWiFQgKMLecK7XmhXJ17Upy9uhSKBgDP3IAW
         CqiOVKDV9LxHmJW7EyytGV81iLjrEOkXee4/ieo8PWIuWmDFtOXHmtvnLMeAh+hn8+RG
         r2Zqhl37R+x3K7EnCjw/oyDcmCfVP5P2608kMQPapKoZ8BfPZVm1ypwUxmhfZIjaK5a5
         RFLjK+dwk9qTntvaWYGMg9pDfVhGuf/36qPjYqgBM9U6CSj7KQo5ECnj4p/0boePhQOM
         4J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wNGDZz1ZqCpXmCvb0HnNmy909SX9mnqHH2KZdKl4tJY=;
        b=K9B4pG39iA/rpxDp8MBlLslwpVrrVI1Osyl8wVZCaGmuA/rmpu/E007u/DBW7c5yuw
         GilNWD+k0wXoWLYmVTbLKXpWCK5vh9MCpmJ7L70rCoZhxoBsa6e03v77lMBu/9jrnE1A
         2CYZrBJaWy1Ap+ANv1L3rDwN2RHSTPRNX0yjuLmO6f5FN169hJWE1WRVsd5sS2WZgalq
         jHMaHw5ihhH5wkxEMAPhnbxAsBs0sxM49CHEFFJh+ZQrOJ5xcFuJ3Gt4+XnhVhCKBJyt
         UiUUOpwMDfMtP8cipKnEwbeBh1bjkofXIJaPbLuRToV+1ROmvtnHqtD1m0FGLXJXkChc
         IT6Q==
X-Gm-Message-State: APjAAAXr0L6MIYb/vmjPyrKnPPONVMZk92J3HKKzQxf0zJevFxfdrztJ
        U2s232jg9eiOncN1el/CAx6ImQ2k
X-Google-Smtp-Source: APXvYqxSV05lIJSHkNcaD+Sp/eok9e9r/nVWhs1w0+5JWvJVPb7PPzJH/Ytz0z2QTtZVXubx/MjKIA==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr839191wmb.137.1580848064492;
        Tue, 04 Feb 2020 12:27:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p26sm4959097wmc.24.2020.02.04.12.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 12:27:44 -0800 (PST)
Message-Id: <1b01c735a955f09218a4ab94d446dbddd1a1a1e2.1580848060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
References: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
        <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Feb 2020 20:27:38 +0000
Subject: [PATCH v3 4/6] refs: document how ref_iterator_advance_fn should
 handle symrefs
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/refs-internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ff2436c0fb..1d7a485220 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -438,6 +438,11 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 
 /* Virtual function declarations for ref_iterators: */
 
+/*
+ * backend-specific implementation of ref_iterator_advance.
+ * For symrefs, the function should set REF_ISSYMREF, and it should also dereference
+ * the symref to provide the OID referent.
+ */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
-- 
gitgitgadget

