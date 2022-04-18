Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B417DC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347048AbiDRR2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347031AbiDRR1H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF840344E8
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so8635010wml.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uwv3ATPGIcsL6IoKarM6AcLLCW1ewl0sGTUCtMEDj94=;
        b=Jg3DvTu4hyMRcQ7ocVjqBQtXGfCyRxa7dXRUKNOTmb3Xkae8tMC6BlU3OZn2PN8O+I
         424Snej4G0tujrm2VSW0cXM78s5fdonFABnQSM2jcsBdG3KU7pCx9yO2PlIO0G3D8F5C
         QGh+Wqi008mdtOv7BBebXrLFuAexYumCI9SHedyfWkdQD6WZ5i2bZbBGO3PUclDSRrcY
         xpx4GkcTXPZC7T8/oxXrf9z/p9G404Prs00n+iZZG1XGCI9GRONHYRLr0Ipz0CcP6UgK
         lTh8CT39yVc1KdbVZML9QvQxRanD85/QgpcItZ/lie2gSEoxMBukSyCp2WoDzVu3S34y
         H/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uwv3ATPGIcsL6IoKarM6AcLLCW1ewl0sGTUCtMEDj94=;
        b=YTY/pQaJn6E/IRbdbtGz3UB+rjgeOEMmorR1mpmzshyC9BEODJtrYdLBlRlalwjcQ1
         GbouKMqIZ5vyK9Aqjg4XNC001XNC6UUwz6VsxoRBjyy1OaW+NZKQtjXqC+gK8HsNqKGb
         i2DEm1QuSaa0zAmdbwpcixdYR2oghqyzdsZ53M/CfCWU0t5Zb2zouqOXwETWO3OZLHZ0
         d5mKhRGzPSzyhxSTCkKfNDot+XZSY9NO7q6GmphD7bSB3qQSdCPtxBlXZ8zbI5JwB3NG
         0pJr24611/CE3RJ73anxH/QHgx+bj3TwklI89s17Oa+D9cIG6SCzY/rSwxg658nw1Er2
         U+MA==
X-Gm-Message-State: AOAM531ER75zRzPXlMwOGcLnQNk5pF7Ak76GEb9+POAi5sALAsnA+1ks
        4PnY8wwN4cCeeLrGK9UYwsqKm8Tx/MMSdg==
X-Google-Smtp-Source: ABdhPJwzRZMeqEsp64w5UwSORo2yLeg6R+QBMuBvx0ImvJiE+VDdC7ZnLwTCmzbBWu0fL2Q5O9Zzrw==
X-Received: by 2002:a1c:a101:0:b0:392:942f:3aa with SMTP id k1-20020a1ca101000000b00392942f03aamr6809944wme.1.1650302658066;
        Mon, 18 Apr 2022 10:24:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 17/36] remote-curl: add 'get' capability
Date:   Mon, 18 Apr 2022 19:23:34 +0200
Message-Id: <RFC-patch-v2-17.36-8ac5bfca545-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 2 files changed, 38 insertions(+)

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
-- 
2.36.0.rc2.902.g60576bbc845

