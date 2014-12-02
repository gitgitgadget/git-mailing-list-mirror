From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t/lib-gpg: adjust permissions for gnupg 2.1
Date: Tue,  2 Dec 2014 14:40:27 +0100
Message-ID: <9c28f16c677bbc774e5b8dfc79b6ffe2c55d1720.1417527514.git.git@drmicha.warpmail.net>
References: <547DB6C3.5010704@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 14:40:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvnh6-0003Q3-77
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 14:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbaLBNkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 08:40:33 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48919 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932151AbaLBNka (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 08:40:30 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 1EC5A21426
	for <git@vger.kernel.org>; Tue,  2 Dec 2014 08:40:29 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 02 Dec 2014 08:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=irN8CGZ/GTrp4v
	l8bewWGKhJp4k=; b=QlCqhVWwUOhJYoXKjLGHfBfGC9cGpmUXby/dkiXVbRaGrq
	ZoU6pA3SZPgbqavO6mdvYkzGAhH1KGQMMKuwFadaC3d8rToNRZkgk9KzEQBviSCG
	nbOc9PgLsrR0obowQAO29yzwLvPJ8ktacwlpIpQUWCDr2Gz07YRZAvAMkNVhE=
X-Sasl-enc: g9+Ift4c28cGnVAVZGsUQLeZcxSVTSRcHLrit7MhyLLp 1417527628
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B8E496801A2;
	Tue,  2 Dec 2014 08:40:28 -0500 (EST)
X-Mailer: git-send-email 2.2.0.rc3.286.g888a711
In-Reply-To: <547DB6C3.5010704@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260569>

Before gnupg 2.1 (aka "modern branch"), gpghome would contain only files
which allowed t/lib-gpg.sh to set permissions explicitely, and we did
that since
28a1b07 (t/lib-gpg: adjust permissions for gnupg 2.1, 2014-12-02)
in order to adjust wrong permissions from a checkout on ro file systems.

gnupg 2.1 creates a new directory in gpghome which would get its x bit removed.

Adjust and use +X so that any directory would get its x bit set. This
also keeps the x bit on files which had it set for whatever wrong
reason, but we care only about having at least the necessary
permissions for the tests to run.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Something like this?
Untested for lack of gpg2.1

 t/lib-gpg.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index cd2baef..25ca12d 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -17,8 +17,7 @@ else
 		# Name and email: C O Mitter <committer@example.com>
 		# No password given, to enable non-interactive operation.
 		cp -R "$TEST_DIRECTORY"/lib-gpg ./gpghome
-		chmod 0700 gpghome
-		chmod 0600 gpghome/*
+		chmod -R u+rwX gpghome
 		GNUPGHOME="$(pwd)/gpghome"
 		export GNUPGHOME
 		test_set_prereq GPG
-- 
2.2.0.rc3.286.g888a711
