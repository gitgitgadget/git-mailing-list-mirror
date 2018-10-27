Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6E01F453
	for <e@80x24.org>; Sat, 27 Oct 2018 17:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeJ1CME (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 22:12:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46031 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeJ1CME (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 22:12:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id c24-v6so3149437lfi.12
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mAfV2Nz5oHseiWQnq7IrtXDy2ffEDSwSfXwchHyglKQ=;
        b=CvwWDLdcZM/zewZBYd+NYSE9co/qOc0qN2731u37knRXLs4LYUdJFtTPjhEmGEV1Qc
         IiDDWWmIBWbI0ONWE+5f0tOl/cd5Vmj+oxeAHXg9u4T2ZB9Oi6yhcI31HqUfPqH4utTJ
         q2G0npbwmOw2sy3LmtOqpKjvYQwjA58BR0I6zMaqr2Hr4kwP3XRASq9/6yLA0XBFeveV
         JzgBDPsbYKaWp7yAxTE/dD4bc0rRCSvkF38rDMLKYl9JEpftjQ3eoA2fGFnIhMAIvcuC
         Y/fRZnUXAiQZMiazF0anBfi12zAp/MEP9IsbXAz+JPkZ8cIn0Pmw6AQNurZUhO78G9to
         Qw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAfV2Nz5oHseiWQnq7IrtXDy2ffEDSwSfXwchHyglKQ=;
        b=OK7iI12DwXzEUr8ntI4HKe2tsce6WiACWvMsKNyizipNLPq4JAf6Wlm0ZFjYGpUaPx
         unYx2I+WLyPRKtMEWrGHvObm+dNQK8JuHnPAoOXHHFoZBk3b9mlaTv35Xka40DnzoHFH
         lKgClbnF+VKAKj/ZnAcTUVjY0bpAg+EAbWUCmbEOwYY3GwZAT0TP3QRAMfgqTMYggZaE
         mEg6ddXwJm4OgWNt4P5RB4HBiNTvfr4vWOC9N/+k8oGp8udOqM6fv6xvIL9Jbk8N80eV
         Ojq+hhcNYe2ko+iyzUzMB2nweJT4LmGBxnL9mAcl/WN4YAPsAue4yaqPw+Ggk/+GXiet
         mr4A==
X-Gm-Message-State: AGRZ1gIsqt42phDfrBqRX5y4hyzANjFGCa98jt04x0vjW3FViykRlXiP
        X721huAv7X+6UW07if+B2u0=
X-Google-Smtp-Source: AJdET5ekh4FzqZOCxB9YIdtB/Ma5/dpI6mx//eSNe52+gK2eYzX83+gp3RRDmPC+jrlzslorNXetWQ==
X-Received: by 2002:a19:ae03:: with SMTP id f3mr5075773lfc.86.1540661421485;
        Sat, 27 Oct 2018 10:30:21 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i185-v6sm2333517lfg.89.2018.10.27.10.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:30:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v2 04/10] attr.c: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 19:30:02 +0200
Message-Id: <20181027173008.18852-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027173008.18852-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 attr.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/attr.c b/attr.c
index 60d284796d..eaece6658d 100644
--- a/attr.c
+++ b/attr.c
@@ -41,23 +41,17 @@ const char *git_attr_name(const struct git_attr *attr)
 
 struct attr_hashmap {
 	struct hashmap map;
-#ifndef NO_PTHREADS
 	pthread_mutex_t mutex;
-#endif
 };
 
 static inline void hashmap_lock(struct attr_hashmap *map)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_lock(&map->mutex);
-#endif
 }
 
 static inline void hashmap_unlock(struct attr_hashmap *map)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_unlock(&map->mutex);
-#endif
 }
 
 /*
@@ -498,23 +492,17 @@ static struct check_vector {
 	size_t nr;
 	size_t alloc;
 	struct attr_check **checks;
-#ifndef NO_PTHREADS
 	pthread_mutex_t mutex;
-#endif
 } check_vector;
 
 static inline void vector_lock(void)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_lock(&check_vector.mutex);
-#endif
 }
 
 static inline void vector_unlock(void)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_unlock(&check_vector.mutex);
-#endif
 }
 
 static void check_vector_add(struct attr_check *c)
@@ -1181,8 +1169,6 @@ void git_all_attrs(const struct index_state *istate,
 
 void attr_start(void)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_init(&g_attr_hashmap.mutex, NULL);
 	pthread_mutex_init(&check_vector.mutex, NULL);
-#endif
 }
-- 
2.19.1.647.g708186aaf9

