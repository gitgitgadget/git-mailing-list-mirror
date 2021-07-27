Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E9DC432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BB96023F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhG0VV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhG0VVD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:03 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0639FC0619E5
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:37 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m13so407222iol.7
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F/IBzNhz3we3jN0q4nSUHUFH9YcmmNPKSaDo7UThrOg=;
        b=KBoJqZ5UYrlfWr7Bsd5CTT98tGPMBfWpM1VqcZsvk2QnxE8Uw/yoEex7ga6rna2azr
         /ZAqq6X8/B/8psA8U9sjclLlQmlLz5N2jrGwEx+5RePygvro0xXD3W5ERFamKCB+pLfS
         hkiOd5In+ISZusRaX7017gJqw/Lv5Cco+kzolinIoKRYdgIT7m6I4cQ74nOPkJsrCgsK
         4xB8hIBacLoT8IuyHRiMrspcyBgXIjcmWDqvu+AL5O9jlQHbzdDbdJsKny5YVXWnGR/9
         4KazbvCFTQs0kRT0FiAELA7cwcnk1eCNLV5mPOTR678HDcnRQmZ4indxKw6RXL8LW5pa
         GEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F/IBzNhz3we3jN0q4nSUHUFH9YcmmNPKSaDo7UThrOg=;
        b=mtwns8tdiwe7NvDjikNYUHiy6KpAt8cPgaibfyAHPywHjIicpl4E6axQKNkWMWNztN
         blI043ECfl0M304LRkxMAWSUGsrhH0hBlOlTFj59OI+awxlEZ/0k4WurzKqT3NKJrh7y
         0xyFdvOx16pHg7rfx/3IMLU9wWOLoYNuZpbHgdx548dKW/OD19UpgoF4IfrutW+8tUtE
         RAJs12rur+nGZ1lOyOnCOgAWABX4J69R/HZ34hAsAYdjkspTZiGR7Q5ZdgQHDyLH4lXt
         g4LG1ulSRl9O2+GlkafknrzuazXIk5GBA0qUXUpCX3swja1EoPS4yZVUUFMSwy6EZ0Lt
         LXMA==
X-Gm-Message-State: AOAM5329ojbtqXqJlLZ1tT/nXfCE6SwUtGsw2Mlf2ODJpEkaUCmHsTrl
        OmI5ZdxYYJW3cFIgveCs+jxN6AFKH02kczXr
X-Google-Smtp-Source: ABdhPJxfknnEoySxaBgtht/FkNonDnZVtn4CPRtbTMW+vsNMvAghu8wnvHnWVGRokTv/VKxZFD6feg==
X-Received: by 2002:a05:6638:2107:: with SMTP id n7mr4182983jaj.117.1627420776218;
        Tue, 27 Jul 2021 14:19:36 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id b6sm3138797ioq.43.2021.07.27.14.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:35 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 05/25] midx: clear auxiliary .rev after replacing the MIDX
Message-ID: <49297f57ed60cecdf7516f79f3977d94f962b214.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new multi-pack index, write_midx_internal() attempts to
clean up any auxiliary files (currently just the MIDX's `.rev` file, but
soon to include a `.bitmap`, too) corresponding to the MIDX it's
replacing.

This step should happen after the new MIDX is written into place, since
doing so beforehand means that the old MIDX could be read without its
corresponding .rev file.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 9a35b0255d..3193426d24 100644
--- a/midx.c
+++ b/midx.c
@@ -1086,10 +1086,11 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name, midx_hash, &ctx);
-	clear_midx_files_ext(the_repository, ".rev", midx_hash);
 
 	commit_lock_file(&lk);
 
+	clear_midx_files_ext(the_repository, ".rev", midx_hash);
+
 cleanup:
 	for (i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].p) {
-- 
2.31.1.163.ga65ce7f831

