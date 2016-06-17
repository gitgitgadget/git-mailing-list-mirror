Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97361F744
	for <e@80x24.org>; Fri, 17 Jun 2016 07:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbcFQHq0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 03:46:26 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56439 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755350AbcFQHqV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 03:46:21 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9468A20A80;
	Fri, 17 Jun 2016 03:46:20 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 17 Jun 2016 03:46:20 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=ywc1+RMSdAUiO3ICKELxz/07Voc
	=; b=HLGJCxfvhg0KHfgMCkA+RTF1Ic6HY6QBoybQCEK4KrFwCH4lzOg7s2oVb3u
	48tG2l4qK/qnlufCyb+kzNwPBcCW+j/9/aIjnTLjMKwXRCQZvLvaRiqJsi9aPuKg
	rRMv2muvzZOu+9cPMMI4/on796Rj9xHxnwcskjT1KLVCXi6o=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ywc1
	+RMSdAUiO3ICKELxz/07Voc=; b=HQOoWUs2EsC5FyYj1h+GQaKbAgIrpV2mUQYV
	meclrOFS0WwBzZlsIyVxG94rRstmamJYRQ1v4vrgLGmDcCOs5/lIXLl9UdzBvHba
	L9bzwEyHdKW98x19jb9Kpb99pWhR/fUIHMR/9fDpVY2rms6wb4v6CBam0C+EXWP0
	FK9nAk8=
X-Sasl-enc: ccoBS28UBPljL1EP8zJUCxd1Oa7hLrtfpE/GDCA+4hb0 1466149580
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1C91DCCD34;
	Fri, 17 Jun 2016 03:46:20 -0400 (EDT)
From:	Michael J Gruber <git@drmicha.warpmail.net>
To:	git@vger.kernel.org
Subject: [PATCH 5/5] Documentation/technical: push certificate format
Date:	Fri, 17 Jun 2016 09:46:12 +0200
Message-Id: <b2557387aeea4b34da4a5b28e87063d1f2c9ff69.1466148698.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.9.0.382.g87fd384
In-Reply-To: <cover.1466148698.git.git@drmicha.warpmail.net>
References: <cover.1466148698.git.git@drmicha.warpmail.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/technical/signature-format.txt | 56 ++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
index 7afd403..c50602f 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/technical/signature-format.txt
@@ -184,3 +184,59 @@ Date:   Wed Jun 15 09:13:29 2016 +0000
     # gpg:          There is no indication that the signature belongs to the owner.
     # Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
 ----
+
+== Push certificates
+
+- created by: `git push --signed`
+- payload: a push certificate header followed by the push transcript
+  (see pack-protocol.txt and below)
+- embedding: append the signature to the push transcript and pass it to receive hooks
+  via the environment (see below)
+- example: push of commit `dd1416f` updating `master` on `.` from `d36de3d`,
+  resulting in push certificate object `d4169b9`:
+
+----
+certificate version 0.1
+pusher C O Mitter <committer@example.com> 1465983405 +0000
+pushee .
+nonce 1465983405-07421dc1515c6f4d76d4
+
+d36de3db9b6a83076477254a3186b721a7bfaab7 dd1416f2cd1ec85957a9520a33e9053a133a775d refs/heads/master
+-----BEGIN PGP SIGNATURE-----
+Version: GnuPG v1
+
+iEYEABECAAYFAldhIa0ACgkQE7b1Hs3eQw2pGwCgmJs98xETSDZb6rooh/X7af3V
+zWgAn08ctVNga27jRkIdhFNetJy3x8De
+=WH0m
+-----END PGP SIGNATURE-----
+----
+
+- verify with: `git verify-tag --blob [-v]`
+
+----
+gpg: Signature made Wed Jun 15 11:36:45 2016 CEST using DSA key ID CDDE430D
+gpg: Good signature from "C O Mitter <committer@example.com>"
+certificate version 0.1
+pusher C O Mitter <committer@example.com> 1465983405 +0000
+pushee .
+nonce 1465983405-07421dc1515c6f4d76d4
+
+d36de3db9b6a83076477254a3186b721a7bfaab7 dd1416f2cd1ec85957a9520a33e9053a133a775d refs/heads/master
+----
+
+- pre- and post-receive hook input:
+
+----
+d36de3db9b6a83076477254a3186b721a7bfaab7 dd1416f2cd1ec85957a9520a33e9053a133a775d refs/heads/master
+----
+
+- pre- and post-receive hook environment:
+
+----
+GIT_PUSH_CERT_NONCE_STATUS=OK
+GIT_PUSH_CERT_KEY=13B6F51ECDDE430D
+GIT_PUSH_CERT=d4169b9a3c2674458f9656796132c145bbc5ba74
+GIT_PUSH_CERT_STATUS=G
+GIT_PUSH_CERT_SIGNER=C O Mitter <committer@example.com>
+GIT_PUSH_CERT_NONCE=1465983405-07421dc1515c6f4d76d4
+----
-- 
2.9.0.382.g87fd384

