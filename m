Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B468C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352785AbiETSlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348717AbiETSkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:40:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6977E220D9
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f2so12666548wrc.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W72aloNxM/Tcj8Wd/rvxE5MbzvH4i1p/07+4lMHlbqE=;
        b=FF+uM5Jc7a+T8JJTbNvkzajNMs5TgIaIXuRvO9G3LUo4k+FgyO8sk89oTGGYsQyQdc
         K2gOUucvC7A5MthXCJvSyhFH4WvhKfZWAHd3EjxlQuAnPrwKbP+mYcap9aHQmpq573HU
         CvMZi69j5eDa9PQINyu19l0qNil/U1hBw4EnYpTJKJSqEulM54MQ4O6FhAcKLEmGbra0
         0QsetDyr4kVGPKefY8y0Uz8gsszVwj4BTtt5kngqXJZT7rHbINkr/xQz3FqYAE2OguQg
         eFUiWHc9S9gdoqEezoEj/HEqiuN9CS7A5gjIz4wODx9KWnxbCL65T6f5pn/kXfMzowCV
         FE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W72aloNxM/Tcj8Wd/rvxE5MbzvH4i1p/07+4lMHlbqE=;
        b=LO24duRexn7GFb+dwlqOiccjltXMEogyVbgTCPhcO8n4qg3jY0eY9SjqHT/yleL3T4
         X+Ir57eL2hOMM7nNvPHhQkCfobO97IOxc5PMAdX6FMD9zGUmamDMJa3qPGWQgkY7wADY
         aBikyADU1UhyZ5bT5Ax6A7rHwgAwNOcXLHYuleCLEh8g5L1ftXbn6QEvOBzKrp9aY0Mr
         uev6R+AqUKPDe7cr17CYTlsPDBW7Pokn46YQ1swZbhq+9EzKntVPb9FVf/seXJqA7BIi
         SHgjahNBQ5TchUZA70AFEBU0MPnvtufETtw7NSxGV+zi+abXHAqkNHxRmdmiLY9QI8Xf
         Dx8w==
X-Gm-Message-State: AOAM531wy03O7we7OvRUc7Tvtn6kcQIuss6m1lAkcsq+gYLXru27BcbT
        Lyxnb7CiNitOo1skjDFXfqsIRuSPJBo=
X-Google-Smtp-Source: ABdhPJypN3cvR2d0+j4DOA8V/0+RO0Rmdnkna2Q1qGV1vkES6ZJ/nqoniOOCAIShpypyGnYsXz4tTg==
X-Received: by 2002:a05:6000:1682:b0:20e:6de0:a566 with SMTP id y2-20020a056000168200b0020e6de0a566mr7469689wrd.91.1653072046818;
        Fri, 20 May 2022 11:40:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd18-20020a05600c1f1200b003973d0a78casm1321697wmb.38.2022.05.20.11.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:46 -0700 (PDT)
Message-Id: <682326226783d25744ca72fefb61ec0362f7f141.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:20 +0000
Subject: [PATCH 02/24] remote-curl: add 'get' capability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A future change will want a way to download a file over HTTP(S) using
the simplest of download mechanisms. We do not want to assume that the
server on the other side understands anything about the Git protocol but
could be a simple static web server.

Create the new 'get' capability for the remote helpers which advertises
that the 'get' command is avalable. A caller can send a line containing
'get <url> <path>' to download the file at <url> into the file at
<path>.

RFC-TODO: This change requires tests directly on the remote helper.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/gitremote-helpers.txt |  6 ++++++
 remote-curl.c                       | 32 +++++++++++++++++++++++++++++
 t/t6021-fetch-bundle.sh             | 23 +++++++++++++++++++++
 transport-helper.c                  |  5 ++++-
 4 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100755 t/t6021-fetch-bundle.sh

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 6f1e269ae43..f82588601a9 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -168,6 +168,9 @@ Supported commands: 'list', 'import'.
 	Can guarantee that when a clone is requested, the received
 	pack is self contained and is connected.
 
+'get'::
+	Can use the 'get' command to download a file from a given URI.
+
 If a helper advertises 'connect', Git will use it if possible and
 fall back to another capability if the helper requests so when
 connecting (see the 'connect' command under COMMANDS).
@@ -418,6 +421,9 @@ Supported if the helper has the "connect" capability.
 +
 Supported if the helper has the "stateless-connect" capability.
 
+'get' <uri> <path>::
+	Downloads the file from the given `<uri>` to the given `<path>`.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
diff --git a/remote-curl.c b/remote-curl.c
index 67f178b1120..53750d88e76 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1276,6 +1276,33 @@ static void parse_fetch(struct strbuf *buf)
 	strbuf_reset(buf);
 }
 
+static void parse_get(struct strbuf *buf)
+{
+	struct http_get_options opts = { 0 };
+	struct strbuf url = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	const char *p, *space;
+
+	if (!skip_prefix(buf->buf, "get ", &p))
+		die(_("http transport does not support %s"), buf->buf);
+
+	space = strchr(p, ' ');
+
+	if (!space)
+		die(_("protocol error: expected '<url> <path>', missing space"));
+
+	strbuf_add(&url, p, space - p);
+	strbuf_addstr(&path, space + 1);
+
+	http_get_file(url.buf, path.buf, &opts);
+
+	strbuf_release(&url);
+	strbuf_release(&path);
+	printf("\n");
+	fflush(stdout);
+	strbuf_reset(buf);
+}
+
 static int push_dav(int nr_spec, const char **specs)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -1549,9 +1576,14 @@ int cmd_main(int argc, const char **argv)
 				printf("unsupported\n");
 			fflush(stdout);
 
+		} else if (skip_prefix(buf.buf, "get ", &arg)) {
+			parse_get(&buf);
+			fflush(stdout);
+
 		} else if (!strcmp(buf.buf, "capabilities")) {
 			printf("stateless-connect\n");
 			printf("fetch\n");
+			printf("get\n");
 			printf("option\n");
 			printf("push\n");
 			printf("check-connectivity\n");
diff --git a/t/t6021-fetch-bundle.sh b/t/t6021-fetch-bundle.sh
new file mode 100755
index 00000000000..8ae16009ba0
--- /dev/null
+++ b/t/t6021-fetch-bundle.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='test fetching files and bundles over HTTP'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'set up source repo' '
+	git init src &&
+	test_commit -C src one
+'
+
+test_expect_success 'fail to get a file over HTTP' '
+	cat >input <<-EOF &&
+	get $HTTPD_URL/does-not-exist.txt download-failed.txt
+
+	EOF
+	git remote-https "$HTTPD_URL" <input 2>err &&
+	test_path_is_missing download-failed.txt
+'
+
+test_done
diff --git a/transport-helper.c b/transport-helper.c
index b4dbbabb0c2..dfbeaebe40c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -33,7 +33,8 @@ struct helper_data {
 		check_connectivity : 1,
 		no_disconnect_req : 1,
 		no_private_update : 1,
-		object_format : 1;
+		object_format : 1,
+		get : 1;
 
 	/*
 	 * As an optimization, the transport code may invoke fetch before
@@ -210,6 +211,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->no_private_update = 1;
 		} else if (starts_with(capname, "object-format")) {
 			data->object_format = 1;
+		} else if (!strcmp(capname, "get")) {
+			data->get = 1;
 		} else if (mandatory) {
 			die(_("unknown mandatory capability %s; this remote "
 			      "helper probably needs newer version of Git"),
-- 
gitgitgadget

