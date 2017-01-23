Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DFE220A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdAWUnd (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:43:33 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33064 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdAWUnc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:43:32 -0500
Received: by mail-pf0-f178.google.com with SMTP id y143so43786087pfb.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A1Rkq/h8lxG8s/WG0l3S1Gc48D/SA05ncJf5tn81XY0=;
        b=HM90nNIVPEPJ4WburNeeMPPIXQKPe3hsxwwCvsJ8wzcohCXqRXDoJBqf5s1mj66zNM
         fI9pBERO62TxpMtvxjdLAfjnXLCW+mgM2bRmfvXzA1tQH88C27SIwEqeaFM3YtOERkoV
         PXaFCRUwXh6LSiCKDTMz9c+tqE7wkSm+lUnVlEwiqVuG8qAzruEkuGbcFKRYzXsFaBK4
         EJpIR6rol9HckFAETuTcfXmnE2nYSfOqXdkax78InUQqYdCyeHx+LWX2eaTRkFf0XpNm
         y0r90Dx6qH7kx6JVsFpPofxZf8vU/nnDyxjkxoIXarqQ2NwnUW4U0jCsGJcfR4o/fwa4
         B3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A1Rkq/h8lxG8s/WG0l3S1Gc48D/SA05ncJf5tn81XY0=;
        b=jzxT4Z0gfJ3LlZJuIiz4QDX125hroyK9n3v/dSEaOQCkJub3Tp9R0x6mTd/15Nz3aR
         /Ozgj7tszctRomSPbtdWGqw37t9sfPq3NYGJ9qxD9KPR3BFdlCWMOUMGxv89yI8TBDAl
         dA3udXsgN/F3TfZP7WwJi1TbscLY1G2flyECo4bS3FwL0q3FnX/ND8t7yTMo/IaJ7b0p
         22q4S2l5SGO8ZNznExQuQr5zcMLBaqwvEBaC9X8TQJd5qhHLSsQNNM1pItMf7Q9e9iz3
         RHhe0Io1Lgrz3mZkGd4P8Mc9XIGWcTPrKyc5RqRpeCx2muzvkCToFacH4EwYnXCJYFKY
         0MzQ==
X-Gm-Message-State: AIkVDXJpf2RRXxbZP89JnsUXqnp9EhscYF7tfU7rsUVUdx4XjhRtPfMTwM4Tu5CW9ezrDOhv
X-Received: by 10.98.201.135 with SMTP id l7mr34159047pfk.67.1485203765508;
        Mon, 23 Jan 2017 12:36:05 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:36:04 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v2 19/27] attr: pass struct attr_check to collect_some_attrs
Date:   Mon, 23 Jan 2017 12:35:17 -0800
Message-Id: <20170123203525.185058-20-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old callchain used to take an array of attr_check_item items.
Instead pass the 'attr_check' container object to 'collect_some_attrs()'
and access the fields in the data structure directly.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/attr.c b/attr.c
index da727e3fd..e58fa340c 100644
--- a/attr.c
+++ b/attr.c
@@ -777,9 +777,7 @@ static int macroexpand_one(int nr, int rem)
  * check_all_attr. If num is non-zero, only attributes in check[] are
  * collected. Otherwise all attributes are collected.
  */
-static void collect_some_attrs(const char *path, int num,
-			       struct attr_check_item *check)
-
+static void collect_some_attrs(const char *path, struct attr_check *check)
 {
 	struct attr_stack *stk;
 	int i, pathlen, rem, dirlen;
@@ -802,17 +800,18 @@ static void collect_some_attrs(const char *path, int num,
 	prepare_attr_stack(path, dirlen);
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
-	if (num && !cannot_trust_maybe_real) {
+	if (check->check_nr && !cannot_trust_maybe_real) {
 		rem = 0;
-		for (i = 0; i < num; i++) {
-			if (!check[i].attr->maybe_real) {
+		for (i = 0; i < check->check_nr; i++) {
+			const struct git_attr *a = check->check[i].attr;
+			if (!a->maybe_real) {
 				struct attr_check_item *c;
-				c = check_all_attr + check[i].attr->attr_nr;
+				c = check_all_attr + a->attr_nr;
 				c->value = ATTR__UNSET;
 				rem++;
 			}
 		}
-		if (rem == num)
+		if (rem == check->check_nr)
 			return;
 	}
 
@@ -821,18 +820,17 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-static int git_check_attrs(const char *path, int num,
-			   struct attr_check_item *check)
+int git_check_attr(const char *path, struct attr_check *check)
 {
 	int i;
 
-	collect_some_attrs(path, num, check);
+	collect_some_attrs(path, check);
 
-	for (i = 0; i < num; i++) {
-		const char *value = check_all_attr[check[i].attr->attr_nr].value;
+	for (i = 0; i < check->check_nr; i++) {
+		const char *value = check_all_attr[check->check[i].attr->attr_nr].value;
 		if (value == ATTR__UNKNOWN)
 			value = ATTR__UNSET;
-		check[i].value = value;
+		check->check[i].value = value;
 	}
 
 	return 0;
@@ -843,7 +841,7 @@ void git_all_attrs(const char *path, struct attr_check *check)
 	int i;
 
 	attr_check_reset(check);
-	collect_some_attrs(path, check->check_nr, check->check);
+	collect_some_attrs(path, check);
 
 	for (i = 0; i < attr_nr; i++) {
 		const char *name = check_all_attr[i].attr->name;
@@ -856,11 +854,6 @@ void git_all_attrs(const char *path, struct attr_check *check)
 	}
 }
 
-int git_check_attr(const char *path, struct attr_check *check)
-{
-	return git_check_attrs(path, check->check_nr, check->check);
-}
-
 struct attr_check *attr_check_alloc(void)
 {
 	return xcalloc(1, sizeof(struct attr_check));
-- 
2.11.0.483.g087da7b7c-goog

