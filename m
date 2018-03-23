Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5791F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeCWRqT (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:46:19 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37203 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeCWRpr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:47 -0400
Received: by mail-lf0-f66.google.com with SMTP id m16-v6so15743025lfc.4
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4V/VQvSgnW8cnjWKDhU3bZSAXE8zRsJQrO3DhYjU74=;
        b=ckJSkerlaSZIChMEoXx5/HDezPJUWx1GWP3edeoqnIsuPcygp1JZroNJ8NDCbK6PxI
         iFx4j5W4B7l2ckwlsECryRMIawpsh9GGwc1Tr34g+VS6VtClaFPmg34K5od4y+xf/Am+
         vRzn8DaGKsp+Z1bwz3Xjh2hQjMWM3wSqK7pRlcQRkBQ3ttVFdAtnmVr7fioFMozkWdvQ
         2nyQTCOBG9agYJL5UIjWN2U3F8llCuE4kwmf9J4ZKEeRhkcL0Z33JnRtADE8YouP3cuX
         QndpmvSkEeniA2D9uxY77jngshvlnqEoT6QDE1dDHY4IKrPQWP3aWgr4IgnD3kCvnBB9
         dsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4V/VQvSgnW8cnjWKDhU3bZSAXE8zRsJQrO3DhYjU74=;
        b=aRVfDjCyZGBAxQQBA6HQhsn8ZlrDfh+Iv2+yBztxcvS+8giHpwgnz9yDrowfN3ARVh
         xtwfngcp5YAC3dRr+EtMbQwsfGiS0XJ2Pq/7l989Wbp2S8mX5JbULGQSM8vh7tZUB8Q9
         uJv9r64yFiLgxmOuH4wz1JWtidWBkLBJs5yT+pnEbu1YVEY31KvgxyWghZhIKWnLs1X0
         lTqSorY3hI5IGGzs27kXN3nvTiSwtk71v5Czr0Ibi4BOFj7uUqSaSHWcI58srGpnXSXF
         Sj2GORtWrjHcg4eQ4O1pcCrRL8Q07nSu28Y0FKn37RxWOWUsK+AyhzgBUIYEJjY206vn
         Fqzw==
X-Gm-Message-State: AElRT7FVLg6SOFfVf47jEO6W6GZXMgTUYUOeMWDHiZriPL+Q8VttMYib
        Ma3PaTlIXik9OuqEnEAeDiM=
X-Google-Smtp-Source: AG47ELvqxj1lvmx3v8gJW7FY7ycdkVK10bwup2F1Gwznnu13YeVI495IvW0UEsSYeZqPjTmoucaerw==
X-Received: by 10.46.33.230 with SMTP id h99mr20655539lji.47.1521827145944;
        Fri, 23 Mar 2018 10:45:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 04/12] packfile: add repository argument to prepare_packed_git_one
Date:   Fri, 23 Mar 2018 18:45:19 +0100
Message-Id: <20180323174527.30337-5-pclouds@gmail.com>
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

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 packfile.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index ff302142c7..0e5fa67526 100644
--- a/packfile.c
+++ b/packfile.c
@@ -735,7 +735,8 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-static void prepare_packed_git_one(char *objdir, int local)
+#define prepare_packed_git_one(r, o, l) prepare_packed_git_one_##r(o, l)
+static void prepare_packed_git_one_the_repository(char *objdir, int local)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -889,10 +890,10 @@ void prepare_packed_git(void)
 
 	if (the_repository->objects->packed_git_initialized)
 		return;
-	prepare_packed_git_one(get_object_directory(), 1);
+	prepare_packed_git_one(the_repository, get_object_directory(), 1);
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(alt->path, 0);
+		prepare_packed_git_one(the_repository, alt->path, 0);
 	rearrange_packed_git(the_repository);
 	prepare_packed_git_mru(the_repository);
 	the_repository->objects->packed_git_initialized = 1;
-- 
2.17.0.rc0.348.gd5a49e0b6f

