Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AAD20288
	for <e@80x24.org>; Thu, 20 Jul 2017 00:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933118AbdGTAWA (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 20:22:00 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33444 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbdGTAV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 20:21:58 -0400
Received: by mail-pf0-f173.google.com with SMTP id s70so5802420pfs.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 17:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sgbApo/oGivjgcfE03Mkf7w7UnbttdkQSx4aKsSsmq0=;
        b=fuwG17EGG3y0Bug58dtHGleOeJw2Aoe9uNIlm+yJ0qyfIN7rJ7XFZ84zIXZysdBTpO
         SP/aDm+mf+HtVrLjUoX6hx5P2x3sGXr80DRdERLVip6hYi6jMbKexPBBeYadnd4hAUgR
         nGOGPbdqdx1Sds02f1NK7utDNVDbDoG4vkUKWE7htLwu5RsgRbw8N8IrnsyUqLnnFMO7
         1uYh5IWz4JPYhW9PrpWJtChZAe3t/qqcJN9WUTJ/Y4VTYm22UGOmYc6la4Aw1VpNAIm+
         vC9B3lB/XnUPClE28geblb12i3YKToaQ9f90C+7ssGmdpxPG6zW1UTjOKh8QaWdfIKQ/
         PPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sgbApo/oGivjgcfE03Mkf7w7UnbttdkQSx4aKsSsmq0=;
        b=BICZddXB99Ak+VXwjN+GjUTPU83zIjQ7CahbG0SckGHyVgOssbeoPC/r5RZFoIyKrK
         K80Ix+NxMIsom7hoQWMgkNVUfq1RHLmt3oIY3XqUxp4GIvmjC8n/Cxq58ZNnmwylZ3iW
         oCHvBSvK13Pt0suCYX/5BXeni4NtF9Ni7FFfAjeJTd+XvSDRAvRQZuuirqKo1FN1mcMp
         CMiid4HbBjq1ps5Dd3ZJimtSPhITTqRhriE6I7llUXovhif8znVfLP9IaSp966ocRUzB
         5Zid9eBeCA4K1N3x0j/HGJIHJdukSgXIqWQh08fFze9lrjYOr4IWISYt0VzRXGJPP3SS
         3gBw==
X-Gm-Message-State: AIVw113wrpnreuN7Fh5HF04Z8gyuVlDMVJq7JnpaTnrmid+Ug0NWpF65
        gW5qmNIPOnxY/z+8bPsRwQ==
X-Received: by 10.99.108.134 with SMTP id h128mr1884889pgc.29.1500510117101;
        Wed, 19 Jul 2017 17:21:57 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id n129sm1285891pfn.27.2017.07.19.17.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Jul 2017 17:21:55 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        sbeller@google.com, git@jeffhostetler.com, peartben@gmail.com,
        philipoakley@iee.org
Subject: [RFC PATCH v2 3/4] sha1-array: support appending unsigned char hash
Date:   Wed, 19 Jul 2017 17:21:46 -0700
Message-Id: <0451fd25052ee217df8eca31fe12a08886cd6c34.1500508695.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.284.gd933b75aa4-goog
In-Reply-To: <cover.1500508695.git.jonathantanmy@google.com>
References: <cover.1500508695.git.jonathantanmy@google.com>
In-Reply-To: <cover.1500508695.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com> <cover.1500508695.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent patch, sha1_file will need to append object names in the
form of "unsigned char *" to oid arrays. Teach sha1-array support for
that.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sha1-array.c | 7 +++++++
 sha1-array.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/sha1-array.c b/sha1-array.c
index 838b3bf84..6e0e35391 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -9,6 +9,13 @@ void oid_array_append(struct oid_array *array, const struct object_id *oid)
 	array->sorted = 0;
 }
 
+void oid_array_append_sha1(struct oid_array *array, const unsigned char *sha1)
+{
+	ALLOC_GROW(array->oid, array->nr + 1, array->alloc);
+	hashcpy(array->oid[array->nr++].hash, sha1);
+	array->sorted = 0;
+}
+
 static int void_hashcmp(const void *a, const void *b)
 {
 	return oidcmp(a, b);
diff --git a/sha1-array.h b/sha1-array.h
index 04b075633..3479959e4 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -11,6 +11,7 @@ struct oid_array {
 #define OID_ARRAY_INIT { NULL, 0, 0, 0 }
 
 void oid_array_append(struct oid_array *array, const struct object_id *oid);
+void oid_array_append_sha1(struct oid_array *array, const unsigned char *sha1);
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid);
 void oid_array_clear(struct oid_array *array);
 
-- 
2.14.0.rc0.284.gd933b75aa4-goog

