From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Mon, 4 Jul 2005 17:52:26 +0200
Message-ID: <20050704155226.GQ18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630193825.GA17345@pc117b.liacs.nl> <20050630210023.GY10850@kiste.smurf.noris.de> <20050704130324.GK18608MdfPADPa@garage.linux.student.kuleuven.ac.be> <20050704135327.GA32098@kiste.smurf.noris.de> <20050704134611.GM18608MdfPADPa@garage.linux.student.kuleuven.ac.be> <20050704143637.GB32098@kiste.smurf.noris.de>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 18:16:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpTbw-0000g4-22
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 18:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVGDQOt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 12:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVGDQNi
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 12:13:38 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:12947 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261165AbVGDQJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 12:09:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id BD39133E84
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 18:09:14 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id ED2B833E90
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 18:09:12 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id D1BC14C2C5
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 18:09:12 +0200 (CEST)
Received: (qmail 2907 invoked by uid 500); 4 Jul 2005 15:52:26 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050704143637.GB32098@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 04, 2005 at 04:36:37PM +0200, Matthias Urlichs wrote:
> Ideally, I'd prefer to recycle standard CVS options as much as possible, 
> but given that the confusion is already there (worse: cvs' -z wants an
> argument (compression level), cvsps' -Z doesn't) that may not actually
> make sense. *Shrug*
> 
> I'm too happy when other people improve my tools to get hung up on
> details like that. ;-)

Here it is, then.

skimo
--
git-cvsimport-script: provide direct support for cvsps -z option

---
commit 28537171e7ec23c8677ea6e77c208583f95caa28
tree ca80ed2fad05b150984c14a5364dac8d3e307120
parent 6e7e37b0bfc921aa1f0cb30560fc128e87a41966
author Sven Verdoolaege <skimo@kotnet.org> Mon, 04 Jul 2005 17:10:06 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Mon, 04 Jul 2005 17:10:06 +0200

 git-cvsimport-script |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -28,19 +28,19 @@ use POSIX qw(strftime dup2);
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our($opt_h,$opt_o,$opt_v,$opt_d,$opt_p,$opt_C);
+our($opt_h,$opt_o,$opt_v,$opt_d,$opt_p,$opt_C,$opt_z);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from CVS
-	   [ -o branch-for-HEAD ] [ -h ] [ -v ] [ -d CVSROOT ]
-       [ -p opts-for-cvsps ] [ -C GIT_repository ]
+       [ -o branch-for-HEAD ] [ -h ] [ -v ] [ -d CVSROOT ]
+       [ -p opts-for-cvsps ] [ -C GIT_repository ] [ -z fuzz ]
        [ CVS_module ]
 END
 	exit(1);
 }
 
-getopts("hqvo:d:p:C:") or usage();
+getopts("hqvo:d:p:C:z:") or usage();
 usage if $opt_h;
 
 @ARGV <= 1 or usage();
@@ -436,6 +436,7 @@ die "Cannot fork: $!\n" unless defined $
 unless($pid) {
 	my @opt;
 	@opt = split(/,/,$opt_p) if defined $opt_p;
+	unshift @opt, '-z', $opt_z if defined $opt_z;
 	exec("cvsps",@opt,"-u","-A","--cvs-direct",'--root',$opt_d,$cvs_tree);
 	die "Could not start cvsps: $!\n";
 }
