From: Matteo Bertini <naufraghi@develer.com>
Subject: [PATCH 4/4] git-svn.perl: Add git svn init --enable-filters option.
Date: Tue, 31 May 2016 17:07:49 +0200
Message-ID: <20160531150749.24840-5-naufraghi@develer.com>
References: <20160531150749.24840-1-naufraghi@develer.com>
Cc: Matteo Bertini <matteo@naufraghi.net>, normalperson@yhbt.net,
	gitster@pobox.com, Matteo Bertini <naufraghi@develer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 17:14:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7lNa-00028N-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbcEaPOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 11:14:44 -0400
Received: from neo.develer.net ([2.228.72.10]:39508 "EHLO neo.develer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871AbcEaPOn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 11:14:43 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 May 2016 11:14:43 EDT
Received: from odello.trilan (odello.trilan [10.3.15.118])
	(Authenticated sender: naufraghi)
	by neo.develer.net (Postfix) with ESMTPSA id DA7645E3124;
	Tue, 31 May 2016 17:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=develer.com;
	s=gongolo; t=1464707277;
	bh=/TCtAZoOQ23QAJZJcnRhst2UGyFp2+Y+ELnf2J/zEII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihN4l7h+/mKW5y1tIDJf3UMvTCbPQKqUY2yNyC65fehErkBYkNdkGWdV+tE1mqU+O
	 p2b1AiTanRceWWetJIuVi/KRUs7G98btCKnf5PazwlafqrAcmtIeGQ6eE+6vmLiUCi
	 KHre9lsSXEiWlS5HG9CgXR/FodsaSQ9k0zHJ/6jo=
X-Mailer: git-send-email 2.9.0.rc0.39.gb9f310b.dirty
In-Reply-To: <20160531150749.24840-1-naufraghi@develer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295980>

From: Matteo Bertini <matteo@naufraghi.net>

The enabled option activates the propagation of the real paths towards
hash-object and the removal of the --no-filters option.

Signed-off-by: Matteo Bertini <naufraghi@develer.com>
---
 git-svn.perl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-svn.perl b/git-svn.perl
index 05eced0..4d4d6c4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -153,6 +153,7 @@ my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
 		  'use-svnsync-props' => sub { $icv{useSvnsyncProps} = 1 },
 		  'rewrite-root=s' => sub { $icv{rewriteRoot} = $_[1] },
 		  'rewrite-uuid=s' => sub { $icv{rewriteUUID} = $_[1] },
+		  'enable-filters' => \$Git::SVN::Fetcher::_enable_filters,
                   %remote_opts );
 my %cmt_opts = ( 'edit|e' => \$_edit,
 		'rmdir' => \$Git::SVN::Editor::_rmdir,
@@ -495,6 +496,9 @@ sub do_git_init_db {
 		command_noisy('config', "$pfx.preserve-empty-dirs", 'true');
 		command_noisy('config', "$pfx.placeholder-filename", $$fname);
 	}
+
+	command_noisy('config', "$pfx.enable-filters", 'true')
+		if defined $Git::SVN::Fetcher::_enable_filters
 }
 
 sub init_subdir {
-- 
2.9.0.rc0.39.gb9f310b.dirty
