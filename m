From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 3/3] Revert "git-svn: always initialize with core.autocrlf=false"
Date: Wed,  3 Mar 2010 21:10:23 +0100
Message-ID: <1267647023-2604-3-git-send-email-kusmabite@gmail.com>
References: <1267647023-2604-1-git-send-email-kusmabite@gmail.com>
Cc: normalperson@yhbt.net, dpotapov@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 21:11:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmuuz-0004X4-DA
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535Ab0CCULa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:11:30 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:59172 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513Ab0CCUL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 15:11:28 -0500
Received: by mail-ew0-f220.google.com with SMTP id 20so1265376ewy.21
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+MXGc2Tq+wuPE2K4hgYhftyicckBKuRiqYGj3RFMGus=;
        b=frO2l+OdUm/iSfWxAomeS1B3J4XjvASUo3bk7c5p15JAjMKo+Lt5nkzoPzezfz/Jca
         G/cwOr8UZZW00K1meAPJzWXcWFBvyuCtvj+iqTV7BPn7NXWWS4hHYWVMH06J4RNB9TPG
         keRf/MstIhWRGoYNhSjqQw9n0CM0eQCkBuyss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M0IesBIsSWtzsOumDO7yA1VILUD1FBOorhGzJipFDluw7w6+dBCoJwhl8wP5nz3q3b
         dz2JySOEDTz7L/7oq77kzbWHjcchsgu9L0Su3XOT4/rxo/ydoXZv8WD6fVnGgDxq1V3/
         MchD6BIpwi0lhAS1AbjyQNHXMR8kkyxj5ucSQ=
Received: by 10.213.109.212 with SMTP id k20mr671895ebp.32.1267647086157;
        Wed, 03 Mar 2010 12:11:26 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id 15sm3977040ewy.4.2010.03.03.12.11.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 12:11:25 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.141.gc5984a
In-Reply-To: <1267647023-2604-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141470>

git-svn rebase used to have issues with CRLF conversion. Since these issues
have been fixed, we can safely revert the work-around that disables CRLF
conversion.

This reverts commit d3c9634eacdcaa71cbd69a160e6f4e80ddb7ab63.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

git-svn dcommit uses diff-tree (which does not apply CRLF conversion) to
generate SVN commits, so there never were any CRLF conversion issues when
commiting in the first place.

 git-svn.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b7c03b6..b8a3fc2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -369,7 +369,6 @@ sub do_git_init_db {
 		command_noisy(@init_db);
 		$_repository = Git->repository(Repository => ".git");
 	}
-	command_noisy('config', 'core.autocrlf', 'false');
 	my $set;
 	my $pfx = "svn-remote.$Git::SVN::default_repo_id";
 	foreach my $i (keys %icv) {
-- 
1.7.0.1.141.gc5984a
