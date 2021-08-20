Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B28C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57118610F9
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbhHTAru (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhHTArq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:47:46 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AAEC061756
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:47:09 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id f7so4659352qvt.8
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2FkReEuvD72o/5xCz9qqXZrMDIh05vWKHIhz3bkc+I=;
        b=nJYnG6Q2ibIH2XOFt5MEH4La9xBa8s/lQV0woP4mI+W8XBpFflFgNYst2VwcxHG0AC
         7vf2tMr5fFKaeDHF4Ycj/+ihlB+dVUiB18CYgeHBiudZzLK3a8ND+JoFeKIAo3R59jAa
         8AgnZwSVLJbBtjJnkAMtnJn7lGyMihPUZzNrPGceG8S002PMblneA3cgFacMvlBQoXZL
         Z/O8ejuQR4Ezmj+eGeHesVOYkdTkFme085MXHkyoQrlRRWg17go/7qQPbl6rRJxf2ePh
         AJaNsGxv1j20+GkjsMMDMT/PzpKJGsKWR7ZNdeXbAzU3ZkQ/SHlsrk1/eTP9P16CNzqS
         bi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2FkReEuvD72o/5xCz9qqXZrMDIh05vWKHIhz3bkc+I=;
        b=eJex5MCnOuaQKPraxtb4FroOVk/e+Gi7ZaygK7DBNxthlN4dRsggbPnGNHklA2BI0G
         UL8zg30UAJKwI/yiESBNQZFsNKmziE15+WqOO3TzS8mDqEgOukiuBjm7Kpg1ltxRHnbf
         NmFPy6JnVnv5/s5v9hCsfY79xTKJBnpWBn43ENuTqA0lGCHtr3oX6haYt8qbQkn3VBxO
         TWXbnYBGsB+PMK+hBK9Mz6HCGIwX2eTHdgDEbULQhSZeIU/2soFK/d8MMUojZFYa+nm3
         k9JjvDd6svb7SOpaU599XiMJIj+hG/PtpQxzV1rOf/GPfhixmTa0zN3EMlN5lLIREEOb
         BFUA==
X-Gm-Message-State: AOAM532+kdrY+oPVW7X8LOCACMearfMlbOFYYeCWn4+Lt+4+WfhwSzY1
        gYM+rnVlpoX4jTKMiCbBUGtwh7hNPFE=
X-Google-Smtp-Source: ABdhPJzkfC6JLbkNPgPye0vfJ+30jbjWJcPC3XrgewcejTSCSNSUxupc0uLRnUj4uZcMrj6rr+UqzQ==
X-Received: by 2002:ad4:584d:: with SMTP id de13mr17762330qvb.51.1629420428938;
        Thu, 19 Aug 2021 17:47:08 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id o12sm2095724qtt.94.2021.08.19.17.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:47:08 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     git@vger.kernel.org
Cc:     Thiago Perrotta <tbperrotta@gmail.com>
Subject: [PATCH v2 3/3] send-email docs: mention format-patch options
Date:   Thu, 19 Aug 2021 20:46:04 -0400
Message-Id: <20210820004604.9948-4-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210820004604.9948-1-tbperrotta@gmail.com>
References: <20210820004604.9948-1-tbperrotta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently git-send-email(1) does not make it explicit that format-patch
options are accepted.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 Documentation/git-send-email.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab4ba..05dd8ded44 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -42,6 +42,8 @@ and the "Subject:" of the message as the second line.
 OPTIONS
 -------
 
+Options from linkgit:git-format-patch[1] are also accepted.
+
 Composing
 ~~~~~~~~~
 
-- 
2.33.0

