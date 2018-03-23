Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8D761F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeCWRqC (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:46:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43397 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCWRpv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:51 -0400
Received: by mail-lf0-f66.google.com with SMTP id v207-v6so19491282lfa.10
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YASgPxZdaTVCoUOAWcwyCdfWGQ5zlLlvmnn3ZpaPNmQ=;
        b=Bg23C6AgN7ktEe8eS4h6npRIYyHgoBGb6cF+202My6I9F5kLY1ut82VmyJWTerSGn/
         hzJr2vxnlyMC+Eh09td4Cr64CmsaaCTD1jQGpBrmp5fs9aYmB8xst7i6LF9bnlouuV7l
         0OPFJLjCIfvDae8H9UaHcnt/qMq5C/W4xN+oLkQzxFx0nloePXRNTJ+VLRjSX13rRpJt
         Jj4Qh4IkoiWX57gR4HgekHIORdKnKrqdnk4NAkUAT9BZpKSAbzUl+0UJH7KN54QsCXLL
         YJuEefoVLg72JxhiULT3z3I9nXbnvhW7jq3kj28m3lsun+hM4rS2D+dhHdaKGGGXnCLA
         GhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YASgPxZdaTVCoUOAWcwyCdfWGQ5zlLlvmnn3ZpaPNmQ=;
        b=I54Uj0Dmf+ZWHeXfXqdyRUNGth0g1KE/INBsVrdrZtQfBJzxgl3ttYJDAGYPrVC7E+
         Kur6nFEYWt26snQt9il3inGpsrYIG+SOFfxTLsQt4EvRVouaaotlpp/jpZfIE+VY59pP
         xjGiqLdbh2YaTEA0h5e2RDyzOH4JZJIQtLKyg5YKDMn18YyaLjTlcg+XnP1ynGvw842E
         avR59vMUvaCDOau3zqIANJpUJlHKzoeOkIwrWizjoV4J4KLK5BRe88FjAw/xNXGBlAqI
         2xC5hItjM+xsePVg3dYfPDE8NH1ToWNAnVUzpD8fpNfp+FqgkPKzCYMn/UfNoPvSPxal
         vBmA==
X-Gm-Message-State: AElRT7GbtFZb16q8N/RQQO90M+LQL3tyfp7LDRQo3aOOZXIjkLtgcbB7
        3KbYD9z6epaOWqj70hwT0ys=
X-Google-Smtp-Source: AG47ELtZHjhmxnAMKBSEJ1Dn5E5xeAdMuPXKty4kMJjA0tGQfxMg4+Yeiab1oJTdyNZ4kEksa9fcpA==
X-Received: by 2002:a19:63db:: with SMTP id v88-v6mr15919446lfi.70.1521827150061;
        Fri, 23 Mar 2018 10:45:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 07/12] packfile: allow prepare_packed_git_one to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:45:22 +0100
Message-Id: <20180323174527.30337-8-pclouds@gmail.com>
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
 packfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 1b4296277a..f49902539b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -735,8 +735,7 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-#define prepare_packed_git_one(r, o, l) prepare_packed_git_one_##r(o, l)
-static void prepare_packed_git_one_the_repository(char *objdir, int local)
+static void prepare_packed_git_one(struct repository *r, char *objdir, int local)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -769,7 +768,7 @@ static void prepare_packed_git_one_the_repository(char *objdir, int local)
 		base_len = path.len;
 		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
 			/* Don't reopen a pack we already have. */
-			for (p = the_repository->objects->packed_git; p;
+			for (p = r->objects->packed_git; p;
 			     p = p->next) {
 				size_t len;
 				if (strip_suffix(p->pack_name, ".pack", &len) &&
@@ -783,7 +782,7 @@ static void prepare_packed_git_one_the_repository(char *objdir, int local)
 			     * corresponding .pack file that we can map.
 			     */
 			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(the_repository, p);
+				install_packed_git(r, p);
 		}
 
 		if (!report_garbage)
-- 
2.17.0.rc0.348.gd5a49e0b6f

