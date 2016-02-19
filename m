From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe@aidecoe.name>
Subject: [PATCH] git-p4.py: Don't try to rebase on submit from bare repository
Date: Fri, 19 Feb 2016 18:27:11 +0000
Message-ID: <1455906431-32140-1-git-send-email-aidecoe@aidecoe.name>
References: <xmqqy4agd3b1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, aidecoe@aidecoe.name
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 19:27:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWpm0-0001XE-6j
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 19:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947410AbcBSS1U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2016 13:27:20 -0500
Received: from jim.zolnowski.name ([188.116.54.122]:46026 "EHLO
	jim.zolnowski.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946084AbcBSS1T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 13:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aidecoe.name; s=jim;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=TAGFLmwgRBfEJJQiuNsYz0FFkuD0mASXIuUuMO0/PVg=;
	b=o7jRBQmFV7JooRd0ggLnPtd0ndoeI62+llISjByqPPNdOkRSKY2hZ24/7OGVC93fF1fuO7b6WXNvRY4Z5ch3tfDvTYT8GAlsPuMbEcPzGlxk/rnOGlqw8gzsHy95cM9/M8wlfQQ4GBL7qGbxgy/3+WonWHSigVx7Ki780gghHl2gI4qf2PSAuZ9jrTtvTyk5kdEjDelH5nWNg3w1XrUZN+bQzcKyKMxqFIpTutjiHldJ5KSTSdymAltKAr4UTEd51vyWtxXt3FL4DdjXlj+Q3FdPRsvKI0Purqa3AWpVQbHTmKafMZ4IRKYnKTSm+mSIPy/EEsSqimb7UsdozVTUfg==;
Received: from cpc92302-cmbg19-2-0-cust189.5-4.cable.virginm.net ([82.1.208.190] helo=localhost)
	by jim.zolnowski.name with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.85)
	(envelope-from <aidecoe@aidecoe.name>)
	id 1aWplt-0008AJ-4Y; Fri, 19 Feb 2016 19:27:17 +0100
X-Mailer: git-send-email 2.7.0
In-Reply-To: <xmqqy4agd3b1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286736>

git-p4 can be successfully used from bare repository (which acts as a
bridge between Perforce repository and pure Git repositories). On submi=
t
git-p4 performs unconditional rebase. Do rebase only on non-bare
repositories.

Signed-off-by: Amadeusz =C5=BBo=C5=82nowski <aidecoe@aidecoe.name>
---
 git-p4.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c33dece..e00cd02 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2059,8 +2059,9 @@ class P4Submit(Command, P4UserMap):
                 sync.branch =3D self.branch
             sync.run([])
=20
-            rebase =3D P4Rebase()
-            rebase.rebase()
+            if not gitConfigBool("core.bare"):
+                rebase =3D P4Rebase()
+                rebase.rebase()
=20
         else:
             if len(applied) =3D=3D 0:
--=20
2.7.0
