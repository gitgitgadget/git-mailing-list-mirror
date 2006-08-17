From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/7] gitweb: Added parse_difftree_raw_line function for later use
Date: Thu, 17 Aug 2006 02:55:51 -0700
Message-ID: <7vfyfvsn2w.fsf@assigned-by-dhcp.cox.net>
References: <11558064883957-git-send-email-jnareb@gmail.com>
	<11558064893592-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 11:55:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDebV-0006sr-2w
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWHQJzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWHQJzx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:55:53 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:9925 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932426AbWHQJzx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 05:55:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060817095552.PNHC23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Aug 2006 05:55:52 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <11558064893592-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Thu, 17 Aug 2006 11:21:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25578>

Jakub Narebski <jnareb@gmail.com> writes:

> +sub parse_difftree_raw_line {
> +	my $line = shift;
> +	my %res;
> +
> +	# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M	ls-files.c'
> +	# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M	rev-tree.c'
> +	if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {

We would probably want to say that status symbol is an uppercase
alpha [A-Z].  Or maybe limit it to a non-whitespace letter (\S).
Dot there to say "just any letter" looks wrong.

I would use "+" instead of hardcoding the length of mode strings
(you have 6 there) and object name hash (ditto 40) but that is
mostly style and a slight future proofing against us using
longer hashes (not in our immediate future though).
