Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA89C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591502074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdk6u6ZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgFJU5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgFJU5i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 16:57:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BD4C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u186so3918863ybf.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+/EiPx2LNd7p9vx78He+HdHQ66AdyeNBIK8aJzYcfQo=;
        b=tdk6u6ZVJrp8P4cbNss9AG6TnMn03x+kIMLYCore7AXUXjcTafdkcNICwbYMG6a+9L
         uYbUzTv6/V8rMY1XLSCzPeKeWBk2HFgnbdz3kXtrYJWs0MJoNkcYdgfWYI4gGFE2U1FE
         Az1U/NmCOFXBR5TnNB+03P3TLqx9NsMGmeARmzFlqJUM3Ze7OhltRit+fwJBvaTUC4go
         C1sk3c9wpyimfVQ/Y3iM1hJG2G/IZ62vqpv/2fvS134OIaH0vC242GPFbkpJUXQ5BIpC
         QHbbBTTDGDXewrNfNqEtm0gffCYWVzbwiYT3GLs8m3CqMbWoATsKfdsdD99Ovrf/2oGW
         LCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+/EiPx2LNd7p9vx78He+HdHQ66AdyeNBIK8aJzYcfQo=;
        b=eTbWSjxXkrnDalouyS+XOQ7sfA9EKLikUe9Cndb+aSbbUPjh7d/XK1rHS2jELaGHJs
         hsleKYX8wmffwOfeSMnOBV/sWnehktsSlgd8Gq8LXsiDREusvJs2sUspC8gTVC8qs+qt
         4sClSFpN7Qc3ffRckSmPosh5g8GtpIlxBOHCqOmjM8rrypeAhXa72MheePFDhGdd1m4z
         20z4C2lH/0IFhDLxVDsQemi+4kffvxgUJjPXWOKj8mRdlGX9E2an0Mz1i1qc4os/d/wp
         8deAClGrsyNK5jJ2nsClBLopBerqfwaMYEkFCwQz6jOW9F76iAy8OcLCSt9tepX4+x0t
         xeYQ==
X-Gm-Message-State: AOAM53326/qu+PQqyKXMa8WToKtURUcBj/i5gkJnh+FiD3RO/z02iXYP
        6IX5JOtcf6G4/Dpp5E9o9hXrbFKNseLWhXycyw95IAv9N2S1JT4JeMQtzcPH5AbDf/3ylWmewly
        zc0EDnwPksxq+dZ8NDtcsOpwq4KVCmiJjBucMVfyCiwlmDGyvLm+DyMEQK+fPuAeabo7/rPAFdv
        Cz
X-Google-Smtp-Source: ABdhPJzuQJeOUMjovwxMKru43p70s8T1YIgpe/abAwOvYo+X2U0FEi+vbQQv1scKQXZRFD561PUY+Dmlx+A4K2zit6+n
X-Received: by 2002:a5b:c82:: with SMTP id i2mr8101651ybq.340.1591822656995;
 Wed, 10 Jun 2020 13:57:36 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:57:20 -0700
In-Reply-To: <cover.1591821067.git.jonathantanmy@google.com>
Message-Id: <6344c225897de1a2d8aa86d610e9eaf1c6ec82b4.1591821067.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com> <cover.1591821067.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 6/9] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/packfile-uri.txt | 78 ++++++++++++++++++++++++
 Documentation/technical/protocol-v2.txt  | 32 +++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/technical/packfile-uri.txt

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
new file mode 100644
index 0000000000..318713abc3
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
+The server advertises the `packfile-uris` capability.
+
+If the client then communicates which protocols (HTTPS, etc.) it supports with
+a `packfile-uris` argument, the server MAY send a `packfile-uris` section
+directly before the `packfile` section (right after `wanted-refs` if it is
+sent) containing URIs of any of the given protocols. The URIs point to
+packfiles that use only features that the client has declared that it supports
+(e.g. ofs-delta and thin-pack). See protocol-v2.txt for the documentation of
+this section.
+
+Clients should then download and index all the given URIs (in addition to
+downloading and indexing the packfile given in the `packfile` section of the
+response) before performing the connectivity check.
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
+<uri>` entries. Whenever the list of objects to be sent is assembled, all such
+blobs are excluded, replaced with URIs. The client will download those URIs,
+expecting them to each point to packfiles containing single blobs.
+
+Client design
+-------------
+
+The client has a config variable `fetch.uriprotocols` that determines which
+protocols the end user is willing to use. By default, this is empty.
+
+When the client downloads the given URIs, it should store them with "keep"
+files, just like it does with the packfile in the `packfile` section. These
+additional "keep" files can only be removed after the refs have been updated -
+just like the "keep" file for the packfile in the `packfile` section.
+
+The division of work (initial fetch + additional URIs) introduces convenient
+points for resumption of an interrupted clone - such resumption can be done
+after the Minimum Viable Product (see "Future work").
+
+Future work
+-----------
+
+The protocol design allows some evolution of the server and client without any
+need for protocol changes, so only a small-scoped design is included here to
+form the MVP. For example, the following can be done:
+
+ * On the server, more sophisticated means of excluding objects (e.g. by
+   specifying a commit to represent that commit and all objects that it
+   references).
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
index 995f07481e..f9f4e4ddd0 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -323,13 +323,26 @@ included in the client's request:
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
@@ -347,6 +360,9 @@ header. Most sections are sent only when the packfile is sent.
 		  *PKT-LINE(wanted-ref LF)
     wanted-ref = obj-id SP refname
 
+    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
+    packfile-uri = PKT-LINE(40*(HEXDIGIT) SP *%x20-ff LF)
+
     packfile = PKT-LINE("packfile" LF)
 	       *PKT-LINE(%x01-03 *%x00-ff)
 
@@ -418,6 +434,20 @@ header. Most sections are sent only when the packfile is sent.
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
+	* The hashes are 40 hex characters long. When Git upgrades to a new
+	  hash algorithm, this might need to be updated. (It should match
+	  whatever index-pack outputs after "pack\t" or "keep\t".
+
     packfile section
 	* This section is only included if the client has sent 'want'
 	  lines in its request and either requested that no more
-- 
2.27.0.278.ge193c7cf3a9-goog

