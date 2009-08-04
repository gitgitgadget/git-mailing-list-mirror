From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH] svn: Honor --prefix option in init without --stdlayout
Date: Mon,  3 Aug 2009 21:40:38 -0400
Message-ID: <1249350039-7338-3-git-send-email-adambrewster@gmail.com>
References: <1249350039-7338-1-git-send-email-adambrewster@gmail.com>
 <1249350039-7338-2-git-send-email-adambrewster@gmail.com>
Cc: normalperson@yhbt.net, Adam Brewster <adambrewster@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 03:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY92M-0004K0-Kp
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 03:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbZHDBlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 21:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754903AbZHDBlv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 21:41:51 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:59452 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405AbZHDBlu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 21:41:50 -0400
Received: by qyk34 with SMTP id 34so3393570qyk.33
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ZIzPUAizv2KwZoYHx4ZC1hWeZwnbk8/UiR9j6tWIhRw=;
        b=PpYtVyl8UYIgLfwSMCSaiXapajLXAsx5qyWRTPCio7EnabM3T4OkzAeHaw52yaCuZ5
         hP1/MYSKRS8RgBCjIEbhE8iSQDsI6NFqE1ZPNcK+u9et3H2qq2C6dwDa3CCij4vfnVFe
         m+zB8hpu0X5EJL/PzYwVWUngOJjydXAp+6lfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lEeHSsF8UaKVTBsZD3Odjp54bCHh5dRd01LaGY/ESMuCfBoGtXgl9kwHFlczBwvfDa
         6hyuHixkFnNyjIhQ52VaZn85XZ/Ei3yTtjvolrZUCnVcR2XrjNHgHjZLKRoQvwwHzlhs
         qURzc1zc/M1okE1f8kq5BfHNJm2fwnVqc/7UY=
Received: by 10.224.45.149 with SMTP id e21mr5445701qaf.275.1249350110429;
        Mon, 03 Aug 2009 18:41:50 -0700 (PDT)
Received: from MBE.internal (c-24-61-131-49.hsd1.nh.comcast.net [24.61.131.49])
        by mx.google.com with ESMTPS id 6sm14104764qwk.24.2009.08.03.18.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Aug 2009 18:41:49 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id B132421C827; Mon,  3 Aug 2009 21:40:39 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1249350039-7338-2-git-send-email-adambrewster@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124741>

Most users who type

  git svn init file:///tmp/repo --prefix=my-svn/

would expect the root of the svn repository to be tracked by
refs/remotes/my-svn/git-svn.
---
 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9369acc..51e3f92 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3266,7 +3266,8 @@ sub _new {
 		$repo_id = $Git::SVN::default_repo_id;
 	}
 	unless (defined $ref_id && length $ref_id) {
-		$_[2] = $ref_id = $Git::SVN::default_ref_id;
+		$_prefix = '' unless defined($_prefix);
+		$_[2] = $ref_id = $_prefix . $Git::SVN::default_ref_id;
 	}
 	$_[1] = $repo_id;
 	my $dir = "$ENV{GIT_DIR}/svn/$ref_id";
-- 
1.6.0.6
