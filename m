Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE68E20248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfDPJgw (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:36:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34768 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfDPJgw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:36:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so10071412pgq.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBcE/htEt0yLODu/QQPxJGdb4Ph6/ILKdkvdhPKDqkg=;
        b=QzDa9IW3UfS5fRAjMmQJo/6Gi61WD7no2W14XbSSGM74vKS0/d0VuFizCxJagn1DdK
         8CyqsfJc8tVJQcVskk7zHTJr/b768htbw/AG31nbmdThpj3jwxO2biklbO3QXdPz5d28
         W+HLujYJYJuk1Mird/TceyJPoHM1/+cvHRkYQ/ozU1HBY1PLV8AZU6v9YZ/Qnquj5QbM
         /HJ7Q1i7asq6FFsc2QWJJm9r82Iv8jyzhdq8fu+JppXV77cVWRx2iB4owxJS0pH2MGqy
         QzluLYTrf8cKbMa7oMLVhurMCsXZEesb3St5KbQ1sQ4jIcU+QmSGGbReTV+ec7TKAnV7
         qD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBcE/htEt0yLODu/QQPxJGdb4Ph6/ILKdkvdhPKDqkg=;
        b=JxFt05qJB74Q+DhzEY+MUaoaUpEAOsZnVahrNSuPOXn6h9ZnF2oOuJ1npA5rTNS6aM
         uNjDsk4s5jV5fG9oJ7oAhfXsfKkDAj0uHGaE7T5cLRVOFHMcdYIex9HL9LK3JjJ+roqM
         OrKZVQ2awv8n0pw+SxQWcgTacbrd22N2noabCBAck7+fp5EoBPj24LFm1qlNLzwujfE3
         WEiil32gWEZfM6N4GD+Dk5OGNQemKDVgMSy+VItyOvwsU+KrYIaYZqUxs9G7DrFa0TIH
         Pus4Xf5keZpbuuxo2PPTMc7oBPeVCbHnYInLoU4cZQoeQ3iRDQ8Tw2gj1cwv8+LOvCIN
         YITA==
X-Gm-Message-State: APjAAAXZnHP7zt9xnuKMgQ0qz10AK1J36pgYPKkSno/mZidM4+RYL24w
        g/225XA+A1FtFiRZa1LRTWI=
X-Google-Smtp-Source: APXvYqxOQPET8d+oRX0NMslu45eoRHoE6fHVx1Xrb3XvQZhlvazgb379hfiocrMwWWRcQjvocJtr3g==
X-Received: by 2002:a63:7843:: with SMTP id t64mr57021404pgc.130.1555407411678;
        Tue, 16 Apr 2019 02:36:51 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id t13sm63644279pgo.14.2019.04.16.02.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:36:51 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:36:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 23/34] sha1-name.c: remove the_repo from get_describe_name()
Date:   Tue, 16 Apr 2019 16:33:30 +0700
Message-Id: <20190416093341.17079-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index fb80306f1a..1cda854f02 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1097,7 +1097,9 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	return 0;
 }
 
-static int get_describe_name(const char *name, int len, struct object_id *oid)
+static int get_describe_name(struct repository *r,
+			     const char *name, int len,
+			     struct object_id *oid)
 {
 	const char *cp;
 	unsigned flags = GET_OID_QUIETLY | GET_OID_COMMIT;
@@ -1111,7 +1113,7 @@ static int get_describe_name(const char *name, int len, struct object_id *oid)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_oid(the_repository,
+				return get_short_oid(r,
 						     cp, len, oid, flags);
 			}
 		}
@@ -1162,7 +1164,7 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 		return FOUND;
 
 	/* It could be describe output that is "SOMETHING-gXXXX" */
-	ret = get_describe_name(name, len, oid);
+	ret = get_describe_name(the_repository, name, len, oid);
 	if (!ret)
 		return FOUND;
 
-- 
2.21.0.682.g30d2204636

