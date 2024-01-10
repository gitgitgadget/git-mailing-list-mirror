Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F7317F5
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="fdeKsflp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=t1iCVWOyljqyKfQt+KCPATDidX7XmwZo1fwCdaNzvks=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=fdeKsflp0fdtt/Uy6Aq0slW4EzPKzscYSfdEEpReVdYcB2xq4CFzOipV6tzcRV7OQbbU82w/4R/a
        vf+awkhF1XKoX8OxEQYghrvTi9GWfvQPLWW1MHzXOoSQL07W/JY89alY0FIz6s/lhnYL+yQVkwmA
        XrYfQFF5LvUAaIlt1gc=
Received: by smtp-relay.sendinblue.com with ESMTP id 2b804019-aaa4-4f7c-8892-b05a6ee58abb; Wed, 10 January 2024 02:03:51 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTEwMDIwMzQ3LjY3MzE1NS0zLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Tue,  9 Jan 2024 17:03:44 -0900
Subject: [PATCH v2 2/5] completion: git-log opts to bisect visualize
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 370A452026A; Tue,  9 Jan 2024 17:03:49 -0900 (AKST)
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
Message-Id: <2b804019-aaa4-4f7c-8892-b05a6ee58abb@smtp-relay.sendinblue.com>
Origin-messageId: <20240110020347.673155-3-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: -1Fbr-jdOR3jGrUTQG2RhRUS8uA8fDHyN80Do-JnHLiuBgyEedwtvdtytr85fbNS-Hfaxr2ANj4F7C-L4mGigF9C9s024VRODTR1IOIQNCAnwujKpIAF7Lo_ed7TqyvscgnmOznrhokiMQHejA98yhlfBE3iwNfp1q61W3mcdFXg
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

To do this the majority of =5Fgit=5Flog has been factored out into the new
=5F=5Fgit=5Fcomplete=5Flog=5Fopts.  This is needed because the visualize =
command
accepts git-log options but not rev arguments (they are fixed to the
commits under bisection).

=5F=5Fgit=5Fcomplete=5Flog=5Fopts has a precondition that COMPREPLY be =
empty.  In
a completion context it doesn't seem advisable to implement
preconditions as noisy or hard failures, so instead it becomes a no-op
on violation.  This should be detectable and quick to debug for devels,
without ever aggravating a user (besides completion failure).

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 30 +++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index 15d22ff7d9..c16aded36c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1472,6 +1472,16 @@ =5Fgit=5Fbisect ()
 			;;
 		esac
 		;;
+	visualize)
+		case =22$cur=22 in
+		-*)
+			=5F=5Fgit=5Fcomplete=5Flog=5Fopts
+			return
+			;;
+		*)
+			;;
+		esac
+		;;
 	esac
=20
 	case =22$subcommand=22 in
@@ -2074,10 +2084,14 @@ =5F=5Fgit=5Fdiff=5Fmerges=5Fopts=3D=22off none on =
first-parent 1 separate m combined c dense-c
 =5F=5Fgit=5Flog=5Fpretty=5Fformats=3D=22oneline short medium full fuller =
reference email raw format: tformat: mboxrd=22
 =5F=5Fgit=5Flog=5Fdate=5Fformats=3D=22relative iso8601 iso8601-strict =
rfc2822 short local default human raw unix auto: format:=22
=20
-=5Fgit=5Flog ()
+
+# Check for only porcelain (i.e. not git-rev-list) option (not argument)
+# and selected option argument completions for git-log options and if any
+# are found put them in COMPREPLY.  COMPREPLY must be empty at the start,
+# and will be empty on return if no candidates are found.
+=5F=5Fgit=5Fcomplete=5Flog=5Fopts ()
 {
-	=5F=5Fgit=5Fhas=5Fdoubledash && return
-	=5F=5Fgit=5Ffind=5Frepo=5Fpath
+	[ -z =22$COMPREPLY=22 ] || return 1   # Precondition
=20
 	local merge=3D=22=22
 	if [ -f =22$=5F=5Fgit=5Frepo=5Fpath/MERGE=5FHEAD=22 ]; then
@@ -2171,6 +2185,16 @@ =5Fgit=5Flog ()
 		return
 		;;
 	esac
+}
+
+=5Fgit=5Flog ()
+{
+	=5F=5Fgit=5Fhas=5Fdoubledash && return
+	=5F=5Fgit=5Ffind=5Frepo=5Fpath
+
+        =5F=5Fgit=5Fcomplete=5Flog=5Fopts
+        [ -z =22$COMPREPLY=22 ] || return
+
 	=5F=5Fgit=5Fcomplete=5Frevlist
 }
=20
--=20
2.43.0


