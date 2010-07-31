From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/16] clone: support subtree clone with parameter --subtree
Date: Sat, 31 Jul 2010 23:18:19 +0700
Message-ID: <1280593105-22015-11-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:39:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOSH-00032o-1I
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab0HACjH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:39:07 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50084 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0HACjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:39:04 -0400
Received: by pxi14 with SMTP id 14so977684pxi.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=kZdPP5H1S0WvFRJ2epehMuxg+ovWksPnUaeuQa+ukAM=;
        b=rGWzFcQdy4TNwWcM8IKSeVSYrQWLAviM0R5Z+/q9JI00A5jonNN1jZ94CadNF6tY5J
         cGhGLGqMk/NPLak9U63pk/m3n9GjjWMhmjK9vm3DTETGceN7MuW6K/MVa8fUnTXjf0dh
         XBnpy1e6ASGbMxaA6Wa340YOvl/L+UAvAVI1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=g4EN141NNn5hvujVvr136p0ddUiWG/CEJ0MN4H0qOxwOBGfI9RczLIdHdu7eQac9dz
         QmQnyCgVQ1ZVpAtTD0z62gbhfYX/Z7W2wPQg2+9mtO6l+KLxwERrvKeliG0MUOUS/bzW
         6THrXnYB+MIQD+RYXzSayQ7+CBIMSWdPJFCYw=
Received: by 10.114.38.1 with SMTP id l1mr4904818wal.41.1280630342824;
        Sat, 31 Jul 2010 19:39:02 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id d38sm7701807wam.20.2010.07.31.19.38.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:39:01 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:19:56 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152357>

With all the preparation work, here comes --subtree. So clone away!

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index efb1e6f..43bc34b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -23,6 +23,7 @@
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
+#include "subtree.h"
=20
 /*
  * Overall FIXMEs:
@@ -78,6 +79,8 @@ static struct option builtin_clone_options[] =3D {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
+	OPT_STRING(0, "subtree", &core_subtree, "subtree",
+		   "subtree clone"),
=20
 	OPT_END()
 };
@@ -515,6 +518,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	strbuf_reset(&value);
=20
 	if (path && !is_bundle) {
+		if (core_subtree)
+			die("Local subtree clone does not work (now)");
 		refs =3D clone_local(path, git_dir);
 		mapped_refs =3D wanted_peer_refs(refs, refspec);
 	} else {
@@ -623,6 +628,11 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		transport_disconnect(transport);
 	}
=20
+	if (core_subtree) {
+		git_config_set("core.subtree", core_subtree);
+		subtree_import();
+	}
+
 	if (!option_no_checkout) {
 		struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file))=
;
 		struct unpack_trees_options opts;
--=20
1.7.1.rc1.69.g24c2f7
