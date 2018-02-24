Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50B51F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeBXAsZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:25 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41730 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbeBXAsU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:20 -0500
Received: by mail-pl0-f67.google.com with SMTP id k8so5843298pli.8
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=plNwTDczecXO6CRMFUTawqmrWsfcFCZXPMoMjSEDnrc=;
        b=rE8TGsYFvuf5oSwiMkK4hueNkDzMzC+OqEvGJBS4NBwQc45UMj6tV/+O2mTGnmU9EI
         XvAN596lmEPpLbTJ3LvfMtAVFlhmcOvgvDFP48cSgSV2nG9+CFQXzFp4+9JrAM2NaJ3f
         B/uIl4Ahsfva3nzCA5797RnzTYJIgTbbNozMCCoaRGm4z0wmkpPaIsrt+IaUmUE7qokI
         sweEPcFzsU9sEtZ2WE12TKGhMrOZ5IaCW2hUKvVF+OhzIoYREesWu+7G8fNKMtHlhYs0
         4DO7+sh/OBh2SxPVboY2RuEUXmdr4N/xX7VO1CF0r2QiXV4oKCkZYxlARhJMCEWGy+6r
         AGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=plNwTDczecXO6CRMFUTawqmrWsfcFCZXPMoMjSEDnrc=;
        b=leNw8riP+p1N+tm9ox/FtNWVB+l0Jv4+ws9xgGOSHAn6oKCeNoJkx0U7btnPFqpUlV
         iK/zTOBaqUaV6SQJwKUYf5vPF29b58Ila4buQFFoXbhLeK39bxDBd4HpvlDyNggT+jbM
         3vgqk+wdrsVZVYLOZdQtELreETn9E5pZTYkIDo3qWRXrIRBnTzMArMSQ9azU1VSP4wwz
         +ZfpGlM7ynRlvFmP70CZ1rE3CO+YWNu43nnbtRCwyTDg1hse3Bk2g+HHe4pu5dk+TvgX
         85znPCTFtxHKKtYqvw+A/SS81Nug9JzN78H4hF3J5HjHMW1107rNf0wStZHz7w5Qgfak
         89Mg==
X-Gm-Message-State: APf1xPAXdFtu70reRg3XNDNheXA2CZGMGexfVYcUK1aU4BDsRsQthBA+
        twFwHuznIJUuFjGPtMkHQ3mRS3gif/4=
X-Google-Smtp-Source: AH8x226RnyR4wLkPbuAEG+bREpfz+KZ4tQ1sH4+WTPj4OkigJa8sJx1s3DeYL3vlVBAkKZ71vCXZ4g==
X-Received: by 2002:a17:902:1683:: with SMTP id h3-v6mr3380207plh.433.1519433299311;
        Fri, 23 Feb 2018 16:48:19 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m127sm6881612pfc.78.2018.02.23.16.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com
Subject: [PATCHv4 15/27] sha1_file: allow prepare_alt_odb to handle arbitrary repositories
Date:   Fri, 23 Feb 2018 16:47:42 -0800
Message-Id: <20180224004754.129721-16-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h |  3 +--
 sha1_file.c    | 12 +++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/object-store.h b/object-store.h
index 08cd48ade11..24b9a750aef 100644
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
index ab42d430b8a..03b9bbe8bb7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -671,21 +671,19 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb_the_repository(void)
+void prepare_alt_odb(struct repository *r)
 {
 	const char *alt;
 
-	if (the_repository->objects.alt_odb_tail)
+	if (r->objects.alt_odb_tail)
 		return;
 
 	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
 
-	the_repository->objects.alt_odb_tail =
-			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(the_repository, alt,
-			     PATH_SEP, NULL, 0);
+	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
+	link_alt_odb_entries(r, alt, PATH_SEP, NULL, 0);
 
-	read_info_alternates(the_repository, get_object_directory(), 0);
+	read_info_alternates(r, r->objects.objectdir, 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.16.1.291.g4437f3f132-goog

