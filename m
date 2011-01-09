From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC] completion: support git blame
Date: Sun,  9 Jan 2011 11:38:39 -0500
Message-ID: <1294591119-19701-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 09 17:39:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbyIN-0006ck-3l
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 17:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab1AIQjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 11:39:01 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46251 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab1AIQjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 11:39:00 -0500
Received: by qyj19 with SMTP id 19so897183qyj.19
        for <git@vger.kernel.org>; Sun, 09 Jan 2011 08:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=yglmDhTO7pBZIZFOq9zrzrIkwIF0/Abt1HkOYqVYbBc=;
        b=K8pJVUC46OxMBq0WG8Y+8as5z86iYoFzcI+rwl6LDMkxpadPEpGujEWnPgisKNgXuH
         oMgipO/hX+oZLZzgqTfMt+Oc8MihDjXZMv49gP8BKJxhmw68OvTBNRSQUmJ6mm/QOHw9
         jhFjXEo9BJHayJq7FryYWwpJMF6JdKwza4FH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Xv31raScrZJi4clNVlFR7K/yCfJqRpqPvgIfmJisedfRzY1B5BeY25LyZANZ/9rZDP
         XveKKbaLWUYmrd6NH1Tc2oouJsaMCjnzuCuF3rDdSQeqdD46Arh9pEzVcszguZy6rtVE
         gk7mF57uL9x8L6wizj0WP9Tb7zmFwHxF9R6sE=
Received: by 10.229.251.137 with SMTP id ms9mr21679345qcb.188.1294591139723;
        Sun, 09 Jan 2011 08:38:59 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id t7sm15594830qcs.4.2011.01.09.08.38.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Jan 2011 08:38:58 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164853>

Add basic support for completion of refs with git blame.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

Maybe leave --porcelain and --incremental out since they are intended
for scripts?

blame is pretty uninteresting on untracked files. It would be nice if
to only complete files that exist in the specified commit, just like
'git show $rev:$file' does. I think this applies to some other
commands as well, like 'git checkout $rev [--] $file'. Has this been
discussed before? I didn't find anything when searching the
archives. I can imagine it might have been rejected because of
performance problems.


 contrib/completion/git-completion.bash |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 645549c..d9074ba 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1128,6 +1128,26 @@ _git_bisect ()
 	esac
 }
 
+_git_blame ()
+{
+	__git_has_doubledash && return
+
+	local cur
+	_get_comp_words_by_ref -n =: cur
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--root --show-stats --reverse --encoding=
+			--contents --date --score-debug --show-name
+			--show-number --show-email
+			"
+		;;
+	*)
+		__gitcomp "$(__git_refs)"
+		;;
+	esac
+}
+
 _git_branch ()
 {
 	local i c=1 only_local_ref="n" has_r="n" cur words cword
-- 
1.7.3.2.864.gbbb96
