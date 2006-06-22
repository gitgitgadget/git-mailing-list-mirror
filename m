From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] [RFC] Introduce Git.pm
Date: Wed, 21 Jun 2006 19:31:05 -0700
Message-ID: <20060622023104.GB27871@hand.yhbt.net>
References: <20060622003546.17760.23089.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 04:31:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtEyT-0001t3-6e
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 04:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbWFVCbL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 22:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030542AbWFVCbL
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 22:31:11 -0400
Received: from hand.yhbt.net ([66.150.188.102]:11939 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030521AbWFVCbK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 22:31:10 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id A46E57DC021; Wed, 21 Jun 2006 19:31:06 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060622003546.17760.23089.stgit@machine.or.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22296>

Petr Baudis <pasky@suse.cz> wrote:
> Currently Git.pm just wraps up exec()s of Git commands, but even that
> is not trivial to get right and various Git perl scripts do it in
> various inconsistent ways. And things will get much more interesting
> when we get to XS-izing libgit.

git-svn uses fork/pipe/exec very heavily for both reads and writes and
also a few bidirectional cases, as well.  It would be good exercise to
port it to use Git.pm once it's more complete and stable.

XS-ising libgit would be awesome with all the git-hash-object calls in
git-svn (and other importers, too, I imagine).

> This is mostly to show up what I have so far and gather some comments
> on the general shapes of the interface; I guess in the current shape
> of the API it's suitable for pu at best, but that's not my call.

safe_qx (git-svn) AKA safe_pipe_capture (archimport) would be
non-git-specific, but very useful.

> +	my $pid = open(my $fh, "-|");
> +	if ($pid < 0) {
> +		die "generic($cmd, @args) open: $!";

In Perl, fork returns undef instead of $pid < 0 on failure.  Doing
join(' ',@args) will also make the error message more readable, too :)

-- 
Eric Wong
