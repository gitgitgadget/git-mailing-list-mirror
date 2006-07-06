From: Junio C Hamano <junkio@cox.net>
Subject: Re: comparing file contents in is_exact_match?
Date: Wed, 05 Jul 2006 23:20:13 -0700
Message-ID: <7vd5cj9rvm.fsf@assigned-by-dhcp.cox.net>
References: <20060706055729.GA12512@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 08:20:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyNDs-0006wi-6I
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 08:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWGFGUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 02:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWGFGUP
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 02:20:15 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:60100 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030195AbWGFGUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 02:20:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060706062014.JGBH985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Jul 2006 02:20:14 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060706055729.GA12512@admingilde.org> (Martin Waitz's message
	of "Thu, 6 Jul 2006 07:57:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23374>

Martin Waitz <tali@admingilde.org> writes:

> The reason for that is that is_exact_match (in diffcore-rename.c) maps
> both the source and destination file into memory and then compares them
> byte for byte.  This is a little bit too much for my little machine.
>
> When I remove the content comparation and only leave the sha1
> comparision, then my renames are correctly found in a second.  But
> unluckily, some other renames in the testcases are not correctly
> handled any more.
>
> So is there an easy solution?  Why is the content comparision in
> is_exact_match needed?

Because your working tree can be out of sync with respect to
what's in the index, in which case we cannot trust the sha1
while running diff-index (without --cached flag).

git-update-index --refresh before doing anything might help.
