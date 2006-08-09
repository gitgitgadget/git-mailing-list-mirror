From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Workaround for strange cmp bug
Date: Wed, 09 Aug 2006 03:50:23 -0700
Message-ID: <7v3bc65gk0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608091221550.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 12:50:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAldt-00043C-68
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 12:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030597AbWHIKu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 06:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030660AbWHIKu0
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 06:50:26 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:1762 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030597AbWHIKuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 06:50:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809105024.SAQK6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 06:50:24 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608091221550.1800@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 9 Aug 2006 12:24:06 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25109>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The cmp(1) (cmp (GNU diffutils) 2.8.7) distributed with openSUSE 10.1 has
> a subtle "shortcoming":
>
> 	$ echo a > a
> 	$ echo b > b
> 	$ cmp a b && echo nonono
> 	a b differ: char 1, line 1
> 	$ cmp a b >/dev/null && echo nonono
> 	nonono
> 	$ cmp -s a b >/dev/null && echo nonono
>
> So, if cmp should _not_ be quiet, _and_ the output is redirected to
> /dev/null, it has a bogus exit value. Our test suite redirects to
> /dev/null, which triggers that bug. (Obviously, the tests pass when
> running with '-v', which made that a real bugger to debug.)

While I sympathize unfortunate users who are stuck with such a
broken implementation of an important basic tool, such a rewrite
unnecessarily makes debugging of both test scripts _and_ real
breakage harder.

It actually is very useful, in the chain of &&, to see that
these steps in our tests output something when they shouldn't
when the tests are run under -v; you may have noticed that the
tests written by me have seemingly useless "echo happy" (which
always returns true) and such, and they are there for a reason.

Please get the distribution fixed.
