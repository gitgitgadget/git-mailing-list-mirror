Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA57F207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbdECKTw (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:19:52 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34520 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753434AbdECKTs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:19:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id d1so622152pfe.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+W03EP6xPvkJwteQJktMjTUtBILk+1q83AQzD3ZzdV8=;
        b=N5fFdy0vXBXhPBqQZEoLKUMf3EvfV11SoU50d8UbyHOkCGaghSfLHsKyYYmBk3hJCr
         QkpUwIG/wtT6Fx+kg6hTpNxQpBj6ZZ++3w4hAm+hEjobJQrMtvBPfsFD8sjv+Lv/MQtn
         SoaNXoh14aBvSk1lsjLUZ6rssUiJmecvJ7R/0QgecvJrPC3TTBm4IFgNLsKYxNrG+91g
         Npm46lJe0HXvV3aS1Ammqt7DtjI4m1pEIVZ1Czr6vMk4J7Gkp7H87OIX+EyLPBwf6/ah
         Jh2IDDGSw+QgCR6Ul3qSYGiymKFf5PYulVKGJJMQg5wBTjKQB6dQiSRGzmyCr4ukq0Md
         qJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+W03EP6xPvkJwteQJktMjTUtBILk+1q83AQzD3ZzdV8=;
        b=Rw2UjF6el7QXNTP++Ic+p4xJey5w0fgw+jB+1SRff7Ox3C/f/Vy5AM/6NwHrEb3sFM
         5528UUnEzrh0c2lymcc7AHdtxFpu7KvktsBY6ykxEDWrPtQklujwf9eCOOTclceIl+lN
         rKabSKsuj6/K2nO58wnR2chp0ZsxLRq+0mpFcJXjDeMXPgAIHfinEmLVNpZCYsaSe4lT
         Na5STVwagRe0awRTt9tNZGLRKknzsrgGku++UHvxYZndhuFDPF/SH05Xuk0BM43x2xAi
         Xub6iZG17w+gY3H3k3jeoVdB830tMlg+UvoBvhq18bSzTLJcXmiutqc4USFGklGRy1fx
         SLZg==
X-Gm-Message-State: AN3rC/56Ymw0rG3dxWOR23R1opm9m3F1MjHcZhORIqeIm9Pef3dRAySi
        eCjf4cddYVSopw==
X-Received: by 10.98.204.155 with SMTP id j27mr3991013pfk.213.1493806787735;
        Wed, 03 May 2017 03:19:47 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id s7sm32120779pgs.52.2017.05.03.03.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:19:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:19:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 19/21] xdiff-interface.c: report errno on failure to stat() or fopen()
Date:   Wed,  3 May 2017 17:17:04 +0700
Message-Id: <20170503101706.9223-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 xdiff-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 060038c2d6..d3f78ca2a7 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -164,9 +164,9 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	size_t sz;
 
 	if (stat(filename, &st))
-		return error("Could not stat %s", filename);
+		return error_errno("Could not stat %s", filename);
 	if ((f = fopen(filename, "rb")) == NULL)
-		return error("Could not open %s", filename);
+		return error_errno("Could not open %s", filename);
 	sz = xsize_t(st.st_size);
 	ptr->ptr = xmalloc(sz ? sz : 1);
 	if (sz && fread(ptr->ptr, sz, 1, f) != 1) {
-- 
2.11.0.157.gd943d85

