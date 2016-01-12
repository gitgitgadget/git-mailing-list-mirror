From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 19/21] svn: learn ref-storage argument
Date: Mon, 11 Jan 2016 20:22:18 -0500
Message-ID: <1452561740-8668-20-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:23:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aInfp-0003OU-ND
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761917AbcALBW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:56 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36422 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761817AbcALBWy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:54 -0500
Received: by mail-qg0-f53.google.com with SMTP id e32so328826940qgf.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dGcbZ81EWm/tWV91s4cz1//X/c9mTh0vRHyUE/Atmjw=;
        b=cQzuxjluo2bs9Mus6vi8grd60gkTWTuUJhhebPVyPLAoZ21G3aOczYvCvwJvDHs6L8
         i4Hh4NPYTDCKBjeYvDFGIe/mPplRS8RvVyV3PtU38hbjyc+entQC+E30fRatSycX8oKV
         R/XjGajIqcs0jYelj9oth/nhjFXnMfsz0/cy2SzV3dcOpWZ26zpZz9PmuGn2cT2BY2AK
         LUE6MXPs3xfzAdJs83XUxA67N07gA5UN8QA/3h37A8X/j+zCj1+74rhnnzn31sA9N9Rv
         0F4Y449eh9DjsWWll9tFPvIKYQi+tiw7kUqJdoxdiDh49+AfiobSA1Oxozmyjic7xI4E
         ashA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dGcbZ81EWm/tWV91s4cz1//X/c9mTh0vRHyUE/Atmjw=;
        b=lW74YJzS1Cperpxxr1Htp+3l/8L5LS7mj6+7HySGNTbTno8Yb1B5dqZpzhoI93NF/7
         B8TXVH6sxmLiF4v1pC83v+hg77ugAUbUh4H9HzpMlWmab9wSJLFWFTtt742Petn9XcLN
         IYqwl1CfzGmW+2L1kxuTw6L1SABsh56V2MaWhPHHsVJuLmgk68evlfmQWybp6vVujNER
         6TRm090jEUuA68rBtnWQgtldh7B2T24+8jfrulNQtpKL67VZB6J31blUsXygKNTTRV3+
         S4M0mCZzgX2BOCi/e+otOLjLFjgxhATBr40cN2t2B4sE48oWEyS9jb1l+8q24v5FGpdn
         ZkQw==
X-Gm-Message-State: ALoCoQmigXo+SxQVeW51ILKwUMYpKTztv9rZZUtw/FjF/y3oltCy7fl/N41AileauB7wQvYPxQzywt54szd//TU1yfIgDyKNwA==
X-Received: by 10.140.43.116 with SMTP id d107mr24303728qga.51.1452561773644;
        Mon, 11 Jan 2016 17:22:53 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:53 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283747>

git svn learns to pass the ref-storage command-line argument (to init
and clone) through to git init.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 git-svn.perl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index fa5f253..15d1544 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -141,7 +141,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'localtime' => \$Git::SVN::_localtime,
 		%remote_opts );
 
-my ($_trunk, @_tags, @_branches, $_stdlayout);
+my ($_trunk, @_tags, @_branches, $_stdlayout, $_ref_storage);
 my %icv;
 my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
                   'trunk|T=s' => \$_trunk, 'tags|t=s@' => \@_tags,
@@ -153,6 +153,7 @@ my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
 		  'use-svnsync-props' => sub { $icv{useSvnsyncProps} = 1 },
 		  'rewrite-root=s' => sub { $icv{rewriteRoot} = $_[1] },
 		  'rewrite-uuid=s' => sub { $icv{rewriteUUID} = $_[1] },
+		  'ref-storage=s' => \$_ref_storage,
                   %remote_opts );
 my %cmt_opts = ( 'edit|e' => \$_edit,
 		'rmdir' => \$Git::SVN::Editor::_rmdir,
@@ -469,6 +470,9 @@ sub do_git_init_db {
 				push @init_db, "--shared";
 			}
 		}
+		if (defined $_ref_storage) {
+		    push @init_db, "--ref-storage=" . $_ref_storage;
+		}
 		command_noisy(@init_db);
 		$_repository = Git->repository(Repository => ".git");
 	}
-- 
2.4.2.749.g730654d-twtrsrc
