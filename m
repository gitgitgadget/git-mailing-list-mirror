Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C1AC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406C320578
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BGo+h5lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHXTRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHXTQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:16:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BDFC061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:16:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u128so6539943ybg.17
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=A7Qs+TNEQ5WmONobc2y/iWCU7LgyoYQhC3l1sYuvAUs=;
        b=BGo+h5lxpL1hzSwOVfBiNiLefzrl3knaZ3L6vJrycWd4ubKexudxPXHXX9Yh7doE62
         1V1VCgfHBk8YZsDRO3YEoJMhdkgyArakwFdU3tPTR+N87cq0R4SKojuM0YyhVHSkuLlg
         OTm9QSiK0wPIy5oKJ6DADiWbyi3vvONuUV8yK8ywJE4y7J0vJdR6yNooQ/QC040QFviY
         Kfd3tI1NZM4sPfFfjzXkslGQod0ZsjNaXH4f3mM+9eaDNMwY711QP4lDKY52Hwzx/TaX
         vAXehWjNOy9T6Kt40JQeZ8tG5f8EyQbXK2qK/QHja1VHTM/bSCBOYpAZRIcKfFrQcpWw
         hgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A7Qs+TNEQ5WmONobc2y/iWCU7LgyoYQhC3l1sYuvAUs=;
        b=ND/48xi9ti1Q66rgOP4y8RjF8sSCWfRcDXH5dHagQcqp3G9llz5ZQRJ+GrvK9cLD16
         JuvT598VvuIVVRblFYKcUhJNw3LddBJFpLgkMNThosealpG3DcSDC7z7aHdBV7W/NH5U
         tWJLY0L9ojL4DkoqIPzB6VKhA0o6fJIWKpzdKKzasFB8abII8LjxPY/sjuwHc8th8UxF
         mdz3nRhjEjeA4SGe9eVF3OoHdOfEEOyjeB36C2Ac2n4ZB0U09GUPg4NCeDiaLvY8HOgG
         2+KS4khS/scjr5fsBKtqrk3NbD00QKlWV2HPR8EO50DuFWysXmx73vRmYJcL+GFtfGY0
         D5fw==
X-Gm-Message-State: AOAM533x23fiApQTPWVVO5LCUakN7lneniWaVJrUEThvBd5j6kkb2C+5
        zevq47muKabogrFC+KOH2ammIPz3EojasMFRUfYkvaQlVZQ4+udERgEC4NW3onR3FZNgqc5RhVe
        rsCEcoqWIeNH0MZg9Xxi2nkmX15NTx4q8ZY+zkxeE1BU+Fc3ifsy+yxHcGO21hsRNBzTLG0hgLz
        ks
X-Google-Smtp-Source: ABdhPJyh/tfC4qH6YyVNyyfXTnkXFc2AgLq+cmLM1i6OFps7TFgApGAL0sR44N78DacYsu8b5+NlEkGC3lIb8K1xl/mV
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:2cb:: with SMTP id
 h11mr9142010ybp.116.1598296616088; Mon, 24 Aug 2020 12:16:56 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:16:31 -0700
In-Reply-To: <cover.1598296530.git.jonathantanmy@google.com>
Message-Id: <2a1caac85a6fe4812aea246e6e467c0d25dcbb1c.1598296530.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 1/7] Documentation: deltaBaseCacheLimit is per-thread
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify that core.deltaBaseCacheLimit is per-thread, as can be seen from
the fact that cache usage (base_cache_used in struct thread_local in
builtin/index-pack.c) is tracked individually for each thread and
compared against delta_base_cache_limit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config/core.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 74619a9c03..02002cf109 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -399,7 +399,7 @@ the largest projects.  You probably do not need to adjust this value.
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
 core.deltaBaseCacheLimit::
-	Maximum number of bytes to reserve for caching base objects
+	Maximum number of bytes per thread to reserve for caching base objects
 	that may be referenced by multiple deltified objects.  By storing the
 	entire decompressed base objects in a cache Git is able
 	to avoid unpacking and decompressing frequently used base
-- 
2.28.0.297.g1956fa8f8d-goog

