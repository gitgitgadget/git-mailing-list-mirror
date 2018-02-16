Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0231F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758981AbeBPRqo (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:46:44 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43543 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758971AbeBPRqj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:39 -0500
Received: by mail-pg0-f67.google.com with SMTP id f6so2948598pgs.10
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3CBxxKsZNkvHZctCSJXvhOygva74cYK4i5+lqLtS//Q=;
        b=bbICB/fA9U8D34d9rCrBBS7nCTT9ooganGuvuEJVvGi3U6FIkYwpXk3+M2we35wKgq
         boCQJpdu91KGT4k4gKdVoNSfFfn+2mgF2QpK377Kw3vqAxYEdZFtvKL7/NQYTYx//E7c
         1a4LIWfXe9ZWCoz7Zczi0u7g6r60FK3FnQXIBFGGmykfGjQbJ91Z22dm4e4v0STp76FP
         0NUBBDOQLjVNCanwIx8zTVJKWHy8YkA4OoFiA2RzyvnqJz8tn49IIDSdLy6u5zUCIZQZ
         PgBgIQJIb9hMBx/SW2lO6kZEERDDgwc57vYCeJt/6FugPjpMmS4WZh05/Sr1iflPFMkE
         NoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3CBxxKsZNkvHZctCSJXvhOygva74cYK4i5+lqLtS//Q=;
        b=O/SqxTWRD3xwELo1dD1FKRtSyoDKi1OJPgmUfSoTrWm4fCSmzBjwg1Hd0tL97hzDaL
         Uud3BWVylLMybRX/f3Ak+3PuEkmYuJelqDyu3SRuKIu6gFFU7zbIouVTFuxCFReNemIl
         DDHPTq1zfQt1uNmVzSqX06a+nutwZOfeFibXjKKGxsLbQOXm/zr/jNNJ1SsJlREhBIlX
         IQvHqTS2vEnA59z/TZBjkuQMCMOggz6TNOvCRfnI0GBqE+A70UgGbNxmAbf6+TgbuAFR
         RDes5nC57es4gA51q8wzKPMBiEN+BkhyNAhsU7p/0SaN7dr38LGTJwM1miAslFZecMtp
         Gh8A==
X-Gm-Message-State: APf1xPAxhFo6wYJOK/+FxM9dHmyXVSgZdEbgGOPr4B+ATgxYX3FiaH+L
        ujMcJyhtDE4rxIN3G7NibR6gHnGm22Y=
X-Google-Smtp-Source: AH8x227ZyRP/jWJseXA8BYB2EQkokOz+ru6J/JOj2jCEahoub3LXyg+JVArku8NvW8xaf4Xd8VzYeg==
X-Received: by 10.98.178.218 with SMTP id z87mr6794769pfl.88.1518803197570;
        Fri, 16 Feb 2018 09:46:37 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j1sm38775973pff.94.2018.02.16.09.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 03/16] object-store: free alt_odb_list
Date:   Fri, 16 Feb 2018 09:46:13 -0800
Message-Id: <20180216174626.24677-4-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Free the memory and reset alt_odb_{list, tail} to NULL.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/object.c b/object.c
index 11d904c033..17b1da6d6b 100644
--- a/object.c
+++ b/object.c
@@ -446,7 +446,24 @@ void clear_commit_marks_all(unsigned int flags)
 	}
 }
 
+static void free_alt_odb(struct alternate_object_database *alt)
+{
+	strbuf_release(&alt->scratch);
+	oid_array_clear(&alt->loose_objects_cache);
+}
+
+static void free_alt_odbs(struct raw_object_store *o)
+{
+	while (o->alt_odb_list) {
+		free_alt_odb(o->alt_odb_list);
+		o->alt_odb_list = o->alt_odb_list->next;
+	}
+}
+
 void raw_object_store_clear(struct raw_object_store *o)
 {
 	free(o->objectdir);
+
+	free_alt_odbs(o);
+	o->alt_odb_tail = NULL;
 }
-- 
2.16.1.291.g4437f3f132-goog

