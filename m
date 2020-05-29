Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FABDC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E658A207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUWw1tye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgE2Wal (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 18:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgE2Wai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 18:30:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB2C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x10so4743957ybx.8
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n2/LooV3J7rIzyGhiU1ruNHDoO4132sCvvVFXZPdjZY=;
        b=WUWw1tye7exuRYesZVccQRrOaxae6I/6StqjUCbNzzI7vekcLaJw6M8Bae09x38DMD
         aEdunFlq5iNkxQM8MD8r3qOk53QLuC9vTzjAhEXLneC7BmvxcKXeKAI8E0GwKInSeLc2
         Yy8Nq255qX/42Koma3Uz3F3P41rSb6vSnPy5SM652JyAAFiqQJgkyAguen8qIAIjo6Dd
         WSQwedoEok79KtwJ2EcoItXwfHo6Bez2tzW1yqcV0ePoVERDgJOKkTcp+viM16B8KDk5
         qYAGCtpXz5oQR02ObpK+3QVuBbHVaM7FmEIPuh8mY9ko9Hx8aEScQJL2aZth62TAfvi6
         QS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n2/LooV3J7rIzyGhiU1ruNHDoO4132sCvvVFXZPdjZY=;
        b=nPccILWv6nQxpnHLB+FkK15X4vBpGRJIbyliHQpElJ2IN1nFbqgWYcyu8/NpJs0WKd
         Nc3G5x/+gpQI8aWDMydXWjmQWwdu4nnxloRKoFURCPylnYY0PRWaNIlpjtY4AMbQKHTj
         TWU80/x2P4FP/LD+kKQVj9yknuHDklC9HGPoa/7vQm8vM+csYKvMBqJljQC3HUnAKT04
         OzEA+YlhEaQlsmcFDr1p3xk8ufK7fGySvX15oXs2TFCyQWlrxICbj0E4OL7N0+qwbm4D
         Sbm0g6m6gU+UowZNFdZqHzKbdtEsp0u8Z4X91rCb9TaC+zNycgG49xtCmyNhamwk13z8
         KfZA==
X-Gm-Message-State: AOAM531KIMJVK7NFGC2Hh5qRkMy8bpxzAUuUn4ve9OSCTwD9dErY8xSw
        FrnOpAVWyEt/3QbjpnP6l/BVsF/TQ9GczmPa/s4/7Fw29u0mTSVpTvFZvCkdRCKKfK9ood/oR3T
        EC3tvHW2ywjMRPLLZ1yUiokr83uZL1KJoFV77Qaq/nAvLQKVacAv6g/Ttxck/BaidCfNUUrSQl8
        Ew
X-Google-Smtp-Source: ABdhPJzlCJGWBcFdlD+z9YJLWLGwwbB97TzzOk7JItS37Xt9Rh+woIQKGHHIuZKUK7ll0j3TnpfYyrWh5f7KxcH5Zr6t
X-Received: by 2002:a25:a229:: with SMTP id b38mr15759991ybi.400.1590791437718;
 Fri, 29 May 2020 15:30:37 -0700 (PDT)
Date:   Fri, 29 May 2020 15:30:17 -0700
In-Reply-To: <cover.1590789428.git.jonathantanmy@google.com>
Message-Id: <4eea9d927af1df11cdb0342e969b293a6e317d46.1590789428.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 5/8] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/packfile-uri.txt | 78 ++++++++++++++++++++++++
 Documentation/technical/protocol-v2.txt  | 28 ++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/technical/packfile-uri.txt

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
new file mode 100644
index 0000000000..6a5a6440d5
--- /dev/null
+++ b/Documentation/technical/packfile-uri.txt
@@ -0,0 +1,78 @@
+Packfile URIs
+=============
+
+This feature allows servers to serve part of their packfile response as URIs.
+This allows server designs that improve scalability in bandwidth and CPU usage
+(for example, by serving some data through a CDN), and (in the future) provides
+some measure of resumability to clients.
+
+This feature is available only in protocol version 2.
+
+Protocol
+--------
+
+The server advertises `packfile-uris`.
+
+If the client then communicates which protocols (HTTPS, etc.) it supports with
+a `packfile-uris` argument, the server MAY send a `packfile-uris` section
+directly before the `packfile` section (right after `wanted-refs` if it is
+sent) containing URIs of any of the given protocols. The URIs point to
+packfiles that use only features that the client has declared that it supports
+(e.g. ofs-delta and thin-pack). See protocol-v2.txt for the documentation of
+this section.
+
+Clients then should understand that the returned packfile could be incomplete,
+and that it needs to download all the given URIs before the fetch or clone is
+complete.
+
+Server design
+-------------
+
+The server can be trivially made compatible with the proposed protocol by
+having it advertise `packfile-uris`, tolerating the client sending
+`packfile-uris`, and never sending any `packfile-uris` section. But we should
+include some sort of non-trivial implementation in the Minimum Viable Product,
+at least so that we can test the client.
+
+This is the implementation: a feature, marked experimental, that allows the
+server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
+<uri>` entries. Whenever the list of objects to be sent is assembled, a blob
+with the given sha1 can be replaced by the given URI. This allows, for example,
+servers to delegate serving of large blobs to CDNs.
+
+Client design
+-------------
+
+While fetching, the client needs to remember the list of URIs and cannot
+declare that the fetch is complete until all URIs have been downloaded as
+packfiles.
+
+The division of work (initial fetch + additional URIs) introduces convenient
+points for resumption of an interrupted clone - such resumption can be done
+after the Minimum Viable Product (see "Future work").
+
+The client can inhibit this feature (i.e. refrain from sending the
+`packfile-uris` parameter) by passing --no-packfile-uris to `git fetch`.
+
+Future work
+-----------
+
+The protocol design allows some evolution of the server and client without any
+need for protocol changes, so only a small-scoped design is included here to
+form the MVP. For example, the following can be done:
+
+ * On the server, a long-running process that takes in entire requests and
+   outputs a list of URIs and the corresponding inclusion and exclusion sets of
+   objects. This allows, e.g., signed URIs to be used and packfiles for common
+   requests to be cached.
+ * On the client, resumption of clone. If a clone is interrupted, information
+   could be recorded in the repository's config and a "clone-resume" command
+   can resume the clone in progress. (Resumption of subsequent fetches is more
+   difficult because that must deal with the user wanting to use the repository
+   even after the fetch was interrupted.)
+
+There are some possible features that will require a change in protocol:
+
+ * Additional HTTP headers (e.g. authentication)
+ * Byte range support
+ * Different file formats referenced by URIs (e.g. raw object)
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index ef7514a3ee..7e1b3a0bfe 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -325,13 +325,26 @@ included in the client's request:
 	indicating its sideband (1, 2, or 3), and the server may send "0005\2"
 	(a PKT-LINE of sideband 2 with no payload) as a keepalive packet.
 
+If the 'packfile-uris' feature is advertised, the following argument
+can be included in the client's request as well as the potential
+addition of the 'packfile-uris' section in the server's response as
+explained below.
+
+    packfile-uris <comma-separated list of protocols>
+	Indicates to the server that the client is willing to receive
+	URIs of any of the given protocols in place of objects in the
+	sent packfile. Before performing the connectivity check, the
+	client should download from all given URIs. Currently, the
+	protocols supported are "http" and "https".
+
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
 header. Most sections are sent only when the packfile is sent.
 
     output = acknowledgements flush-pkt |
 	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
-	     [wanted-refs delim-pkt] packfile flush-pkt
+	     [wanted-refs delim-pkt] [packfile-uris delim-pkt]
+	     packfile flush-pkt
 
     acknowledgments = PKT-LINE("acknowledgments" LF)
 		      (nak | *ack)
@@ -349,6 +362,9 @@ header. Most sections are sent only when the packfile is sent.
 		  *PKT-LINE(wanted-ref LF)
     wanted-ref = obj-id SP refname
 
+    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
+    packfile-uri = PKT-LINE(40*(HEXDIGIT) SP *%x20-ff LF)
+
     packfile = PKT-LINE("packfile" LF)
 	       *PKT-LINE(%x01-03 *%x00-ff)
 
@@ -420,6 +436,16 @@ header. Most sections are sent only when the packfile is sent.
 	* The server MUST NOT send any refs which were not requested
 	  using 'want-ref' lines.
 
+    packfile-uris section
+	* This section is only included if the client sent
+	  'packfile-uris' and the server has at least one such URI to
+	  send.
+
+	* Always begins with the section header "packfile-uris".
+
+	* For each URI the server sends, it sends a hash of the pack's
+	  contents (as output by git index-pack) followed by the URI.
+
     packfile section
 	* This section is only included if the client has sent 'want'
 	  lines in its request and either requested that no more
-- 
2.27.0.rc0.183.gde8f92d652-goog

