Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B4CC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347118AbiDRR11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347052AbiDRR1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF0340E3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so9158784wmn.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPUHebGUcrDnj9+Z7KGiJy8IvX+h7GWxl1MxqbxyAPs=;
        b=llGiUiJ7Gon0CscMB6wRQMyk/c+mniPwddqVVBpMnmLxgrklC6AZzC5d1O+NJj+4da
         +2z8SnHrPtNQbT5SkfNUbixF8nJQoxY91PwCOCTXVtwskHKKUIFLqYFWiSda+9YpBPXx
         ltX0kUXMyN9YksgD/oFNt4686xhDZz1ojwSZMnzpkXSkifN3V3SnSIs/L2kyjuu2kvy8
         DEj/JFnGnHN/qXBs5POkL91fGmSEUPTCNELha/MFkk5y2SN0M+jBAB/nz24AIoQNG7dU
         xDsf3UFEjL2WbdyqTv1N1Lb9fzfkdbJAmRe1YEtqtbFHFPf1jr86D9994vDkMMjLNxEg
         ZpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPUHebGUcrDnj9+Z7KGiJy8IvX+h7GWxl1MxqbxyAPs=;
        b=zo884lwgzFnQqoURLLO//xND5uAXFE+VjKqXSA5WT3TuuTPVme4xu4ffvMl7m5WYto
         58DnRwMP1Tdb9UUlN+rFkGZVIZRMsxjx9v0db43cSBRiVFbaiCEKwLrY0mPGacElzvpk
         sIZk8HSG1zxxqOUhS+YVD1+lKIXhaZG/hiQ/Z7Te3rBPgsAvN77SHkOYyrjc83UKhjnu
         TVNDqpoKG27fyS0O/b3J/NtRKn2O5PCyfrKshJF/GmOtIiehdOKhYsNjwrhE+YybY/3W
         FTjncJB6v+3nQP2qd0ZnqvImDHA3f+alOHRDr6iPEYUrNPnmAJ+hlelp/bTUrj3dL/ak
         lBNw==
X-Gm-Message-State: AOAM532Uu4Bx0NnqnlybnVyXULOMw5aRf1GE0cyZ6DqhqEXEXW19nYsK
        SM0QFjHZNFD3XTzM4iTkavcrxoGSlgifcw==
X-Google-Smtp-Source: ABdhPJyCVNfniuvgwRmxQhnkOZrSactsuUvQMH4efLgTKpuM3bxX9sagVbw4dPtJ/B/vWPHJ8L5sqA==
X-Received: by 2002:a1c:cc01:0:b0:37b:dcc8:7dfd with SMTP id h1-20020a1ccc01000000b0037bdcc87dfdmr12327578wmb.134.1650302654845;
        Mon, 18 Apr 2022 10:24:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:14 -0700 (PDT)
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
Subject: [RFC PATCH v2 14/36] bundle-uri client: add boolean transfer.bundleURI setting
Date:   Mon, 18 Apr 2022 19:23:31 +0200
Message-Id: <RFC-patch-v2-14.36-e66aa1f18b4-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
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
index 342e39d81f3..9e20b531215 100644
--- a/transport.c
+++ b/transport.c
@@ -1521,19 +1521,28 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
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
@@ -1548,7 +1557,7 @@ static int bundle_uri_config(const char *var, const char *value, void *data)
 int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 {
 	const struct transport_vtable *vtable = transport->vtable;
-	struct config_cb cb = {
+	struct bundle_config_cb cb = {
 		.transport = transport,
 	};
 
@@ -1558,6 +1567,10 @@ int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 
 	git_config(bundle_uri_config, &cb);
 
+	/* Don't use bundle-uri at all */
+	if (cb.disabled)
+		return 0;
+
 	/* Our own config can fake it up with transport.injectBundleURI */
 	if (cb.configured)
 		return cb.ret;
-- 
2.36.0.rc2.902.g60576bbc845

