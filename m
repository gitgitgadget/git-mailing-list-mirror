Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5620DC433E0
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 20:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3934020709
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 20:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGVU0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVU0k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 16:26:40 -0400
X-Greylist: delayed 97 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jul 2020 13:26:39 PDT
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE14DC0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 13:26:39 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jyLK2-009EzG-3A; Wed, 22 Jul 2020 22:26:38 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     git@vger.kernel.org
Cc:     bup-list@googlegroups.com,
        Jamie Wyrick <terrifiedquack80@gmail.com>
Subject: [PATCH v2] doc: remove misleading documentation on pack names
Date:   Wed, 22 Jul 2020 22:26:29 +0200
Message-Id: <20200722202629.109277-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The index-pack documentation explicitly states that the pack
name is derived from the sorted list of object names, but
that clearly isn't true. I can't seem to be able to figure
out if this was ever changed though.

Be less explicit in the docs as to what the exact output is,
and just say that it's whatever goes into the pack name.

Really it seems to be the sha1 of the entire file, without
the checksum footer.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
It was reported that bup writes pack files that have a name
different from what git does, and I think it's quite possibly
because of this documentation ... it doesn't actually really
*matter* though, as long as the file is internally consistent
nothing checks that the name also matches the footer.

You can also take this as a bug report and fix the language in
some other, perhaps more precise way, if you prefer :-)

v2: correct bup list address, oops
---
 Documentation/git-index-pack.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 9316d9a80b0d..ace40fa9f363 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -104,12 +104,11 @@ This option cannot be used with --stdin.
 NOTES
 -----
 
-Once the index has been created, the list of object names is sorted
-and the SHA-1 hash of that list is printed to stdout. If --stdin was
-also used then this is prefixed by either "pack\t", or "keep\t" if a
-new .keep file was successfully created. This is useful to remove a
-.keep file used as a lock to prevent the race with 'git repack'
-mentioned above.
+Once the index has been created, the hash that goes into the name of
+the pack/idx file is printed to stdout. If --stdin was also used then
+this is prefixed by either "pack\t", or "keep\t" if a new .keep file
+was successfully created. This is useful to remove a .keep file used
+as a lock to prevent the race with 'git repack' mentioned above.
 
 GIT
 ---
-- 
2.26.2

