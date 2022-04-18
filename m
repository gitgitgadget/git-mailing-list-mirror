Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31E9C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347128AbiDRR1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347049AbiDRR1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D60E340D4
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so8634891wml.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sT8WXBO/RMJfeE/24qHChS34dlosgposHdbNtIgPyp0=;
        b=g6QiF0AQuEedhJTfpaiAenQINsXh4bVEBIolkLZHwngkNZAO1OOgAGsWAexjK0XjUy
         +fe3+XC+Li60C7v5qU8lVPAyTG++qDbgyKJiPY5qFQHoTy8LQW6JpUelRP/zqkaT3RRh
         hLvRNPFA8Co7mVZlqWhXVq7QTgrN643BEFGC+q6oaaC+OL99CP3QNm2HbOciJKpgy43S
         jNJMs9R7V8RasgQpdKfeRzDm5PCS5KTwOlYtqCvcGj5/ffx/YQWQF8iCbcCdly7AhVp1
         0LD3OA6E3vYFB4XyjQTyi494VlhSWrog+/8qasdNppw2zb9XoaHxR5K9HdmaA3uP6XTe
         X5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sT8WXBO/RMJfeE/24qHChS34dlosgposHdbNtIgPyp0=;
        b=IArpi95OmppEq6W+QG2Wj/kkzqFDlYIrV1R81IZLcu/hWryBObGlpDej3RBYFMYNWc
         LatSUM4ur4UXRgEFAwnRbSwH9IkO+f0JytMuQLVsv1OKpQdf4f+1VHrVbaP5KO1nulA7
         SwqrnDgOxyvOk0BiAvIf+XDT9DyhSd0trhI3/htOEjHfQeaxZb6j9wQaE1MpLZ80TNM3
         PWJNIKKV0uKaErdcn8f6d2JxrormIk2mu1AIXhjXWqDdt69dkCY5N5ZF4ZVAahfwA3sl
         jgwGKFA1FmHp+ZVEF1b5gqSxq9kHs3xtSNdMxmpxG+KA/fObKD+9hCPQPxTv9R22ywX5
         n6wA==
X-Gm-Message-State: AOAM53389XEFunsOEKhNyQc84ZHQlNY6Ri485Dlr19btzXIgEarVQQOL
        ccQd7Nizsn6Af7rQo9vIrAOJrVwV9QsGRw==
X-Google-Smtp-Source: ABdhPJwqhRoJIQhQ4yxSXV/03Ba/dXo69PyXHLwJD8kjxZTjPkAcBwUQkAIW2LNnXWAllHGpXhnecg==
X-Received: by 2002:a7b:c155:0:b0:38e:b840:c99e with SMTP id z21-20020a7bc155000000b0038eb840c99emr15894257wmi.201.1650302653758;
        Mon, 18 Apr 2022 10:24:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:13 -0700 (PDT)
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
Subject: [RFC PATCH v2 13/36] bundle-uri client: add transfer.injectBundleURI support
Date:   Mon, 18 Apr 2022 19:23:30 +0200
Message-Id: <RFC-patch-v2-13.36-5c50daa92bb-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
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
index d0b15a47ec2..28c095c1224 100644
--- a/t/lib-t5730-protocol-v2-bundle-uri.sh
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -267,3 +267,49 @@ test_expect_success "ls-remote-bundle-uri --[no-]quiet with $T5730_PROTOCOL:// u
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
index e648d3110bb..342e39d81f3 100644
--- a/transport.c
+++ b/transport.c
@@ -1521,14 +1521,47 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
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
2.36.0.rc2.902.g60576bbc845

