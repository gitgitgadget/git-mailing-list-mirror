Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7BB72035A
	for <e@80x24.org>; Tue, 11 Jul 2017 19:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934185AbdGKTsq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 15:48:46 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36788 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934178AbdGKTsn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 15:48:43 -0400
Received: by mail-pg0-f51.google.com with SMTP id u62so1090806pgb.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cWIAeDK0yChc/91jeHdBWsZbrPXLtjPBot7rVvH/ycc=;
        b=Dchy0tD3n7DG/1enH1UQZhkD/bd9ut0HIO8+sdEBWewaelb9YpySxccjod2W1ntpf/
         GZVCfZ8knfDCA4IExIkzCJoVfg9K43r2Ox8QVwcprU54zoAbDWi1jK4hLmoVAlmvJE4O
         9QyirePaQ8W6/f6t7vo/3ig5PIIZfiIr202SXdMmAsS1oK9si9jxnx/yRLnaKud5Vm66
         pFBzHVWlAKPufEpLJslGz7QatLsVINSzk2EI1s5J64WGuj7jCVPmILl1iYJf9nepbw9n
         n51leMKn5LgF2FtjvVRcPMxuQ+h+odqixQWgsZOwOMl7pWqNDCLCDpqqoOPtSpNjGLCp
         VM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cWIAeDK0yChc/91jeHdBWsZbrPXLtjPBot7rVvH/ycc=;
        b=s7x7wOOiT1CvLTRjLS2SO6PZSG4bPrHFwIKHEpz0VwcuFX6C8xPHzsagEblbJ/Eaga
         HHJjauN/KiV8aRIiOAMchQbLXz1ky3QDDnY3XydDjWifvKWFpPL0Zr59faU2QHD1S4N/
         TCGvIAGA17n6rCHAbRLea1ZW/3e1TvAa5ylFiRtLfZd/lf3BnK4WnvJV6rjt8raCT85Y
         4ZNedxRcS52KDElGV/QHGWiNVMZiyo/ZDpVtIl1EXql8NoDjzSxroToltVrFFg2b6oV7
         b2kFlytM9JYi19YDT4drs31nFB0xzwvAPivlgh/LGB0NrIX593wlhMyH0XDZb0c6TEpp
         lPCg==
X-Gm-Message-State: AIVw112vIPJrPzkwYCGpOykTDicbQoWPKe8O945hFaK9CpPaYnTKvdxs
        7o6j80ht+c1xTuGoVO3DAg==
X-Received: by 10.84.138.131 with SMTP id 3mr24271plp.293.1499802522749;
        Tue, 11 Jul 2017 12:48:42 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id 85sm227557pfr.90.2017.07.11.12.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 12:48:41 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 2/3] sha1-array: support appending unsigned char hash
Date:   Tue, 11 Jul 2017 12:48:31 -0700
Message-Id: <523f64e1395124a02316071329bedf9884757479.1499800530.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <cover.1499800530.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
In-Reply-To: <cover.1499800530.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
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
2.13.2.932.g7449e964c-goog

