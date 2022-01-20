Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25899C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376521AbiATPM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376365AbiATPMW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E306C061401
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so14486545wmq.2
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1RBfs0p86hdynJHyBF5Adh0gBV25zTb1bkuk97sM/+w=;
        b=KfDGQgF5TLEyV8bBChACaSDcdE3ca+PPaBBpM6crL4GOJeQuvNqU/XlZe2/Pqyy1FF
         EcKsjjLSobNNeLk+zJYmSgjBwoEkkHDIJQfpI0brHDDKcUgdpb86FCrGP2zosbB2E92E
         kAF8/ftSDm2HFbkaMB5j5Q7E3z26s66bqW+bVrl7ePInYD/3dgjThSZfEakW9FJUqINN
         pMXqjPoNZoxGzGY3yP/mtF5obY3/A4CZ62rWRgARKwL33taI/DwLSCd7cPcNkC7oLXZp
         p6uEdtuTZqdGfGH/7KkkzF4ljT0Z55ELegW5RsWLSWncUXXHBg/sIWDKTFqyrEpO1TPk
         nfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1RBfs0p86hdynJHyBF5Adh0gBV25zTb1bkuk97sM/+w=;
        b=4uUWIc+vC8Y0hk8EOxWYpPP332uy5PzYzB0qiiC1g9bdJlhvVTZlAGUSKh0jbpJ12k
         XM0pE5Gs51gey/3TO21K2Z4yBuJuJc5v0tDtuYI2S9rQ0Gf82RlYqjWdDkYTP5pWgJ5I
         G0HgzSTgQs8/pr0ubI6k8C/+8vWMdqq0Dg0w0rUDIC5oYjv+0iaSpwSYVXtij++8oMoV
         tNxKPqUb5hXIf88TWH3ooAebvCP2iN++Ozovx0wMP/xznrjTsYqkvDRrBeQxll4vvEKK
         W4svhy+120hEzPNF+u418pVp4XC1BzfYVKzD1mj2cNXqM10uHI6x2DJgMqIrbNlVUahr
         oUNw==
X-Gm-Message-State: AOAM533FIrTwotkWTyJAfEFZKl3m1+EAKEarXYWsg/VH4c4sZyzqI8ul
        SOt71cze6nqGEFobPcBFudBqMV17/CA=
X-Google-Smtp-Source: ABdhPJy10YMADMDQAkaLeFz7XEHGkLuIIjtNpAQjS6RF+WTcjq0ZZDz9eGEgihVk4PtgOoAU03rWNQ==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr9515006wmh.42.1642691539771;
        Thu, 20 Jan 2022 07:12:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm2649773wmq.20.2022.01.20.07.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:19 -0800 (PST)
Message-Id: <08be6d90a4890b63fe9b0885af0df084c9ca81fd.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:04 +0000
Subject: [PATCH v6 05/15] reftable: ignore remove() return value in
 stack_test.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

If the cleanup fails, there is nothing we can do.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index e84f50d27ff..19fe4e20085 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -90,7 +90,7 @@ static void test_read_file(void)
 		EXPECT(0 == strcmp(want[i], names[i]));
 	}
 	free_names(names);
-	remove(fn);
+	(void) remove(fn);
 }
 
 static void test_parse_names(void)
-- 
gitgitgadget

