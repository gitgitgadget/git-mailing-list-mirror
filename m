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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695A2C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E7060EEA
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbhHEPIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbhHEPH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E940AC06179C
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m12so6984237wru.12
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgGF/4aXVhq6+B0j6d+3xu8KkDs5gOjRcJ/GTiaRotU=;
        b=TMcH1oqA9yz4fuA/ooI0Px0W0lTZllhBMdnraTdqRCX1j3ra581XragtWVsdMOUqK8
         Vw0+Q+RzJz2k0nJGKZO8B1+QyUjnxVvZX5FoTRqL6bRu1Uapm6K4fjKbtFPVMKgXlinU
         Rr5//49EywD7fIltKeL6LLUD9giM+6P6b27S/fBTJw7uvztlXUVX3/038mB+z4rjOF6b
         eLjq0KfGziZtE6v23tyroXbQN18irWA1Fr6ZzofofD3XmfmwPhCl60mOKIbTbO6Udtg4
         3fmFSJkH7ZjSjrxqeoMbh5bhF5vspvJ7Qrzgsl9L6uftxplQeodyqJsDkbPMeRcOlk/D
         z7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgGF/4aXVhq6+B0j6d+3xu8KkDs5gOjRcJ/GTiaRotU=;
        b=UZtO1WMVwh81we9+EjUE6e1NtaYubHJIusvKNVbSReQIOChkT7OXl5AuAtBd/dkGa0
         84Tk0oR9YwbEgil86dnVm7UoG+jRl3jCnWEQCnrQnhOyax3d/SPCKcUU1GnA24sIOgvk
         hXd5EVPlSIG2/Z0AtNl4OgW2rXStzgt9eYbiRb5UO3Sz4MLeNLix4O+XnzrTO1OCy95Q
         pKbjNyywSwUHYDlkO6gNniC64ngMwAh2GrdjxHNucDnv3ROq0AkgJNBH/VrRDsO7kPl2
         UJIl2XahoUPPUbEP4HdRh1sqH1Y9jsSWLqkN+enx528x/sF0TdWZ39rm45kuedXi58+E
         afmQ==
X-Gm-Message-State: AOAM532j7QrZIBp47bBVSyuAxnXUr80PRixEaOK0lk7Mpzg5ue6PeKXj
        xbcxXFRjft/5iZW55Gw9QFa7ScG8mTPwbg==
X-Google-Smtp-Source: ABdhPJysoFtAb0QjK5bZLJUal1fVq9D4cxdDLN0MwWnmt59CCvhpUU9aDDwdizc8TNFZbtEwtUdcDg==
X-Received: by 2002:adf:a409:: with SMTP id d9mr5825833wra.237.1628176061268;
        Thu, 05 Aug 2021 08:07:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 06/13] bundle-uri client: add transfer.injectBundleURI support
Date:   Thu,  5 Aug 2021 17:07:22 +0200
Message-Id: <RFC-patch-06.13-3427cb4de7-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
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
index 505126a780..a9aff7f982 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -73,3 +73,23 @@ transfer.unpackLimit::
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
index fccf7ccaa2..e5d17f6a81 100644
--- a/t/lib-t5730-protocol-v2-bundle-uri.sh
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -270,3 +270,49 @@ test_expect_success "ls-remote-bundle-uri --[no-]quiet with $T5730_PROTOCOL:// u
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
index 286c96269d..bd8a914652 100644
--- a/transport.c
+++ b/transport.c
@@ -1501,14 +1501,47 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
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
2.33.0.rc0.646.g585563e77f

