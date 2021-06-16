Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647F1C49361
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4262060041
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhFPOSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbhFPOSj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 10:18:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B75C06175F
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d11so517128wrm.0
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h6IFiLyByxsJtiq5gDMgU91U7uhwC4pDvs4JARLFUaU=;
        b=ii5TwkGqEFH5+SVbn55MWQlw+jD4qW1ndgdgEszndB7CwtGbkCB+U73msQ1+XXX7PJ
         5iUqGCV7Ua2ooooKroLfEmOkQiFhcEzgauwCfbFS91Nxe4LzQeBjkhlgsRvKmHdqAl0T
         R5MEzHATzcuJOZ1cE9SckD8V5UmVNvy/zrnR3Of6kdZBG3RskEHof5IrpPtOuRE4BFUR
         zUlgtA1MrsuST3wzZxRukjn7JVXiKNgUqb0rcpURNJKBnSBb8rdMOjCdaCQ6gxmk2DFw
         BorcfuedX61UcB92QAPNEui+P5vE2gw4gADh9j39GgTqPssrH7ZCEFztaBZ9tL4pRgEN
         ODQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h6IFiLyByxsJtiq5gDMgU91U7uhwC4pDvs4JARLFUaU=;
        b=MTj65y9pOQ1QEFkb8btRpm4ZQoUocezlzjsTw0CCtHCUarI/2aAIVP9g7qjFyqags4
         8/sIZKyLcZR9SujkTfb09zdQpz+NQ6zKQZ7fEKjDt2OYw2N0TU94puQ9vOKi9Zu+vjJy
         VS7X70wkfqAPOpGBqBxde8mJsU6cuEOJd3pariGHs6Dp3s37DLYI1ZRnaYopmItXyQT2
         92UWEKtuAFhOTBHplrxl28S3oNaT59/FX50RqZJ/Vlzw72veHLJX522ef0QVj9jb0jP6
         6bUn72MN1knFE7o5xFl4BqsEwGOzl0+e2R89T5xI88qf+K/TtMl3VmbbKW4mhbV4o788
         PV6g==
X-Gm-Message-State: AOAM531VpVEjPD/ZxTXwiNiDNlqshUrM7hnpBCvccgnbVsQzT48is9i0
        BlTvmpwoHM7nzylKygrc6u6MY72F2Fc7pA==
X-Google-Smtp-Source: ABdhPJzkmFZIupQO278tum/KHbe5nhvJ2Wsy8vamjzOtsKpqvmeu5koOGbe0XaSWVD07Z9Cx4x1BxA==
X-Received: by 2002:a5d:5107:: with SMTP id s7mr5782158wrt.12.1623852991434;
        Wed, 16 Jun 2021 07:16:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm2258555wrv.37.2021.06.16.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:16:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] transport: rename "fetch" in transport_vtable to "fetch_refs"
Date:   Wed, 16 Jun 2021 16:16:18 +0200
Message-Id: <patch-2.5-c6720d1bf33-20210616T141332Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "fetch" member of the transport_vtable to "fetch_refs" for
consistency with the existing "push_refs". Neither of them just push
"refs" but refs and objects, but having the two match makes the code
more readable than having it be inconsistent, especially since
"fetch_refs" is a lot easier to grep for than "fetch".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 transport-helper.c   | 8 ++++----
 transport-internal.h | 2 +-
 transport.c          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 4be035edb8b..8d445a8f3ee 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -671,8 +671,8 @@ static int connect_helper(struct transport *transport, const char *name,
 static struct ref *get_refs_list_using_list(struct transport *transport,
 					    int for_push);
 
-static int fetch(struct transport *transport,
-		 int nr_heads, struct ref **to_fetch)
+static int fetch_refs(struct transport *transport,
+		      int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
@@ -681,7 +681,7 @@ static int fetch(struct transport *transport,
 
 	if (process_connect(transport, 0)) {
 		do_take_over(transport);
-		return transport->vtable->fetch(transport, nr_heads, to_fetch);
+		return transport->vtable->fetch_refs(transport, nr_heads, to_fetch);
 	}
 
 	/*
@@ -1263,7 +1263,7 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 static struct transport_vtable vtable = {
 	set_helper_option,
 	get_refs_list,
-	fetch,
+	fetch_refs,
 	push_refs,
 	connect_helper,
 	release_helper
diff --git a/transport-internal.h b/transport-internal.h
index b60f1ba9077..c4ca0b733ac 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -34,7 +34,7 @@ struct transport_vtable {
 	 * get_refs_list(), it should set the old_sha1 fields in the
 	 * provided refs now.
 	 **/
-	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
+	int (*fetch_refs)(struct transport *transport, int refs_nr, struct ref **refs);
 
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
diff --git a/transport.c b/transport.c
index 50f5830eb6b..f60985e2dbd 100644
--- a/transport.c
+++ b/transport.c
@@ -1449,7 +1449,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 			heads[nr_heads++] = rm;
 	}
 
-	rc = transport->vtable->fetch(transport, nr_heads, heads);
+	rc = transport->vtable->fetch_refs(transport, nr_heads, heads);
 
 	free(heads);
 	return rc;
-- 
2.32.0.576.g59759b6ca7d

