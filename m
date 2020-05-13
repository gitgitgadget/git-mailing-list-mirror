Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F463C2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722BC20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xzlhDjBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbgEMAzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38252 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731991AbgEMAzQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:55:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7362660D04;
        Wed, 13 May 2020 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331284;
        bh=JYZIPaXyfRmBGoUSPO/BC8tfJm3FljXIDJUspJCISoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xzlhDjBBHau0DIA5SctEp9ht5Xv2Rxd/aLFHWZ9cmtM4ZdR3CxXH60qjymeVYlc0x
         HSMRWq7m+ln7PeuTHd5ukrCvkmv0zNDuLcG8vJ2cGFcLuLC5qeFK6CcZJ3h1+DDKzc
         fMzN0iOOi2WSbHNWHxDJG6AuvVM+RmcS0Bjzn+ZxsD9rYQ+hxHbkewFmSEZlF+rDNb
         RlQyX6rJapjWl5WuIi10DV+Li+C2OT6cesD3qXFaQ43LqwNqT2u8Ncy0P6XjPIYcP/
         RPHQcC/XLPU4cJYfZKhJsUJn1K5IO3xCADh/kOqI0maNiBvpNhfrY7IJxo0553stJw
         tbKxEx36q1gDD1Wc9zGkFDMWmsqjmhA1+NCVbbV61JV/t27QxV2B9LxU2jp9s9Jm4/
         hCV/jjwkSrrzAs+5nruHIEL6/lKxVBJo8Sz3pOqBWkB49wDg7UDtQjJWMulVSdd6sg
         7okZxJasw/YvxDjDOJFy2c7TfSccEOu7/EnKgCR9cKrOKcQ1xhR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 16/44] docs: update remote helper docs for object-format extensions
Date:   Wed, 13 May 2020 00:53:56 +0000
Message-Id: <20200513005424.81369-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the remote helper docs to document the object-format extensions
we will implement in remote-curl and the transport helper code shortly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitremote-helpers.txt | 33 +++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index f48a031dc3..26f32e4421 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -238,6 +238,9 @@ the remote repository.
 	`--signed-tags=verbatim` to linkgit:git-fast-export[1].  In the
 	absence of this capability, Git will use `--signed-tags=warn-strip`.
 
+'object-format'::
+	This indicates that the helper is able to interact with the remote
+	side using an explicit hash algorithm extension.
 
 
 COMMANDS
@@ -257,12 +260,14 @@ Support for this command is mandatory.
 'list'::
 	Lists the refs, one per line, in the format "<value> <name>
 	[<attr> ...]". The value may be a hex sha1 hash, "@<dest>" for
-	a symref, or "?" to indicate that the helper could not get the
-	value of the ref. A space-separated list of attributes follows
-	the name; unrecognized attributes are ignored. The list ends
-	with a blank line.
+	a symref, ":<keyword> <value>" for a key-value pair, or
+	"?" to indicate that the helper could not get the value of the
+	ref. A space-separated list of attributes follows the name;
+	unrecognized attributes are ignored. The list ends with a
+	blank line.
 +
 See REF LIST ATTRIBUTES for a list of currently defined attributes.
+See REF LIST KEYWORDS for a list of currently defined keywords.
 +
 Supported if the helper has the "fetch" or "import" capability.
 
@@ -430,6 +435,18 @@ attributes are defined.
 	This ref is unchanged since the last import or fetch, although
 	the helper cannot necessarily determine what value that produced.
 
+REF LIST KEYWORDS
+-----------------
+
+The 'list' command may produce a list of key-value pairs.
+The following keys are defined.
+
+'object-format'::
+	The refs are using the given hash algorithm.  This keyword is only
+	used if the server and client both support the object-format
+	extension.
+
+
 OPTIONS
 -------
 
@@ -514,6 +531,14 @@ set by Git if the remote helper has the 'option' capability.
 	transaction.  If successful, all refs will be updated, or none will.  If the
 	remote side does not support this capability, the push will fail.
 
+'option object-format' {'true'|algorithm}::
+	If 'true', indicate that the caller wants hash algorithm information
+	to be passed back from the remote.  This mode is used when fetching
+	refs.
++
+If set to an algorithm, indicate that the caller wants to interact with
+the remote side using that algorithm.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
