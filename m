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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9652C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B622E60F58
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhHEB0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbhHEB0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:26:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2263C061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:25:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c9so4267358wri.8
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZUTuE8hK2BXh6mAC7AfML9ziGZvmFgjbEjdl3O/7uY=;
        b=gwXYANUbDoMo9+HtZ9vcLVdDiNm5E94KkFIn6I6zeTS5S4tJYn8vsvnhMkGrz58D7o
         laXtnQZaiZRnL9KKsTBNehRYKYW+39fz6h1lCwerhBTdcmCAyutzPzVo/rqXkOEZkz3k
         CSBMIdfhJWrNYOnGjylAH5msw/BdIYImZfSzVQFBVaNiVS/K5rLIYU6xu52z8rjlgwYE
         jxUKG/S7vweFVR6dD7lW/8aBfgizbXEolPvpdty40SAFYoAdPqIhHJrqqXNIISRvyhHr
         Ct/xRGYBbfq1QVMxWvl1peHxJbAizVGqFEXqI+q0Q6Bgpb8qMsXCNKfmDaN3874/K4cc
         TOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZUTuE8hK2BXh6mAC7AfML9ziGZvmFgjbEjdl3O/7uY=;
        b=sJUXO5tg2bQHyGhozhjAuxi+BoHmjBKjsmI30o+2CQChvovhw8HN3m0oaPJtS+QPTq
         VGoqWSSt5bogY3EgrpA/5HCm+/+hEILmB3qdWGGoqUIlU2ct1B0mQ7KKQPq/CJbIt8Ww
         dIs+2tIlncExSBxGzEIQhZBTFYfVCC+sGy+pFKCgNug/Iu2mwTlhYP/IdpiI6/VecFqM
         di/sXlBlr46M31T58cjPUkCZN9I3QrEh7qqs3Iy3EXIWHk4oBNN6R6heCv5Z455t+cTR
         DoJQkPZczd+ZwqZ85RzQvrWsUKegppjTKXoRMs/HYWVSStYWt+8EJDCjTNViAoqK4lLN
         m7Ug==
X-Gm-Message-State: AOAM5320F3dQBq/HSbIA59WGu6Pnhy14hmrjoRo7jSpU8rQB/A9Qo1YF
        FU4JtYp1QVhVpE8ykP7zcgeo6Agmp0hrpQ==
X-Google-Smtp-Source: ABdhPJxVIwif101b31J3nZEDkPAAw5WdhLDl01gQo+9pANrQucRmfrTKwRcmyMJtRHKoSZT7kj+1Zg==
X-Received: by 2002:adf:9cc7:: with SMTP id h7mr2095425wre.406.1628126747259;
        Wed, 04 Aug 2021 18:25:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm4120176wru.50.2021.08.04.18.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:25:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/10] transport: rename "fetch" in transport_vtable to "fetch_refs"
Date:   Thu,  5 Aug 2021 03:25:35 +0200
Message-Id: <patch-v4-02.10-162f717436f-20210805T011823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
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
index 17e9629710a..3e8a27b0321 100644
--- a/transport.c
+++ b/transport.c
@@ -1453,7 +1453,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 			heads[nr_heads++] = rm;
 	}
 
-	rc = transport->vtable->fetch(transport, nr_heads, heads);
+	rc = transport->vtable->fetch_refs(transport, nr_heads, heads);
 
 	free(heads);
 	return rc;
-- 
2.33.0.rc0.597.gc569a812f0a

