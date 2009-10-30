From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/8] am -i, git-svn: use "git var GIT_PAGER"
Date: Fri, 30 Oct 2009 05:33:54 -0500
Message-ID: <20091030103354.GG1610@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
 <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:23:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3oe5-00078m-Ej
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 11:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794AbZJ3KXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 06:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756762AbZJ3KXj
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 06:23:39 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51955 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773AbZJ3KXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 06:23:38 -0400
Received: by yxe17 with SMTP id 17so2539811yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=p7ZqaJlSvxGAeRdf+yHthrMDu0KtdWPeD5Sx2nyZztI=;
        b=xVA1H+8A7dHzcMscycfozAM6ihprNoNI3XFh56xzRzWV3FVyNKgGCHGtbZugsdLZ2k
         YmcPy4kftV00yM6QeFtn92iHtIKqPtOakrPnSPGNmvLCqiM863XGlejhGyJheXmrbedQ
         tsKtNSXVhMpQyKA/Xp4GZ0cMsXqASIimIaboQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bUvw7aHIFSx7GtgfZ70A+14/9ty/DIpN3TbFg6u28MOemGTbRx9neCZVwqEjn2NQ95
         7GOz+EM8cweNfewTyid2JN66wlGKCW2nV+fQUr3qb8Xde9YEWohIjtosaYsDxZy4MPnl
         D8tRbh/2BEjmns2jXi2CLtfueHEGt9vYxN0S8=
Received: by 10.150.254.8 with SMTP id b8mr2629466ybi.136.1256898223508;
        Fri, 30 Oct 2009 03:23:43 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm527713gxk.0.2009.10.30.03.23.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 03:23:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091030101634.GA1610@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131690>

Use the new "git var GIT_PAGER" command to ask what pager to use.

Without this change, the core.pager configuration is ignored by
these commands.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-am.sh    |    5 ++++-
 git-svn.perl |    6 ++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c132f50..2649487 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -649,7 +649,10 @@ do
 		[eE]*) git_editor "$dotest/final-commit"
 		       action=again ;;
 		[vV]*) action=again
-		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;
+		       : ${GIT_PAGER=$(git var GIT_PAGER)}
+		       : ${LESS=-FRSX}
+		       export LESS
+		       $GIT_PAGER "$dotest/patch" ;;
 		*)     action=again ;;
 		esac
 	    done
diff --git a/git-svn.perl b/git-svn.perl
index 42c9a72..c4ca548 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5171,10 +5171,8 @@ sub git_svn_log_cmd {
 
 # adapted from pager.c
 sub config_pager {
-	$pager ||= $ENV{GIT_PAGER} || $ENV{PAGER};
-	if (!defined $pager) {
-		$pager = 'less';
-	} elsif (length $pager == 0 || $pager eq 'cat') {
+	chomp(my $pager = command_oneline(qw(var GIT_PAGER)));
+	if ($pager eq 'cat') {
 		$pager = undef;
 	}
 	$ENV{GIT_PAGER_IN_USE} = defined($pager);
-- 
1.6.5.2
