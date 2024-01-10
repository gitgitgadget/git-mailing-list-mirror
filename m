Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43AC17F0
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="OTrwcK9L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=LAU/tQKHY6oYsGjN4J/5HvHLJ7eheo0GAETJzlXFlLY=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=OTrwcK9L4BkEv5t3V5obH7ziktBViN4CvfFfL1JcDSeUf83hRCRN6b6OLxUTC5kR/48IvRIx22DY
        s+zuGfQgyyQKgViO5wfQ0o6PRh0h/YP5Uq/gfbmIJgExR324qLy5155iHzVdpBX2JvEQ4V9BJZQf
        9vNScemi6yuVyP+JIN0=
Received: by smtp-relay.sendinblue.com with ESMTP id 07e5141e-2305-4c21-9ebb-251fa3b4077f; Wed, 10 January 2024 02:03:51 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTEwMDIwMzQ3LjY3MzE1NS00LWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Tue,  9 Jan 2024 17:03:45 -0900
Subject: [PATCH v2 3/5] completion: move to maintain define-before-use
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 3994852026B; Tue,  9 Jan 2024 17:03:49 -0900 (AKST)
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
Message-Id: <07e5141e-2305-4c21-9ebb-251fa3b4077f@smtp-relay.sendinblue.com>
Origin-messageId: <20240110020347.673155-4-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: g-xEZWEHTNuC-PyunLJwRYS9ITZip8MPKK9IQML2Dyw3q2tMOQNyYMoDAMZckCK5ClmajMmEMrd4LdPAvyhcMGOGMRIeaFuQTWfZ86MQPGWfROJXLGSG61fv3yqHFYRK7LLjZuj_f_794WfyovfnkNF547vsM9jfAs7iNtq88hXF
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 269 ++++++++++++-------------
 1 file changed, 134 insertions(+), 135 deletions(-)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index c16aded36c..63ca8082a4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1445,6 +1445,140 @@ =5Fgit=5Farchive ()
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
+# Check for only porcelain (i.e. not git-rev-list) option (not argument)
+# and selected option argument completions for git-log options and if any
+# are found put them in COMPREPLY.  COMPREPLY must be empty at the start,
+# and will be empty on return if no candidates are found.
+=5F=5Fgit=5Fcomplete=5Flog=5Fopts ()
+{
+	[ -z =22$COMPREPLY=22 ] || return 1   # Precondition
+
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
+}
+
 =5Fgit=5Fbisect ()
 {
 	=5F=5Fgit=5Fhas=5Fdoubledash && return
@@ -2052,141 +2186,6 @@ =5Fgit=5Fls=5Ftree ()
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
-# Check for only porcelain (i.e. not git-rev-list) option (not argument)
-# and selected option argument completions for git-log options and if any
-# are found put them in COMPREPLY.  COMPREPLY must be empty at the start,
-# and will be empty on return if no candidates are found.
-=5F=5Fgit=5Fcomplete=5Flog=5Fopts ()
-{
-	[ -z =22$COMPREPLY=22 ] || return 1   # Precondition
-
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
-}
-
 =5Fgit=5Flog ()
 {
 	=5F=5Fgit=5Fhas=5Fdoubledash && return
--=20
2.43.0


