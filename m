Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C151C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 13:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiGRN35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiGRN3w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 09:29:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2025F5B5
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so9829525wme.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xUYYCztqDDmvCtJkTTK81yFvGfXLI7r5lip2GMrvU1k=;
        b=YVs4j5Lb3H8o8n9rp3uODyoFpSOLPF+3an+Gtwd/zuB0obok/TX0Urcz0vrpqOlTSm
         9KtF/hYlIcX9AHDusUZXo+DKPIxpJNheY65SbJ6VrMCR42FhWIsC5nUthO7pSG2rJsWS
         lMasle5slfvaIm2W2ndwx7jMsdHctscWStjQp86+Hw35zoI2yUG7HvoWlLCnhpY0sXkC
         l67plX50qc7+cD/u4A0iMzEwdxZdeTo1TZQET9qvcI4kv+17kvUFZPyEJ87faCsSfhyR
         Jh/8Z/Qvzl52k+17CtMFsztsGOF7KHUdphAThJj8PlqgMPyHPm9fTdoMd0KPdBGkAfE2
         gxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUYYCztqDDmvCtJkTTK81yFvGfXLI7r5lip2GMrvU1k=;
        b=lLjYJ5Egqtg6bhFA38wqoK24sOxp2/T8GRcQCMLghh21oNSoGVaB/+vSG427ANwB/E
         Oy2tx00+RQncI2Vsn664rGj+vNDa+8pSk4JtYO4dPY+I5PHeL80ld0YkeeB1+HUfyuJI
         8lIhwHYUdEDHA5Ha45lR+MLJN1p90OJ3qi0J4Vj4wVgoY8og35LznBgGA7rvAPhUUQoy
         ojL3rNh3GPMzWN6DFsYduLzJuSm+wWdfB5t37G3he80NBOs5Guu82mVuzsl6+NgUEBK9
         4FPNKhnUN6/BEBUAN/720oaPmb54aX5i1Yk1z+3ZuQIsIqiLLByfb3DBHYkv5XP2sXqN
         GMgA==
X-Gm-Message-State: AJIora9Dcax3x7qKf2YB/Pd+O1OXaay1JwXrvfZEavBObFZ0bNEjZJs5
        Y+oRVJyn0CycwrW2huLbW7hLZBpmlnpsoA==
X-Google-Smtp-Source: AGRyM1uisYncixFzdTuvOQJtmNg5tW7rA+81a2kYmfE78DYNDC2QTOFngAXdUGLANIF0446rmv7BFA==
X-Received: by 2002:a7b:cbd4:0:b0:3a3:20eb:2b80 with SMTP id n20-20020a7bcbd4000000b003a320eb2b80mr706259wmi.175.1658150985647;
        Mon, 18 Jul 2022 06:29:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b003a30572072esm14277296wmi.6.2022.07.18.06.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:29:44 -0700 (PDT)
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
Subject: [PATCH v4 5/8] docs: move protocol-related docs to man section 5
Date:   Mon, 18 Jul 2022 15:29:31 +0200
Message-Id: <patch-v4-5.8-968aa977b67-20220718T132911Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1032.gb00b5447790
In-Reply-To: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  8 +++---
 Documentation/config/lsrefs.txt               |  2 +-
 Documentation/config/protocol.txt             |  2 +-
 Documentation/git-upload-pack.txt             |  5 ++--
 Documentation/gitformat-bundle.txt            |  2 +-
 ...otocol.txt => gitformat-pack-protocol.txt} | 22 +++++++++++++--
 ...xt => gitformat-protocol-capabilities.txt} | 28 +++++++++++++++----
 ...mmon.txt => gitformat-protocol-common.txt} | 23 +++++++++++++--
 ...tocol-v2.txt => gitformat-protocol-v2.txt} | 24 +++++++++++++---
 Documentation/technical/api-simple-ipc.txt    |  2 +-
 Documentation/technical/http-protocol.txt     |  6 ++--
 .../long-running-process-protocol.txt         |  2 +-
 Documentation/technical/partial-clone.txt     |  2 +-
 command-list.txt                              |  4 +++
 t/t5551-http-fetch-smart.sh                   |  4 +--
 15 files changed, 103 insertions(+), 33 deletions(-)
 rename Documentation/{technical/pack-protocol.txt => gitformat-pack-protocol.txt} (98%)
 rename Documentation/{technical/protocol-capabilities.txt => gitformat-protocol-capabilities.txt} (96%)
 rename Documentation/{technical/protocol-common.txt => gitformat-protocol-common.txt} (88%)
 rename Documentation/{technical/protocol-v2.txt => gitformat-protocol-v2.txt} (98%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index cc6870cce41..adc1404d380 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -26,6 +26,10 @@ MAN1_TXT += gitweb.txt
 MAN5_TXT += gitattributes.txt
 MAN5_TXT += gitformat-bundle.txt
 MAN5_TXT += gitformat-commit-graph.txt
+MAN5_TXT += gitformat-pack-protocol.txt
+MAN5_TXT += gitformat-protocol-capabilities.txt
+MAN5_TXT += gitformat-protocol-common.txt
+MAN5_TXT += gitformat-protocol-v2.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
 MAN5_TXT += gitmailmap.txt
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
index adeda0f24d3..e9efe498c01 100644
--- a/Documentation/config/lsrefs.txt
+++ b/Documentation/config/lsrefs.txt
@@ -1,7 +1,7 @@
 lsrefs.unborn::
 	May be "advertise" (the default), "allow", or "ignore". If "advertise",
 	the server will respond to the client sending "unborn" (as described in
-	protocol-v2.txt) and will advertise support for this feature during the
+	linkgit:gitformat-protocol-v2[5]) and will advertise support for this feature during the
 	protocol v2 capability advertisement. "allow" is the same as
 	"advertise" except that the server will not advertise support for this
 	feature; this is useful for load-balanced servers that cannot be
diff --git a/Documentation/config/protocol.txt b/Documentation/config/protocol.txt
index 756591d77b0..bf18a70a924 100644
--- a/Documentation/config/protocol.txt
+++ b/Documentation/config/protocol.txt
@@ -58,6 +58,6 @@ protocol.version::
 * `1` - the original wire protocol with the addition of a version string
   in the initial response from the server.
 
-* `2` - link:technical/protocol-v2.html[wire protocol version 2].
+* `2` - Wire protocol version 2, see linkgit:gitformat-protocol-v2[5].
 
 --
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 8f87b23ea86..754619222f6 100644
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
+	linkgit:gitformat-protocol-v2[5] documentation. Also understood by
 	linkgit:git-receive-pack[1].
 
 <directory>::
diff --git a/Documentation/gitformat-bundle.txt b/Documentation/gitformat-bundle.txt
index 6a9d9e5bf6f..3d60d9067e4 100644
--- a/Documentation/gitformat-bundle.txt
+++ b/Documentation/gitformat-bundle.txt
@@ -27,7 +27,7 @@ FORMAT
 ------
 
 We will use ABNF notation to define the Git bundle format. See
-link:technical/protocol-common.html for the details.
+linkgit:gitformat-protocol-common[5] for the details.
 
 A v2 bundle looks like this:
 
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/gitformat-pack-protocol.txt
similarity index 98%
rename from Documentation/technical/pack-protocol.txt
rename to Documentation/gitformat-pack-protocol.txt
index e13a2c064d1..b665af5b690 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/gitformat-pack-protocol.txt
@@ -1,5 +1,17 @@
-Packfile transfer protocols
-===========================
+gitformat-pack-protocol(5)
+==========================
+
+NAME
+----
+gitformat-pack-protocol - How packs are transferred over-the-wire
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
+linkgit:gitformat-protocol-common[5]. When the grammar indicate `PKT-LINE(...)`, unless
 otherwise noted the usual pkt-line LF rules apply: the sender SHOULD
 include a LF, but the receiver MUST NOT complain if it is not present.
 
@@ -707,3 +719,7 @@ An example client/server communication might look like this:
    S: 0018ok refs/heads/debug\n
    S: 002ang refs/heads/master non-fast-forward\n
 ----
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/gitformat-protocol-capabilities.txt
similarity index 96%
rename from Documentation/technical/protocol-capabilities.txt
rename to Documentation/gitformat-protocol-capabilities.txt
index 9dfade930da..2e89f40ddb1 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/gitformat-protocol-capabilities.txt
@@ -1,8 +1,20 @@
-Git Protocol Capabilities
-=========================
+gitformat-protocol-capabilities(5)
+==================================
+
+NAME
+----
+gitformat-protocol-capabilities - Protocol v0 and v1 capabilities
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
+protocol. For version 2, please refer to the linkgit:gitformat-protocol-v2[5]
 doc.
 
 Servers SHOULD support all capabilities defined in this document.
@@ -77,7 +89,7 @@ interleaved with S-R-Q.
 multi_ack_detailed
 ------------------
 This is an extension of multi_ack that permits client to better
-understand the server's in-memory state. See pack-protocol.txt,
+understand the server's in-memory state. See linkgit:gitformat-pack-protocol[5],
 section "Packfile Negotiation" for more information.
 
 no-done
@@ -281,7 +293,7 @@ a packfile upload and reference update.  If the pushing client requests
 this capability, after unpacking and updating references the server
 will respond with whether the packfile unpacked successfully and if
 each reference was updated successfully.  If any of those were not
-successful, it will send back an error message.  See pack-protocol.txt
+successful, it will send back an error message.  See linkgit:gitformat-pack-protocol[5]
 for example messages.
 
 report-status-v2
@@ -292,7 +304,7 @@ adding new "option" directives in order to support reference rewritten by
 the "proc-receive" hook.  The "proc-receive" hook may handle a command
 for a pseudo-reference which may create or update a reference with
 different name, new-oid, and old-oid.  While the capability
-'report-status' cannot report for such case.  See pack-protocol.txt
+'report-status' cannot report for such case.  See linkgit:gitformat-pack-protocol[5]
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
diff --git a/Documentation/technical/protocol-common.txt b/Documentation/gitformat-protocol-common.txt
similarity index 88%
rename from Documentation/technical/protocol-common.txt
rename to Documentation/gitformat-protocol-common.txt
index ecedb34bba5..6e1e1624e2d 100644
--- a/Documentation/technical/protocol-common.txt
+++ b/Documentation/gitformat-protocol-common.txt
@@ -1,5 +1,20 @@
-Documentation Common to Pack and Http Protocols
-===============================================
+gitformat-protocol-common(5)
+============================
+
+NAME
+----
+gitformat-protocol-common - Things common to various protocols
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
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/gitformat-protocol-v2.txt
similarity index 98%
rename from Documentation/technical/protocol-v2.txt
rename to Documentation/gitformat-protocol-v2.txt
index 8a877d27e23..ae4fcc84e37 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/gitformat-protocol-v2.txt
@@ -1,5 +1,17 @@
-Git Wire Protocol, Version 2
-============================
+gitformat-protocol-v2(5)
+========================
+
+NAME
+----
+gitformat-protocol-v2 - Git Wire Protocol, Version 2
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
@@ -26,7 +38,7 @@ Packet-Line Framing
 -------------------
 
 All communication is done using packet-line framing, just as in v1.  See
-`Documentation/technical/pack-protocol.txt` and
+linkgit:gitformat-pack-protocol[5] and
 `Documentation/technical/protocol-common.txt` for more information.
 
 In protocol v2 these special packets will have the following semantics:
@@ -42,7 +54,7 @@ Initial Client Request
 In general a client can request to speak protocol v2 by sending
 `version=2` through the respective side-channel for the transport being
 used which inevitably sets `GIT_PROTOCOL`.  More information can be
-found in `pack-protocol.txt` and `http-protocol.txt`, as well as the
+found in linkgit:gitformat-pack-protocol[5] and `http-protocol.txt`, as well as the
 `GIT_PROTOCOL` definition in `git.txt`. In all cases the
 response from the server is the capability advertisement.
 
@@ -566,3 +578,7 @@ and associated requested information, each separated by a single space.
 	attr = "size"
 
 	obj-info = obj-id SP obj-size
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.txt
index d79ad323e67..945c21bbc38 100644
--- a/Documentation/technical/api-simple-ipc.txt
+++ b/Documentation/technical/api-simple-ipc.txt
@@ -78,7 +78,7 @@ client and an optional response message from the server.  Both the
 client and server messages are unlimited in length and are terminated
 with a flush packet.
 
-The pkt-line routines (Documentation/technical/protocol-common.txt)
+The pkt-line routines (linkgit:gitformat-protocol-common[5])
 are used to simplify buffer management during message generation,
 transmission, and reception.  A flush packet is used to mark the end
 of the message.  This allows the sender to incrementally generate and
diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index cc5126cfeda..9d9c7acd512 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -222,7 +222,7 @@ smart server reply:
    S: 0000
 
 The client may send Extra Parameters (see
-Documentation/technical/pack-protocol.txt) as a colon-separated string
+linkgit:gitformat-pack-protocol[5]) as a colon-separated string
 in the Git-Protocol HTTP header.
 
 Uses the `--http-backend-info-refs` option to
@@ -518,5 +518,5 @@ References
 
 http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
 http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
-link:technical/pack-protocol.html
-link:technical/protocol-capabilities.html
+linkgit:gitformat-pack-protocol[5]
+linkgit:gitformat-protocol-capabilities[5]
diff --git a/Documentation/technical/long-running-process-protocol.txt b/Documentation/technical/long-running-process-protocol.txt
index aa0aa9af1c2..c6922ce6ccc 100644
--- a/Documentation/technical/long-running-process-protocol.txt
+++ b/Documentation/technical/long-running-process-protocol.txt
@@ -3,7 +3,7 @@ Long-running process protocol
 
 This protocol is used when Git needs to communicate with an external
 process throughout the entire life of a single Git command. All
-communication is in pkt-line format (see technical/protocol-common.txt)
+communication is in pkt-line format (see linkgit:gitformat-protocol-common[5])
 over standard input and standard output.
 
 Handshake
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 99f0eb30406..9d5199d5c6c 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -79,7 +79,7 @@ Design Details
   upload-pack negotiation.
 +
 This uses the existing capability discovery mechanism.
-See "filter" in Documentation/technical/pack-protocol.txt.
+See "filter" in linkgit:gitformat-pack-protocol[5].
 
 - Clients pass a "filter-spec" to clone and fetch which is passed to the
   server to request filtering during packfile construction.
diff --git a/command-list.txt b/command-list.txt
index 66e6a0ba217..bec0fa690aa 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -210,6 +210,10 @@ giteveryday                             guide
 gitfaq                                  guide
 gitformat-bundle                        gitformats
 gitformat-commit-graph                  gitformats
+gitformat-pack-protocol                 gitformats
+gitformat-protocol-capabilities         gitformats
+gitformat-protocol-common               gitformats
+gitformat-protocol-v2                   gitformats
 gitglossary                             guide
 githooks                                userformats
 gitignore                               userformats
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index b9351a732f6..d17f77dda6f 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -175,8 +175,8 @@ test_expect_success 'no-op half-auth fetch does not require a password' '
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
2.37.1.1032.gb00b5447790

