From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: Dropping Git.pm (at least Git.xs)?
Date: Sun, 3 Sep 2006 17:03:05 +0200
Message-ID: <20060903150305.G50c94aea@leonov.stosberg.net>
References: <7vodtxuqt4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 17:03:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJtVK-0005ON-Lr
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 17:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWICPDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 11:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWICPDJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 11:03:09 -0400
Received: from kleekamp.stosberg.net ([85.116.201.130]:52610 "EHLO
	kleekamp.stosberg.net") by vger.kernel.org with ESMTP
	id S1751150AbWICPDI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 11:03:08 -0400
Received: by kleekamp.stosberg.net (Postfix, from userid 500)
	id 7EA75FB061; Sun,  3 Sep 2006 17:03:05 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodtxuqt4.fsf@assigned-by-dhcp.cox.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26373>

Junio C Hamano wrote:

> In the ideal world in admittably not so immediate future, I
> would rather have a honestly libified git that encapsulates
[...]
>  - I think the clean-up promise of Git.pm is great (e.g.
>    safe_qx should be part of it not in git-svn alone).
> 
>  - I think Git.xs was a bit premature and raised the hurdle of
>    cleaning up and consolidating various core-wrappers from
>    existing Perl scripts into Git.pm and have them use Git.pm.
>    It would be nice if we can drop this part for now, and do a
>    bit more Perl-level clean-up first.

Having perl bindings to git internals and sometime in the future to a
libified git is a great thing.  It will allow people to do interesting
things, quickly trying concepts without having to write any C code.
And I expect that gitweb can be sped up remarkably by using Git.pm (no
forking, parsing of command output often not necessary, easy caching of
frequently cached data across calls, etc)

So I think there are valid uses for Git.pm.

On the other hand there are the problems Junio mentioned.  And the
portability issues wit Git.pm:

 - Git has to be built with the same compiler perl was built with,
   which is a problem on many Solaris machines.
 - We need to generate position-independent code on some archs, but
   have no proper way to determine on which systems it is really
   necessary. 
 - It completely breaks cross-compiling.

And the gain is negligible at the moment: There are only two users
left: git-annotate and git-send-email.  The first one has already
been superseded by git-blame and the second one can easily be
converted back.

I think Git.pm would be a good candidate for the contrib section if
there is someone who keeps it up-to-date through the coming changes.
The only thing that would have to be kept in the main Makefile is the
option to generate position-independent code, defaulting to off.

Regards,
Dennis



-- 
VGER BF report: U 0.957499
