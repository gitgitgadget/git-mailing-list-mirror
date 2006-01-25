From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] use "git <command>" instead of "git-<command>"
Date: Tue, 24 Jan 2006 18:08:34 -0800
Message-ID: <7v64o93vq5.fsf@assigned-by-dhcp.cox.net>
References: <20060124105224.GA6765@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 03:08:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1a5X-0001ys-VE
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 03:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWAYCIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 21:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWAYCIg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 21:08:36 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58003 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750789AbWAYCIg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 21:08:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125020632.KRFW17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 Jan 2006 21:06:32 -0500
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15111>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> Otherwise installations with gitexecdir != bindir are not able
> to determine the right version.

True, but this part

> -VN=$(git-describe --abbrev=4 HEAD 2>/dev/null | sed -e 's/-/./g') ||
> +VN=$(git describe --abbrev=4 HEAD 2>/dev/null | sed -e 's/-/./g') ||
>...

has a subtle issue, which the commit 026351a addresses, which
will hopefully become a non-issue given enough time.  Then it
would be safe to make this change.

Of course, if/when I change the main Makefile to have different
gitexecdir and bindir by default, it would become "my problem",
but until then...

> -dirty=$(sh -c 'git-diff-index --name-only HEAD' 2>/dev/null) || dirty=
> +dirty=$(sh -c 'git diff-index --name-only HEAD' 2>/dev/null) || dirty=

On the other hand, your patch is correct for this part.  The
issue 026351a commit addressed does not apply.  An ancient 'git'
that did not have 'diff-index' (it was called 'diff-cache')
would have hit a breakage early on since 'describe' did not
exist back then.
