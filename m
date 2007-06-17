From: Junio C Hamano <gitster@pobox.com>
Subject: Re: repack behaves unexpectedly if called in a bare _subrepo_
Date: Sun, 17 Jun 2007 10:22:39 -0700
Message-ID: <7vir9mzeao.fsf@assigned-by-dhcp.pobox.com>
References: <20070617153810.GB2763@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 19:22:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzySY-00008i-G1
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 19:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092AbXFQRWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 13:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754920AbXFQRWl
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 13:22:41 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:54503 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbXFQRWk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 13:22:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070617172239.VUPM4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Jun 2007 13:22:39 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ChNf1X0071kojtg0000000; Sun, 17 Jun 2007 13:22:39 -0400
In-Reply-To: <20070617153810.GB2763@steel.home> (Alex Riesen's message of
	"Sun, 17 Jun 2007 17:38:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50361>

Alex Riesen <raa.lkml@gmail.com> writes:

> Just a heads-up. This took me by surprise. And I suppose it will be
> the same even if the subrepo is a real subproject.
>
> To illustrate:
>
> (
>     mkdir super && cd super
>     git init
>     echo 0 > a; git add a; git commit -m0
>     echo 2 >> a; git commit -a -m1
>     echo 3 >> a; git commit -a -m2
>     cp -a .git sub
>     cd sub
>     git --bare config --bool core.bare true
>     git repack -a -d
> )

I think what is happening is that in that bare repository 'sub',
the sequence we find where a git repository is is defined so
that the current directory is checked way after "one of my
parents with .git/ subdirectory" check.

If super (a directory) has a subproject sub as its subproject,
then you would be copying .git to sub/.git, not sub/, wouldn't
you?  What are you trying to achieve?
