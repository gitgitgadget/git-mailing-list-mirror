From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: [PATCH 2/2] add--interactive: added [c]heckout
Date: Mon, 6 Oct 2008 17:55:35 +0200
Message-ID: <20081006155535.GB28582@gmx.de>
References: <20081005152654.GA13618@gmx.de> <20081005164124.GA31903@coredump.intra.peff.net> <20081005214644.GB32727@gmx.de> <20081005221150.GA22007@coredump.intra.peff.net> <353e718308129444268e61f251dab769761f095f.1223304141.git.marco-oweber@gmx.de> <20081006145137.GC8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 18:01:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmsS2-0002U1-Nx
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 17:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbYJFPzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 11:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752976AbYJFPzk
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 11:55:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:56578 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752953AbYJFPzj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 11:55:39 -0400
Received: (qmail invoked by alias); 06 Oct 2008 15:55:36 -0000
Received: from pD9E0B45E.dip.t-dialin.net (EHLO nixos) [217.224.180.94]
  by mail.gmx.net (mp013) with SMTP; 06 Oct 2008 17:55:36 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+Z5MJ6N7uZEK+d10MW0crjZDDZyyh8ybpjnCcOvE
	/JxKt1dpAgcvGP
Received: by nixos (sSMTP sendmail emulation); Mon, 06 Oct 2008 17:55:35 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org,
	spearce@spearce.org
Content-Disposition: inline
In-Reply-To: <20081006145137.GC8203@spearce.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97597>

> Uhm, what is this patch against?  git.git?  If so why are we creating
> a new 1129 line script named something erily close to a script we
> already have?
I accidently added the dist file git-add--interactive instead of
the .perl file.. I'll take more care the next time.
Both patches should apply cleanly against git.git master branch c4275591fb

============= 2/2 starting at commit message =========================
From 741d1e87669ced27a41f8be1b7b65836bd969d5a Mon Sep 17 00:00:00 2001
Message-Id: <741d1e87669ced27a41f8be1b7b65836bd969d5a.1223307236.git.marco-oweber@gmx.de>
In-Reply-To: <b41e1729a8817f0d3cba2be1edc37513a72901dd.1223307236.git.marco-oweber@gmx.de>
References: <b41e1729a8817f0d3cba2be1edc37513a72901dd.1223307236.git.marco-oweber@gmx.de>
From: Marc Weber <marco-oweber@gmx.de>
Date: Mon, 6 Oct 2008 14:32:13 +0000
Subject: [PATCH 2/2] add--interactive: added [c]heckout

this is convinient for cygwin users not using rxvt.

command added last (before quit and help) to not break menu layout and keep exisiting
numbering

Signed-off-by: Marc Weber <marco-oweber@gmx.de>
---
 git-add--interactive.perl |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 5352d16..34629b5 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -532,6 +532,27 @@ sub reset_cmd {
 	print "\n";
 }
 
+sub checkout_cmd {
+	my @update = list_and_choose({ PROMPT => 'Checkout',
+				       HEADER => $status_head, },
+				     list_modified());
+	if (@update) {
+		if (is_initial_commit()) {
+			# should never be executed because there can't be modified files
+			print "error: no revision in repo yet\n";
+		}
+		else {
+			for (@update) {
+				system(qw(git checkout --),
+				$_->{VALUE});
+			}
+		}
+		refresh();
+		say_n_paths('checked out', @update);
+	}
+	print "\n";
+}
+
 sub add_untracked_cmd {
 	my @add = list_and_choose({ PROMPT => 'Add untracked' },
 				  list_untracked());
@@ -1074,6 +1095,7 @@ sub main_loop {
 		   [ 'add untracked', \&add_untracked_cmd, ],
 		   [ 'patch', \&patch_update_cmd, ],
 		   [ 'diff', \&diff_cmd, ],
+		   [ 'checkout', \&checkout_cmd, ],
 		   [ 'quit', \&quit_cmd, ],
 		   [ 'help', \&help_cmd, ],
 	);
-- 
1.6.0.2.GIT
