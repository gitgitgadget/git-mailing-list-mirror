From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] git-difftool: allow skipping file by typing 'n' at prompt
Date: Thu, 6 Oct 2011 23:45:22 +0530
Message-ID: <20111006181522.GA2936@sita-lt.atc.tcs.com>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
 <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
 <CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com>
 <7vty7oblpu.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gssgpy7nF46c1roJUCN5yvQaOYfVE_-ZrvMfHGWKvk0w@mail.gmail.com>
 <20111006125658.GB18709@sita-lt.atc.tcs.com>
 <7v62k210pj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 20:15:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBsU0-0007un-Su
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758861Ab1JFSPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:15:38 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:32942 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758826Ab1JFSPe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:15:34 -0400
Received: by pzk1 with SMTP id 1so7552548pzk.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WZlvO0KIDMHKVEr7GQGikHG+0xDEe0Thn5fmeyMwWXY=;
        b=Vv8Xn6mrkHxIaixPhdsTmXtJk0aLX8+55v6C82gs3oUeMvgwbpWKZxeweKCDehSKZ4
         2DS8n78p6igYz1G+HK2Cyj89gEnbrCSMX6SvWfk9AuA0GgCeOboLgUh3T8qN+J30lgnm
         Yk91ouZ1eMt3wGPq5nB640V8oFyFNJnkOFtr0=
Received: by 10.68.17.193 with SMTP id q1mr7140876pbd.98.1317924933865;
        Thu, 06 Oct 2011 11:15:33 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.161.22])
        by mx.google.com with ESMTPS id ml4sm21968075pbc.0.2011.10.06.11.15.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 11:15:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v62k210pj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183004>

This is useful if you forgot to restrict the diff to the paths you want
to see, or selecting precisely the ones you want is too much typing.

Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
---

On Thu, Oct 06, 2011 at 10:36:40AM -0700, Junio C Hamano wrote:

> Thanks. It is clear from the subject and the patch text that you are
> changing "hit return to unconditionally launch" into "launch it if you
> want to", but can you give justification why a choice not to launch is
> needed in the log message?

OK; done.

 git-difftool--helper.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 8452890..0468446 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -38,15 +38,16 @@ launch_merge_tool () {
 
 	# $LOCAL and $REMOTE are temporary files so prompt
 	# the user with the real $MERGED name before launching $merge_tool.
+	ans=y
 	if should_prompt
 	then
 		printf "\nViewing: '$MERGED'\n"
 		if use_ext_cmd
 		then
-			printf "Hit return to launch '%s': " \
+			printf "Launch '%s' [Y/n]: " \
 				"$GIT_DIFFTOOL_EXTCMD"
 		else
-			printf "Hit return to launch '%s': " "$merge_tool"
+			printf "Launch '%s' [Y/n]: " "$merge_tool"
 		fi
 		read ans
 	fi
@@ -54,9 +55,9 @@ launch_merge_tool () {
 	if use_ext_cmd
 	then
 		export BASE
-		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
+		test "$ans" != "n" && eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
 	else
-		run_merge_tool "$merge_tool"
+		test "$ans" != "n" && run_merge_tool "$merge_tool"
 	fi
 }
 
-- 
1.7.6
