Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876B16413
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="220wpOaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=yHqlKFDwPJ4G5E3t+doXcGPFWVFt32PEsLQCUM1fS5s=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=220wpOaP7KbuliIf5PvCteUa6VQ4iZx2jxAkolubNzTAP65S1u4KUfO7lWbwL2sWadvkFB9brUTm
        9A9NdnWGrmJuC6BvghVfn+iv4hX8H3ANOYN4MMKKLX67w02Q005Izn1rIV/YHuOQOr44Eh068YiB
        3GAe7elEn4urNlPBz0Q=
Received: by smtp-relay.sendinblue.com with ESMTP id 85d66039-f19a-4ee3-99ae-f8b01b8bd1d9; Tue, 02 January 2024 19:57:53 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTAyMTk1NzQ0LjQ3ODUwMy00LWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Tue,  2 Jan 2024 10:57:41 -0900
Subject: [RFC PATCH 3/6] completion: move to maintain define-before-use
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id C15E2520263; Tue,  2 Jan 2024 10:57:51 -0900 (AKST)
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
Message-Id: <85d66039-f19a-4ee3-99ae-f8b01b8bd1d9@smtp-relay.sendinblue.com>
Origin-messageId: <20240102195744.478503-4-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: KrWs_lg1oYJMk_VJsep_dpusy6Xp6PHgmcq9CuGulYNBuAi3brXRU8rZm_1iRgqOKH1cbHRVoxhmr8I-kqjtNVuHYIRakvt_0hpPRE608TQFvyDdvtKckvXVIvcAGvFq0HoiAHh0uGfzK7YdYyPuaLSrAF9WyOuAVOlVUgkkZG61
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 265 ++++++++++++-------------
 1 file changed, 132 insertions(+), 133 deletions(-)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index 3472fab514..4940ad3e24 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1445,6 +1445,138 @@ =5Fgit=5Farchive ()
 	=5F=5Fgit=5Fcomplete=5Ffile
 }
=20
+# Options that go well for log, shortlog and gitk
+=5F=5Fgit=5Flog=5Fcommon=5Foptions=3D=22
+	--not --all
+	--branches --tags --remotes
+	--first-parent --merges --no-merges
+	--max-count=3D
+	--max-age=3D --since=3D --after=3D
+	--min-age=3D --until=3D --before=3D
+	--min-parents=3D --max-parents=3D
+	--no-min-parents --no-max-parents
+=22
+# Options that go well for log and gitk (not shortlog)
+=5F=5Fgit=5Flog=5Fgitk=5Foptions=3D=22
+	--dense --sparse --full-history
+	--simplify-merges --simplify-by-decoration
+	--left-right --notes --no-notes
+=22
+# Options that go well for log and shortlog (not gitk)
+=5F=5Fgit=5Flog=5Fshortlog=5Foptions=3D=22
+	--author=3D --committer=3D --grep=3D
+	--all-match --invert-grep
+=22
+# Options accepted by log and show
+=5F=5Fgit=5Flog=5Fshow=5Foptions=3D=22
+	--diff-merges --diff-merges=3D --no-diff-merges --dd --remerge-diff
+=22
+
+=5F=5Fgit=5Fdiff=5Fmerges=5Fopts=3D=22off none on first-parent 1 separate =
m combined c dense-combined cc remerge r=22
+
+=5F=5Fgit=5Flog=5Fpretty=5Fformats=3D=22oneline short medium full fuller =
reference email raw format: tformat: mboxrd=22
+=5F=5Fgit=5Flog=5Fdate=5Fformats=3D=22relative iso8601 iso8601-strict =
rfc2822 short local default human raw unix auto: format:=22
+
+# Find only porcelain (i.e. not git-rev-list) option (not argument) and
+# selected option argument completions for git-log options and put them =
in
+# COMPREPLY.
+=5F=5Fgit=5Fcomplete=5Flog=5Fopts ()
+{
+	local merge=3D=22=22
+	if [ -f =22$=5F=5Fgit=5Frepo=5Fpath/MERGE=5FHEAD=22 ]; then
+		merge=3D=22--merge=22
+	fi
+	case =22$prev,$cur=22 in
+	-L,:*:*)
+		return	# fall back to Bash filename completion
+		;;
+	-L,:*)
+		=5F=5Fgit=5Fcomplete=5Fsymbol --cur=3D=22${cur#:}=22 --sfx=3D=22:=22
+		return
+		;;
+	-G,*|-S,*)
+		=5F=5Fgit=5Fcomplete=5Fsymbol
+		return
+		;;
+	esac
+	case =22$cur=22 in
+	--pretty=3D*|--format=3D*)
+		=5F=5Fgitcomp =22$=5F=5Fgit=5Flog=5Fpretty=5Fformats =
$(=5F=5Fgit=5Fpretty=5Faliases)
+			=22 =22=22 =22${cur#*=3D}=22
+		return
+		;;
+	--date=3D*)
+		=5F=5Fgitcomp =22$=5F=5Fgit=5Flog=5Fdate=5Fformats=22 =22=22 =
=22${cur##--date=3D}=22
+		return
+		;;
+	--decorate=3D*)
+		=5F=5Fgitcomp =22full short no=22 =22=22 =22${cur##--decorate=3D}=22
+		return
+		;;
+	--diff-algorithm=3D*)
+		=5F=5Fgitcomp =22$=5F=5Fgit=5Fdiff=5Falgorithms=22 =22=22 =
=22${cur##--diff-algorithm=3D}=22
+		return
+		;;
+	--submodule=3D*)
+		=5F=5Fgitcomp =22$=5F=5Fgit=5Fdiff=5Fsubmodule=5Fformats=22 =22=22 =
=22${cur##--submodule=3D}=22
+		return
+		;;
+	--ws-error-highlight=3D*)
+		=5F=5Fgitcomp =22$=5F=5Fgit=5Fws=5Ferror=5Fhighlight=5Fopts=22 =22=22 =
=22${cur##--ws-error-highlight=3D}=22
+		return
+		;;
+	--no-walk=3D*)
+		=5F=5Fgitcomp =22sorted unsorted=22 =22=22 =22${cur##--no-walk=3D}=22
+		return
+		;;
+	--diff-merges=3D*)
+                =5F=5Fgitcomp =22$=5F=5Fgit=5Fdiff=5Fmerges=5Fopts=22 =
=22=22 =22${cur##--diff-merges=3D}=22
+                return
+                ;;
+	--*)
+		=5F=5Fgitcomp =22
+			$=5F=5Fgit=5Flog=5Fcommon=5Foptions
+			$=5F=5Fgit=5Flog=5Fshortlog=5Foptions
+			$=5F=5Fgit=5Flog=5Fgitk=5Foptions
+			$=5F=5Fgit=5Flog=5Fshow=5Foptions
+			--root --topo-order --date-order --reverse
+			--follow --full-diff
+			--abbrev-commit --no-abbrev-commit --abbrev=3D
+			--relative-date --date=3D
+			--pretty=3D --format=3D --oneline
+			--show-signature
+			--cherry-mark
+			--cherry-pick
+			--graph
+			--decorate --decorate=3D --no-decorate
+			--walk-reflogs
+			--no-walk --no-walk=3D --do-walk
+			--parents --children
+			--expand-tabs --expand-tabs=3D --no-expand-tabs
+			$merge
+			$=5F=5Fgit=5Fdiff=5Fcommon=5Foptions
+			=22
+		return
+		;;
+	-L:*:*)
+		return	# fall back to Bash filename completion
+		;;
+	-L:*)
+		=5F=5Fgit=5Fcomplete=5Fsymbol --cur=3D=22${cur#-L:}=22 --sfx=3D=22:=22
+		return
+		;;
+	-G*)
+		=5F=5Fgit=5Fcomplete=5Fsymbol --pfx=3D=22-G=22 --cur=3D=22${cur#-G}=22
+		return
+		;;
+	-S*)
+		=5F=5Fgit=5Fcomplete=5Fsymbol --pfx=3D=22-S=22 --cur=3D=22${cur#-S}=22
+		return
+		;;
+	esac
+
+}
+
 =5Fgit=5Fbisect ()
 {
 	=5F=5Fgit=5Fhas=5Fdoubledash && return
@@ -2052,139 +2184,6 @@ =5Fgit=5Fls=5Ftree ()
 	=5F=5Fgit=5Fcomplete=5Ffile
 }
=20
-# Options that go well for log, shortlog and gitk
-=5F=5Fgit=5Flog=5Fcommon=5Foptions=3D=22
-	--not --all
-	--branches --tags --remotes
-	--first-parent --merges --no-merges
-	--max-count=3D
-	--max-age=3D --since=3D --after=3D
-	--min-age=3D --until=3D --before=3D
-	--min-parents=3D --max-parents=3D
-	--no-min-parents --no-max-parents
-=22
-# Options that go well for log and gitk (not shortlog)
-=5F=5Fgit=5Flog=5Fgitk=5Foptions=3D=22
-	--dense --sparse --full-history
-	--simplify-merges --simplify-by-decoration
-	--left-right --notes --no-notes
-=22
-# Options that go well for log and shortlog (not gitk)
-=5F=5Fgit=5Flog=5Fshortlog=5Foptions=3D=22
-	--author=3D --committer=3D --grep=3D
-	--all-match --invert-grep
-=22
-# Options accepted by log and show
-=5F=5Fgit=5Flog=5Fshow=5Foptions=3D=22
-	--diff-merges --diff-merges=3D --no-diff-merges --dd --remerge-diff
-=22
-
-=5F=5Fgit=5Fdiff=5Fmerges=5Fopts=3D=22off none on first-parent 1 separate =
m combined c dense-combined cc remerge r=22
-
-=5F=5Fgit=5Flog=5Fpretty=5Fformats=3D=22oneline short medium full fuller =
reference email raw format: tformat: mboxrd=22
-=5F=5Fgit=5Flog=5Fdate=5Fformats=3D=22relative iso8601 iso8601-strict =
rfc2822 short local default human raw unix auto: format:=22
-
-
-# Find only porcelain (i.e. not git-rev-list) option (not argument) and
-# selected option argument completions for git-log options and put them =
in
-# COMPREPLY.
-=5F=5Fgit=5Fcomplete=5Flog=5Fopts ()
-{
-	local merge=3D=22=22
-	if [ -f =22$=5F=5Fgit=5Frepo=5Fpath/MERGE=5FHEAD=22 ]; then
-		merge=3D=22--merge=22
-	fi
-	case =22$prev,$cur=22 in
-	-L,:*:*)
-		return	# fall back to Bash filename completion
-		;;
-	-L,:*)
-		=5F=5Fgit=5Fcomplete=5Fsymbol --cur=3D=22${cur#:}=22 --sfx=3D=22:=22
-		return
-		;;
-	-G,*|-S,*)
-		=5F=5Fgit=5Fcomplete=5Fsymbol
-		return
-		;;
-	esac
-	case =22$cur=22 in
-	--pretty=3D*|--format=3D*)
-		=5F=5Fgitcomp =22$=5F=5Fgit=5Flog=5Fpretty=5Fformats =
$(=5F=5Fgit=5Fpretty=5Faliases)
-			=22 =22=22 =22${cur#*=3D}=22
-		return
-		;;
-	--date=3D*)
-		=5F=5Fgitcomp =22$=5F=5Fgit=5Flog=5Fdate=5Fformats=22 =22=22 =
=22${cur##--date=3D}=22
-		return
-		;;
-	--decorate=3D*)
-		=5F=5Fgitcomp =22full short no=22 =22=22 =22${cur##--decorate=3D}=22
-		return
-		;;
-	--diff-algorithm=3D*)
-		=5F=5Fgitcomp =22$=5F=5Fgit=5Fdiff=5Falgorithms=22 =22=22 =
=22${cur##--diff-algorithm=3D}=22
-		return
-		;;
-	--submodule=3D*)
-		=5F=5Fgitcomp =22$=5F=5Fgit=5Fdiff=5Fsubmodule=5Fformats=22 =22=22 =
=22${cur##--submodule=3D}=22
-		return
-		;;
-	--ws-error-highlight=3D*)
-		=5F=5Fgitcomp =22$=5F=5Fgit=5Fws=5Ferror=5Fhighlight=5Fopts=22 =22=22 =
=22${cur##--ws-error-highlight=3D}=22
-		return
-		;;
-	--no-walk=3D*)
-		=5F=5Fgitcomp =22sorted unsorted=22 =22=22 =22${cur##--no-walk=3D}=22
-		return
-		;;
-	--diff-merges=3D*)
-                =5F=5Fgitcomp =22$=5F=5Fgit=5Fdiff=5Fmerges=5Fopts=22 =
=22=22 =22${cur##--diff-merges=3D}=22
-                return
-                ;;
-	--*)
-		=5F=5Fgitcomp =22
-			$=5F=5Fgit=5Flog=5Fcommon=5Foptions
-			$=5F=5Fgit=5Flog=5Fshortlog=5Foptions
-			$=5F=5Fgit=5Flog=5Fgitk=5Foptions
-			$=5F=5Fgit=5Flog=5Fshow=5Foptions
-			--root --topo-order --date-order --reverse
-			--follow --full-diff
-			--abbrev-commit --no-abbrev-commit --abbrev=3D
-			--relative-date --date=3D
-			--pretty=3D --format=3D --oneline
-			--show-signature
-			--cherry-mark
-			--cherry-pick
-			--graph
-			--decorate --decorate=3D --no-decorate
-			--walk-reflogs
-			--no-walk --no-walk=3D --do-walk
-			--parents --children
-			--expand-tabs --expand-tabs=3D --no-expand-tabs
-			$merge
-			$=5F=5Fgit=5Fdiff=5Fcommon=5Foptions
-			=22
-		return
-		;;
-	-L:*:*)
-		return	# fall back to Bash filename completion
-		;;
-	-L:*)
-		=5F=5Fgit=5Fcomplete=5Fsymbol --cur=3D=22${cur#-L:}=22 --sfx=3D=22:=22
-		return
-		;;
-	-G*)
-		=5F=5Fgit=5Fcomplete=5Fsymbol --pfx=3D=22-G=22 --cur=3D=22${cur#-G}=22
-		return
-		;;
-	-S*)
-		=5F=5Fgit=5Fcomplete=5Fsymbol --pfx=3D=22-S=22 --cur=3D=22${cur#-S}=22
-		return
-		;;
-	esac
-
-}
-
 =5Fgit=5Flog ()
 {
 	=5F=5Fgit=5Fhas=5Fdoubledash && return
--=20
2.43.0


