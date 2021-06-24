Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F75C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE42F613CE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhFXT0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhFXT0f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46748C061760
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c84so4720140wme.5
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJXPQXau0J9Rss6rqwihiAOlqZBIRK4wpjx6rAeSfhI=;
        b=AAjroJQzL/vGra6SyDUR+FeGhJhn+C1eKxko4V1xiIr+QQKrnU4fVwXUBeVIA6ClV0
         DwHBny0Z/M2sPrfSXLZthntZgsgDqJ8kFavJQ+lmLifAFy7IeT4lNBlK5kOsDxBYTZU8
         cUY7/uXSRn7HzxwZGwe4JmvHd0d1MoAGvhYaizjIizsW7HgZcpNyR4OmeBcNtIQdefJM
         e0db5BTFghmCXgYSgyCVcA2bDSftUcjzfVQMdTPPhEPO2RosvISZ24/b/Sn7X4XojvJm
         3giAg/IG64Y8+Qli+Waz4iCP+LNu4HskSOjRh9kCyJ9UdBvsYlobGkcjB7nuy3OCbkoH
         +WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJXPQXau0J9Rss6rqwihiAOlqZBIRK4wpjx6rAeSfhI=;
        b=XzkeUkrgMKZGEjQ7834nhR3xPLPa8nk89meuZ8K7gONpa4CAZ4DlEpqkHkFEbWtc5+
         AXqDRqdzJz8yy1bHN3G2nUExHSuPxp6yQ5HH7uOPKZ/vAXv3qct2NpAev8zEFsTiVT+l
         HRAGLr/RlAMA6oN2CCDkiJynQn4UKBrSx4d+5N1fy9vrGmnOf/aocrMWPyVTDx+JufHS
         TTpcJZbGbn+/se+pQO4H/diIaakLwFhhNYC4u9meYr4d8RnMaAWNShtHgsHVEO27uJyu
         KWyjBXnw7rK0uS/wpxNQsb91n0g3I3DwXoN7HBzxzThmq2TMn/qBtsDiJoj7mV2Ya+7u
         C/aw==
X-Gm-Message-State: AOAM532B9RM/SZ56SLjREBrOIKP0faL0Kzu6f164N1/2TbTY4IsCb4vR
        IK4oyv/Tu7jEI/UtUbzFad2HCWP1mnyT8g==
X-Google-Smtp-Source: ABdhPJyrbjbb8WnmqKQWGmjYbjxIWpA4Fx4oCJPo8xpdmbL7Wp3nMRUWSM1T1qw8fDMTnYEIHrLi5Q==
X-Received: by 2002:a1c:9d89:: with SMTP id g131mr6249129wme.45.1624562653654;
        Thu, 24 Jun 2021 12:24:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/21] object-file.c: add missing braces to loose_object_info()
Date:   Thu, 24 Jun 2021 21:23:49 +0200
Message-Id: <patch-11.21-74c308adc19-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the formatting in loose_object_info() to conform with our usual
coding style:

    When there are multiple arms to a conditional and some of them
    require braces, enclose even a single line block in braces for
    consistency -- Documentation/CodingGuidelines

This formatting-only change makes a subsequent commit easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index e0ba1842272..646ca7f85d6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1450,17 +1450,20 @@ static int loose_object_info(struct repository *r,
 		if (unpack_loose_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
 			status = error(_("unable to unpack %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
-	if (status < 0)
-		; /* Do nothing */
-	else if (hdrbuf.len) {
+	}
+
+	if (status < 0) {
+		/* Do nothing */
+	} else if (hdrbuf.len) {
 		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
 			status = error(_("unable to parse %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0)
+	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0) {
 		status = error(_("unable to parse %s header"), oid_to_hex(oid));
+	}
 
 	if (status >= 0 && oi->contentp) {
 		*oi->contentp = unpack_loose_rest(&stream, hdr,
@@ -1469,8 +1472,9 @@ static int loose_object_info(struct repository *r,
 			git_inflate_end(&stream);
 			status = -1;
 		}
-	} else
+	} else {
 		git_inflate_end(&stream);
+	}
 
 	munmap(map, mapsize);
 	if (oi->sizep == &size_scratch)
-- 
2.32.0.606.g2e440ee2c94

