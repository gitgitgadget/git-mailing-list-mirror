Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3536D1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeBXAsH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:07 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46278 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeBXAsF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:05 -0500
Received: by mail-pl0-f67.google.com with SMTP id x19so5843779plr.13
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YSToifHIoRXUt7Nbl5HkAbnbVF1Ib9tf/JI0kHNKkS0=;
        b=mvs4TLL9V6bfKenBunE3UAW5gNWddpSeshf5CbrGlJ7FH2UPPNuLQiy000kZkKfNXZ
         qYSv9uXS8EZNUW+0hfupl9FQ2xrvPtyJcn7977VcausCKYShyvw1SbtzyWRGIWSdt+BR
         DFlTIx1qf1ijoC+h/HAHS9MNReYJGbIvTOefAKPujmbXrxi/F1mOdZYhpZVbWCmKZYT8
         j1/LIURh3aJRG4rOrSATrk3yLMMleWCSQBM5ntLOCCtPbdGVUviVz0VSS6MckOMNJE+2
         +W9vTihjVjEClBtlfK673ZWLufq90uF4s07FYob41a1EkWnq8PrhEYFPb+FaUB5GHA+9
         oszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YSToifHIoRXUt7Nbl5HkAbnbVF1Ib9tf/JI0kHNKkS0=;
        b=Wn9jce71xtwlK+u8cq3DomldmCJnTmfIkafSAlLHo+oQLVQ0Cb9FNhspCeC6lkiVF9
         cjyJk72X43o7Mw6j3UKxIbMTV97teK2IzxHAeQJS6YMFCHlO2HZc0WFffNTOxKq6X1Zg
         Hb9JbwpGwBghvj0DRGlpOgvtM87VFfJLFVW6DwjPlgSdiKuPqUQgePJPxoQeD5OCXdhh
         5Pzop6b0nHptcsDQHMIJKv77/q5n7XgztDyrFZ0jxUomyhmLHZ400sAY5WAXVz3IOp+V
         yWgZHdJmTH+RKJPjKbIDl6Jqb8nUluaxajqBV7z1Iu4R5PheGl7/f6zwljmc4RlLITLs
         7C6w==
X-Gm-Message-State: APf1xPBj9NdW7jCldmVi1aTxuk/P1XvBT6/mahFoSyhHH4aZmJ0/6Zxd
        L4LT/i/lou6R6svf26fhO/m8oA==
X-Google-Smtp-Source: AH8x225oHJfeYsUSjCtnv4UfITQBvTEoNH0nVtTMLqXx22AQcfe5g8MTh3dYGlNeaY7Zsnu41JJssQ==
X-Received: by 2002:a17:902:47:: with SMTP id 65-v6mr3286659pla.194.1519433284577;
        Fri, 23 Feb 2018 16:48:04 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t87sm7718414pfi.37.2018.02.23.16.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:04 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com
Subject: [PATCHv4 04/27] object-store: free alt_odb_list
Date:   Fri, 23 Feb 2018 16:47:31 -0800
Message-Id: <20180224004754.129721-5-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
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
index a2acdee1405..920dc4463fa 100644
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
 	FREE_AND_NULL(o->objectdir);
+
+	free_alt_odbs(o);
+	o->alt_odb_tail = NULL;
 }
-- 
2.16.1.291.g4437f3f132-goog

