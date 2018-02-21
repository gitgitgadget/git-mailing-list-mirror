Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6C81F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeBUBzH (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:07 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33444 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeBUBzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:05 -0500
Received: by mail-pf0-f195.google.com with SMTP id q13so64644pff.0
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TVbwGpOLT/0Rnw49aQy3sJrkJQTdf9qcuemln3dmNTA=;
        b=NrqOnP8GDf6C3rIKMfukLngN2INhr+o91elcKbLyqyXWM2iouHDUEDP5C4ksuECjxP
         +U3aJd8gkgFLd1V6oXOFyfwO1FzhQnx1Kw46aXMw2MQSrwcBKyhJGvJAedhc93Lfa5SP
         KLzrwc4IW2I1GEesuPZ47JW7BLvGZKXtg/luaCujQVftasZaFcS+RNMv+UaYjsOnCBS0
         zMiv4+9E38u+7VWyZhtlIRMIJraEgA+MSBvnBdrGPmdFHXwCWDWp21aZOTWhJd7vObfa
         SnzAu+8b1EmWIhGXUYajqo6gbFNZPNxY8z66SLlo45LtxNlLgBKyz/l7bAyqr+1kfVjb
         0paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TVbwGpOLT/0Rnw49aQy3sJrkJQTdf9qcuemln3dmNTA=;
        b=b+OeMnVgwznw1SHC2FLZjox7wls6q3CkzZIBgROnmTd8c3H2bQKcqH/5ri2sGtswlJ
         UH8JmxnqNZUrqHkemYA33rqRtgdTYTSVSaB95z9QiV6zal0bou2ZglFL5HXA/jXAU3GS
         8KMOJ3VWT9nIh7VVAdIhKfV+T4ODZYYYatZMtW2nKzCGeYKHPdtOiV7F6bX6YWubvacz
         6lHNpvcxtafoLCmt0Y3xAcW+qMMHh2PDqrKFRlS0CVb//EIRfrzt9wv4mGldcrJuaIhG
         ltsqq6yxZIfSiDGE/8vPuU8CoPLHGuDPDV9IjlCTroi90mloRbQK5Pa9TWdQpIHA0yV2
         ilgA==
X-Gm-Message-State: APf1xPDFl97YEX0j05y6kVYc0+TMdQNl4c/rM3kZeOWBAiyGGH/G4M+3
        RL3BXElVpGHUlVQL0wCF7tzLNk3h+3s=
X-Google-Smtp-Source: AH8x226okOyyQHXIuCcgjZaQN/UOPA2+E1kj1pm2FYs5l6X8LuEUtBfDI4IhRy58TXJ2+TWY0z+Bjg==
X-Received: by 10.98.97.198 with SMTP id v189mr1623323pfb.110.1519178104337;
        Tue, 20 Feb 2018 17:55:04 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id c62sm17193519pfk.127.2018.02.20.17.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: [PATCH 15/27] sha1_file: allow prepare_alt_odb to handle arbitrary repositories
Date:   Tue, 20 Feb 2018 17:54:18 -0800
Message-Id: <20180221015430.96054-16-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h |  3 +--
 sha1_file.c    | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/object-store.h b/object-store.h
index f283fbdba9..873b341774 100644
--- a/object-store.h
+++ b/object-store.h
@@ -24,8 +24,7 @@ struct alternate_object_database {
 	 */
 	char path[FLEX_ARRAY];
 };
-#define prepare_alt_odb(r) prepare_alt_odb_##r()
-void prepare_alt_odb_the_repository(void);
+void prepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index 6e5105a252..9cf3fffbeb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -673,21 +673,22 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb_the_repository(void)
+void prepare_alt_odb(struct repository *r)
 {
-	const char *alt;
-
-	if (the_repository->objects.alt_odb_tail)
+	if (r->objects.alt_odb_tail)
 		return;
 
-	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
+	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
+
+	if (!r->ignore_env) {
+		const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT);
+		if (!alt)
+			alt = "";
 
-	the_repository->objects.alt_odb_tail =
-			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(the_repository, alt,
-			     PATH_SEP, NULL, 0);
+		link_alt_odb_entries(r, alt, PATH_SEP, NULL, 0);
+	}
 
-	read_info_alternates(the_repository, get_object_directory(), 0);
+	read_info_alternates(r, r->objects.objectdir, 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.16.1.291.g4437f3f132-goog

