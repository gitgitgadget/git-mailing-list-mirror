From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [PATCH v2] git-clone: Add option --branch to override initial branch
Date: Tue,  3 Mar 2009 01:33:34 +0100
Message-ID: <1236040414-19089-1-git-send-email-torarnv@gmail.com>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 01:32:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeIY8-00025g-5f
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 01:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbZCCAa3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 19:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbZCCAa2
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 19:30:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:51731 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbZCCAa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 19:30:27 -0500
Received: by fg-out-1718.google.com with SMTP id 16so10715fgg.17
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 16:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KASJAzKbidhNfpOxzVgG6tzGgvSLusK1ojeQltDWTr8=;
        b=f3LfpbA3/sgyQFF49Lz7Kyk27kiXNezMMb3cpwE1BfR5t3Zk2E8606VSNABwYpQ5Kc
         71sBTNSkMSxgsA7af2DX/0PTpEvEt1+/sSxAHoV0tZ2oBtKApB5UGAlT1a9H8XYXd7/F
         q5ZkcAbLDCRak8NXwjhOYq22zsdMq7VuFv/0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KygwQcV7AwihlHD31qWLSPzTXh31EI4m1UhewyQy+4nZVB0MTt6sKfpPDvhXcFxRO1
         IiYfRoP7tLNT6xLI4WsjL9WvEidFXfvQNuDd7l+2I2HKaOBPmBGxKSmOk2f7nwHBo8wb
         ++mYTVrNXbifZsMsmyWD++yu2jTa83BblrsiY=
Received: by 10.86.61.13 with SMTP id j13mr3319177fga.59.1236040224771;
        Mon, 02 Mar 2009 16:30:24 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 12sm54708fgg.43.2009.03.02.16.30.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Mar 2009 16:30:24 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id F2B5E468001; Tue,  3 Mar 2009 01:33:34 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc2.17.g2aa38
In-Reply-To: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111983>

The options --branch and -b allow the user to override the initial
branch created and checked out by git-clone (normally this is the
active branch of the remote repository).

If the selected branch is not found the operation aborts.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---

Something like this?

Documentation/git-clone.txt |    5 +++++
 builtin-clone.c             |   32 ++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 95f08b9..e7feb4d 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -119,6 +119,11 @@ then the cloned repository will become corrupt.
 	Instead of using the remote name 'origin' to keep track
 	of the upstream repository, use <name> instead.
=20
+--branch <name>::
+-b <name>::
+	Instead of using the remote repository's active branch as the
+	initial branch, use <name> instead.
+
 --upload-pack <upload-pack>::
 -u <upload-pack>::
 	When given, and the repository to clone from is accessed
diff --git a/builtin-clone.c b/builtin-clone.c
index c338910..5fc01ce 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -38,6 +38,7 @@ static int option_quiet, option_no_checkout, option_b=
are, option_mirror;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin =3D NULL;
+static char *option_branch =3D NULL;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbose;
=20
@@ -66,6 +67,8 @@ static struct option builtin_clone_options[] =3D {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
+	OPT_STRING('b', "branch", &option_branch, "branch",
+		    "initial remote branch to check out"),
=20
 	OPT_END()
 };
@@ -372,7 +375,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir;
 	int dest_exists;
-	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
+	const struct ref *refs, *mapped_refs;
+	const struct ref *remote_head =3D NULL;
+	const struct ref *head_points_at =3D NULL;
 	struct strbuf key =3D STRBUF_INIT, value =3D STRBUF_INIT;
 	struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INIT;
 	struct transport *transport =3D NULL;
@@ -545,12 +550,31 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
=20
 		mapped_refs =3D write_remote_refs(refs, &refspec, reflog_msg.buf);
=20
-		head_points_at =3D locate_head(refs, mapped_refs, &remote_head);
+		if (option_branch) {
+		    const int offset =3D 11;
+		    const char *branch =3D option_branch;
+		    if (!prefixcmp(branch, "refs/heads/"))
+			branch +=3D offset;
+
+		    const struct ref *r;
+		    for (r =3D mapped_refs; r; r =3D r->next) {
+			if (!strcmp(r->name + offset, branch)) {
+			    /* Override initial branch */
+			    head_points_at =3D r;
+			    remote_head =3D r;
+			    break;
+			}
+		    }
+
+		    if (!head_points_at)
+			die("remote has no branch named '%s'.", option_branch);
+
+		} else {
+		    head_points_at =3D locate_head(refs, mapped_refs, &remote_head);
+		}
 	}
 	else {
 		warning("You appear to have cloned an empty repository.");
-		head_points_at =3D NULL;
-		remote_head =3D NULL;
 		option_no_checkout =3D 1;
 		if (!option_bare)
 			install_branch_config("master", option_origin,
--=20
1.6.2.rc2.17.g2aa38
