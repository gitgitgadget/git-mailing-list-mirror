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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD863C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39AA60EE5
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhHEPIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241805AbhHEPH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69D2C06179F
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d8so7011137wrm.4
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntkjnM72vPz4c599gvUd+qiC0QhjxLERFS+xpDLHSlU=;
        b=HsN6P2FzoCw67O1tW9OyFRjmCDvl+uPZNlxMhxIJye3IqA6ObLl/7CHSxDw8gQTpkv
         s5fPI/gi7AJjmEM7uQAId0vvVRS+veUXMur7mD1Ka0/INdvkDaAEy+zs65roS4P08PL8
         jcBEiEa6TiiBO4JME7GkyzwuvXJvIGA3wX0sTymhcerEzUp7FJtUff+J1FoGmE5be3l/
         PEq3QDHkGeN8BySvfNcjuZA3oeQ+PMysoWwfgmc9VB4GmY8Bm9QFEMtsoXTnXDkrbxVD
         iw6z9otuTcjVuzZeKSbxveobcRiKRed4GxsXp/zl9YA2BZgIhbZFjlURKTnASCIF3vv/
         lnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntkjnM72vPz4c599gvUd+qiC0QhjxLERFS+xpDLHSlU=;
        b=hspgWEGfyWPkSB2WZ4iRKqF+bwsoIIfoOEfgEHl0Uhvg3h6yNMGhXz925qB+/pmll0
         /Hlx/IOn4u98CjBjCfA4layupORGElv9wi43PdBFgAt80qiGCQ4wFnkW60BONQI7DL7R
         jiMQVJcGzu8WbmuLTH0BDEgiAiO5kMNl2bPNhJxkg1tSohUyjp2vjxTBk3T4FLQUQfGj
         s22W7IjgO2Y2sHs/Z91hhFBH98f8xnkx8nFhZ4Vbgoplry7WK8aoYMGHYZ2/W4VrafzT
         k9n9Px2TO+wyXsNkmxr43ujrJM1YKYHS3YmaIG+bRYoOUnEXj3mSGYUf8Vwrp18JBod/
         a2Cw==
X-Gm-Message-State: AOAM5330CyJGO0feR1+AcRw+KQWaXAxvkw/T5hbmZ452kDZqRu9hElZv
        d43HADVVN8Y5/iVOLPl2RWHd191FcfWnXQ==
X-Google-Smtp-Source: ABdhPJzvSerfe2ewEsnwmte1OjV2qyShj9VeWaswd/gWnenwQIf6ER2Y/skqYY1KRaNE7sOgXt2AJg==
X-Received: by 2002:a5d:44cb:: with SMTP id z11mr5892020wrr.100.1628176062078;
        Thu, 05 Aug 2021 08:07:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 07/13] bundle-uri client: add boolean transfer.bundleURI setting
Date:   Thu,  5 Aug 2021 17:07:23 +0200
Message-Id: <RFC-patch-07.13-f0e4052de4-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
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
 transport.c                       | 15 ++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index a9aff7f982..1ed026421c 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -74,6 +74,12 @@ transfer.advertiseSID::
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
index bd8a914652..80d1857374 100644
--- a/transport.c
+++ b/transport.c
@@ -1503,6 +1503,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 
 struct config_cb {
 	struct transport *transport;
+	int disabled;
 	int configured;
 	int ret;
 };
@@ -1513,7 +1514,15 @@ static int bundle_uri_config(const char *var, const char *value, void *data)
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
@@ -1538,6 +1547,10 @@ int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 
 	git_config(bundle_uri_config, &cb);
 
+	/* Don't use bundle-uri at all */
+	if (cb.disabled)
+		return 0;
+
 	/* Our own config can fake it up with transport.injectBundleURI */
 	if (cb.configured)
 		return cb.ret;
-- 
2.33.0.rc0.646.g585563e77f

