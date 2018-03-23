Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D855B1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeCWRpt (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:45:49 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43384 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCWRpo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:44 -0400
Received: by mail-lf0-f66.google.com with SMTP id v207-v6so19490841lfa.10
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRRVg+uQVg33+QudhqUlxMnjkyFNfMHW46updpmsoQ4=;
        b=Wy8GcceHSL9sX0Y0yodZh4XScfT9XAGB4VhNbi/W6vmI9YhEmtJa0HgQhUJH8IFLRS
         72K36KU+BQC2PHIaHleLnJXrPLOLeV0aoUM0HLWM5Es46Lm8h/IZpz/ZECd/dB1aPbUG
         Pulp4e4IZ07HvT+/SgmH+DnQGkHmPtO8L4tg/WK7q6kbgmPfmDfYwDd8P25Rlj6IzXTz
         cFHysLP69lTeaLvMVNPgfXilctuWY8GrqcSVlyYrqD+4qVJZjEKXxis7VRXg4JidEJBD
         nZvzjyPZR2GMK4R31NbpRseh+9Z4I/ZOOgFByI19U2CrqAlz7vUlsvgk3z/joBbPaScC
         m1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRRVg+uQVg33+QudhqUlxMnjkyFNfMHW46updpmsoQ4=;
        b=IMYJAUJpnaU2oo6CThjo/z55u67eudJ/uF0hRnknSQT+xUnaYuEKvAX2IUVbNfY882
         qNPUwmtDBWjy14f8N+2y2qPH7CmIi4nkK5tA/75b9HsKkgkcgjrgZ7RO8ZclExUEdCvD
         QEo0ytztNHGCzXqAjPXOBP7NyLF0JSVgYY402naPzc4GUNBPbOI6vQBSMfv31NigrQGE
         eElnh8jnP2Z7IsTtQW7X3b+yKSuadENvUSXoYbEfq1C32vlA6sV1Wupf9wHRR46jgN0B
         Whnr8tsTs+gAkKYU/fMRjFLxR/sG1dkxRF1XIy80+e1t68ww/NK2g+0hKnNf7jL8OlKy
         fjWw==
X-Gm-Message-State: AElRT7HkZR9ZT+yQR6axTUKzQhvFRVkWwKelx36PsMPmAU7RlSV/MTF1
        owj0XrPXWEqQR48OdljBi3Y=
X-Google-Smtp-Source: AG47ELvYyiPhe2ZMin9xZiww/awecmzEuiCGUVRVFHv8exZGEEjyZMsYGQiz7cip+x6ZfZhWd0P78w==
X-Received: by 10.46.154.9 with SMTP id o9mr15873156lji.98.1521827143474;
        Fri, 23 Mar 2018 10:45:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 02/12] packfile: allow rearrange_packed_git to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:45:17 +0100
Message-Id: <20180323174527.30337-3-pclouds@gmail.com>
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
 packfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 8c335bdcd1..bff22a8c81 100644
--- a/packfile.c
+++ b/packfile.c
@@ -866,10 +866,10 @@ static int sort_pack(const void *a_, const void *b_)
 	return -1;
 }
 
-static void rearrange_packed_git(void)
+static void rearrange_packed_git(struct repository *r)
 {
-	the_repository->objects->packed_git = llist_mergesort(
-		the_repository->objects->packed_git, get_next_packed_git,
+	r->objects->packed_git = llist_mergesort(
+		r->objects->packed_git, get_next_packed_git,
 		set_next_packed_git, sort_pack);
 }
 
@@ -893,7 +893,7 @@ void prepare_packed_git(void)
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
-	rearrange_packed_git();
+	rearrange_packed_git(the_repository);
 	prepare_packed_git_mru(the_repository);
 	the_repository->objects->packed_git_initialized = 1;
 }
-- 
2.17.0.rc0.348.gd5a49e0b6f

