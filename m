Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16427C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbiBWSbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243880AbiBWSbm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B864B403
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s13so12547052wrb.6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b2SPFTkKJp2RnDv9/xes81K08Q/esDVTO6037Hllzsg=;
        b=Z1oEIs5atEDk7bclrgmdt7MB2XI996OIxYSMDNkYxy/yOxfXO4WJVXLxJDKuzdS5jS
         cTzNxrZRo+sToOQAlv2buRzDyYey5x0DwvIXZFVRgza1ECVoMGbEgQS61DHrJJk2aXDy
         9DEDq1CjDORKGd0PTdlXtiYNO8Z21ltnT5k3AQ3RR1iOnqel4SHHmI0zglYL6niqmDlY
         8AvX5HqcJ+N3a10Gpderqt4bp6e6ERXnoT4Hifwo6vvrGrUlU/kAXlQ3t6yBB/RLcq7V
         Rd8gTiZdE190KvPFsh0RZrijyZufb2OPZ+BZtQCgayNEDko8v42p0QBnyE8hj6DPn1tv
         QKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b2SPFTkKJp2RnDv9/xes81K08Q/esDVTO6037Hllzsg=;
        b=1tqBjWXb8R/PEDwQr63jOMiWZGj609Xqh9hzAHwiDahvzufsEOSdJwcogfUvdnmSGp
         DrpFxvAHbjbG04GfrQHguo6hhlsLTMtuBNMUpF0tVMxvxWgYIGueg61nPSln+r1O9NrV
         MCHC0lth5RB7zpXhFtyYfCF4i3E4At+Nw58TE79F1zF1NgvEShAfIhlJ2e/LR4s1d3no
         DbKuJ3dtz6JUYbIQRti/R4oMlvDhYJ+u/jkYwFh3oa4Nd+dIoLMWJhrjUjlUA2KSMnUi
         HvbI7VfmbnyRtLIFZqJjzTOErnF+Mx5PilIWZ58yDWOybDWcUQJKLYJdmYc3eym7HzPo
         DBSw==
X-Gm-Message-State: AOAM533GHT+F+GEc8W7OFy+6RqIrwBECksUVO8f+cpdRTs3wRe/8XXkS
        xJN+4leSrGL+l+2dh6xmGqkMV6imgfA=
X-Google-Smtp-Source: ABdhPJzOOn8G1mCZZUdcfYy2h+DwWrMvZ6utixGafoyR4625A/goEZVh0ax5JFF+kUFEOJlTPmfbLA==
X-Received: by 2002:adf:d1cf:0:b0:1ea:937c:1c89 with SMTP id b15-20020adfd1cf000000b001ea937c1c89mr655188wrd.602.1645641072563;
        Wed, 23 Feb 2022 10:31:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm272599wre.102.2022.02.23.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:12 -0800 (PST)
Message-Id: <ba605c0e4989eb8fabda4836ccd4ee0ef946e1e2.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:45 +0000
Subject: [PATCH 07/25] remote-curl: add 'get' capability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
index 0dabef2dd7c..92beb98631b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1270,6 +1270,33 @@ static void parse_fetch(struct strbuf *buf)
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
@@ -1542,9 +1569,14 @@ int cmd_main(int argc, const char **argv)
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
gitgitgadget

