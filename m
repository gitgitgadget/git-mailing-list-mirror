From: Junio C Hamano <junkio@cox.net>
Subject: Re: Use a *real* built-in diff generator
Date: Fri, 24 Mar 2006 22:54:10 -0800
Message-ID: <7vk6ajxbe5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 07:54:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN2f9-0003Gq-As
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 07:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWCYGyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 01:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWCYGyM
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 01:54:12 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20395 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750704AbWCYGyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 01:54:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325065411.CQJC17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 01:54:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 24 Mar 2006 20:13:22 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17959>

Linus Torvalds <torvalds@osdl.org> writes:

> This uses a simplified libxdiff setup to generate unified diffs _without_ 
> doing  fork/execve of GNU "diff".

Good stuff.

> Now, in the interest of full disclosure, I should also point out a few 
> downsides:
>
>  - the libxdiff algorithm is different,...
>
>  - GNU diff does some nice eye-candy, like trying to figure out what the 
>    last function was, and adding that information to the "@@ .." line. 
>    libxdiff doesn't do that. 

That's kind of sad --- Documentation/SubmittingPatches request
people to say "diff -u -p".

>  - The libxdiff thing has some known deficiencies. In particular, it gets 
>    the "\No newline at end of file" case wrong. So this is currently for 
>    the experimental branch only. I hope Davide will help fix it.

Another thing I noticed is that while libxdiff always shows full
line counts "-n,m +l,k" GNU seems to omit them when it can (m,k
<=1).  I am not sure if apply.c is set up to grok what libxdiff
emits correctly.  Running t/t1200 shows some obvious examples.
