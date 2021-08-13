Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D96C432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBDC9610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhHMIX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbhHMIXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E202C0617AE
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h13so12174215wrp.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QNasbiGAZli473fXu4QgD2u/UTIEGvkgntmX6viQd9U=;
        b=tyCkZOh/WlA3f5X2DB7VazRVlTVZ++gtD7r0rmM9rcsH1iJh2ooj1XO/pAfDDrVyt0
         qr5cAtfwZ0Rd2N9yv2GA8ozzNxlvQuSpUt9IjdYLGQMszWsErbM57YxfEemgs0lax4Ba
         Pm7uEm5g6cINiEcezExiz9yOXTlWhIOWswwg8FiQtvBaKHtVucknhQfu5hsBdyqBQbfo
         rAoNZMLlkcWYaM1BQnFmA0Qm/X5mwpWa1c/9DcAPyRVdE+JY0Bke6GwDVzhCDAXKVJxW
         pOadf3PznGcW73NFLcn1dultwBaynp5Fx8lI4qbBBrqI9NTPHnn84PUjBEb+t6Jy3Y/u
         V+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QNasbiGAZli473fXu4QgD2u/UTIEGvkgntmX6viQd9U=;
        b=VTOKY6vX9G8STrDpYdtl52TfGS0wNLi//I0vG/fM5wB7h6KxGSiiOy234TrgHVdsQZ
         yDbjeBchIBYRQqsNeqeM4e1CgHRyyVfaWZMHzjGqtFwB3wcTQ2EyxDbJD3m/k+tX/2f+
         fLHRQzfuMdhqWIzF8ttUqxmmtz7trHEk+tLJHmqLEEBVM4XcyDQZ7P2Vag62zcK2oWz5
         yicrqWT2s+MZUgDcuLV+o3ONeTCtsAN68lDuEd4UVlVdan5RbJu4KmZQrSenULWE/zIC
         QB4VDPrVWfc1+daYldp33hV7jwoDipmmF3pL/Tx/ftIHyc+vUcogEdPpHxYIODRY8Zws
         Xo0Q==
X-Gm-Message-State: AOAM530SmBhesbCzKGF/1GFlEoYifBkNbtC3gSsetQHdGzxCjcCVH3/T
        kciKMAHX+TxtZxcW5P3j1tquVOGLBXI=
X-Google-Smtp-Source: ABdhPJydTdux6OtQ6J01xfn0qU55dROW/0I5pAhWQ6Ah195MI2HzaBIw2wmKfJWaMqr3uMm7paKlIQ==
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr1618637wrq.355.1628842998170;
        Fri, 13 Aug 2021 01:23:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm680986wmi.22.2021.08.13.01.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:17 -0700 (PDT)
Message-Id: <39d930361dbd87d1ddd2608e3346c10861653658.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:22:53 +0000
Subject: [PATCH 10/27] [GSOC] cat-file: add has_object_file() check
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
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
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

