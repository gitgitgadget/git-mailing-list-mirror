Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4911725
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="zbkmKO2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=1gxtnAgcErlaCc5oSBJKnLEVg7XiRs+rUgFO0WlZG3U=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=zbkmKO2IvmT9/h2XTBemDlKeX9kSfyRFGn57rW9qGLggAu/Bvme05EoaI3rMWbh5duPrCgXar1rJ
        Vxl54FiRYFha7tSPFPhZ6NpKdo/mJcByUhOks8I7s/BbfLKDoT3zqp4ziIu677jREiq9QTK24PrN
        Qd0caU9z1YymzSP+Bto=
Received: by smtp-relay.sendinblue.com with ESMTP id 8a8dfcfc-3369-42b8-8387-f1af33202b16; Sun, 07 January 2024 21:42:03 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTA3MjE0MjAwLjI5Njg0LTItYnJpdHRvbi5rZXJpbkBnbWFpbC5jb20%2BfmFhLmQuc2VuZGVyLXNpYi5jb20%3D
Date: Sun,  7 Jan 2024 12:42:00 -0900
Subject: [PATCH 1/1] completion: dir-type optargs for am, format-patch
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id AE4C8520265; Sun,  7 Jan 2024 12:42:01 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240107214200.29684-1-britton.kerin@gmail.com>
References: <20240107214200.29684-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <8a8dfcfc-3369-42b8-8387-f1af33202b16@smtp-relay.sendinblue.com>
Origin-messageId: <20240107214200.29684-2-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: dNO7KGJACFgBPSNHTUS5NAfppDg-4DpL96BmmxzAuQy4jj6WR_VjvC3jPwbv9vIOTEMKeKPQU2UWWTYPZEO38yHXtweh4IpDQJO4Al8-4tqxOEvaKCVlm6TurI323qSngkmXv0uKNq8PyeRYPEKLYWcb13MW5kZbnrjGMzDuLrYT
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index 185b47d802..c3b0a3699c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1356,6 +1356,30 @@ =5F=5Fgit=5Fcount=5Farguments ()
 	printf =22%d=22 $c
 }
=20
+
+# Complete actual dir (not pathspec), respecting any -C options.
+#
+# Usage: =5F=5Fgit=5Fcomplete=5Frefs [<option>]...
+# --cur=3D<word>: The current dir to be completed.  Defaults to the =
current word.
+=5F=5Fgit=5Fcomplete=5Fdir ()
+{
+	local cur=5F=3D=22$cur=22
+
+	while test $# !=3D 0; do
+		case =22$1=22 in
+		--cur=3D*)	cur=5F=3D=22${1##--cur=3D}=22 ;;
+		*)		return 1 ;;
+		esac
+		shift
+	done
+
+	local context=5Fdir=3D$(=5F=5Fgit rev-parse --show-toplevel --show-prefix=
 2>/dev/null | paste -s -d '/' 2>/dev/null)
+	[ -d =22$context=5Fdir=22 ] || return
+
+	COMPREPLY=3D$(cd $context=5Fdir 2>/dev/null && compgen -d -- =
=22$cur=5F=22)
+}
+
+
 =5F=5Fgit=5Fwhitespacelist=3D=22nowarn warn error error-all fix=22
 =5F=5Fgit=5Fpatchformat=3D=22mbox stgit stgit-series hg mboxrd=22
 =5F=5Fgit=5Fshowcurrentpatch=3D=22diff raw=22
@@ -1374,6 +1398,10 @@ =5Fgit=5Fam ()
 		=5F=5Fgitcomp =22$=5F=5Fgit=5Fwhitespacelist=22 =22=22 =
=22${cur##--whitespace=3D}=22
 		return
 		;;
+	--directory=3D*)
+		=5F=5Fgit=5Fcomplete=5Fdir --cur=3D=22${cur##--directory=3D}=22
+		return
+		;;
 	--patch-format=3D*)
 		=5F=5Fgitcomp =22$=5F=5Fgit=5Fpatchformat=22 =22=22 =
=22${cur##--patch-format=3D}=22
 		return
@@ -1867,7 +1895,17 @@ =5F=5Fgit=5Fformat=5Fpatch=5Fextra=5Foptions=3D=22
=20
 =5Fgit=5Fformat=5Fpatch ()
 {
+	case =22$prev,$cur=22 in
+	-o,*)
+		=5F=5Fgit=5Fcomplete=5Fdir
+		return
+		;;
+	esac
 	case =22$cur=22 in
+	--output-directory=3D*)
+		=5F=5Fgit=5Fcomplete=5Fdir --cur=3D=22${cur##--output-directory=3D}=22
+		return
+		;;
 	--thread=3D*)
 		=5F=5Fgitcomp =22
 			deep shallow
--=20
2.43.0


