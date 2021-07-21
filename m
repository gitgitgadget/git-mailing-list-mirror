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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDACC6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A230B61222
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhGUW7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhGUW7p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077CC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t5so3880855wrw.12
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBhSgJ197C6XcNth5XEFoKmYYgYN07YEA3M83wlnAPU=;
        b=J0/pHhlFFgVlROMyWM+fFFU4B+k8lANtrRnYpmhpazC5iPrd/ceaxzNgqGXJNFlKS5
         JjwT606UdHlgCu/V8+UJgyNFQpQMq1+N8PfRkn+Hwsuv/9CwifQDU4Y7hMtkNkfViGra
         3ZTzBZJKpAiF35V724SEtOo+fPSNDL+6c1Xjuy4LFS1Eym6/HyIP4uFvGvFPXNJ3j5/1
         yXF51cdYhMGZUnNi8UdH+h8L/jBA/ee3FTLBPBqF1bcKPOf8o5rv1g9f0/r+WX0WSBmI
         55taol5a/4ARJjIBM7hbXPshAyBgLhYRXUo98aQJf62iF/g35vx4VPkqzaOzUgXz5ISN
         6AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBhSgJ197C6XcNth5XEFoKmYYgYN07YEA3M83wlnAPU=;
        b=bxERHmgiy9C7Bk6YyrHZJBDUph8iTDVd8QCAp3A2QgsgQy9Hea5tV9pVmuhXcaf7Qo
         I/3jsiTYIKtBDoCHx1Oisz3V6RMx7XPCprOSNW8saRdZYOscdzEv6Big93Kg9exHZyHI
         YygNxZKVZ46a2L1cRFwHwaYujoFqaNJ8xjS4Q697BDcC+ZZesu/202ILbasXQP1bbZhQ
         VuznhSZo84pYwgR6w8DzS9wMGwdfRfD1M8Kg6mPmqeZLnZit7I21cMkIEHcdpVZR5OVs
         tQYjSw1ZsXs8BuI88reUHFCik0lfxthYDnMQh7HCKZT63J8Icx6GariHIPOn1d84NQeW
         PZJQ==
X-Gm-Message-State: AOAM532NYeb00j9v2pFmj7xvSoH8/EcQ8AVq9QgMCLIjIScH5s+XiBy9
        PKf5HA1chu0lgVxK0U5dOIpgsx3qE/dFXg==
X-Google-Smtp-Source: ABdhPJyP7gj4yiBENIWxq3Qb1GyZa5gPkuzSVsvanZ8AjCHZD2+JebXL1ynUeXZG0s2vMOTKgHUGWg==
X-Received: by 2002:a5d:408d:: with SMTP id o13mr46251935wrp.246.1626910818863;
        Wed, 21 Jul 2021 16:40:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/12] transport: rename "fetch" in transport_vtable to "fetch_refs"
Date:   Thu, 22 Jul 2021 01:40:03 +0200
Message-Id: <patch-02.12-d716bd3c537-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
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
2.32.0.955.ge7c5360f7e7

