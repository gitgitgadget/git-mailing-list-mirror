From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/10] branch: request resolve_ref() to allocate new buffer
Date: Tue, 15 Nov 2011 13:07:56 +0700
Message-ID: <1321337276-17803-10-git-send-email-pclouds@gmail.com>
References: <20111115060603.GA17585@tre>
 <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 07:06:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQCA1-0005p2-0o
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 07:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab1KOGGO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 01:06:14 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:51083 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab1KOGGM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 01:06:12 -0500
Received: by mail-pz0-f42.google.com with SMTP id 36so14545629pzk.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 22:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k5gdSLll1zvjWE9+jFjeq4iod1aiZqxxmEr/WQb03Po=;
        b=P5tjhaP/JiKABzk82So6jf7vUlfP4rZQy6YnhS+Mg4TNe6G9ti8akXelsUTSHMPUjh
         j8DGz7e8AOk0Art6wUzXVBhvfPOrBYC9Qm93ULSHdnJCPDUpK3VzGcVlVoDKftknVSzD
         AsGUCh4abUzc6YCchPyanVsA5R3D1I1rIq72U=
Received: by 10.68.39.98 with SMTP id o2mr57445657pbk.119.1321337172075;
        Mon, 14 Nov 2011 22:06:12 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id wn14sm62432022pbb.5.2011.11.14.22.06.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 22:06:11 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Nov 2011 13:08:56 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185431>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 43b494c..7a31b1e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -103,7 +103,7 @@ static int branch_merged(int kind, const char *name=
,
 	 * safely to HEAD (or the other branch).
 	 */
 	struct commit *reference_rev =3D NULL;
-	const char *reference_name =3D NULL;
+	char *reference_name =3D NULL;
 	int merged;
=20
 	if (kind =3D=3D REF_LOCAL_BRANCH) {
@@ -115,7 +115,7 @@ static int branch_merged(int kind, const char *name=
,
 		    branch->merge[0] &&
 		    branch->merge[0]->dst &&
 		    (reference_name =3D
-		     resolve_ref(branch->merge[0]->dst, sha1, 1, NULL, 0)) !=3D NULL=
)
+		     resolve_ref(branch->merge[0]->dst, sha1, 1, NULL, 1)) !=3D NULL=
)
 			reference_rev =3D lookup_commit_reference(sha1);
 	}
 	if (!reference_rev)
@@ -141,6 +141,7 @@ static int branch_merged(int kind, const char *name=
,
 				"         '%s', even though it is merged to HEAD."),
 				name, reference_name);
 	}
+	free(reference_name);
 	return merged;
 }
=20
--=20
1.7.4.74.g639db
