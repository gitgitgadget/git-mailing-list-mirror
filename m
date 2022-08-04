Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBAFC19F2D
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiHDQ3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbiHDQ3U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:29:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068CA6A484
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:29:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m41-20020a05600c3b2900b003a4e094256eso148252wms.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Fp6tEU+fWUh5+hVL19oAmS9mtY+H2xLgHIhMwYkEgdg=;
        b=QYE89kZQRhpnfwS5AHWh0nngfhnWjtKilWorxDEdfMcVJ6QMn4F69uHDFvq74iDh45
         VQF8mrM/6lvfHzyDzTTj3HNTiVHh3mm8c3E1FmacWY6lKHh/RpTagIuGrdTwN+8Vb+WT
         9J6yibrI60COKy48RNHF4YjrqGYdIyO+bhqOuYpjxgOkaEpvtDrNvVgtN2+N75FU8Jyj
         HCSwrwTN2VmJQ6gxMTvfoVf8CYauwuNjMLhJEB6U9q+J4ip5SxQBR/0pmyaWw2Kgy1a5
         6MJGPxzeEx2Kfix0Vtu6oaveCN6qMrOcx7FZKeAvmUk2r5kzr12QswbeRRicXvFTMA1x
         VhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Fp6tEU+fWUh5+hVL19oAmS9mtY+H2xLgHIhMwYkEgdg=;
        b=6NB0UY0R+Oatye4iCEYb+tjUMBUmm1fqEAEsQfDli5I6i6NG+gFJkZ4Y6SfKQ9j1qH
         ldtHeqwii5NdVe+j477m+QqAbcBbpNtGU0p55ZsvgklL3xp+ZCoCk0Dql/DdIv5y+Fj1
         r03HVp4o1m3ijrJpYS1MwttzZOj9IsEEXCn/N8xoTYrNHn2ch2YGSkJFZfRzypYqWnK2
         mVHLbD0vkfwgmhWvRykR8C1iF7BpIDv2tA80NhRxNvW/rn62jVUDxwQkafk6pv4IA8HJ
         gBT4zFnUollzfYTAUwm2NSPn54uD5fWv0SBMJmUTDNMEfp9F++fpEnQCk89di5qFGi5o
         +qNQ==
X-Gm-Message-State: ACgBeo1Tfabk18eYHgLLlju272Xybmb0yRbppxUWBEJosnBKL+e92QhJ
        HAolNUf8TaZzrZSux6sRvXKCZk5BWbxsqw==
X-Google-Smtp-Source: AA6agR5YnlmPOoA1CYSOCJTosfyMotUDqda/U27PVle+tDkaQmH0BUlPVvMUQ4UZQoaivbAA9GiY5w==
X-Received: by 2002:a7b:cd15:0:b0:3a3:1d69:5201 with SMTP id f21-20020a7bcd15000000b003a31d695201mr2069775wmj.10.1659630544847;
        Thu, 04 Aug 2022 09:29:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a513ee7830sm1868063wme.27.2022.08.04.09.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:29:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 12/12] docs: move http-protocol docs to man section 5
Date:   Thu,  4 Aug 2022 18:28:41 +0200
Message-Id: <patch-v8-12.12-c572688c525-20220804T162138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.g61622908797
In-Reply-To: <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com> <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the move of existing Documentation/technical/* protocol and
file-format documentation into our main documentation space by moving
the http-protocol.txt documentation over. I'm renaming it to
"protocol-http" to be consistent with other things in the new
gitformat-protocol-* namespace.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  2 +-
 Documentation/git-upload-pack.txt             |  6 ++--
 ...http-protocol.txt => gitprotocol-http.txt} | 29 ++++++++++++++++---
 Documentation/gitprotocol-pack.txt            |  2 +-
 Documentation/gitprotocol-v2.txt              |  4 +--
 command-list.txt                              |  1 +
 6 files changed, 33 insertions(+), 11 deletions(-)
 rename Documentation/{technical/http-protocol.txt => gitprotocol-http.txt} (98%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 41a070ab593..346bbcf8be7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -36,6 +36,7 @@ MAN5_TXT += gitmailmap.txt
 MAN5_TXT += gitmodules.txt
 MAN5_TXT += gitprotocol-capabilities.txt
 MAN5_TXT += gitprotocol-common.txt
+MAN5_TXT += gitprotocol-http.txt
 MAN5_TXT += gitprotocol-pack.txt
 MAN5_TXT += gitprotocol-v2.txt
 MAN5_TXT += gitrepository-layout.txt
@@ -106,7 +107,6 @@ TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/hash-function-transition
-TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/pack-heuristics
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 3409e0d36d1..3f89d640772 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -39,9 +39,9 @@ OPTIONS
 --http-backend-info-refs::
 	Used by linkgit:git-http-backend[1] to serve up
 	`$GIT_URL/info/refs?service=git-upload-pack` requests. See
-	"Smart Clients" in link:technical/http-protocol.html[the HTTP
-	transfer protocols] documentation and "HTTP Transport" in the
-	linkgit:gitprotocol-v2[5] documentation. Also understood by
+	"Smart Clients" in linkgit:gitprotocol-http[5] and "HTTP
+	Transport" in in the linkgit:gitprotocol-v2[5]
+	documentation. Also understood by
 	linkgit:git-receive-pack[1].
 
 <directory>::
diff --git a/Documentation/technical/http-protocol.txt b/Documentation/gitprotocol-http.txt
similarity index 98%
rename from Documentation/technical/http-protocol.txt
rename to Documentation/gitprotocol-http.txt
index 8bd672d55bb..ccc13f0a407 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/gitprotocol-http.txt
@@ -1,5 +1,19 @@
-HTTP transfer protocols
-=======================
+gitprotocol-http(5)
+===================
+
+NAME
+----
+gitprotocol-http - Git HTTP-based protocols
+
+
+SYNOPSIS
+--------
+[verse]
+<over-the-wire-protocol>
+
+
+DESCRIPTION
+-----------
 
 Git supports two HTTP based transfer protocols.  A "dumb" protocol
 which requires only a standard HTTP server on the server end of the
@@ -512,11 +526,18 @@ the id obtained through ref discovery as old_id.
 
 TODO: Document this further.
 
-
-References
+REFERENCES
 ----------
 
 http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
 http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
+
+SEE ALSO
+--------
+
 linkgit:gitprotocol-pack[5]
 linkgit:gitprotocol-capabilities[5]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitprotocol-pack.txt b/Documentation/gitprotocol-pack.txt
index 93b30b88450..dd4108b7a3b 100644
--- a/Documentation/gitprotocol-pack.txt
+++ b/Documentation/gitprotocol-pack.txt
@@ -17,7 +17,7 @@ Git supports transferring data in packfiles over the ssh://, git://, http:// and
 file:// transports.  There exist two sets of protocols, one for pushing
 data from a client to a server and another for fetching data from a
 server to a client.  The three transports (ssh, git, file) use the same
-protocol to transfer data. http is documented in http-protocol.txt.
+protocol to transfer data. http is documented in linkgit:gitprotocol-http[5].
 
 The processes invoked in the canonical Git implementation are 'upload-pack'
 on the server side and 'fetch-pack' on the client side for fetching data;
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index d6105e07408..c9c0f9160b2 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -53,7 +53,7 @@ Initial Client Request
 In general a client can request to speak protocol v2 by sending
 `version=2` through the respective side-channel for the transport being
 used which inevitably sets `GIT_PROTOCOL`.  More information can be
-found in linkgit:gitprotocol-pack[5] and `http-protocol.txt`, as well as the
+found in linkgit:gitprotocol-pack[5] and linkgit:gitprotocol-http[5], as well as the
 `GIT_PROTOCOL` definition in `git.txt`. In all cases the
 response from the server is the capability advertisement.
 
@@ -77,7 +77,7 @@ HTTP Transport
 ~~~~~~~~~~~~~~
 
 When using the http:// or https:// transport a client makes a "smart"
-info/refs request as described in `http-protocol.txt` and requests that
+info/refs request as described in linkgit:gitprotocol-http[5] and requests that
 v2 be used by supplying "version=2" in the `Git-Protocol` header.
 
    C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0
diff --git a/command-list.txt b/command-list.txt
index 5394eefb6ee..f96bdabd7d9 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -224,6 +224,7 @@ gitmodules                              userinterfaces
 gitnamespaces                           guide
 gitprotocol-capabilities                developerinterfaces
 gitprotocol-common                      developerinterfaces
+gitprotocol-http                        developerinterfaces
 gitprotocol-pack                        developerinterfaces
 gitprotocol-v2                          developerinterfaces
 gitremote-helpers                       guide
-- 
2.37.1.1233.g61622908797

