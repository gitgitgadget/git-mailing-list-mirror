From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rc3 gitweb is broken, won't deliver snapshots
Date: Wed, 25 Jul 2007 15:48:31 -0700
Message-ID: <7vsl7ccd6o.fsf@assigned-by-dhcp.cox.net>
References: <30e4a070707250627l29ce4794x97d03b8232352cae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Mark Levedahl" <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:48:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDpem-0001SM-QN
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 00:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757533AbXGYWsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 18:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758333AbXGYWsd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 18:48:33 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60151 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276AbXGYWsc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 18:48:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725224832.VMVG1393.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 25 Jul 2007 18:48:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TyoX1X00U1kojtg0000000; Wed, 25 Jul 2007 18:48:32 -0400
In-Reply-To: <30e4a070707250627l29ce4794x97d03b8232352cae@mail.gmail.com>
	(Mark Levedahl's message of "Wed, 25 Jul 2007 09:27:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53731>

"Mark Levedahl" <mlevedahl@gmail.com> writes:

> gitweb in 1.5.3-rc3 fails to deliver snapshots in any useable format
> (bzip2, gz, or zip). Clicking on a link seems to work, but the
> delivered file as stored on my system is empty. No error messages
> appear anywhere I can find. I am hosting gitweb on FC7 using lighttpd,
> if that matters.
>
> The snapshot service at git.kernel.org also seems broken, I don't know
> what gitweb is running there so don't know if the issue is related.
>
> I have fixed this for my use by reverting the following commits
>
> 3473e7df5f8c7f8dc3e2c3f2fdc99a1d1a719c16 gitweb: More detailed error
> messages for snapshot format
> a781785d8f1eb7adf05a24b121104716a086a67a gitweb: Fix support for
> legacy gitweb config for snapshots
> a3c8ab30a54c30a6a434760bedf04548425416ef gitweb: snapshot cleanups &
> support for offering multiple formats
>
> The snapshot problem first appears when a3c8ab30a54 is applied.

True.  I wonder if people who submitted patches even tested
these things... Sigh.

---

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0acd0ca..b381692 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4343,7 +4343,7 @@ sub git_snapshot {
 	my $cmd;
 	$filename .= "-$hash$known_snapshot_formats{$format}{'suffix'}";
 	$cmd = "$git_command archive " .
-		"--format=$known_snapshot_formats{$format}{'format'}" .
+		"--format=$known_snapshot_formats{$format}{'format'} " .
 		"--prefix=\'$name\'/ $hash";
 	if (exists $known_snapshot_formats{$format}{'compressor'}) {
 		$cmd .= ' | ' . join ' ', @{$known_snapshot_formats{$format}{'compressor'}};
