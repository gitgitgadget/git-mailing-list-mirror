Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04447C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiG1Qr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiG1QrP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:47:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5099F61733
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:47:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso1336576wmq.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0V0rNEVNlnnNI1y572pOl6cP6hKkEmOavC44n4QWdnk=;
        b=dkbObrF8ICwW9QFjSmBKKVQS7r7ia9xCfqUgZnlF5+3Qi6y5+auSjDHNWZdQ0BqBhS
         P4/C2CFdBl8aRy3N+Mg2uV4HpZiYgl1hIRNYTFs5nIpgark9ikLb+JvQQD5cpBkpMQrH
         AlDCTqD2wBEV6kNp2/b0LUDMNTVFwkyEkXjLHz3DCaAS5Vr0gSRHfWpXzfybF9sNF2NP
         Bc5CbAISPD2hxrcpmX9bZpqVRXPUsfwip3en+8LZ7ExxVF0Acr90n4NNejYxy0rQHbz2
         wQir3VErCaMxO0QGDEsU3+jHVgMwHPntthzVBsGdz2hMLgo+0SBClj6iI5iX9mcpDKNh
         h+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0V0rNEVNlnnNI1y572pOl6cP6hKkEmOavC44n4QWdnk=;
        b=wxCnetdp7JrazyFk5wSPUVS5GzSV3N+y4L413IWee61hY1lLalIm1jQLMamtwEnqyz
         xeCEJwUvOBUTrsJCMD1gGuRsqLkDaAZ+5leV1y1Zu76RKz4iEfS6QLO6fhEW1h2x5s5V
         gt1p3HIk0zqNKuQKJyFa/8SBI0htgUVVJ1nTCeVIlaMvyOGOwgu+O/K5rwEweDtyVarY
         rm2kjGptHFAGpf+b2Nyy2ZgAWF88WVTdukVGiFeL/CscwNyH5BXIZdv8UeYcZJMnQZ+N
         KsnOz094EU/i8ZuBcOg43YZEDkaNszIvecrQiHD5DG9+B+IGFcJbjaQ7yPAcnylOAVMO
         kBPQ==
X-Gm-Message-State: AJIora9NrYyYaedz+7QZXYbkfBFTq09KSyBkeOWbUeMiHHtJmIRcQUKG
        U4bnDE7TZ2BWGGhaTvtUzHTmSUdzcK60Gg==
X-Google-Smtp-Source: AGRyM1u36ylsV3q+XyjNidBqmBWbrt+osNKm0PQqd58LSoTta2MNxwnSQUvQWfwD87R5qml31gjloA==
X-Received: by 2002:a05:600c:384c:b0:3a3:744d:8dd2 with SMTP id s12-20020a05600c384c00b003a3744d8dd2mr179603wmr.117.1659026825518;
        Thu, 28 Jul 2022 09:47:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6043000000b0021efc75914esm1495403wrt.79.2022.07.28.09.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:47:03 -0700 (PDT)
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
Subject: [PATCH v6 8/9] docs: move http-protocol docs to man section 5
Date:   Thu, 28 Jul 2022 18:46:47 +0200
Message-Id: <patch-v6-8.9-a8a883ebf85-20220728T164243Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
References: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com> <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
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
index cd09ccd8c13..6efac142e3e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -37,6 +37,7 @@ MAN5_TXT += gitmailmap.txt
 MAN5_TXT += gitmodules.txt
 MAN5_TXT += gitprotocol-capabilities.txt
 MAN5_TXT += gitprotocol-common.txt
+MAN5_TXT += gitprotocol-http.txt
 MAN5_TXT += gitprotocol-pack.txt
 MAN5_TXT += gitprotocol-v2.txt
 MAN5_TXT += gitrepository-layout.txt
@@ -107,7 +108,6 @@ TECH_DOCS += SubmittingPatches
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
index 4f30a6c30c8..e3a5d417792 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -225,6 +225,7 @@ gitmodules                              userinterfaces
 gitnamespaces                           guide
 gitprotocol-capabilities                developerinterfaces
 gitprotocol-common                      developerinterfaces
+gitprotocol-http                       developerinterfaces
 gitprotocol-pack                        developerinterfaces
 gitprotocol-v2                          developerinterfaces
 gitremote-helpers                       guide
-- 
2.37.1.1197.g7ed548b7807

