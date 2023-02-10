Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892D2C636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 06:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjBJGSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 01:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjBJGSN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 01:18:13 -0500
Received: from tilde.club (tilde.club [142.44.150.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDFC74338
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 22:17:51 -0800 (PST)
Received: from tilde.club (tor-exit-35.for-privacy.net [185.220.101.35])
        by tilde.club (Postfix) with ESMTPSA id 1D186220C8162;
        Fri, 10 Feb 2023 06:17:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 1D186220C8162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1676009858; bh=9iG0PEHreAL9grD3gTrQlwNjn9sed6cbu6aS5JEjZVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnHG3ZQetodP1g5rCN7omOHxHEGKzVbWWnti4gesR5rWYJXZip4hx08Vel/NDriwL
         u1vDZ5TsU3GE2FsoQ5eIsTKI1dI8yBiEwHIomUw3iYMq5TZXn+xLJrygpNv8xJ9k/a
         A9IxGQoklaA6PERxWuNwmSYhbnwMA/Wf9V/p+EQ0=
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: [PATCH v2] signature-format.txt: note SSH and X.509 signature delimiters
Date:   Fri, 10 Feb 2023 06:16:11 +0000
Message-Id: <20230210061611.124932-1-gwymor@tilde.club>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20220120053223.221667-1-gwymor@tilde.club>
References: <20220120053223.221667-1-gwymor@tilde.club>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This document only explained PGP signatures, but Git now supports X.509
and SSH signatures.

Signed-off-by: Gwyneth Morgan <gwymor@tilde.club>
---
 Documentation/gitformat-signature.txt | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitformat-signature.txt b/Documentation/gitformat-signature.txt
index d8e3eb1bac..5f0c9202e3 100644
--- a/Documentation/gitformat-signature.txt
+++ b/Documentation/gitformat-signature.txt
@@ -17,12 +17,26 @@ DESCRIPTION
 Git uses cryptographic signatures in various places, currently objects (tags,
 commits, mergetags) and transactions (pushes). In every case, the command which
 is about to create an object or transaction determines a payload from that,
-calls gpg to obtain a detached signature for the payload (`gpg -bsa`) and
-embeds the signature into the object or transaction.
-
-Signatures always begin with `-----BEGIN PGP SIGNATURE-----`
-and end with `-----END PGP SIGNATURE-----`, unless gpg is told to
-produce RFC1991 signatures which use `MESSAGE` instead of `SIGNATURE`.
+calls an external program to obtain a detached signature for the payload
+(`gpg -bsa` in the case of PGP signatures), and embeds the signature into the
+object or transaction.
+
+Signatures begin with an ASCII Armor header line and end with a tail line,
+which differ depending on signature type.
+
+PGP::
+	Signatures begin with `-----BEGIN PGP SIGNATURE-----` and end
+	with `-----END PGP SIGNATURE-----`, unless gpg is told to
+	produce RFC1991 signatures which use `MESSAGE` instead of
+	`SIGNATURE`.
+
+SSH::
+	Signatures begin with `-----BEGIN SSH SIGNATURE-----` and end
+	with `-----END SSH SIGNATURE-----`.
+
+X.509::
+	Signatures begin with `-----BEGIN SIGNED MESSAGE-----` and end
+	with `-----END SIGNED MESSAGE-----`.
 
 Signatures sometimes appear as a part of the normal payload
 (e.g. a signed tag has the signature block appended after the payload
