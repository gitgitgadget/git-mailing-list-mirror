From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 3/3] The Makefile.PL will now find .pm files itself.
Date: Tue, 24 Jul 2012 20:21:11 -0700
Message-ID: <1343186471-1024-4-git-send-email-schwern@pobox.com>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, "Michael G. Schwern" <schwern@pobox.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 25 05:21:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StsAZ-0006Hi-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093Ab2GYDVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:21:47 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40199 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139Ab2GYDVp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:21:45 -0400
Received: by gglu4 with SMTP id u4so256583ggl.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=DbIxWsG+NiWwhc+j1cJRb2W63sPhvAc3LC/5+QjeCZ4=;
        b=OvPBIjbZqGZTW5HlEPMkoW8Wa71oAINM2FJUrE3q2KsMARklsFyy0ddsfGrjjsO2R0
         MMYhp2yRsmZChTbUImplpbApcE+LiVJDVSy3LwFMvd/Z2TicRqKx3+r/NFwZKNhV553R
         AHN+FYtk69RgHrOh5uWqNza4bmIkiZqdqFNeyeFwpG4kb/8mNx8eH5ADUw1m1iRhh1KF
         7GpyurBWCOmHryVzyuklokMRuyCgJ+erg31e0dMkDaVTE2iXD5KaWbrI21I+CnpIVBWH
         fUi4JNP2wXOMwEfRKm4aKhU9mKt/pM7pWSm4tthcYs9GuYphHJherOJ2vJ/KYflby8AM
         9+Rg==
Received: by 10.66.88.39 with SMTP id bd7mr9330594pab.50.1343186504886;
        Tue, 24 Jul 2012 20:21:44 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id hf5sm13423597pbc.4.2012.07.24.20.21.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:21:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343186471-1024-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202108>

From: "Michael G. Schwern" <schwern@pobox.com>

It is no longer necessary to manually add new .pm files to the
Makefile.PL.  This makes it easier to add modules.

It is still necessary to add them to the Makefile, but that extra work
should be removed at a future date.

Signed-off-by: Michael G Schwern <schwern@pobox.com>
---
 perl/Makefile.PL | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 887fa1b..3f29ba9 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -2,6 +2,10 @@ use strict;
 use warnings;
 use ExtUtils::MakeMaker;
 use Getopt::Long;
+use File::Find;
+
+# Don't forget to update the perl/Makefile, too.
+# Don't forget to test with NO_PERL_MAKEMAKER=YesPlease
 
 # Sanity: die at first unknown option
 Getopt::Long::Configure qw/ pass_through /;
@@ -25,19 +29,18 @@ endif
 MAKE_FRAG
 }
 
-# XXX. When editing this list:
-#
-# * Please update perl/Makefile, too.
-# * Don't forget to test with NO_PERL_MAKEMAKER=YesPlease
-my %pm = (
-	'Git.pm' => '$(INST_LIBDIR)/Git.pm',
-	'Git/I18N.pm' => '$(INST_LIBDIR)/Git/I18N.pm',
-	'Git/SVN/Memoize/YAML.pm' => '$(INST_LIBDIR)/Git/SVN/Memoize/YAML.pm',
-	'Git/SVN/Fetcher.pm' => '$(INST_LIBDIR)/Git/SVN/Fetcher.pm',
-	'Git/SVN/Editor.pm' => '$(INST_LIBDIR)/Git/SVN/Editor.pm',
-	'Git/SVN/Prompt.pm' => '$(INST_LIBDIR)/Git/SVN/Prompt.pm',
-	'Git/SVN/Ra.pm' => '$(INST_LIBDIR)/Git/SVN/Ra.pm',
-);
+# Find all the .pm files in "Git/" and Git.pm
+my %pm;
+find sub {
+	return unless /\.pm$/;
+
+	# sometimes File::Find prepends a ./  Strip it.
+	my $pm_path = $File::Find::name;
+	$pm_path =~ s{^\./}{};
+
+	$pm{$pm_path} = '$(INST_LIBDIR)/'.$pm_path;
+}, "Git", "Git.pm";
+
 
 # We come with our own bundled Error.pm. It's not in the set of default
 # Perl modules so install it if it's not available on the system yet.
-- 
1.7.11.1
