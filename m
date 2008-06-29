From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] git cat-file: Fix memory leak in batch mode
Date: Sun, 29 Jun 2008 03:21:25 +0200
Message-ID: <20080629012125.GA1722@atjola.homenet>
References: <20080629005858.GA2036@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Adam Roben <aroben@apple.com>,
	Samuel Bronson <naesten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 03:23:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCld8-0003aU-FO
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 03:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbYF2BVa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jun 2008 21:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbYF2BV3
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 21:21:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:48540 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752792AbYF2BV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 21:21:29 -0400
Received: (qmail invoked by alias); 29 Jun 2008 01:21:27 -0000
Received: from i577BB248.versanet.de (EHLO atjola.local) [87.123.178.72]
  by mail.gmx.net (mp066) with SMTP; 29 Jun 2008 03:21:27 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+gGxovovWgB4ddytYFwUKjq3sV+ROwLPD0CG/zt6
	9JYsxuXxrmYIhu
Content-Disposition: inline
In-Reply-To: <20080629005858.GA2036@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86753>

When run in batch mode, git cat-file never frees the memory for the blo=
b
contents it is printing. This quickly adds up and causes git-svn to be
hardly usable for imports of large svn repos, because it uses cat-file =
in
batch mode and cat-file's memory usage easily reaches several hundred M=
B
without any good reason.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 builtin-cat-file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index bd343ef..f966dcb 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -183,6 +183,7 @@ static int batch_one_object(const char *obj_name, i=
nt print_contents)
 		fflush(stdout);
 	}
=20
+	free(contents);
 	return 0;
 }
=20
--=20
1.5.6.1.94.gd3899.dirty
