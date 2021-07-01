Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBE5C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16306141A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhGAQLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhGAQK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:10:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E7AC0613DF
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:08:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so7219513wms.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QNasbiGAZli473fXu4QgD2u/UTIEGvkgntmX6viQd9U=;
        b=azZ3dhloUV7h4a5jG4FcGmhQJRFHVCNBKxhCUoNEkeESgWyFBcTXQd5v3YXT7FZHzB
         KF80tR59irp2K9z6Yre8rfjZr8i+R4+dpWvARZJAnnS00NZ9p9xpdD78pbKtniuhf2cv
         tZs+wBZhdms55yxgjTDm2Ygyhl7WlpDzs40qvXIiipZRBEi9VdWlqEw5D7e8ZnTrhsl6
         qw4IhVWAA0ApN3ejJBIneTVMAuI3Fgg5WEY6VqRYSB2dbd2m9Y5i1VXa9Zi2GO18GKcu
         d4HUma8Z/S8qxGZWxVNGPvpVDLzG2qGvgs5y3wgRqEO6d68JTNADj+Jh8DlNuvo15jkv
         kjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QNasbiGAZli473fXu4QgD2u/UTIEGvkgntmX6viQd9U=;
        b=MB1eY9kwpg/o9E7fhRBa+K/g7VYGZpQQTkl1NtXqLuaFitkWEKPmWVY/724fKsSJbv
         WSH8anne1/d8wsickokxneqEE1isUQuMTGiWNSZ1d23vX7LlaA1CHVrMwC+QTFU3thIw
         AT83Hqn87lMl3HTp589yK8McXWRXlYyc2G2cJZ4+2giEfKAC7lW3SiSz5AQOryZ8WLQ1
         tTveWEyFq3WeUq1RwB2V22bWk1Gfi1tlegLVYf1k5x8cOAwMVPrn4abs0l0A5VPtVpMF
         3LQ3zbUukN8Tit/em2zNJvq/i3q8lp2XVwnxkr5mWQLcfrywWILbgFuRcIxvm02s9z6I
         HOKQ==
X-Gm-Message-State: AOAM532bOUrM6dZ3QGM4UHrASDxqFWdGbx6u0n2jYZGoar0WuhU39qiw
        4AGBAwsU85Vx2Ug5Frs028IzdyNGcr0=
X-Google-Smtp-Source: ABdhPJyTdkPVTHiw8R1B725Iovt3IlzQIXzrGuvxkFimQKDKzgisMcPOaPd3ap+5LEz6utwFzljZIQ==
X-Received: by 2002:a1c:f705:: with SMTP id v5mr11617565wmh.69.1625155700908;
        Thu, 01 Jul 2021 09:08:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm423390wms.6.2021.07.01.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:08:20 -0700 (PDT)
Message-Id: <18f38075b3c70748894ad6b2e1158f2b17460845.1625155693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.989.git.1625155693.gitgitgadget@gmail.com>
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:08:08 +0000
Subject: [PATCH 10/15] [GSOC] cat-file: add has_object_file() check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Use `has_object_file()` in `batch_one_object()` to check
whether the input object exists. This can help us reject
the missing oid when we let `cat-file --batch` use ref-filter
logic later.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 243fe6844bc..59a86412fd0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -428,6 +428,13 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
+	if (!has_object_file(&data->oid)) {
+		printf("%s missing\n",
+		       obj_name ? obj_name : oid_to_hex(&data->oid));
+		fflush(stdout);
+		return;
+	}
+
 	batch_object_write(obj_name, scratch, opt, data);
 }
 
-- 
gitgitgadget

