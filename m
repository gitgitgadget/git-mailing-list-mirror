From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] completion: fix completion of git <TAB><TAB>
Date: Thu,  8 Oct 2009 23:21:43 -0700
Message-ID: <1255069304-8953-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:23:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw8sf-0002i1-Se
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbZJIGUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 02:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbZJIGUM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:20:12 -0400
Received: from mail-qy0-f172.google.com ([209.85.221.172]:41694 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbZJIGUK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 02:20:10 -0400
Received: by qyk2 with SMTP id 2so6292572qyk.21
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 23:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=W920F+CwMad3TjBacsjJQpU9wnRqhC+9z2BOhwwuJ+c=;
        b=hQKhWrr5hjuIrWWoJSt4arZq8vnHJi+r/3tkele8m0nB9oKoFi/mC+XzU9ng/GPf/e
         hXQbZIrLxUN5rHxE3FKIgSWH8XXny0cWP1CMZqWwUwyWaMDA74IYxG/Hpfj+Cie1S+9g
         PUgbqo0hYh7kUQn430EhqFqTJJcrUvpyikiw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=u6sOrk6eDIO1HQ1hj5sLIoAlj5bY1pstC5NNsrpwTZrhRTUxJ3duYZHslqK4kS2ORQ
         F2JL6mPkkT73++7CuRPQZOHaAyxdZnBFreW0/tRXM47hWo6pgkxLrW2n/5kAi8tcOKsz
         +8wffr7hvhlZoBT4a6FuW1ONHT/F7NIaTpVN4=
Received: by 10.224.93.146 with SMTP id v18mr2180096qam.78.1255069171916;
        Thu, 08 Oct 2009 23:19:31 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 4sm715881qwe.38.2009.10.08.23.19.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 23:19:31 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 08 Oct 2009 23:21:44 -0700
X-Mailer: git-send-email 1.6.5.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129738>

After commit 511a3fc (wrap git's main usage string., 2009-09-12), the
bash completion for git commands includes COMMAND and [ARGS] when it
shouldn't. Fix this by grepping more strictly for a line with git
commands. It's doubtful whether git will ever have commands starting
with anything besides numbers and letters so this should be fine. At
least by being stricter we'll know when we break the completion earlier.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 88b1b3c..652a47c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -496,7 +496,7 @@ __git_all_commands ()
 		return
 	fi
 	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^ ')
+	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
 	do
 		case $i in
 		*--*)             : helper pattern;;
-- 
1.6.5.rc3
