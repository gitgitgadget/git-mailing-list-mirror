From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Tue, 8 Feb 2011 20:50:31 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102081959210.14152@debian>
References: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com> <AANLkTi=Uqkzv+ucBzww6R1V+0ujmfH-dED8XJhyRvWQF@mail.gmail.com> <alpine.DEB.2.00.1102081320350.4475@debian> <20110208220505.GA17981@elie>
 <alpine.DEB.2.00.1102081916330.9042@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 02:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmzCe-0005xm-1g
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 02:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab1BIBuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 20:50:39 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55764 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab1BIBui (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 20:50:38 -0500
Received: by vws16 with SMTP id 16so3269331vws.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 17:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=6GGyRg7hU+NvJqMSOu/vMh+lDPVaol4AVaoSb1y99vI=;
        b=TZwR0L9YRG71cA77ZNFBfhM2h1FG4YvdT9Hq2pGSD6LPHlBg7y6cU4vzEoflAZkpAN
         W3Wasb7EiGRnVrAqe6Y5zIQgvOpFY18lXTghLh2eaTi6W4iRBcK4mVfYvVpjg4G6TZ4d
         iEqe+XEcbK3Qn2jmyF4pZ1zrpX1rb/bxBlm6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=wlRCC5cR6SFbrZbWdUpZDnz3XM4+Ej0y5L7XMLhyRdfzcvsHI4aBwHGWYanm8aw/Is
         liYdH34fMnFWb3JSQS64Ein+ggenOOB/srDEtSRwMjlDXJo1boXm/RTTUltKdPGNHxyZ
         DMWbSlZk+zwcFeo/elnbM1fFDbX2B5SKyAAZU=
Received: by 10.220.187.69 with SMTP id cv5mr4722716vcb.200.1297216237335;
        Tue, 08 Feb 2011 17:50:37 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id ft27sm162520vbb.8.2011.02.08.17.50.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 17:50:36 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.2.00.1102081916330.9042@debian>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166387>

On Tue, 8 Feb 2011, Martin von Zweigbergk wrote:

> On Tue, 8 Feb 2011, Jonathan Nieder wrote:
> 
> > Martin von Zweigbergk wrote:
> > > On Tue, 8 Feb 2011, Sverre Rabbelier wrote:
> > 
> > >> I particularly like that you explain to the user clearly what they
> > >> have to do to make this work (e.g., configure the upstream). Nice.
> > >
> > > Thanks, but that was stolen from git-pull.sh ;-)
> > 
> > Doesn't that suggest it might belong in some common git-upstream--lib.sh
> > (or git-sh-setup.sh)?
> 
> Maybe it does...

Maybe something like this on top? I put it in git-parse-remote.sh for
now. There were some related functions there, so maybe it's not so
bad. Should I put it there (and rename to git-upstream--lib.sh?), in
new git-upstream--lib.sh or in git-sh-setup.sh.

Changes to the text compared to before:

 * "remote branch" became "upstream branch", even for git pull

 * "You asked me to pull" became "You asked me to merge" or "You asked
   me to rebase", even for git pull

 * Now printed to stderr, because I simply didn't think about it. Good
   or bad?

What do you think?


-- 8< --


diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 1cc2ba6..ff58d5b 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -99,3 +99,40 @@ get_remote_merge_branch () {
 	    esac
 	esac
 }
+
+error_on_missing_default_upstream () {
+	op_type="$1"
+	op_prep="$2"
+	example="$3"
+	documentation="$4"
+	branch_name=$(git symbolic-ref -q HEAD)
+	if test -z "$branch_name"
+	then
+		die "You are not currently on a branch, so I cannot use any
+'branch.<branchname>.merge' in your configuration file.
+Please specify which upstream branch you want to use on the command
+line and try again (e.g. '$example').
+See $documentation for details."
+	else
+		echo &2> "You asked me to $op_type without telling me which branch you
+want to $op_type $op_prep, and 'branch.${branch_name#refs/heads/}.merge' in
+your configuration file does not tell me, either. Please
+specify which branch you want to use on the command line and
+try again (e.g. '$example').
+See $documentation for details.
+
+If you often $op_type $op_prep the same branch, you may want to
+use something like the following in your configuration file:
+    [branch \"${branch_name#refs/heads/}\"]
+    remote = <nickname>
+    merge = <remote-ref>"
+		test rebase = "$op_type" &&
+		echo &2> "    rebase = true"
+		die "
+    [remote \"<nickname>\"]
+    url = <url>
+    fetch = <refspec>
+
+See git-config(1) for details."
+	fi
+}
diff --git a/git-pull.sh b/git-pull.sh
index eb87f49..8ec1d3d 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -163,34 +163,10 @@ error_on_no_merge_candidates () {
 		echo "You asked to pull from the remote '$1', but did not specify"
 		echo "a branch. Because this is not the default configured remote"
 		echo "for your current branch, you must specify a branch on the command line."
-	elif [ -z "$curr_branch" ]; then
-		echo "You are not currently on a branch, so I cannot use any"
-		echo "'branch.<branchname>.merge' in your configuration file."
-		echo "Please specify which remote branch you want to use on the command"
-		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
-	elif [ -z "$upstream" ]; then
-		echo "You asked me to pull without telling me which branch you"
-		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge' in"
-		echo "your configuration file does not tell me, either. Please"
-		echo "specify which branch you want to use on the command line and"
-		echo "try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
-		echo
-		echo "If you often $op_type $op_prep the same branch, you may want to"
-		echo "use something like the following in your configuration file:"
-		echo
-		echo "    [branch \"${curr_branch}\"]"
-		echo "    remote = <nickname>"
-		echo "    merge = <remote-ref>"
-		test rebase = "$op_type" &&
-			echo "    rebase = true"
-		echo
-		echo "    [remote \"<nickname>\"]"
-		echo "    url = <url>"
-		echo "    fetch = <refspec>"
-		echo
-		echo "See git-config(1) for details."
+	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
+		. git-parse-remote
+		error_on_missing_default_upstream $op_type $op_prep \
+			"git pull <repository> <refspec>" "git-pull(1)"
 	else
 		echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
 		echo "from the remote, but no such ref was fetched."
diff --git a/git-rebase.sh b/git-rebase.sh
index 5975642..8b39cab 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -144,25 +144,6 @@ run_pre_rebase_hook () {
 	fi
 }
 
-error_on_missing_default_upstream () {
-	branch_name=$(git symbolic-ref -q HEAD)
-	if test -z "$branch_name"
-	then
-		die "You are not currently on a branch, so I cannot use any
-'branch.<branchname>.merge' in your configuration file.
-Please specify which upstream branch you want to use on the command
-line and try again (e.g. 'git rebase <upstream branch>').
-See git-rebase(1) for details."
-	else
-		die "You asked me to rebase without telling me which branch you
-want to rebase against, and 'branch.${branch_name#refs/heads/}.merge' in
-your configuration file does not tell me, either. Please
-specify which branch you want to use on the command line and
-try again (e.g. 'git rebase <upstream branch>').
-See git-rebase(1) for details."
-	fi
-}
-
 test -f "$apply_dir"/applying &&
 	die 'It looks like git-am is in progress. Cannot rebase.'
 
@@ -381,8 +362,13 @@ if test -z "$rebase_root"
 then
 	case "$#" in
 	0)
-		upstream_name=$(git rev-parse --symbolic-full-name --verify -q \
-		@{upstream}) || error_on_missing_default_upstream
+		if ! upstream_name=$(git rev-parse --symbolic-full-name \
+			--verify -q @{upstream})
+		then
+			. git-parse-remote
+			error_on_missing_default_upstream "rebase" "against" \
+				"git rebase <upstream branch>" "git-rebase(1)"
+		fi
 		;;
 	*)	upstream_name="$1"
 		shift
