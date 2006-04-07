From: Junio C Hamano <junkio@cox.net>
Subject: Re: realloc
Date: Fri, 07 Apr 2006 13:35:30 -0700
Message-ID: <7vmzexi0od.fsf@assigned-by-dhcp.cox.net>
References: <118833cc0604071311v1da93f83n112cc2ea44552ca9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 07 22:35:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRxg9-00030P-KK
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 22:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWDGUfe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 16:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWDGUfe
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 16:35:34 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:3736 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964939AbWDGUfd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Apr 2006 16:35:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060407203531.IQEP20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Apr 2006 16:35:31 -0400
To: git@vger.kernel.org
In-Reply-To: <118833cc0604071311v1da93f83n112cc2ea44552ca9@mail.gmail.com>
	(Morten Welinder's message of "Fri, 7 Apr 2006 16:11:21 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18505>

"Morten Welinder" <mwelinder@gmail.com> writes:

> I could be wrong, but shouldn't
>
>       var = realloc (var, whatever);
>
> be changed to call xrealloc?  That, or assign to a different variable and check
> for NULL.
>
> This should affect the last four hits below.
>
> M.
>
>
>
>
> /scratch/welinder/git> grep -w realloc *.c
> daemon.c:               newlist = realloc(socklist, sizeof(int) *
> (socknum + 1));
> diff-delta.c:                           out = realloc(out, outsize);
> git.c:          cmdname = realloc(cmdname, cmdname_alloc * sizeof(*cmdname));
> ls-files.c:             which->excludes = realloc(which->excludes,
> sha1_file.c:                            buf = realloc(buf, size);

There is no excuse for not using xrealloc() in git.c,
ls-files.c, and sha1_file.c.

The diff-delta.c code wants to be independent from the rest of
git code, so it probably should check the returned value itself.

Historically to a certain degree daemon.c also wanted to be
independent from the rest of git, but I suspect it still is the
case (it uses small pieces from packet interface but that is
about it).
