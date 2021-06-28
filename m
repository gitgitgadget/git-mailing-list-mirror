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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84BC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DE061992
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhF1TWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhF1TWD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:22:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C4C061766
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a13so22575013wrf.10
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4mnmf+zQquQk2VS0VCraZZaOLEW0g3riRf7ZlJoXOk=;
        b=WT5Jgdy3KT2aeLJYYO/EZQnbd4zlipx97SLPNGfglwgsN7bKaCHuclVDocxk7+zYkB
         WSLBrKJMbh1a+LN7FrqvzZFGsfdQpZih3Uz0f8ztiQATcwoNsS0Gs4/b38EINifReEYJ
         zxi6THIelvb/oeLjeFqj9ggAwA3KJcv97xC8UOKv0TTKdKRA85d9wf5mcnAbFntt5EbG
         UGfAnzN4mvylvZdNesGe1bHgCm6WXGykEpGKFiuZ/tuuxcTNXM3bbCQMCMH0b+gZfV2G
         ZM4zJzlzsaY+x3KSl41JuYg1ouQWBCk9n3AKm522Wy00FKe/hxCSVd1VkaTQjvAM3kQq
         +KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4mnmf+zQquQk2VS0VCraZZaOLEW0g3riRf7ZlJoXOk=;
        b=JWR/fsqnjf6pmXpwqmV2uVsrviq429/AavpRH/PmXM3BohmGMqOInRLf57BL4ENeMS
         K19zH4Izlmn8QVAsrQLraG9QnGqK7Faz6wCvnhwJKzR1TmPDXavT6raD1MBwTyPlcv+I
         O0qkchR4i8JhPkMisaTA+iOTFn01CEMo/ovR1ur00jFpGQAHhpVrmnebSWPo9EPOFatG
         z8Bo2GeX82rQ7dHn7i4Z45EQUHZPZTK4sy2Ip83/rg7VTqVmUfLOQg+DiZ3idAeWB1mx
         rhmOYWbuDhaYclTCIALCoCwWPQTp8H4I1+5fk7gVLI4Y/E9aUu3EC5npKf/LNYk4IaqS
         RxHQ==
X-Gm-Message-State: AOAM530vrOwM5uEiiznZBGYZw3YqHjrnaGNVnJN3R2wASByvva0qoAju
        RTP0B4kt8FSlLXgeZanu2470I0FLaeX7oQ==
X-Google-Smtp-Source: ABdhPJzC7u9qw8XCQxXfUSQ3dtSUaK8WDXZIoUiNsYT2OicHGl9uJsAvQ+mtSpa3NVOdm1RB3zMhTA==
X-Received: by 2002:a5d:60ce:: with SMTP id x14mr28757423wrt.385.1624907973645;
        Mon, 28 Jun 2021 12:19:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s5sm350531wmh.46.2021.06.28.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:19:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] transport: rename "fetch" in transport_vtable to "fetch_refs"
Date:   Mon, 28 Jun 2021 21:19:19 +0200
Message-Id: <patch-2.8-7b8101dca71-20210628T191634Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.611.gd4a17395dfa
In-Reply-To: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com> <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
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
2.32.0.611.gd4a17395dfa

