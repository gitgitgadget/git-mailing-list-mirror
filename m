From: Mathias Lafeldt <misfire@debugon.org>
Subject: [PATCH] git-svn: fix processing of decorated commit hashes
Date: Fri, 24 Sep 2010 00:05:03 +0200
Message-ID: <4C9BCF0F.5020101@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 24 00:05:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OytvK-0007wW-Nk
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 00:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab0IWWFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 18:05:24 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:53323 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab0IWWFW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 18:05:22 -0400
Received: from [192.168.2.2] (p54B94F3A.dip.t-dialin.net [84.185.79.58])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0Mhh2N-1PBDjN09HH-00MvXx; Fri, 24 Sep 2010 00:05:19 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
X-Provags-ID: V02:K0:9x2x+WoFPigEz5WOaI5Y/XAfURiqc+gJdVlcYianB80
 rTudF06fU0YqBwlGB2mujCFQ3n6HBDVfF2a6sCmwdeGXdLOXWm
 ydeLWaIXZZQR3WU+yW+adw2ynYbQdbuoen/pe433q809f9uDyN
 OOq2yufyPfyGGPnT06i2D7dg8d7IOw6YAToR19xQLvPEsHVTvS
 iLXU55+w1sUxP/tSvD1pcz9s+pJAKT5Q4HMbRL9pJc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156919>

The function working_head_info() fails to parse commit hashes if they
are decorated (i.e. log.decorate is true), causing dcommit, rebase, and
other vital git-svn commands to malfunction.

This patch disables decorated log output with --no-decorate.

Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9b046b6..90e1236 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1513,7 +1513,7 @@ sub cmt_sha2rev_batch {
 
 sub working_head_info {
 	my ($head, $refs) = @_;
-	my @args = ('log', '--no-color', '--first-parent', '--pretty=medium');
+	my @args = qw/log --no-color --no-decorate --first-parent --pretty=medium/;
 	my ($fh, $ctx) = command_output_pipe(@args, $head);
 	my $hash;
 	my %max;
-- 
1.7.3
