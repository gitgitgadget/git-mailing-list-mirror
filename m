Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25051C433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245154AbiCJRgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243214AbiCJRgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:36:25 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA28F18A783
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:35:24 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C6ED75A130;
        Thu, 10 Mar 2022 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646933721;
        bh=6buXR4uOxTjS4ym5fXokbQ+IJ9qja4KkXgNOi8DH2xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=esjvAZMglmoCHjK2HCXMX/UZ7++pq9S2UIx1vogpSvraIrs15HItoecOjfwPfwKvn
         4k8OfwvB8cyY1dUqZtHlIt5qUw41usvjYxt2m2j/UmQPldmUPsXveyoDjVOXbtSuB5
         Tc2dHgZFsZCkL+7CAFZEoqzUxsUbWewrkDkhS1vjpHId0L7P/MvMFnmDfBwhwgtjSC
         Zp4U99sImlPa+cxfIbkDRsB9sV+Uv2hkuXf46geJKhUFqAsd9uPiMyaDsm/T3wVp0H
         Dn1fQJb63qOR3VtIfxZS3mVX9x4kIX0QVqv5+c3so/XaR2GFvgtyigGfZsirefps8l
         tvHmQ1d0OpsijIbWDYU6v8w41isqzNf6UXVG3zlr9neq9V2zBjTUBag0CrGdnQcoyT
         6pU1WWkX5eXzA0935qN/FBxRj67Fii5V5Wvw7iTnKB2Lp4uqkCndkDpCpCPUN/LeUr
         26a635gjM/V7aBscbJ24/vRIec4e86z0Qf4U6yQWHV/xhlfmc+2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 6/6] doc: add stash export and import to docs
Date:   Thu, 10 Mar 2022 17:32:36 +0000
Message-Id: <20220310173236.4165310-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have an easy way for users to import and export their
stashes, let's document this in manual page so users will know how to
use it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-stash.txt | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 6e15f47525..283677314a 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -20,6 +20,8 @@ SYNOPSIS
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
+'git stash' export ( --print | --to-ref <ref> ) [<stashes>]
+'git stash' import <commit>
 
 DESCRIPTION
 -----------
@@ -151,6 +153,18 @@ store::
 	reflog.  This is intended to be useful for scripts.  It is
 	probably not the command you want to use; see "push" above.
 
+export ( --print | --to-ref <ref> ) [<stashes>]::
+
+	Export the specified stashes, or all of them if none are specified, to
+	a chain of commits which can be transferred using the normal fetch and
+	push mechanisms, then imported using the `import` subcommand.
+
+import <commit>::
+
+	Import the specified stashes from the specified commit, which must have been
+	created by `export`, and add them to the list of stashes.  To replace the
+	existing stashes, use `clear` first.
+
 OPTIONS
 -------
 -a::
@@ -239,6 +253,19 @@ literally (including newlines and quotes).
 +
 Quiet, suppress feedback messages.
 
+--print::
+	This option is only valid for `export`.
++
+Create the chain of commits representing the exported stashes without
+storing it anywhere in the ref namespace and print the object ID to
+standard output.  This is designed for scripts.
+
+--to-ref::
+	This option is only valid for `export`.
++
+Create the chain of commits representing the exported stashes and store
+it to the specified ref.
+
 \--::
 	This option is only valid for `push` command.
 +
