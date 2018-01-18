Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C2E1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbeAROvT (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:51:19 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32828 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756643AbeAROvR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:51:17 -0500
Received: by mail-lf0-f66.google.com with SMTP id t139so12224499lff.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=D4v8UqRkbOmIcn44aOw+BsbRyepgIgnUpibqrqKxo3E=;
        b=vM9i++ZHrmTxU4B10xdAjOBZXQonI70dK5UrHit6aBtactlcQRsuQ8xxCpcJDvL/yF
         3R5SVKBjgfDlEmdn0VAjlkeEupRp0YkSE62J7o1O4SueQDxXKbIW7txZYMwrh2+c06n/
         07FTQ3EQx/cfcUlXQ2/UyrTstU+qWRHKJxnDxchoGS8M1DCTwAgtWDQCIvCUO06wAIWV
         d0tRd+0ioCi5NKCX+epLirXjkm1rtsbpgvuv2YP+TotZrGXqmDMzfSh9j5MD7bewO9Da
         vb1nAzAIuJ7d/OGE0XtgYF7FXf5P28t1Jv5HETKsidPQuvbQlUjcfJxIsSKNZHGbt2bX
         0evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=D4v8UqRkbOmIcn44aOw+BsbRyepgIgnUpibqrqKxo3E=;
        b=o+q9BA8SjFeGMgC0/68Y9uqkCpvIK738OmQgUTZpeAT0YbxcTUq6x21GToFZ5j14d0
         T/xpz/0rYugox3YXaivtncydFXuEfTWt0OXe5j+V7jmkQfM5xLX7CmcXo+p2V+4aSsQ/
         tf0EU196A9wRqEPMFXRacWHZc1VKZrulzlxQHVGUIvCpUQbH0WewpytcD79PEJUAMcOD
         vQEYS9SXs4jbbQsgZ7R7KM1JfIZm1dLPZXMW2zmldtkD85hWS722JIJXU6RaA7mVVh0i
         gXdSNkqYrQtlq/lnkLuQZu7Alra78BK65h7hxdAMvGcp21b1Ft1uWlcpuv3YPWZEHjcp
         Vhzw==
X-Gm-Message-State: AKwxytf3qDwzzh+MeotIceEl33yKksz2VuRu4YGRI8QGQo/CUv2Ybv7h
        iukiWMAlr0Jy9vjNuUVPjuuXLk4ylks=
X-Google-Smtp-Source: ACJfBouVWfojql1m6Tt4nJz1GR7/jkbBHV+tbTBeCdmopZj5OpMXNFpTlLIgvPSTJrxgaydbkXZ7zQ==
X-Received: by 10.46.5.151 with SMTP id 145mr9381123ljf.134.1516287076421;
        Thu, 18 Jan 2018 06:51:16 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id 23sm560988lju.28.2018.01.18.06.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 06:51:15 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH 06/11] cache: clear whole hash buffer with oidclr
Date:   Thu, 18 Jan 2018 15:50:58 +0100
Message-Id: <ed802103a33d698ff1c70608254ff4ac624512e0.1516282880.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As long as GIT_SHA1_RAWSZ is equal to GIT_MAX_RAWSZ there's no problem,
but when new hashing algorithm will be in place this memset will clear
only 20-byte prefix of hash buffer.

Alternatively, hashclr implementation could be adjusted, but this
function is almost removed from codebase already.  Separate
implementation of oidclr prevents potential buffer overrun in case
someone incorrectly used hashclr on object_id in future.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index b953d9f82c..cf98573805 100644
--- a/cache.h
+++ b/cache.h
@@ -1029,7 +1029,7 @@ static inline void hashclr(unsigned char *hash)
 
 static inline void oidclr(struct object_id *oid)
 {
-	hashclr(oid->hash);
+	memset(oid->hash, 0, GIT_MAX_RAWSZ);
 }
 
 
-- 
2.14.3

