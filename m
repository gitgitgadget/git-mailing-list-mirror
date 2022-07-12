Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE89C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 20:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiGLUHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiGLUHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 16:07:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E15B3D6C
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 13:07:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z12so12677431wrq.7
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7gDj5Ui6onNCbadxKzljRopMVmi/YIy4v/9uAW3a6U=;
        b=ngviPQgJhsJBvVtC2hXKGOePeEfvykVp9ZWZiw3wPzVz/hKo2RYzQzfmYEeZOhU6Et
         XtLKkmy52+BXqjf9EmopW8GAVcIxICbAe/p7ro9q/NjTGL/r9VdNVTm5wAOuvi92Cw+S
         AeHDP5RZXkBJVIdVP6GSEKEpsoVTlB+dnKmI6rlmytVZVyqhQOk9StCBYvWDrr/yn1kr
         1Z73bzn4ANSK6CxoUwfK5jTOATOxJlIPvT6XF2fFeqekD6YwV0PdDGmFW5oBZYdpRQ09
         u/uhSa8HTBFQSOHXwpFQMQNYZnHunZXr6GCSlUN5ZqsyzlgHPUgdnjJkmGlGMfNc1k5t
         QNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7gDj5Ui6onNCbadxKzljRopMVmi/YIy4v/9uAW3a6U=;
        b=ylvmN1yhvWfUbEVQEB/UXkKioXTwnXwf7EWvzTwnpbZ+xmDZAbAj+FTKYrXknPGzCl
         c2D1jJkTKq40zW7vKl1iOwLGRufQrOqaZ53PeP8iQJPFBFpLV+WfaWZzpCb9WpQNVmfK
         0XMC43QePBQ1Xt0naRlIeh8OT87Dq31NgZ5JzHzr83CD5dLNVGt1l9OVm+xfMi+djXi+
         vQ+QOR8Fwaz5LPKuriMHnFA9vCoVW6Tk5W5GU2A+F/oY21qM8VLOTLtTso/M4M20RM4n
         keoVKXYic0enChuDvvV5yjgs5MMgdErEpAYKdWplQ9MecuFY4sUlC+2fQpDhG8PK5qyf
         LBhQ==
X-Gm-Message-State: AJIora++V7KjgPIAwoMnh8g2uX+6NNYV5M9WO4Ec4VIET5ErbfQsZrdX
        7ebvSwfq2Wr9/8IfchgcceDIV3HrAgQxEw==
X-Google-Smtp-Source: AGRyM1tT5btlu9n+1/eKurk+KgDDRQQK1iYQKOSTZK4ryZJaDaKiLpsmLwS4ROEGUTNv5kHzW0Ehyw==
X-Received: by 2002:a5d:638e:0:b0:21d:68bc:17c8 with SMTP id p14-20020a5d638e000000b0021d68bc17c8mr23913928wru.467.1657656440007;
        Tue, 12 Jul 2022 13:07:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b5-20020adfe305000000b0021d8c8c79dbsm8929448wrj.65.2022.07.12.13.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:07:18 -0700 (PDT)
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
Subject: [PATCH v3 6/7] docs: move http-protocol docs to man section 5
Date:   Tue, 12 Jul 2022 22:07:01 +0200
Message-Id: <patch-v3-6.7-5cf8b526bff-20220712T195419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
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
 Documentation/gitformat-pack-protocol.txt     |  2 +-
 ...otocol.txt => gitformat-protocol-http.txt} | 29 ++++++++++++++++---
 Documentation/gitformat-protocol-v2.txt       |  4 +--
 command-list.txt                              |  1 +
 6 files changed, 33 insertions(+), 11 deletions(-)
 rename Documentation/{technical/http-protocol.txt => gitformat-protocol-http.txt} (98%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 64be37526c1..0e87d5151df 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -34,6 +34,7 @@ MAN5_TXT += gitformat-pack-protocol.txt
 MAN5_TXT += gitformat-pack.txt
 MAN5_TXT += gitformat-protocol-capabilities.txt
 MAN5_TXT += gitformat-protocol-common.txt
+MAN5_TXT += gitformat-protocol-http.txt
 MAN5_TXT += gitformat-protocol-v2.txt
 MAN5_TXT += gitformat-signature.txt
 MAN5_TXT += githooks.txt
@@ -107,7 +108,6 @@ TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/hash-function-transition
-TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/pack-heuristics
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 754619222f6..720697df3a0 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -39,9 +39,9 @@ OPTIONS
 --http-backend-info-refs::
 	Used by linkgit:git-http-backend[1] to serve up
 	`$GIT_URL/info/refs?service=git-upload-pack` requests. See
-	"Smart Clients" in link:technical/http-protocol.html[the HTTP
-	transfer protocols] documentation and "HTTP Transport" in the
-	linkgit:gitformat-protocol-v2[5] documentation. Also understood by
+	"Smart Clients" in linkgit:gitformat-protocol-http[5] and
+	"HTTP Transport" in link:technical/protocol-v2.html[the Git
+	Wire Protocol, Version 2] documentation. Also understood by
 	linkgit:git-receive-pack[1].
 
 <directory>::
diff --git a/Documentation/gitformat-pack-protocol.txt b/Documentation/gitformat-pack-protocol.txt
index f1bfd6705d9..c82b926e661 100644
--- a/Documentation/gitformat-pack-protocol.txt
+++ b/Documentation/gitformat-pack-protocol.txt
@@ -17,7 +17,7 @@ Git supports transferring data in packfiles over the ssh://, git://, http:// and
 file:// transports.  There exist two sets of protocols, one for pushing
 data from a client to a server and another for fetching data from a
 server to a client.  The three transports (ssh, git, file) use the same
-protocol to transfer data. http is documented in http-protocol.txt.
+protocol to transfer data. http is documented in linkgit:gitformat-protocol-http[5].
 
 The processes invoked in the canonical Git implementation are 'upload-pack'
 on the server side and 'fetch-pack' on the client side for fetching data;
diff --git a/Documentation/technical/http-protocol.txt b/Documentation/gitformat-protocol-http.txt
similarity index 98%
rename from Documentation/technical/http-protocol.txt
rename to Documentation/gitformat-protocol-http.txt
index 9d9c7acd512..b85fc86abf6 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/gitformat-protocol-http.txt
@@ -1,5 +1,19 @@
-HTTP transfer protocols
-=======================
+gitformat-protocol-http(5)
+==========================
+
+NAME
+----
+gitformat-protocol-http - Git HTTP-based protocols
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
 linkgit:gitformat-pack-protocol[5]
 linkgit:gitformat-protocol-capabilities[5]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitformat-protocol-v2.txt b/Documentation/gitformat-protocol-v2.txt
index ae4fcc84e37..e29bc4b6a68 100644
--- a/Documentation/gitformat-protocol-v2.txt
+++ b/Documentation/gitformat-protocol-v2.txt
@@ -54,7 +54,7 @@ Initial Client Request
 In general a client can request to speak protocol v2 by sending
 `version=2` through the respective side-channel for the transport being
 used which inevitably sets `GIT_PROTOCOL`.  More information can be
-found in linkgit:gitformat-pack-protocol[5] and `http-protocol.txt`, as well as the
+found in linkgit:gitformat-pack-protocol[5] and linkgit:gitformat-protocol-http[5], as well as the
 `GIT_PROTOCOL` definition in `git.txt`. In all cases the
 response from the server is the capability advertisement.
 
@@ -78,7 +78,7 @@ HTTP Transport
 ~~~~~~~~~~~~~~
 
 When using the http:// or https:// transport a client makes a "smart"
-info/refs request as described in `http-protocol.txt` and requests that
+info/refs request as described in linkgit:gitformat-protocol-http[5] and requests that
 v2 be used by supplying "version=2" in the `Git-Protocol` header.
 
    C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0
diff --git a/command-list.txt b/command-list.txt
index 8cd64c34a7c..fad553784d9 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -218,6 +218,7 @@ gitformat-pack-cruft                    gitformats
 gitformat-pack-protocol                 gitformats
 gitformat-protocol-capabilities         gitformats
 gitformat-protocol-common               gitformats
+gitformat-protocol-http                 gitformats
 gitformat-protocol-v2                   gitformats
 gitformat-signature                     gitformats
 gitglossary                             guide
-- 
2.37.0.932.g7b7031e73bc

