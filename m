Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1460C433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 15:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A9360F5D
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 15:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhIDPTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 11:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhIDPTA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 11:19:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F23546056B;
        Sat,  4 Sep 2021 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630768678;
        bh=xNL+HaIMJA0SvvqNYM+YxSWXOyEqKWgxbPL78PIkMy0=;
        h=From:To:Cc:Subject:Date:From;
        b=Kjx92dgboW/rbzTNGmKDhtxHRXWC3vRNcCf76LcL3QDtv+gTWwizR0FhfrsaMv+qt
         6dGg62dvhvDAUqEfe/trr+mqyoQTKqOlnfFb50qMlmVpQ5piKy88qPUpD02tMPWTri
         hA5ebQW9Xg2bpiRhhlGkRc/+xQpOb7o0GXMD0ja4=
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
Date:   Sat,  4 Sep 2021 11:17:21 -0400
Message-Id: <20210904151721.445117-1-konstantin@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; h=from:subject; bh=xNL+HaIMJA0SvvqNYM+YxSWXOyEqKWgxbPL78PIkMy0=; b=owGbwMvMwCG27YjM47CUmTmMp9WSGBKNe38E7t304Mve86wLzt0z7JjOON/662ymQwrf9E7s/mT9 YukLjY5SFgYxDgZZMUWWsn2xm4IKH3rIpfeYwsxhZQIZwsDFKQATWfCM4X/QMoFog7JjcxtnHGeJtA 9Z/Yn73cIr69mCLXz6Ha58VjFg+KcUZfxJ1Syn1COVM+hp1ppdeXKzNOsP3eO7LMA11bzuEysA
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp; fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the server-side to properly respond to v2 protocol requests, the
webserver must set the GIT_PROTOCOL environment variable to the value of
the Git-Protocol: request header.

Link: https://lore.kernel.org/git/YTNtVJy6sCfQ7T3L@coredump.intra.peff.net/
Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 Documentation/technical/protocol-v2.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 1040d85319..7a0e97cc8d 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -81,6 +81,21 @@ A v2 server would reply:
 Subsequent requests are then made directly to the service
 `$GIT_URL/git-upload-pack`. (This works the same for git-receive-pack).
 
+The web server handling the requests must properly set the GIT_PROTOCOL
+environment variable when it finds `Git-Protocol` in the request headers.
+
+Apache example:
+
+   SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
+
+Nginx + uwsgi example:
+
+   uwsgi_param GIT_PROTOCOL $http_git_protocol;
+
+Nginx + fastcgi example:
+
+   fastcgi_param GIT_PROTOCOL $http_git_protocol;
+
 Capability Advertisement
 ------------------------
 

base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
-- 
2.31.1

