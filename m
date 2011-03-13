From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Sat, 12 Mar 2011 20:32:39 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1103122005490.15442@debian>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vzkpxm45e.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102152040370.14950@debian> <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com> <alpine.DEB.2.00.1102161122350.14950@debian>
 <AANLkTik-JGZFCE+m7g__mwfQhRReOM=Qe_EO3otw50XC@mail.gmail.com> <alpine.DEB.2.00.1103120930250.15442@debian> <AANLkTikrYbY6r5hYnhWCB1GVKbPgounxdvAGeejsUKoC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sun Mar 13 02:32:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyaAy-0000t1-M7
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 02:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756311Ab1CMBco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 20:32:44 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36064 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab1CMBcn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 20:32:43 -0500
Received: by vxi39 with SMTP id 39so3551259vxi.19
        for <git@vger.kernel.org>; Sat, 12 Mar 2011 17:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=IRT6LXhcY20ibKLwxh5wM8DBtBDrpgBn4arJpnlbJlo=;
        b=Yds90MXJeY5HhdCoHwbq3Xp4yLAKm0afytQ4O1Q+hahl3/hTmFULLBnP3BDPR5Kfbw
         IHnbyAaYNYYzn+5EqVgV0oy9bKOjPEf98oAzI44TesW4CnfnEPF9pbSDjgYy1uYuoNA7
         oNPvVSha8cVNrhyB7oQEJUGc+2bmyT3ykzGR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=ra/LXuuaA2LdjUXQ4M+rD05DAqdrE0OLTROjCWT5TspuOVpB1mxyNPyHgYPa6Kg7qJ
         U4F0EyGSoqnPJ+kBxP/stUpzm/I/Nwws6fyPrR9ZckFQanyv5I+pRY6P72nt9/BDv/jR
         dGpsqCu2DrYSd/ufDcYjXtUcOISmcSF30zG4w=
Received: by 10.52.91.166 with SMTP id cf6mr8078576vdb.192.1299979963135;
        Sat, 12 Mar 2011 17:32:43 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s6sm1945195vch.23.2011.03.12.17.32.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Mar 2011 17:32:42 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <AANLkTikrYbY6r5hYnhWCB1GVKbPgounxdvAGeejsUKoC@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168954>

On Sun, 13 Mar 2011, Santi B?jar wrote:

> First, care to share the scripts/patches for the timings? Thanks.

Sure, see end of mail for the changes to git-rebase.sh. It applies on
top of the patch that started this thread. There are some minor
differences from what I used when I ran the tests, but nothing that
should impact the timings.

To run the tests, I just did modified versions of

git reset --hard u@{100}
touch foo && git add foo && git ci -m foo
time git rebase -n --guess-base=merge u

I don't have a script that creates the initial setup, but that should
be easy enough to do. I should warn you that it took 16 hours to run
it on my 6 year old computer :-).


> Could you test also variants of the exponential strategy?

I guess I could :-). Will see if I get time for that later today.

> exponential(n,m): like merge-base, but start with n candidates {u@{0},
> ..., u@{n-1}}, then n*m candidates and so on until a commit that b
> contains is found.
> 
> Your exponential would be exponential(1,2).
> 
> Timings for something like exponential(10,2) or exponential(10,10),
> maybe others.
> 
> Thanks,
> Santi
> 


-- 8< --

diff --git a/git-rebase.sh b/git-rebase.sh
index b50c91e..8a4efab 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -56,6 +56,7 @@ ignore-date!       passed to 'git am'
 whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
+guess-base=!       to guess the base
  Actions:
 continue!          continue rebasing process
 abort!             abort rebasing process and restore original branch
@@ -87,6 +88,7 @@ git_am_opt=
 rebase_root=
 force_rebase=
 allow_rerere_autoupdate=
+guess_base=
 # Non-empty if a rebase was in progress when 'git rebase' was invoked
 in_progress=
 # One of {am, merge, interactive}
@@ -228,6 +230,10 @@ do
 	--no-autosquash)
 		autosquash=
 		;;
+	--guess-base)
+		shift
+		guess_base=$1
+		;;
 	-M|-m)
 		do_merge=t
 		;;
@@ -459,19 +465,51 @@ esac
 
 require_clean_work_tree "rebase" "Please commit or stash them."
 
-upstream_ref=$(git rev-parse -q --verify --symbolic-full-name \
-	"$upstream_name") && test -n "$upstream_ref" &&
-for reflog in $(git rev-list -g $upstream_name 2>/dev/null)
-do
-	if test $reflog = $(git merge-base $reflog $orig_head)
-	then
-		if test $reflog != $(git merge-base $onto $reflog)
-		then
-			upstream=$reflog
-		fi
-		break
-	fi
-done
+if test -n "$guess_base" && test -n "$(git rev-parse -q --verify \
+	--symbolic-full-name "$upstream_name")"
+then
+	case $guess_base in
+	linear)
+		for reflog in $(git rev-list -g $upstream_name 2>/dev/null)
+		do
+			if test $reflog = $(git merge-base $reflog $orig_head)
+			then
+				if test $reflog != $(git merge-base $onto $reflog)
+				then
+					upstream=$reflog
+				fi
+				break
+			fi
+		done
+		;;
+	merge)
+		upstream=$(git merge-base $orig_head $(git rev-list -g $upstream_name 2>/dev/null))
+		;;
+	exponential)
+		reflogs=$(git rev-list -g $upstream_name 2>/dev/null)
+		limit=$(echo "$reflogs" | wc -l)
+		lo=0
+		hi=1
+		while true
+		do
+			echo $lo - $hi
+			candidates=$(echo "$reflogs" | head -$hi | tail -$(($hi - $lo)))
+			reflog=$(git merge-base $orig_head $candidates)
+			if test -n "$(echo $candidates | grep $reflog)"
+			then
+				upstream=$reflog
+				break
+			fi
+			if test $hi -ge $limit
+			then
+				break
+			fi
+			lo=$hi
+			hi=$((2 * $lo))
+		done
+		;;
+	esac
+fi
 
 # Now we are rebasing commits $upstream..$orig_head (or with --root,
 # everything leading up to $orig_head) on top of $onto
