Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F02B1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030240AbeF2BXZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:25 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:40437 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936487AbeF2BXT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:19 -0400
Received: by mail-qt0-f201.google.com with SMTP id t23-v6so7339436qto.7
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=kM7f5Wh41TrYYg3YsprNPyLFUg0f/yzqKnyI/rtos6U=;
        b=kus5axBFAaCFWQxBzSKOXWlj+RtAEDXM5tbIfPccht8D3zAMDR1XaLOaUPQ4Z+ZUBP
         +WahGCAD0akXvyYE57Qc4pmyayHv2e81ZoOv8InaNVL/Y11i3jejBQCnpUkkxM3M66RE
         9qlshR1BooMl/z7DK08bADn111YJE4dnNAz0273dMWz/aQ7PYGd9ydxBVZyhPEGj4ta5
         4waiEzJLZKo2Obd7EPvTH+H0KpG82z5G6kLsz6wwvDbbkVr/vjbu5ILy/fEYFROjwUCE
         s6m727Sq5wj352nmiho3WIRzWrs31a7N3m6eGtzcnrHRFej/xdKQUJyz9MYPvv/3mQNF
         S7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=kM7f5Wh41TrYYg3YsprNPyLFUg0f/yzqKnyI/rtos6U=;
        b=UmzbBXlndcwMStYmRRAw0L1QoaWkn3br4kWgG7h1jcUdmu5ch8nYhDgBi7+jNNpbwE
         kQ8v9JNgcr3Ad9zYpDPzFZIGWcOrKqkRIR9BMeCSle1yti+ASSZi77nIC2sSGDeOhXpf
         Yy6H/bQ5h4IgWqEizysKazJ+bYoJYRImTTlo/ZcYqqzS7QFED1/Kg7r06mqGJncpgEe4
         CdOgJPorxv24G+Nh9+6uyAXTMZjO5H73yv5UXe6dF/UqD25iY/goIKZ7zZYaxNKc9oJS
         h4GNvyhqsqRy5C/BRQzdcr/rOWjrRrZ4sy5VItfXi5+07IHRY2Hewd/aavL1rfZfOWe5
         cU5w==
X-Gm-Message-State: APt69E1dTi9+O64fCZNx7cf4OHVlwt5wbZXj2DM2Db2piABa3A9yy5y2
        r+io6tmmXFUMIBMWjLGRBLDMr0zzCcVXaZfIJAGC3Jqh1R5+WsdOkB5PsYeoh8CO0cNmcIwI/c+
        pTITnh8trUev+Rxa8TnIWU0ThldBa88diYpGydTVgsMwohYobpKBM5JdiESP+
X-Google-Smtp-Source: AAOMgpdOOOcRhz9iRnFAfD/WuLDSqg61UV4ryYXm7UrE0IkxCWuyq8NfuI32hCrls+62/XipoLzyGdwXaw1I
MIME-Version: 1.0
X-Received: by 2002:a0c:b0e1:: with SMTP id p30-v6mr4545348qvc.58.1530235398797;
 Thu, 28 Jun 2018 18:23:18 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:10 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-21-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 20/32] commit: allow lookup_commit to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 10 +++++-----
 commit.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index aa5557dee84..8749e151451 100644
--- a/commit.c
+++ b/commit.c
@@ -53,13 +53,13 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 	return c;
 }
 
-struct commit *lookup_commit_the_repository(const struct object_id *oid)
+struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(r, oid->hash);
 	if (!obj)
-		return create_object(the_repository, oid->hash,
-				     alloc_commit_node(the_repository));
-	return object_as_type(the_repository, obj, OBJ_COMMIT, 0);
+		return create_object(r, oid->hash,
+				     alloc_commit_node(r));
+	return object_as_type(r, obj, OBJ_COMMIT, 0);
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
diff --git a/commit.h b/commit.h
index 237607d64cb..27888d82468 100644
--- a/commit.h
+++ b/commit.h
@@ -63,8 +63,7 @@ enum decoration_type {
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
-#define lookup_commit(r, o) lookup_commit_##r(o)
-struct commit *lookup_commit_the_repository(const struct object_id *oid);
+struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
 #define lookup_commit_reference(r, o) \
 		lookup_commit_reference_##r(o)
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
-- 
2.18.0.399.gad0ab374a1-goog

