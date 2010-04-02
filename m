From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH 1/3] Attr: Fixed debug output for macro expansion.
Date: Fri,  2 Apr 2010 21:33:39 +0200
Message-ID: <ca1f7f974d72a036dd8369309d487bbd047a8e2d.1270236242.git.grubba@grubba.org>
References: <cover.1270236242.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 21:34:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxmd8-0003Cl-QS
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 21:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab0DBTeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 15:34:05 -0400
Received: from mail.roxen.com ([212.247.29.220]:53673 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333Ab0DBTeC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 15:34:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 6005762817C
	for <git@vger.kernel.org>; Fri,  2 Apr 2010 21:34:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NdCRHzFK-6aw; Fri,  2 Apr 2010 21:33:59 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 0CA32628163;
	Fri,  2 Apr 2010 21:33:59 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o32JXwFn026558;
	Fri, 2 Apr 2010 21:33:58 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o32JXwZI026557;
	Fri, 2 Apr 2010 21:33:58 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3.316.g33b5e
In-Reply-To: <cover.1270236242.git.grubba@grubba.org>
In-Reply-To: <cover.1270236242.git.grubba@grubba.org>
References: <cover.1270236242.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143842>

When debug_set() was called during macro expansion, it
received a pointer to a struct git_attr rather than a
string.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 attr.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index f5346ed..5c6464e 100644
--- a/attr.c
+++ b/attr.c
@@ -605,7 +605,9 @@ static int fill_one(const char *what, struct match_=
attr *a, int rem)
 		const char *v =3D a->state[i].setto;
=20
 		if (*n =3D=3D ATTR__UNKNOWN) {
-			debug_set(what, a->u.pattern, attr, v);
+			debug_set(what,
+				  a->is_macro?a->u.attr->name:a->u.pattern,
+				  attr, v);
 			*n =3D v;
 			rem--;
 		}
--=20
1.7.0.3.316.g33b5e
