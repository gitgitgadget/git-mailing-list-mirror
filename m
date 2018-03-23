Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050391F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeCWRps (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:45:48 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46270 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeCWRpq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id j68-v6so19469399lfg.13
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zXOLquq/4OJ/YALzhqEVe+jHQ6MZSlIKyDhJQoy4vyQ=;
        b=syCs4SzBi1Meohut4z3BFaEXyojMUmrj2p5MOvZziDFMWxUpwaLYGMpArvsEHDnZvk
         S2INBZwevz953qTQ/bO6ptCjKQ56y5PMmb6WhAe6fWRB07fXtzDJWfu0Gh8dcgkSr5/k
         K/g1AKSskEKWHPHn1zWMImm0tMLJjRS0AV9p8yvbFfArh354bAVlDfYD31L8lQEWrUW8
         b8vNyNpbo1YPzKg9VbtYLdd0N91711QTehhhJgz7wL/i50gRpc4f3Ua6Iz3JpszcJCFx
         P8u2O5TE1FP0oq8+tFO868V3Xots4nm/5XihqZg7ySP+QBQD0blSjEeO/eJ4juaTwUmw
         ttcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXOLquq/4OJ/YALzhqEVe+jHQ6MZSlIKyDhJQoy4vyQ=;
        b=UKB9hulWxq0KU36eMS/bxC1847wzBF9nroTdo++gyZPRgVizBSWo5qDjksrUrT6vcH
         JAmTOl8mYZRnr7ZPRPiWncrV7Ps0vo8jK6yJLPdQgyZ+tTsUlcKjtAFb8gzmtoQCIYzF
         ++FQnizyYGJlpFS5Sdzj+NH979fekPrvHjo1NWQ/kLijje/gbjavoUi8L+NDzc/jRMxV
         TMo9J9akngURuBm3Iq4zPIkDuP+KAMY+AkX7IZrvjVkM8fJeMs/zi4boZNde3wehp6BU
         F5s5nFgEB1vNH+L1Q+l9VGoFj34PjUSg3DWJvG4LxeTGdtl6sR/S4okmJjavTh6Z6olx
         XQvw==
X-Gm-Message-State: AElRT7ERHgoqHYqeXux+So4BL4aLcvWEgm4bbPoASMyeIoPQHJGxvuhE
        2tgZyqsH6gxQd53ZTaUUFfROpQ==
X-Google-Smtp-Source: AG47ELv7Z2N18AbBKXhKHoNVfVBT28Px/VOcYW2llWSJl23j87Ir34SvDHz7CLHqiFIQWFWDc1cPsQ==
X-Received: by 10.46.91.21 with SMTP id p21mr17265474ljb.38.1521827144705;
        Fri, 23 Mar 2018 10:45:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 03/12] packfile: allow install_packed_git to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:45:18 +0100
Message-Id: <20180323174527.30337-4-pclouds@gmail.com>
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
is easy to review, as it only has one caller and all lines but the first
two are converted.

We must not convert 'pack_open_fds' to be a repository specific variable,
as it is used to monitor resource usage of the machine that Git executes
on.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fast-import.c | 2 +-
 http.c        | 2 +-
 packfile.c    | 8 ++++----
 packfile.h    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b3492fce5c..ae4ced3ae1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1038,7 +1038,7 @@ static void end_packfile(void)
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] = new_p;
-		install_packed_git(new_p);
+		install_packed_git(the_repository, new_p);
 		free(idx_name);
 
 		/* Print the boundary */
diff --git a/http.c b/http.c
index 4d613d5f6b..111e3c12c8 100644
--- a/http.c
+++ b/http.c
@@ -2134,7 +2134,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		return -1;
 	}
 
-	install_packed_git(p);
+	install_packed_git(the_repository, p);
 	free(tmp_idx);
 	return 0;
 }
diff --git a/packfile.c b/packfile.c
index bff22a8c81..ff302142c7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -680,13 +680,13 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	return p;
 }
 
-void install_packed_git(struct packed_git *pack)
+void install_packed_git(struct repository *r, struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	pack->next = the_repository->objects->packed_git;
-	the_repository->objects->packed_git = pack;
+	pack->next = r->objects->packed_git;
+	r->objects->packed_git = pack;
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
@@ -782,7 +782,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 			     * corresponding .pack file that we can map.
 			     */
 			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(p);
+				install_packed_git(the_repository, p);
 		}
 
 		if (!report_garbage)
diff --git a/packfile.h b/packfile.h
index 5b1ce00f84..77442172f0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -36,7 +36,7 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
-extern void install_packed_git(struct packed_git *pack);
+extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
-- 
2.17.0.rc0.348.gd5a49e0b6f

