Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CA3C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 17:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353028AbiEBRNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 13:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386544AbiEBRNb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 13:13:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AB95FE6
        for <git@vger.kernel.org>; Mon,  2 May 2022 10:10:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7c322f770so140074037b3.20
        for <git@vger.kernel.org>; Mon, 02 May 2022 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0Qd7+3fsF3+7ZN+LU+unprZr4AWRLqqP/7TZGEeVq78=;
        b=YDjFGM1iFZ2Kuup9myfFjPFs5TQ5RRF0QXyEXx067Q5Xh8vrTle9pbSZA2avSjpbZ3
         fFdqiNmwPSQImIZRV8DNaSw5KNlzo4zW/WbwgAjzueY5KjU8M2CHqhsQBHJMmMQtvWER
         2ArrNG2Ys6jk1Uwbt8dZM+Bv4GpXnJ+OrbMdjYOiZ70RdZx+P3nEEuxzbPdDcM/ZAO0k
         IWJVK+xA0f9cm9RAGhkxU/JtllKhGcdLhYvptFihklbdgXuMMSOz64TmVelsBjuzkHC0
         L7UnRRxwDr9LY97rhbmtrri6xdsdgZYrZSa3IXfOT8xQLEOlBJ2hGjGYFTXbk2aauY3b
         Z0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0Qd7+3fsF3+7ZN+LU+unprZr4AWRLqqP/7TZGEeVq78=;
        b=dobpTZsbcoSIs0qULbjDrDytOd2sM77iGDnw6GbxxUyuH4TrsfoBMyRo4iuFE5OLbs
         crm1asBd35kg2QVpOHZ+X2943wT9xVM26ZwBbudhgjFZc7SBeyf4gjzlns8W8btKAG5l
         34iY90VNJjv4B3fRvcpPPlb1DGAi2PStnzSRtt6/zANuf27yr+RBju5wvAvx3uCDmvtK
         qCd3xnVWpmE58o48IJ0gs4Vg9ZNZhD1zxXHijr9YeYTrX3GwNX/u1OrS9lf8fzomzsiB
         zf1R9ezVtiapEfZTiuZHFZ6DTM0p0qZJVtIMW0Kuz6F0xiG4sGGJsljwxQPquRS0Tfw+
         5adw==
X-Gm-Message-State: AOAM531ehaXwmZxp/Damwqh8fx4wvBDmItnfsJyCK2v1W0h2XrITF2eQ
        Ew6XdWwuQ2xqCIHIBKbm6IrPWOMm9OSHrDzhJhzXm38B4PdzsvzEIrnKIu7gwAbj/DckAdIuRzM
        EH79jdtB4ZeLJQWter2YAPKJ3R+Z0hYFao3F5CPl3nJ4Wpwx1ycu4omg+zgpdcRKAbw==
X-Google-Smtp-Source: ABdhPJxzAEsFJmegEEMiLeQ0VVBsVvUhQ7wJESa2KRFsMOy2uElp4FQE5ThZHQCIR68uNIFJBT2nzEmvKYnEbJU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:78ce:0:b0:2f8:fbad:c446 with SMTP id
 t197-20020a8178ce000000b002f8fbadc446mr682538ywc.498.1651511400904; Mon, 02
 May 2022 10:10:00 -0700 (PDT)
Date:   Mon,  2 May 2022 17:08:59 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220502170904.2770649-4-calvinwan@google.com>
Mime-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com> <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.36.0.rc2.10170.gb555eefa6f
Subject: [PATCH v4 3/8] object-store: add function to free object_info contents
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, calvinwan@google.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce free_object_info_contents.

---
 object-file.c  | 16 ++++++++++++++++
 object-store.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/object-file.c b/object-file.c
index 5ffbf3d4fd..34a6e34adf 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2659,3 +2659,19 @@ int read_loose_object(const char *path,
 		munmap(map, mapsize);
 	return ret;
 }
+
+void free_object_info_contents(struct object_info *object_info)
+{
+	if (!object_info)
+		return;
+	if (object_info->typep)
+		free(object_info->typep);
+	if (object_info->sizep)
+		free(object_info->sizep);
+	if (object_info->disk_sizep)
+		free(object_info->disk_sizep);
+	if (object_info->delta_base_oid)
+		free(object_info->delta_base_oid);
+	if (object_info->type_name)
+		free(object_info->type_name);
+}
\ No newline at end of file
diff --git a/object-store.h b/object-store.h
index bd2322ed8c..840e04b56f 100644
--- a/object-store.h
+++ b/object-store.h
@@ -533,4 +533,7 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(each_packed_object_fn, void *,
 			   enum for_each_object_flags flags);
 
+/* Free pointers inside of object_info, but not object_info itself */
+void free_object_info_contents(struct object_info *object_info);
+
 #endif /* OBJECT_STORE_H */
-- 
2.36.0.rc2.10170.gb555eefa6f

