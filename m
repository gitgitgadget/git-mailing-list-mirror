From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/16] commit_tree(): rewriting/replacing new commits
Date: Sat, 31 Jul 2010 23:18:23 +0700
Message-ID: <1280593105-22015-15-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOSj-0003As-SG
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab0HACjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:39:37 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42790 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0HACjf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:39:35 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so977126pwi.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=IpBVo+q3I1HRcUqO7wdfHMU5poDAfxwadETjr7gjX8o=;
        b=pddiADBnjal4CS8t0oGVYaGBZPdyWTWti1DARgPQ9kBFWzsJgMfRLvXOi1fN96iTJI
         M/aU/Y7tM27sZHducNSlU3m/s5hDEJk8RxPM+fN3A91GBQchuff4JkYd+LVHLPDOWeWC
         IFFgsTkhZiJfgTgN9Qm9muRMi5M07AJnBEqA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UMCuZ123wzL6hBhjdGEZGbKTkeYCs1YWOVRFWubfLs1TR2NFxShvSyEJj2foQcua5a
         X7W5ABYEDwAKN2Y8kw9DO8Z5nv24o/LM412rpMaOcpLqEg8k4yS9OXvNNJAQ5A/9wChW
         OGtCblMQYlwBd8FNi4jkTg4jw2kaOc+p8f0P8=
Received: by 10.114.110.10 with SMTP id i10mr4867380wac.70.1280630375703;
        Sat, 31 Jul 2010 19:39:35 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id c24sm7702518wam.19.2010.07.31.19.39.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:39:34 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:20:29 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152361>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 7121631..258d3fb 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "subtree.h"
=20
 int save_commit_buffer =3D 1;
=20
@@ -858,5 +859,12 @@ int commit_tree(const char *msg, unsigned char *tr=
ee, unsigned char *base_tree,
=20
 	result =3D write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
 	strbuf_release(&buffer);
+
+	if (core_subtree && !result) {
+		unsigned char subtree_commit[20];
+		memcpy(subtree_commit, ret, 20);
+		result =3D subtree_export(subtree_commit, base_tree, ret);
+	}
+
 	return result;
 }
--=20
1.7.1.rc1.69.g24c2f7
