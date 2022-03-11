Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DEBC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350266AbiCKQZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350264AbiCKQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:47 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136C10DA42
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:39 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so1405108wme.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NiERUVfRIkvIhvj6gzXZ7qdfWgchCemTEYyCpUMqpYE=;
        b=S6WRT5e4K1LsvBsfXh8OohZQCgaZTO2HRGE7lnTjcUTlvMA08n1pGrHHJhHQuW7/bd
         mW8woz6idWeTunFOVKTQAVjwpRx1BIAY3wOhMPC+aLh90Fo8ZFN0L/wqTVOPJMv6V3V1
         ZPTieihS/IneBAXpcdYikbb5bIGeunPcaANf3obdzxptH8f2QIZup7HUE/Ypm+EbtO6F
         kwUHwN8/OmwhY7wzwxM5m80EvtbKxbFZ2YrAsOIAqCCpbPWkS1wOycYhlWlkkt9LqXF2
         ewLLNf/YcnhvcPUozGmRdSA1Dnt9ks7ALxLc7DsEMZ7xzrm8S7ywG3JzbOERKDXOqZOF
         Sg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiERUVfRIkvIhvj6gzXZ7qdfWgchCemTEYyCpUMqpYE=;
        b=vzmjKhmsZv+T8vPQw9kiTROjJFj6DAll+/+Jx+MlHMzwRCsvsmp91w2TmC4annhvOl
         ctfAv4/hNLEv4txhm5m1jDuGw1q1/tyMS0l4OxWfxyGrBY6ZKAX7RZ2PmDJH6BUJxu0f
         8Tjp3R5YfopgZZOAEwQmWXa6LK/HqxmSCzPWifdz9e4KB1wROZi23yR8BYYg8gZIsYNt
         kpH2L7/+e8mtgq/YnEnLTHGphOWaqTfenoMr1TFG2c1Z9U+8wFGaD07msQ5nrrD9YN8k
         MN979l7q0eGr5xFh8Lq34vkfAHK65Z575jUv6PpejZoWeyIG1KtfGEHM44NNUOj/QwjU
         p4aA==
X-Gm-Message-State: AOAM533bO6iaDZc36++XsTmVHyj99pvvHRLqMWDmvSvjURNauhdUM1wh
        n7Vb2ooIod6ntBr+xnKnNe4FtwPf0rCnBw==
X-Google-Smtp-Source: ABdhPJzCML4nnqW+2HG2MmG0bU9hD1EHI5UynEtk5OUhpddTW/aL8xPhkYsxsgLWxAMNoNRDogjKmA==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr8190160wmk.58.1647015877726;
        Fri, 11 Mar 2022 08:24:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:36 -0800 (PST)
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
Subject: [RFC PATCH v2 07/13] bundle-uri client: add transfer.injectBundleURI support
Date:   Fri, 11 Mar 2022 17:24:19 +0100
Message-Id: <RFC-patch-v2-07.13-b0ce379528e-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com> <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to inject "fake" bundle URIs into the newly supported
bundle-uri dialog. As discussed in the added documentation this allows
us to pretend as though the remote supports bundle URIs.

This will be useful both for ad-hoc testing, and for the real use-case
of retrofitting bundle URI support on-the-fly, i.e. to have:

	git -c transfer.injectBundleURI "file://$(pwd)/local.bdl" \
	clone https://example.com/git.git"

Be similar in spirit to:

	git clone --reference local-clone.git --disassociate \
	https://example.com/git.git"

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/transfer.txt     | 20 ++++++++++++
 t/lib-t5730-protocol-v2-bundle-uri.sh | 46 +++++++++++++++++++++++++++
 transport.c                           | 33 +++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index b49429eb4db..71b9b8f29e6 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -77,3 +77,23 @@ transfer.unpackLimit::
 transfer.advertiseSID::
 	Boolean. When true, client and server processes will advertise their
 	unique session IDs to their remote counterpart. Defaults to false.
+
+transfer.injectBundleURI::
+	Allows for the injection of `bundle-uri` lines into the
+	protocol v2 transport dialog (see `protocol.version` in
+	linkgit:git-config[1]). See `bundle-uri` in
+	link:technical/protocol-v2.html[the Git Wire Protocol, Version
+	2] documentation for what the format looks like.
++
+Can be given more than once, each key being injected as one line into
+the dialog.
++
+This is useful for testing the `bundle-uri` facility, and to e.g. use
+linkgit:git-clone[1] to clone from a server which does not support
+`bundle-uri`, but where the clone can benefit from getting some or
+most of the data from a static bundle retrieved from elsewhere.
++
+Impacts any command that uses the transport to communicate with remote
+linkgit:git-upload-pack[1] processes, e.g. linkgit:git-clone[1],
+linkgit:git-fetch[1] and the linkgit:git-ls-remote-bundle-uri[1]
+inspection command, this includes the `file://` protocol.
diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
index f0c41d60654..3be47bacc5f 100644
--- a/t/lib-t5730-protocol-v2-bundle-uri.sh
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -271,3 +271,49 @@ test_expect_success "ls-remote-bundle-uri --[no-]quiet with $T5730_PROTOCOL:// u
 	test_must_be_empty err &&
 	test_cmp out.expect out.actual
 '
+
+test_expect_success "ls-remote-bundle-uri with -c transfer.injectBundleURI using with $T5730_PROTOCOL:// using protocol v2" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
+		"$T5730_BUNDLE_URI_ESCAPED" &&
+
+	cat >expect <<-\EOF &&
+	https://injected.example.com/fake-1.bdl
+	https://injected.example.com/fake-2.bdl
+	EOF
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		-c transfer.injectBundleURI="https://injected.example.com/fake-1.bdl" \
+		-c transfer.injectBundleURI="https://injected.example.com/fake-2.bdl" \
+		ls-remote-bundle-uri \
+		"$T5730_URI" \
+		>actual 2>err &&
+	test_cmp expect actual &&
+	test_path_is_missing log
+'
+
+test_expect_success "ls-remote-bundle-uri with bad -c transfer.injectBundleURI protocol v2 with $T5730_PROTOCOL://" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
+		"$T5730_BUNDLE_URI_ESCAPED" &&
+
+	cat >err.expect <<-\EOF &&
+	error: bad (empty) transfer.injectBundleURI
+	error: could not get the bundle-uri list
+	EOF
+
+	test_must_fail env \
+		GIT_TRACE_PACKET="$PWD/log" \
+		git \
+		-c protocol.version=2 \
+		-c transfer.injectBundleURI \
+		ls-remote-bundle-uri \
+		"$T5730_URI" \
+		>out 2>err.actual &&
+	test_must_be_empty out &&
+	test_cmp err.expect err.actual &&
+	test_path_is_missing log
+'
diff --git a/transport.c b/transport.c
index 16147a170f8..16332f9d64a 100644
--- a/transport.c
+++ b/transport.c
@@ -1510,14 +1510,47 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	return rc;
 }
 
+struct config_cb {
+	struct transport *transport;
+	int configured;
+	int ret;
+};
+
+static int bundle_uri_config(const char *var, const char *value, void *data)
+{
+	struct config_cb *cb = data;
+	struct transport *transport = cb->transport;
+	struct string_list *uri = &transport->bundle_uri;
+
+	if (!strcmp(var, "transfer.injectbundleuri")) {
+		cb->configured = 1;
+		if (!value)
+			cb->ret = error(_("bad (empty) transfer.injectBundleURI"));
+		else if (bundle_uri_parse_line(uri, value) < 0)
+			cb->ret = error(_("bad transfer.injectBundleURI: '%s'"),
+					value);
+		return 0;
+	}
+	return 0;
+}
+
 int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 {
 	const struct transport_vtable *vtable = transport->vtable;
+	struct config_cb cb = {
+		.transport = transport,
+	};
 
 	/* Lazily configured */
 	if (transport->got_remote_bundle_uri++)
 		return 0;
 
+	git_config(bundle_uri_config, &cb);
+
+	/* Our own config can fake it up with transport.injectBundleURI */
+	if (cb.configured)
+		return cb.ret;
+
 	/*
 	 * This is intentionally below the transport.injectBundleURI,
 	 * we want to be able to inject into protocol v0, or into the
-- 
2.35.1.1337.g7e32d794afe

