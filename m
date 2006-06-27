From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [TRYTHIS] cvsimport: fix initial import
Date: Tue, 27 Jun 2006 13:01:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606271259200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44A102F0.9090604@op5.se>  <Pine.LNX.4.63.0606271234350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90606270352w32e3888dk1557eefbe1043d92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 27 13:02:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvBKR-0003Sb-B8
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 13:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWF0LBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 07:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933397AbWF0LBy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 07:01:54 -0400
Received: from mail.gmx.de ([213.165.64.21]:32693 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933385AbWF0LBx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 07:01:53 -0400
Received: (qmail invoked by alias); 27 Jun 2006 11:01:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 27 Jun 2006 13:01:52 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606270352w32e3888dk1557eefbe1043d92@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22730>

Hi,

On Tue, 27 Jun 2006, Martin Langhoff wrote:

> this patch doesn't quite make sense to me. The git-read-tree should be
> in the else block of the unless you have right there (and it's
> actually there, but it may be breaking in some cases? Perhaps should
> happen a bit earlier?).
> 
> How do you expect to run git-read-tree or die _before_ git-init-db?

Oops. I even do not remember what I smoked.

The git-read-tree before git-init-db evidently only works if this is not 
the initial import. Which it wasn't in my case.

And I keep getting confused with the "if" and "unless" sometimes 
prepended, sometimes appended. Well, that is Perl before Swine for me ;-)

How about this instead:

 git-cvsimport.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 50f5d96..4caef10 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -470,8 +470,6 @@ my %index; # holds filenames of one inde
 $index{$opt_o} = tmpnam();
 
 $ENV{GIT_INDEX_FILE} = $index{$opt_o};
-system("git-read-tree", $opt_o);
-die "read-tree failed: $?\n" if $?;
 
 unless(-d $git_dir) {
 	system("git-init-db");
@@ -482,6 +480,8 @@ unless(-d $git_dir) {
 	$last_branch = $opt_o;
 	$orig_branch = "";
 } else {
+	system("git-read-tree", $opt_o);
+	die "read-tree failed: $?\n" if $?;
 	-f "$git_dir/refs/heads/$opt_o"
 		or die "Branch '$opt_o' does not exist.\n".
 		       "Either use the correct '-o branch' option,\n".
