Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84FF71F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeBFAYS (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:24:18 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43137 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeBFAYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:24:16 -0500
Received: by mail-pl0-f68.google.com with SMTP id f4so120829plr.10
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RqPSOrEVgngq2ILjm5nlMHUT+m7rOUVI2rHP5ftUklI=;
        b=F51rkeQ1jKtv8oeA0V0FJJPzs3HgFlM0/MdhuU0Jok6cyG0Nm+dxvhzGE1a0bJ65Aq
         E/jEkypf8v5j0u3eVUoPAraKSe09L27MK9ket/YyDMf84AUGA5s4doC2lZxwtSHkXKzY
         x6U2hUMk75SJhh7micbOLkplbU58zLXfcfgpUwiAWjFY+Ybi6nZd+4tm1FJGeEyvr6b5
         ySxW1IEJr7UbFlWGkL0ikRvswePgl0T+0D/SMfBHTMHG3wThMXDYtK6uq3YnY4amdAcc
         fQI7gn2l6+fNiUtrOBYAjThp2ONeCpcY8qfXjmjzqvsu38cpo47+5mwCgUCAFnV9qpoh
         K70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RqPSOrEVgngq2ILjm5nlMHUT+m7rOUVI2rHP5ftUklI=;
        b=nWOOcfTmVkquF2wga1uMoCvMpos2jECjtlbgAc6s5UCE6NH8DAEyAnMg2bYmwqCzra
         zxTuC1STm8hmAK/N0vDhxd+tef198IW8pVDgyre5hppfg0ljHRIVTS5QtRAyKEDsX2MK
         vlQrt+y3ayFRJ+fnXetLlD6QcFai8IlLYDDVkTT+HtlcNQZwvblxKk1ElQqOu/0xKMBN
         M9xZwmqmZD9rsvw+/ZGLEdgRAwOitLDkZYJEswT2PLa+hNJHAxN7GIWUo2GBtqED51Z/
         P/iB2MPUfT4Bthh99TxM3TMD3BKrzXpHU/KJ/OA2ZEmpraC6Oq8uRl3w1YcQMg/av23N
         XJNw==
X-Gm-Message-State: APf1xPAT8HBFrxrQpzv2bKzTEsnwpnKlf+8A+IfT8eo/9L8qT/McXeAb
        uHjsewgTW07eIbumILyr2of/JZrCfLw=
X-Google-Smtp-Source: AH8x225l1txxE9J6ZpeHZXLCaVVw0yO3O4DXcsyG0m067IH/e/TFKGoDb8EyL/zsDCqZuG7BHtzdSg==
X-Received: by 2002:a17:902:42a3:: with SMTP id h32-v6mr570259pld.56.1517876655824;
        Mon, 05 Feb 2018 16:24:15 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e4sm17740326pff.116.2018.02.05.16.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:24:15 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 139/194] sha1_file: allow add_to_alternates_file to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:54 -0800
Message-Id: <20180206001749.218943-41-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brandon Williams <bmwill@google.com>

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alternates.h | 3 +--
 sha1_file.c  | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/alternates.h b/alternates.h
index b3d8d57ba4..4d5296c83f 100644
--- a/alternates.h
+++ b/alternates.h
@@ -48,8 +48,7 @@ struct alternate_object_database *alloc_alt_odb(const char *dir);
  * Add the directory to the on-disk alternates file; the new entry will also
  * take effect in the current process.
  */
-#define add_to_alternates_file(r, d) add_to_alternates_file_##r(d)
-extern void add_to_alternates_file_the_repository(const char *dir);
+extern void add_to_alternates_file(struct repository *r, const char *dir);
 
 /*
  * Add the directory to the in-memory list of alternates (along with any
diff --git a/sha1_file.c b/sha1_file.c
index 3c39e34c72..8638fae9c4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -538,10 +538,10 @@ struct alternate_object_database *alloc_alt_odb(const char *dir)
 	return ent;
 }
 
-void add_to_alternates_file_the_repository(const char *reference)
+void add_to_alternates_file(struct repository *r, const char *reference)
 {
 	struct lock_file lock = LOCK_INIT;
-	char *alts = git_pathdup("objects/info/alternates");
+	char *alts = repo_git_path(r, "objects/info/alternates");
 	FILE *in, *out;
 	int found = 0;
 
@@ -574,8 +574,8 @@ void add_to_alternates_file_the_repository(const char *reference)
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
-		if (the_repository->objects.alt_odb.tail)
-			link_alt_odb_entries(the_repository, reference,
+		if (r->objects.alt_odb.tail)
+			link_alt_odb_entries(r, reference,
 					     '\n', NULL, 0);
 	}
 	free(alts);
-- 
2.15.1.433.g936d1b9894.dirty

