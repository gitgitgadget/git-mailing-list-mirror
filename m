Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDEFC19F28
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiHBM6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbiHBM6K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:58:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337EF15FC1
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:58:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso3093997wme.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IP8pd/9PNNEE3llshjGOZ7KuaI8sljZivdRQ7GbvJjA=;
        b=iEokziOCRdaWEu7wFnN5NfW/Ya2QC4xi9i1AWfjtpH7gHd3i0jpfW149qiBXOW6Gku
         l5gGW8FM4SEIi8hyxeowuaC/11UbnJ62cX7brXq9A1P2N7FTgwoAcLoVa1yl2rPUyrgM
         DMEe2lFku3fPmemRyCYtjRcOfl/tLyQwTLSKkltjPXTcmtQYGkRo8PSJt9sewdABSXNC
         MfYOnAblI3L2ROY1oSZOzNCMNoh4excSmKFjqk2JmgbNM/4mONYheL5VhAVk/uQoy9uf
         k4dQ3QObjMkAUE9Wz+CN0Rjqp9BIH6WMED3XaHtknOPkcNn9lzHzQg+ssWyOxssS0h6X
         yKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IP8pd/9PNNEE3llshjGOZ7KuaI8sljZivdRQ7GbvJjA=;
        b=bEu92I4WcNsoOQnsENK+UxESyL7HsruldQ5iuDXrKiOlE6rzFMTtPjGuCEralPwr7p
         x7JioI/V6gxLU1iTAC1eCihJNC3h1MYDCTFiCZKr4FhvZioWfVGmjpp+qu3q2LZ52+/7
         6rec7RESTCIarp63A3ysLmwG2Xl2rC9nzrbkbYo3KElu+95CNknIhB6A5nemcR+ax11x
         31vFxBA9tjGNclrgS36I1YkmzT4dOSFFjeNXMICQuG9vvQv9RfFkHT0bIHZfN5mLnADg
         kHUWdunlVclgXxHkWjGR/HkPQVG9Fc2wcQJJwhFz+2X6Xmav+da8KGwNBZylOehIOlPr
         R9cQ==
X-Gm-Message-State: AJIora9/Vh1LYm6tQ3zlgHMcNErfW7hAalRRaJi7AIPgu+96ISUMnnuB
        VXXa1jCy/Prful7vkVgQLKXbm5FsDUdkOw==
X-Google-Smtp-Source: AGRyM1uFAdBisg8tMAyLxhsdrPmJFJp1eyJCM2SbbvvXw5Gd1n7/F6pEiR9iPHWouoGdMOPkkliSGw==
X-Received: by 2002:a7b:c7d2:0:b0:3a3:209d:cdc6 with SMTP id z18-20020a7bc7d2000000b003a3209dcdc6mr14629929wmk.55.1659445086123;
        Tue, 02 Aug 2022 05:58:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t4-20020adfeb84000000b0021e45afa7b0sm15056145wrn.109.2022.08.02.05.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:58:05 -0700 (PDT)
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
Subject: [PATCH v7 07/10] docs: move protocol-related docs to man section 5
Date:   Tue,  2 Aug 2022 14:56:56 +0200
Message-Id: <patch-v7-07.10-cfd1b0afb53-20220802T125258Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1232.gc0cde427aa7
In-Reply-To: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the move of existing Documentation/technical/* protocol and
file-format documentation into our main documentation space. By moving
the things that discuss the protocol we can properly link from
e.g. lsrefs.unborn and protocol.version documentation to a manpage we
build by default.

So far we have been using the "gitformat-" prefix for the
documentation we've been moving over from Documentation/technical/*,
but for protocol documentation let's use "gitprotocol-*".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  8 +++---
 Documentation/config/lsrefs.txt               |  2 +-
 Documentation/config/protocol.txt             |  2 +-
 Documentation/git-upload-pack.txt             |  5 ++--
 Documentation/gitformat-bundle.txt            |  2 +-
 ...ities.txt => gitprotocol-capabilities.txt} | 28 +++++++++++++++----
 ...ocol-common.txt => gitprotocol-common.txt} | 23 +++++++++++++--
 ...pack-protocol.txt => gitprotocol-pack.txt} | 24 +++++++++++++---
 .../protocol-v2.txt => gitprotocol-v2.txt}    | 25 +++++++++++++----
 Documentation/technical/api-simple-ipc.txt    |  2 +-
 Documentation/technical/http-protocol.txt     |  6 ++--
 .../long-running-process-protocol.txt         |  2 +-
 Documentation/technical/packfile-uri.txt      |  2 +-
 Documentation/technical/partial-clone.txt     |  2 +-
 command-list.txt                              |  5 +++-
 refspec.h                                     |  2 +-
 t/t5551-http-fetch-smart.sh                   |  4 +--
 17 files changed, 106 insertions(+), 38 deletions(-)
 rename Documentation/{technical/protocol-capabilities.txt => gitprotocol-capabilities.txt} (96%)
 rename Documentation/{technical/protocol-common.txt => gitprotocol-common.txt} (89%)
 rename Documentation/{technical/pack-protocol.txt => gitprotocol-pack.txt} (98%)
 rename Documentation/{technical/protocol-v2.txt => gitprotocol-v2.txt} (98%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e7bd72bb84e..b53f3c12843 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -30,6 +30,10 @@ MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
 MAN5_TXT += gitmailmap.txt
 MAN5_TXT += gitmodules.txt
+MAN5_TXT += gitprotocol-capabilities.txt
+MAN5_TXT += gitprotocol-common.txt
+MAN5_TXT += gitprotocol-pack.txt
+MAN5_TXT += gitprotocol-v2.txt
 MAN5_TXT += gitrepository-layout.txt
 MAN5_TXT += gitweb.conf.txt
 
@@ -105,12 +109,8 @@ TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/pack-format
 TECH_DOCS += technical/pack-heuristics
-TECH_DOCS += technical/pack-protocol
 TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
-TECH_DOCS += technical/protocol-capabilities
-TECH_DOCS += technical/protocol-common
-TECH_DOCS += technical/protocol-v2
 TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/reftable
 TECH_DOCS += technical/send-pack-pipeline
diff --git a/Documentation/config/lsrefs.txt b/Documentation/config/lsrefs.txt
index adeda0f24d3..3d88fb0badb 100644
--- a/Documentation/config/lsrefs.txt
+++ b/Documentation/config/lsrefs.txt
@@ -1,7 +1,7 @@
 lsrefs.unborn::
 	May be "advertise" (the default), "allow", or "ignore". If "advertise",
 	the server will respond to the client sending "unborn" (as described in
-	protocol-v2.txt) and will advertise support for this feature during the
+	linkgit:gitprotocol-v2[5]) and will advertise support for this feature during the
 	protocol v2 capability advertisement. "allow" is the same as
 	"advertise" except that the server will not advertise support for this
 	feature; this is useful for load-balanced servers that cannot be
diff --git a/Documentation/config/protocol.txt b/Documentation/config/protocol.txt
index 756591d77b0..57603818514 100644
--- a/Documentation/config/protocol.txt
+++ b/Documentation/config/protocol.txt
@@ -58,6 +58,6 @@ protocol.version::
 * `1` - the original wire protocol with the addition of a version string
   in the initial response from the server.
 
-* `2` - link:technical/protocol-v2.html[wire protocol version 2].
+* `2` - Wire protocol version 2, see linkgit:gitprotocol-v2[5].
 
 --
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 8f87b23ea86..3409e0d36d1 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -40,9 +40,8 @@ OPTIONS
 	Used by linkgit:git-http-backend[1] to serve up
 	`$GIT_URL/info/refs?service=git-upload-pack` requests. See
 	"Smart Clients" in link:technical/http-protocol.html[the HTTP
-	transfer protocols] documentation and "HTTP Transport" in
-	link:technical/protocol-v2.html[the Git Wire Protocol, Version
-	2] documentation. Also understood by
+	transfer protocols] documentation and "HTTP Transport" in the
+	linkgit:gitprotocol-v2[5] documentation. Also understood by
 	linkgit:git-receive-pack[1].
 
 <directory>::
diff --git a/Documentation/gitformat-bundle.txt b/Documentation/gitformat-bundle.txt
index 6a9d9e5bf6f..00e0a20e657 100644
--- a/Documentation/gitformat-bundle.txt
+++ b/Documentation/gitformat-bundle.txt
@@ -27,7 +27,7 @@ FORMAT
 ------
 
 We will use ABNF notation to define the Git bundle format. See
-link:technical/protocol-common.html for the details.
+linkgit:gitprotocol-common[5] for the details.
 
 A v2 bundle looks like this:
 
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/gitprotocol-capabilities.txt
similarity index 96%
rename from Documentation/technical/protocol-capabilities.txt
rename to Documentation/gitprotocol-capabilities.txt
index 9dfade930da..c6dcc7d565d 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/gitprotocol-capabilities.txt
@@ -1,8 +1,20 @@
-Git Protocol Capabilities
-=========================
+gitprotocol-capabilities(5)
+===========================
+
+NAME
+----
+gitprotocol-capabilities - Protocol v0 and v1 capabilities
+
+SYNOPSIS
+--------
+[verse]
+<over-the-wire-protocol>
+
+DESCRIPTION
+-----------
 
 NOTE: this document describes capabilities for versions 0 and 1 of the pack
-protocol. For version 2, please refer to the link:protocol-v2.html[protocol-v2]
+protocol. For version 2, please refer to the linkgit:gitprotocol-v2[5]
 doc.
 
 Servers SHOULD support all capabilities defined in this document.
@@ -77,7 +89,7 @@ interleaved with S-R-Q.
 multi_ack_detailed
 ------------------
 This is an extension of multi_ack that permits client to better
-understand the server's in-memory state. See pack-protocol.txt,
+understand the server's in-memory state. See linkgit:gitprotocol-pack[5],
 section "Packfile Negotiation" for more information.
 
 no-done
@@ -281,7 +293,7 @@ a packfile upload and reference update.  If the pushing client requests
 this capability, after unpacking and updating references the server
 will respond with whether the packfile unpacked successfully and if
 each reference was updated successfully.  If any of those were not
-successful, it will send back an error message.  See pack-protocol.txt
+successful, it will send back an error message.  See linkgit:gitprotocol-pack[5]
 for example messages.
 
 report-status-v2
@@ -292,7 +304,7 @@ adding new "option" directives in order to support reference rewritten by
 the "proc-receive" hook.  The "proc-receive" hook may handle a command
 for a pseudo-reference which may create or update a reference with
 different name, new-oid, and old-oid.  While the capability
-'report-status' cannot report for such case.  See pack-protocol.txt
+'report-status' cannot report for such case.  See linkgit:gitprotocol-pack[5]
 for details.
 
 delete-refs
@@ -378,3 +390,7 @@ packet-line, and must not contain non-printable or whitespace characters. The
 current implementation uses trace2 session IDs (see
 link:api-trace2.html[api-trace2] for details), but this may change and users of
 the session ID should not rely on this fact.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/protocol-common.txt b/Documentation/gitprotocol-common.txt
similarity index 89%
rename from Documentation/technical/protocol-common.txt
rename to Documentation/gitprotocol-common.txt
index ecedb34bba5..1486651bd10 100644
--- a/Documentation/technical/protocol-common.txt
+++ b/Documentation/gitprotocol-common.txt
@@ -1,5 +1,20 @@
-Documentation Common to Pack and Http Protocols
-===============================================
+gitprotocol-common(5)
+=====================
+
+NAME
+----
+gitprotocol-common - Things common to various protocols
+
+SYNOPSIS
+--------
+[verse]
+<over-the-wire-protocol>
+
+DESCRIPTION
+-----------
+
+This document sets defines things common to various over-the-wire
+protocols and file formats used in Git.
 
 ABNF Notation
 -------------
@@ -97,3 +112,7 @@ Examples (as C-style strings):
   "000bfoobar\n"    "foobar\n"
   "0004"            ""
 ----
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/gitprotocol-pack.txt
similarity index 98%
rename from Documentation/technical/pack-protocol.txt
rename to Documentation/gitprotocol-pack.txt
index e13a2c064d1..8a4de6decd0 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/gitprotocol-pack.txt
@@ -1,5 +1,17 @@
-Packfile transfer protocols
-===========================
+gitprotocol-pack(5)
+===================
+
+NAME
+----
+gitprotocol-pack - How packs are transferred over-the-wire
+
+SYNOPSIS
+--------
+[verse]
+<over-the-wire-protocol>
+
+DESCRIPTION
+-----------
 
 Git supports transferring data in packfiles over the ssh://, git://, http:// and
 file:// transports.  There exist two sets of protocols, one for pushing
@@ -18,7 +30,7 @@ pkt-line Format
 ---------------
 
 The descriptions below build on the pkt-line format described in
-protocol-common.txt. When the grammar indicate `PKT-LINE(...)`, unless
+linkgit:gitprotocol-common[5]. When the grammar indicate `PKT-LINE(...)`, unless
 otherwise noted the usual pkt-line LF rules apply: the sender SHOULD
 include a LF, but the receiver MUST NOT complain if it is not present.
 
@@ -60,7 +72,7 @@ Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
 
 Servers that receive any such Extra Parameters MUST ignore all
 unrecognized keys. Currently, the only Extra Parameter recognized is
-"version" with a value of '1' or '2'.  See protocol-v2.txt for more
+"version" with a value of '1' or '2'.  See linkgit:gitprotocol-v2[5] for more
 information on protocol version 2.
 
 Git Transport
@@ -707,3 +719,7 @@ An example client/server communication might look like this:
    S: 0018ok refs/heads/debug\n
    S: 002ang refs/heads/master non-fast-forward\n
 ----
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/gitprotocol-v2.txt
similarity index 98%
rename from Documentation/technical/protocol-v2.txt
rename to Documentation/gitprotocol-v2.txt
index 8a877d27e23..d6105e07408 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -1,5 +1,17 @@
-Git Wire Protocol, Version 2
-============================
+gitprotocol-v2(5)
+=================
+
+NAME
+----
+gitprotocol-v2 - Git Wire Protocol, Version 2
+
+SYNOPSIS
+--------
+[verse]
+<over-the-wire-protocol>
+
+DESCRIPTION
+-----------
 
 This document presents a specification for a version 2 of Git's wire
 protocol.  Protocol v2 will improve upon v1 in the following ways:
@@ -26,8 +38,7 @@ Packet-Line Framing
 -------------------
 
 All communication is done using packet-line framing, just as in v1.  See
-`Documentation/technical/pack-protocol.txt` and
-`Documentation/technical/protocol-common.txt` for more information.
+linkgit:gitprotocol-pack[5] and linkgit:gitprotocol-common[5] for more information.
 
 In protocol v2 these special packets will have the following semantics:
 
@@ -42,7 +53,7 @@ Initial Client Request
 In general a client can request to speak protocol v2 by sending
 `version=2` through the respective side-channel for the transport being
 used which inevitably sets `GIT_PROTOCOL`.  More information can be
-found in `pack-protocol.txt` and `http-protocol.txt`, as well as the
+found in linkgit:gitprotocol-pack[5] and `http-protocol.txt`, as well as the
 `GIT_PROTOCOL` definition in `git.txt`. In all cases the
 response from the server is the capability advertisement.
 
@@ -566,3 +577,7 @@ and associated requested information, each separated by a single space.
 	attr = "size"
 
 	obj-info = obj-id SP obj-size
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.txt
index d79ad323e67..d44ada98e7d 100644
--- a/Documentation/technical/api-simple-ipc.txt
+++ b/Documentation/technical/api-simple-ipc.txt
@@ -78,7 +78,7 @@ client and an optional response message from the server.  Both the
 client and server messages are unlimited in length and are terminated
 with a flush packet.
 
-The pkt-line routines (Documentation/technical/protocol-common.txt)
+The pkt-line routines (linkgit:gitprotocol-common[5])
 are used to simplify buffer management during message generation,
 transmission, and reception.  A flush packet is used to mark the end
 of the message.  This allows the sender to incrementally generate and
diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index cc5126cfeda..8bd672d55bb 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -222,7 +222,7 @@ smart server reply:
    S: 0000
 
 The client may send Extra Parameters (see
-Documentation/technical/pack-protocol.txt) as a colon-separated string
+linkgit:gitprotocol-pack[5]) as a colon-separated string
 in the Git-Protocol HTTP header.
 
 Uses the `--http-backend-info-refs` option to
@@ -518,5 +518,5 @@ References
 
 http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
 http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
-link:technical/pack-protocol.html
-link:technical/protocol-capabilities.html
+linkgit:gitprotocol-pack[5]
+linkgit:gitprotocol-capabilities[5]
diff --git a/Documentation/technical/long-running-process-protocol.txt b/Documentation/technical/long-running-process-protocol.txt
index aa0aa9af1c2..6f33654b428 100644
--- a/Documentation/technical/long-running-process-protocol.txt
+++ b/Documentation/technical/long-running-process-protocol.txt
@@ -3,7 +3,7 @@ Long-running process protocol
 
 This protocol is used when Git needs to communicate with an external
 process throughout the entire life of a single Git command. All
-communication is in pkt-line format (see technical/protocol-common.txt)
+communication is in pkt-line format (see linkgit:gitprotocol-common[5])
 over standard input and standard output.
 
 Handshake
diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
index 1eb525fe760..9d453d47651 100644
--- a/Documentation/technical/packfile-uri.txt
+++ b/Documentation/technical/packfile-uri.txt
@@ -18,7 +18,7 @@ a `packfile-uris` argument, the server MAY send a `packfile-uris` section
 directly before the `packfile` section (right after `wanted-refs` if it is
 sent) containing URIs of any of the given protocols. The URIs point to
 packfiles that use only features that the client has declared that it supports
-(e.g. ofs-delta and thin-pack). See protocol-v2.txt for the documentation of
+(e.g. ofs-delta and thin-pack). See linkgit:gitprotocol-v2[5] for the documentation of
 this section.
 
 Clients should then download and index all the given URIs (in addition to
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 99f0eb30406..92fcee2bfff 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -79,7 +79,7 @@ Design Details
   upload-pack negotiation.
 +
 This uses the existing capability discovery mechanism.
-See "filter" in Documentation/technical/pack-protocol.txt.
+See "filter" in linkgit:gitprotocol-pack[5].
 
 - Clients pass a "filter-spec" to clone and fetch which is passed to the
   server to request filtering during packfile construction.
diff --git a/command-list.txt b/command-list.txt
index 44e244a76f6..ed859fdd798 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -210,7 +210,6 @@ gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
 gitformat-bundle                        developerinterfaces
-gitformat-bundle                        developerinterfaces
 gitformat-commit-graph                  developerinterfaces
 gitglossary                             guide
 githooks                                userinterfaces
@@ -219,6 +218,10 @@ gitk                                    mainporcelain
 gitmailmap                              userinterfaces
 gitmodules                              userinterfaces
 gitnamespaces                           guide
+gitprotocol-capabilities                developerinterfaces
+gitprotocol-common                      developerinterfaces
+gitprotocol-pack                        developerinterfaces
+gitprotocol-v2                          developerinterfaces
 gitremote-helpers                       guide
 gitrepository-layout                    userinterfaces
 gitrevisions                            userinterfaces
diff --git a/refspec.h b/refspec.h
index 8b79891d321..8c0c4469933 100644
--- a/refspec.h
+++ b/refspec.h
@@ -69,7 +69,7 @@ int valid_remote_name(const char *name);
 struct strvec;
 /*
  * Determine what <prefix> values to pass to the peer in ref-prefix lines
- * (see Documentation/technical/protocol-v2.txt).
+ * (see linkgit:gitprotocol-v2[5]).
  */
 void refspec_ref_prefixes(const struct refspec *rs,
 			  struct strvec *ref_prefixes);
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 245532df881..6a38294a476 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -181,8 +181,8 @@ test_expect_success 'no-op half-auth fetch does not require a password' '
 	# This is not possible with protocol v2, since both objects and refs
 	# are obtained from the "git-upload-pack" path. A solution to this is
 	# to teach the server and client to be able to inline ls-refs requests
-	# as an Extra Parameter (see pack-protocol.txt), so that "info/refs"
-	# can serve refs, just like it does in protocol v0.
+	# as an Extra Parameter (see "git help gitformat-pack-protocol"), so that
+	# "info/refs" can serve refs, just like it does in protocol v0.
 	GIT_TEST_PROTOCOL_VERSION=0 git --git-dir=half-auth fetch &&
 	expect_askpass none
 '
-- 
2.37.1.1232.gc0cde427aa7

