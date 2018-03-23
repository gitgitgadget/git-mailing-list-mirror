Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588AF1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeCWRpp (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:45:45 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40959 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeCWRpn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id e5-v6so19498879lfb.7
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGCKlj2PMKIqja6wmx9oujDFRCPViJYUAJxy0QDdGaI=;
        b=a63CuNc7PvA5sUgCo3z0hmztv6MOtBafagLMod5h6LaCwZ61pTWZix35e7QZh5GT4s
         QPjyegw66jRtKeoH8DdJtqnNa5HVJUsRisnVj5K/7g0nnbUzSeDMYYEfX9cX1RcJkKrG
         pLEXTcz7R6f1OLPvSOqncjQbQ7/izP/Sqh724JOlYvCeKuTTug55B8ujXEFZaBF0rbzB
         UHGJGyyJiiRotJ0KXS8sMF93bmQ+JI3t9dEKVP78SS3ncJesq1oblhSFLgFHru2EDr7/
         MrwECMVaMWrIVFyAARGOcffqpHqFR60a+wbBr19YV36XAup7vFepQc1By9XH6r3z+yyA
         U+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGCKlj2PMKIqja6wmx9oujDFRCPViJYUAJxy0QDdGaI=;
        b=DCGEx5Wp9EzzKvQRYlJa1T8TvH/YKuMn7Wzer4ipBIRYsw55Ek3BRnlxiZuJkzBKO6
         UEKWyxarPVPE24SXaLtj64/xxUj9hz4OTXkmA11zvjJoxOgMBWbRo/3ADzyJdLsCl4FI
         NGgEuu9IxIG8KRRUaAs9SgGrLFeVJzTR6Yypqfq8MK45xehTkFwR2N9MC+kbZqdTj+33
         LtWCnePp/rlGfrgFah1vd3YAAypiLSXfZEwJoG/egSUK6izzgHpzYzYoz0mWuaa/dADB
         589XeIyv7PvM3MIhrTKXGPEUEYJZi1nmI08VdM97ShmMY2TgCBAwtJbymZMpZF/8wqYg
         20bg==
X-Gm-Message-State: AElRT7F0oRAc5SKgJCfQXmGkW2q29vGNGhZ8ev3A+r/TPxeCndvwYL5O
        RR86YwkXScDckQgFFnNmLzI=
X-Google-Smtp-Source: AG47ELvuFaxKAWUMLQtrUWJRjGtOCUqxfndyVZ5T9M1tAvh3crH4byQ1WRKIOq3BYTuWd4x5k9Gp8A==
X-Received: by 10.46.128.16 with SMTP id j16mr4906489ljg.26.1521827142155;
        Fri, 23 Mar 2018 10:45:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 01/12] packfile: allow prepare_packed_git_mru to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:45:16 +0100
Message-Id: <20180323174527.30337-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323174527.30337-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323174527.30337-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

This conversion was done without the #define trick used in the earlier
series refactoring to have better repository access, because this function
is easy to review, as all lines are converted and it has only one caller

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 packfile.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 17170fc662..8c335bdcd1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -873,14 +873,14 @@ static void rearrange_packed_git(void)
 		set_next_packed_git, sort_pack);
 }
 
-static void prepare_packed_git_mru(void)
+static void prepare_packed_git_mru(struct repository *r)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&the_repository->objects->packed_git_mru);
+	INIT_LIST_HEAD(&r->objects->packed_git_mru);
 
-	for (p = the_repository->objects->packed_git; p; p = p->next)
-		list_add_tail(&p->mru, &the_repository->objects->packed_git_mru);
+	for (p = r->objects->packed_git; p; p = p->next)
+		list_add_tail(&p->mru, &r->objects->packed_git_mru);
 }
 
 void prepare_packed_git(void)
@@ -894,7 +894,7 @@ void prepare_packed_git(void)
 	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
-	prepare_packed_git_mru();
+	prepare_packed_git_mru(the_repository);
 	the_repository->objects->packed_git_initialized = 1;
 }
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

