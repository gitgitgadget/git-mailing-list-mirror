Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC33C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350305AbiCKQ0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350269AbiCKQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:47 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D510DA62
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h15so13705240wrc.6
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8FtkZfff+trl7oLBI7PBtzLR1xTOcYhlTuDosltTNzI=;
        b=Kr/XtGpfyRI5JjUA4L6WDkDAunbzkiT+fWi6t+8H6Zq5ZKOmUZg49vlHL5xsBphzpJ
         YUR5UXs0L4IThZe11qRmY9q0uLrdv5cUdd3pDDZgo1j4P9LVMNCcsUjyCZFxAQAqKzhB
         P9FoPqNkWzqR1ogvqzlt+gJHM3de9+PZQIfkw5AWxt27eJ9vLRd0qq4V75eqYEUwPMks
         H4VkNNyQhD7paEq6p1+qEKZhGhe0nL+fC2uGnQOapQ2Gcdg5U0tLELfARRZkyPNXhBlZ
         BOril/qWk/8W+n/JXGcrJH+3vpXL3eEbxMG7sOtCSSrZhG4QcJNbvAqIW1QjL4/Jvbko
         Yl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8FtkZfff+trl7oLBI7PBtzLR1xTOcYhlTuDosltTNzI=;
        b=QI/m9ewMahl84IDlgbHcyVc265kF6BFOxfM/NqxQk2yUAqBUZyzDbYxqr0G5/befcU
         Kt5TNEGOSjp0Pa3mh7/GBWdwX/sTGJVv50y0/YXekzHqys2+gREST6t7wBd6bbIl6QdM
         lxR3/1wmhTkubfXKGD1QtYSipLC2t63wDh/xLCZuseMZHlPgEH+hSZjjE6JTm6gh/yA2
         R6hD4hbPtSkk89Wos81Ol10YTlyJUCPc0aLdcPJ07YYps7WNOFf4a1cukbBbeopjc8tH
         OWdoIVLUz41K/6H59PZlouV11Ayk+v3/xab7sXw8cTI7gF86a/O56g6VrpA58DDZ7CLl
         lixg==
X-Gm-Message-State: AOAM531Bz2BU5Lqr7W0tPN9nPqI3oa9Zlxl/ViOx2cHCZ3mrbz3msWn8
        vOB9A9YsIYP49Qb+kfd/9fofwLAc3K7KxA==
X-Google-Smtp-Source: ABdhPJyma+KEB0+Wtq/wWhAgJCaHcVNfXoebVa4l/W/ypr7nS2ROsXr7tfi/AA5pCWL6dqI2daWdlw==
X-Received: by 2002:adf:eb44:0:b0:1f0:483c:f015 with SMTP id u4-20020adfeb44000000b001f0483cf015mr7625743wrn.397.1647015878726;
        Fri, 11 Mar 2022 08:24:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 08/13] bundle-uri client: add boolean transfer.bundleURI setting
Date:   Fri, 11 Mar 2022 17:24:20 +0100
Message-Id: <RFC-patch-v2-08.13-44d96a0f5f8-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com> <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The yet-to-be introduced client support for bundle-uri will always
fall back on a full clone, but we'd still like to be able to ignore a
server's bundle-uri advertisement entirely.

This is useful for testing, and if a server is pointing to bad
bundles, they take a while to time out etc.

Since we might see the config in any order we need to clear out any
accumulated bundle_uri list when we see transfer.bundleURI=false
setting, and not add any more things to the list.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/transfer.txt |  6 ++++++
 transport.c                       | 21 +++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index 71b9b8f29e6..ae85ca5760b 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -78,6 +78,12 @@ transfer.advertiseSID::
 	Boolean. When true, client and server processes will advertise their
 	unique session IDs to their remote counterpart. Defaults to false.
 
+transfer.bundleURI::
+	When set to `false` ignores any server advertisement of
+	`bundle-uri` and proceed with a "normal" clone/fetch even if
+	using bundles to bootstap is possible. Defaults to `true`,
+	i.e. bundle-uri is tried whenever a server offers it.
+
 transfer.injectBundleURI::
 	Allows for the injection of `bundle-uri` lines into the
 	protocol v2 transport dialog (see `protocol.version` in
diff --git a/transport.c b/transport.c
index 16332f9d64a..7085bfb3db8 100644
--- a/transport.c
+++ b/transport.c
@@ -1510,19 +1510,28 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	return rc;
 }
 
-struct config_cb {
+struct bundle_config_cb {
 	struct transport *transport;
 	int configured;
 	int ret;
+	int disabled;
 };
 
 static int bundle_uri_config(const char *var, const char *value, void *data)
 {
-	struct config_cb *cb = data;
+	struct bundle_config_cb *cb = data;
 	struct transport *transport = cb->transport;
 	struct string_list *uri = &transport->bundle_uri;
 
-	if (!strcmp(var, "transfer.injectbundleuri")) {
+	if (!strcmp(var, "transfer.bundleuri")) {
+		cb->disabled = !git_config_bool(var, value);
+		if (cb->disabled)
+			bundle_uri_string_list_clear(uri);
+		return 0;
+	}
+
+	if (!cb->disabled &&
+	    !strcmp(var, "transfer.injectbundleuri")) {
 		cb->configured = 1;
 		if (!value)
 			cb->ret = error(_("bad (empty) transfer.injectBundleURI"));
@@ -1537,7 +1546,7 @@ static int bundle_uri_config(const char *var, const char *value, void *data)
 int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 {
 	const struct transport_vtable *vtable = transport->vtable;
-	struct config_cb cb = {
+	struct bundle_config_cb cb = {
 		.transport = transport,
 	};
 
@@ -1547,6 +1556,10 @@ int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 
 	git_config(bundle_uri_config, &cb);
 
+	/* Don't use bundle-uri at all */
+	if (cb.disabled)
+		return 0;
+
 	/* Our own config can fake it up with transport.injectBundleURI */
 	if (cb.configured)
 		return cb.ret;
-- 
2.35.1.1337.g7e32d794afe

