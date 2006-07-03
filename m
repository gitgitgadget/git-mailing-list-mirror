From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Eliminate Scalar::Util for something simpler
Date: Mon, 3 Jul 2006 23:49:56 +0200
Message-ID: <20060703214956.GP29115@pasky.or.cz>
References: <20060703204415.28541.47920.stgit@machine.or.cz> <20060703204803.28541.67315.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 23:50:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxWIv-00026p-Vg
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 23:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWGCVt7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 17:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWGCVt7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 17:49:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15266 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751005AbWGCVt6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 17:49:58 -0400
Received: (qmail 5569 invoked by uid 2001); 3 Jul 2006 23:49:56 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060703204803.28541.67315.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23217>

Dear diary, on Mon, Jul 03, 2006 at 10:48:03PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> +		xs__call_gate(Scalar::Util::refaddr($self), $self->repo_path());

This was silly and requires Scalar::Util.

->8-
Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 65acaa7..f2467bd 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -92,13 +92,14 @@ increate nonwithstanding).
 use Carp qw(carp croak); # but croak is bad - throw instead
 use Error qw(:try);
 use Cwd qw(abs_path);
-use Scalar::Util;
 
 require XSLoader;
 XSLoader::load('Git', $VERSION);
 
 }
 
+my $instance_id = 0;
+
 
 =head1 CONSTRUCTORS
 
@@ -216,7 +217,7 @@ sub repository {
 		delete $opts{Directory};
 	}
 
-	$self = { opts => \%opts };
+	$self = { opts => \%opts, id => $instance_id++ };
 	bless $self, $class;
 }
 
@@ -855,7 +856,7 @@ sub _call_gate {
 		# For now, when we will need to do it we could temporarily
 		# chdir() there and then chdir() back after the call is done.
 
-		xs__call_gate(Scalar::Util::refaddr($self), $self->repo_path());
+		xs__call_gate($self->{id}, $self->repo_path());
 	}
 
 	# Having to call throw from the C code is a sure path to insanity.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
