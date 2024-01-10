Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688217F1
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="b+qKSQOU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=3TYULjfEdCjy9zNvlzCO2uBs1FJOXcUCdPf28hyJsG4=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=b+qKSQOUbl9oT5qFJY9iIhcoduSqS7q1qAF9dCpcb0gjn1MO0WfSFdoCJpU5PFEvHOErhFd0Ax1J
        XgeVMv1B/d9IueiNTkSDL/6mKZua0pNZLUS9xwietdkFh1waGDGcnFnlEdLo/ww5QlNAJrKIq8a0
        M0wsG6CrR7y7faZWmeo=
Received: by smtp-relay.sendinblue.com with ESMTP id 2031a7b7-ddd4-4467-9274-90896d0906f4; Wed, 10 January 2024 02:03:51 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTEwMDIwMzQ3LjY3MzE1NS01LWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Tue,  9 Jan 2024 17:03:46 -0900
Subject: [PATCH v2 4/5] completion: custom git-bisect terms
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 3CB8252026C; Tue,  9 Jan 2024 17:03:49 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110020347.673155-1-britton.kerin@gmail.com>
References: <9e180f50-4bf4-4822-9b02-2a1b50114e09@smtp-relay.sendinblue.com> <20240110020347.673155-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <2031a7b7-ddd4-4467-9274-90896d0906f4@smtp-relay.sendinblue.com>
Origin-messageId: <20240110020347.673155-5-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: SiYY3ErAIo-yIgJO7SI9JN2dG6lMvihkwmO34gi14k2usQsOo-dOW_Qs9sRyTd59C0tTNwTMCnNCNN6nl7cMdpndwzn5w9eELbGBvkDT6TW584i09RpaZflQ4mEqJHkt4PD0B00j_RM4H7i3cLYS86KAdYjCaWxaGgJfU6GzhWvG
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index 63ca8082a4..ad80df6630 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1583,10 +1583,19 @@ =5Fgit=5Fbisect ()
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
@@ -1619,7 +1628,7 @@ =5Fgit=5Fbisect ()
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


