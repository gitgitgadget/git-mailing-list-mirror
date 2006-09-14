From: Junio C Hamano <junkio@cox.net>
Subject: Re: open(2) vs fopen(3)
Date: Thu, 14 Sep 2006 09:37:39 -0700
Message-ID: <7vr6ye4d64.fsf@assigned-by-dhcp.cox.net>
References: <20060914091513.19826.qmail@web25812.mail.ukl.yahoo.com>
	<Pine.LNX.4.64.0609140835080.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Sep 14 18:37:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNuDi-0007a4-OW
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 18:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWINQhn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 12:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWINQhn
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 12:37:43 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46781 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750749AbWINQhn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 12:37:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914163742.DAZK2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 12:37:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NGdU1V00Z1kojtg0000000
	Thu, 14 Sep 2006 12:37:31 -0400
To: moreau francis <francis_moreau2000@yahoo.fr>
In-Reply-To: <Pine.LNX.4.64.0609140835080.4388@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 14 Sep 2006 08:46:13 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27010>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 14 Sep 2006, moreau francis wrote:
>> 
>> I'm reading git source code and falling on this stupid question:
>> Why sometime open(2) is used and other time fopen(3) is
>> prefered. I'm sorry for this dump question but I have no clue.
>
> fopen() tends to result in easier usage, especially if the file in 
> question is a line-based ASCII file, and you can just use "fgets()" to 
> read it. So fopen is the simple alternative for simple problems.
>
> Using a direct open() means that you have to use the low-level IO 
> functions (I'm ignoring the use of "fdopen()"), but if done right, it has 
> a number of advantages:
>...
>  - error conditions are a lot more obvious and repeatable with the 
>    low-level things, at least so I find personally. Error handling with 
>    stdio routines is _possible_, but probably because almost nobody ever 
>    does it, it's not something that people are conditioned to do, so it 
>    ends up beign "strange".

Another issue related with this is that stdio implementations
tend to have unintuitive interaction with signals, one fine
example of it being the problem we fixed with commit fb7a653,
where on Solaris fgets(3) did not restart the underlying read(2)
upon SIGALRM.

Technically it was a bug on our part not Solaris, but that was
something unexpected to see.
