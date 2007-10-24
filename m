From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-remote: Use of uninitialized value in string ne, line 248
Date: Wed, 24 Oct 2007 04:49:51 -0700
Message-ID: <7vwstc68bk.fsf@gitster.siamese.dyndns.org>
References: <20071024110807.GA12501@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 13:51:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikeku-000515-Hr
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 13:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbXJXLt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 07:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755989AbXJXLt6
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 07:49:58 -0400
Received: from rune.pobox.com ([208.210.124.79]:57009 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755911AbXJXLt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 07:49:57 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 2F0D014F148;
	Wed, 24 Oct 2007 07:50:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9577814ED1D;
	Wed, 24 Oct 2007 07:50:15 -0400 (EDT)
In-Reply-To: <20071024110807.GA12501@piper.oerlikon.madduck.net> (martin
	f. krafft's message of "Wed, 24 Oct 2007 13:08:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62211>

martin f krafft <madduck@madduck.net> writes:

> piper:~> git remote show origin
> * remote origin
>   URL: ssh://git.madduck.net/~/git/etc/mailplate.git
> Use of uninitialized value in string ne at /usr/local/stow/git/bin/git-remote line 248.
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Perhaps....

 git-remote.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 9ca3e7e..4cee044 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -244,7 +244,8 @@ sub show_remote {
 	print "* remote $name\n";
 	print "  URL: $info->{'URL'}\n";
 	for my $branchname (sort keys %$branch) {
-		next if ($branch->{$branchname}{'REMOTE'} ne $name);
+		next if (!$branch->{$branchname}{'REMOTE'} ||
+			 $branch->{$branchname}{'REMOTE'} ne $name);
 		my @merged = map {
 			s|^refs/heads/||;
 			$_;
