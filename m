From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v4 6/8] attr: Fixed debug output for macro expansion.
Date: Tue,  6 Apr 2010 14:46:42 +0200
Message-ID: <11fd448fbc25ce76a1fb2eb52df6e260e34014ad.1270554878.git.grubba@grubba.org>
References: <cover.1270554878.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 14:47:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz8Bl-0004uy-9Z
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 14:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490Ab0DFMrG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 08:47:06 -0400
Received: from mail.roxen.com ([212.247.29.220]:51189 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755403Ab0DFMqx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 08:46:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id CA63E62818D
	for <git@vger.kernel.org>; Tue,  6 Apr 2010 14:46:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iHcpalq6IPo9; Tue,  6 Apr 2010 14:46:52 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id AD021628173;
	Tue,  6 Apr 2010 14:46:52 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o36Ckqod028662;
	Tue, 6 Apr 2010 14:46:52 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o36CkqaT028661;
	Tue, 6 Apr 2010 14:46:52 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3.316.g33b5e
In-Reply-To: <cover.1270554878.git.grubba@grubba.org>
In-Reply-To: <cover.1270554878.git.grubba@grubba.org>
References: <cover.1270554878.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144136>

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
