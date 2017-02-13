Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89AC41FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 15:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbdBMPVH (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 10:21:07 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35172 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbdBMPVC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 10:21:02 -0500
Received: by mail-ot0-f195.google.com with SMTP id 65so11878884otq.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 07:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sY7lluAxSJ3e7ZRloDLN1RcA5cwvrECW04pllhFoiBM=;
        b=lgrw+9xapzmZqr9P8xhpnP7b8EML4Pey0U0/dHaghLplq1f9EnAoO0vHKTZFTcdnC/
         xPrntNLznlhK1z6OcyZdzDZuxV27houMO4sqLgJz2pZ9v5WARQjNzKBWxPG4FSdGdEMU
         yuNQM3gvSWWUy3emCHAl41nOh14UMdynlbcFY++zpjsJaSSzVZobYHqLG21z/X1rbu8m
         XxnSxICnkZpyeAwh8En9Mj8UmjY2a6oOxzDRYFI0pqaI39imtWB8s/PehC3RSQIjOxbs
         8Z6u5aG8nucs3Y+ofBd29rvLzYgg5inoVfFO+qHTL9ctiUSC/HpbpIFT5re/ynarWDEl
         ErXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sY7lluAxSJ3e7ZRloDLN1RcA5cwvrECW04pllhFoiBM=;
        b=LTegfGpdUJlLaKqJkasA0VUDnR7K6ODEiSeLx8tpRZaUIFdVqukwinPSEOT0UEj4po
         Q055Li4M0VTrJEc4RU9o7HTbwGOtEztcfSaQxqZFIIBgCSWbo2jNlNaCrEoB5LtO2Z65
         nhCD9WRKTmvOVo6clwmEtEUWx/JxD+oeISkiLHUswo/BLnanfAbB6rjEw+W8d5VFLw4D
         IVrcQQfF8dj9ILwlDmb5Btfj5U+JSIYGNc8035oLC3ZknUHXB5FTqGhIugDh/z6tkh12
         rACzckTDR9AnyIxj0FnbDuLFxb+BqHbzzdZBNRpaecu881XUTekpScCQC+lZ9gK7ODrN
         T6wQ==
X-Gm-Message-State: AMke39kvEXmBOisMwqKP5/oYybhheLtFhCTjwib0CrbsDXi+btzPuHMmZ7VIP366kbvbWA==
X-Received: by 10.98.74.84 with SMTP id x81mr26371850pfa.172.1486999247078;
        Mon, 13 Feb 2017 07:20:47 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id r4sm15457910pgr.53.2017.02.13.07.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 07:20:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Feb 2017 22:20:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/11] refs.c: share is_per_worktree_ref() to files-backend.c
Date:   Mon, 13 Feb 2017 22:20:05 +0700
Message-Id: <20170213152011.12050-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170213152011.12050-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 6 ------
 refs/refs-internal.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index f03dcf58b..2cacd934e 100644
--- a/refs.c
+++ b/refs.c
@@ -489,12 +489,6 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
-static int is_per_worktree_ref(const char *refname)
-{
-	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/bisect/");
-}
-
 static int is_pseudoref_syntax(const char *refname)
 {
 	const char *c;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 59e65958a..f4aed49f5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -651,4 +651,10 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 				    int resolve_flags,
 				    unsigned char *sha1, int *flags);
 
+static inline int is_per_worktree_ref(const char *refname)
+{
+	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "refs/bisect/");
+}
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.11.0.157.gd943d85

