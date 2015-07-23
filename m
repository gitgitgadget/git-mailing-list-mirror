From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC/PATCH] contrib: teach completion about git-worktree options and arguments
Date: Thu, 23 Jul 2015 16:49:10 -0400
Message-ID: <1437684550-21884-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 22:49:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZINRC-0001CP-Gj
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 22:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbbGWUto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 16:49:44 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33025 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030180AbbGWUtm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 16:49:42 -0400
Received: by ietj16 with SMTP id j16so3665862iet.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 13:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=NJ7wjqsi82oKYrzD8RvYOGhZsvglUP1sfsTOswVmgAE=;
        b=sHdLklglUiaBU1ez3lyPWBdVsL7tFC5a/z6p3g7jbcHCaSEuLikDX7OhaDB15RuUP6
         0FrGfcXc2uq0QiHYisv0MoAwcK6NUSqrQz7l1c335119dIvP1mjgx005Kk++ITmCKTm4
         5CyxvEh9T1PjE9u3V7cEiIaEHviSnAEOs9ErpXTmlYDT4j0bmh5344Nc91zegP4ZqNiV
         seOWEBoF1A9eNMJlciU2PirhKqCbZrhIdKkQ4R2+rDONjW5jURC2f/kv9cdAJp2O+DUO
         6eCOvkPu4R8QrRdJ+mXWxCbJNtasz/Wio8LVDmMovHEKbUvb+tSVDzP7Ov745sz1o6ly
         y9KQ==
X-Received: by 10.50.136.194 with SMTP id qc2mr365499igb.6.1437684581433;
        Thu, 23 Jul 2015 13:49:41 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 196sm3696810ioe.23.2015.07.23.13.49.40
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 13:49:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.407.g68aafd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274526>

Complete subcommands 'add' and 'prune', as well as their respective
options --force, --detach, --dry-run, --verbose, and --expire. Also
complete 'refname' in "git worktree add [-b <newbranch>] <path>
<refname>".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is RFC since this is my first foray into the Git completion script,
and there are likely better and more idiomatic ways to accomplish this.

 contrib/completion/git-completion.bash | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c97c648..07c34ef 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2564,6 +2564,38 @@ _git_whatchanged ()
 	_git_log
 }
 
+_git_worktree ()
+{
+	local subcommands='add prune'
+	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	local c=2 n=0 refpos=2
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+	else
+		case "$subcommand,$cur" in
+		add,--*)
+			__gitcomp "--force --detach"
+			;;
+		add,*)
+			while [ $c -lt $cword ]; do
+				case "${words[c]}" in
+				--*) ;;
+				-[bB]) ((refpos++)) ;;
+				*) ((n++)) ;;
+				esac
+				((c++))
+			done
+			if [ $n -eq $refpos ]; then
+				__gitcomp_nl "$(__git_refs)"
+			fi
+			;;
+		prune,--*)
+			__gitcomp "--dry-run --verbose --expire"
+			;;
+		esac
+	fi
+}
+
 __git_main ()
 {
 	local i c=1 command __git_dir
-- 
2.5.0.rc3.407.g68aafd0
