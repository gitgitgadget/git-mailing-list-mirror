Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4D491F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeBUByu (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:54:50 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38575 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeBUByq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:54:46 -0500
Received: by mail-pf0-f193.google.com with SMTP id d26so59889pfn.5
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3CBxxKsZNkvHZctCSJXvhOygva74cYK4i5+lqLtS//Q=;
        b=r9uhaxNbYafail5LjO/rEm+ACgaFEaG0mRpAo8tlmT3qTwF6+TxkoT9Oq4K2RLA9Fg
         GqlPRt9+YvA84OE+k74BF8pNTRrLwye1iPROoZMrlCxRL2y4kjkXyjpdJCCVC+dVNJTR
         p83fk8WchdNFdBsTAB2/4pjf0Azhuyp69HuT8JzgvnnpuJqOb1UV2ro7HuAiUyr+3OoC
         TLJhc/9gdyczz2R2vLJ2/Nj05O/db9KTx0EweUDUJLyVzffiedY5q5PwxpR842ymffCN
         hJts7XvyUvPx4poBsrLyW5CsOjRXmaEcxzEi6mK3LD9QMpazDDlJCwSSE2RyMrLuWKL2
         UVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3CBxxKsZNkvHZctCSJXvhOygva74cYK4i5+lqLtS//Q=;
        b=H6ya6YUf2nVtWOePRGhPPU9aEwOgrGj2BVwoSOK5LU1zTtYvXRgMRF1EkrFSd6ZD+A
         QVjBOxbycrl6HwAPDSJ6RuXJKiMf7Ww+2cRxSldJpw/VAxx1LJngzkYGZlC2cNxHve2u
         WwMS49pz8wsjDH/NITpdr/zYBt4+NzSm0hIa0kJeo6Uj34AGVdDI8+wkFIDszxWv9A4u
         MYg+s++BBGv1ZSoC4oPoU6zjhjipyJ4DAVYUorZu+eOeMfCBgeI7qWeUwt1oAhGXHTfx
         wpKdz24Ms4HlfDPQvLo2a+EkM2zeAwzlq+f+NrYIvmsG/wr9NDuKlLKFjhjzoTBnb/vF
         a4Tg==
X-Gm-Message-State: APf1xPBz4H7PvC0DSw55MT6EP/HRhyGDVCZ+C/cN9K0zPVVEJYWI0InQ
        TS/WJfw+3ixAr3Gkj3xi7rdtRw==
X-Google-Smtp-Source: AH8x224iO+EpfdPVtsqH1HO6oezlq/QPDUkpZWzoVlyxHEohhm+LIGVw43S2pSw/UcRC+nH44qV5oQ==
X-Received: by 10.101.97.72 with SMTP id o8mr1327266pgv.119.1519178085345;
        Tue, 20 Feb 2018 17:54:45 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a138sm32898751pfd.47.2018.02.20.17.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: [PATCH 04/27] object-store: free alt_odb_list
Date:   Tue, 20 Feb 2018 17:54:07 -0800
Message-Id: <20180221015430.96054-5-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
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

