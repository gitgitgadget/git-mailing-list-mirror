From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] git-difftool: allow skipping file by typing 'n' at prompt
Date: Thu, 6 Oct 2011 18:26:58 +0530
Message-ID: <20111006125658.GB18709@sita-lt.atc.tcs.com>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
 <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
 <CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com>
 <7vty7oblpu.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gssgpy7nF46c1roJUCN5yvQaOYfVE_-ZrvMfHGWKvk0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 14:57:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBnVm-0007rc-2i
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 14:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758257Ab1JFM5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 08:57:09 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45874 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425Ab1JFM5I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 08:57:08 -0400
Received: by qadb15 with SMTP id b15so1901797qad.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=v2HMK3upou6MBUAGEGJ98/sUIuJoA1JTn9XoEkXuE7o=;
        b=dmRwBM6XYfZMEFZKYcaxt/GgvJF9DT9ZrZY3FGOon3tg5Ny6d27pwP7pGzPaN+vJIy
         kWFK80yA6hY4Dt9uTA9IuCaBkI8jGBcUNSstNaKmrEJtL9NLXmKkVwejbWhLqGrh0uC3
         z56XuUPaTj67za5OcjcyOOqXm6B1Ibabd5X2A=
Received: by 10.68.0.40 with SMTP id 8mr5786145pbb.45.1317905827252;
        Thu, 06 Oct 2011 05:57:07 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.161.22])
        by mx.google.com with ESMTPS id p4sm19293688pbs.6.2011.10.06.05.57.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 05:57:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMK1S_gssgpy7nF46c1roJUCN5yvQaOYfVE_-ZrvMfHGWKvk0w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182941>

Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
---

(re-rolled according to earlier discussion)

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
