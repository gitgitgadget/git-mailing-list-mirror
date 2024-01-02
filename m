Received: from bi.d.mailin.fr (bi.d.mailin.fr [185.41.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F716415
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bi.d.mailin.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="GmLdWdOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=OJAZlgtb2of+PzCihRXxYKS52QcBToY7nm64FTyNJRk=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=GmLdWdOXwi/tk0VAK1uOXGEN8yyno4UOZun8CAvhmw/dmhmLpWF64CvUltZXW84rtATeAoUSSbf1
        O2muFNhGLOD7c9vOt4sCt3KRW+pysiQNMi/iQBUi7R4zIbHEJQ8KLAG706WWaVUDe7x4mYV+hpv0
        nnKaxT/LsRH7h+9+Neg=
Received: by smtp-relay.sendinblue.com with ESMTP id ed2116c7-88ed-4fa9-9286-89a945ce9e50; Tue, 02 January 2024 19:57:54 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTAyMTk1NzQ0LjQ3ODUwMy01LWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5iaS5kLm1haWxpbi5mcg%3D%3D
Date: Tue,  2 Jan 2024 10:57:42 -0900
Subject: [RFC PATCH 4/6] completion: custom git-bisect terms
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 57F2E520261; Tue,  2 Jan 2024 10:57:52 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102195744.478503-1-britton.kerin@gmail.com>
References: <20240102195744.478503-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <ed2116c7-88ed-4fa9-9286-89a945ce9e50@smtp-relay.sendinblue.com>
Origin-messageId: <20240102195744.478503-5-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: V0njMbMIJ-l1zf8UDl-DPfrSgUh_rUU9CF9VNiNOCLXuhCUCTXPwrxVjmEFQvpkLTZSiW0EHjMSHSac-lB5qosiafXgGwpMSPOAHY-OG6CHcq6hbjE1GkiEwdsf00Mk1Z1jtnSuFnpMvvvs0mnK-_yP9fSHtob_wxjqV0yb-CjP-
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.109:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index 4940ad3e24..a09598c5c1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1581,10 +1581,19 @@ =5Fgit=5Fbisect ()
 {
 	=5F=5Fgit=5Fhas=5Fdoubledash && return
=20
-	local subcommands=3D=22start bad new good old terms skip reset visualize =
replay log run help=22
+	=5F=5Fgit=5Ffind=5Frepo=5Fpath
+
+	local term=5Fbad term=5Fgood
+	if [ -f =22$=5F=5Fgit=5Frepo=5Fpath=22/BISECT=5FSTART ]; then
+		term=5Fbad=3D`=5F=5Fgit bisect terms --term-bad`
+		term=5Fgood=3D`=5F=5Fgit bisect terms --term-good`
+	fi
+
+	local subcommands=3D=22start bad new $term=5Fbad good old $term=5Fgood =
terms skip reset visualize replay log run help=22
+
 	local subcommand=3D=22$(=5F=5Fgit=5Ffind=5Fon=5Fcmdline =
=22$subcommands=22)=22
+
 	if [ -z =22$subcommand=22 ]; then
-		=5F=5Fgit=5Ffind=5Frepo=5Fpath
 		if [ -f =22$=5F=5Fgit=5Frepo=5Fpath=22/BISECT=5FSTART ]; then
 			=5F=5Fgitcomp =22$subcommands=22
 		else
@@ -1617,7 +1626,7 @@ =5Fgit=5Fbisect ()
 	esac
=20
 	case =22$subcommand=22 in
-	bad|new|good|old|reset|skip|start)
+	bad|new|=22$term=5Fbad=22|good|old|=22$term=5Fgood=22|reset|skip|start)
 		=5F=5Fgit=5Fcomplete=5Frefs
 		;;
 	*)
--=20
2.43.0


