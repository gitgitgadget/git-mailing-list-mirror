Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5981C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 16:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbhLOQXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 11:23:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:52424 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244761AbhLOQXu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 11:23:50 -0500
Received: (qmail 17798 invoked by uid 109); 15 Dec 2021 16:23:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Dec 2021 16:23:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5778 invoked by uid 111); 15 Dec 2021 16:23:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Dec 2021 11:23:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Dec 2021 11:23:48 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH] doc/config: mark ssh allowedSigners example as literal
Message-ID: <YboWlOG3vZD/7Osx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The discussion for gpg.ssh.allowedSignersFile shows an example string
that contains "user1@example.com,user2@example.com". Asciidoc thinks
these are real email addresses and generates "mailto" footnotes for
them. This makes the rendered content more confusing, as it has extra
"[1]" markers:

  The file consists of one or more lines of principals followed by an
  ssh public key. e.g.: user1@example.com[1],user2@example.com[2]
  ssh-rsa AAAAX1... See ssh-keygen(1) "ALLOWED SIGNERS" for details.

and also generates pointless notes at the end of the page:

  NOTES
        1. user1@example.com
           mailto:user1@example.com

        2. user2@example.com
           mailto:user2@example.com

We can fix this by putting the example into a backtick literal block.
That inhibits the mailto generation, and as a bonus typesets the example
text in a way that sets it off from the regular prose (a tt font for
html, or bold in the roff manpage).

Signed-off-by: Jeff King <peff@peff.net>
---
Possibly this could actually be done in a separate example block, but I
think this looks OK and fixes the most obvious problem.

 Documentation/config/gpg.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 4f30c7dbdd..7875f4fccc 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -44,7 +44,7 @@ gpg.ssh.allowedSignersFile::
 	A file containing ssh public keys which you are willing to trust.
 	The file consists of one or more lines of principals followed by an ssh
 	public key.
-	e.g.: user1@example.com,user2@example.com ssh-rsa AAAAX1...
+	e.g.: `user1@example.com,user2@example.com ssh-rsa AAAAX1...`
 	See ssh-keygen(1) "ALLOWED SIGNERS" for details.
 	The principal is only used to identify the key and is available when
 	verifying a signature.
-- 
2.34.1.662.g7157fbae24
