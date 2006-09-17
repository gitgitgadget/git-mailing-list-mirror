From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-apply fails to apply some patches
Date: Sat, 16 Sep 2006 23:16:25 -0700
Message-ID: <7vzmcz6mrq.fsf@assigned-by-dhcp.cox.net>
References: <20060915132225.12040.qmail@a0896f98af57b2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 386495@bugs.debian.org
X-From: git-owner@vger.kernel.org Sun Sep 17 08:16:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOpxK-0001Lq-27
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 08:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWIQGQ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 02:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWIQGQ1
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 02:16:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36764 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932217AbWIQGQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 02:16:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917061625.OPCI2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 02:16:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PJGD1V00J1kojtg0000000
	Sun, 17 Sep 2006 02:16:13 -0400
To: Gerrit Pape <pape@smarden.org>
cc: git@vger.kernel.org
In-Reply-To: <20060915132225.12040.qmail@a0896f98af57b2.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Fri, 15 Sep 2006 13:22:25 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27159>

Gerrit Pape <pape@smarden.org> writes:

>...
> On top of that, I try to apply this interdiff generated patch:
>
> diff -u pciutils-2.1.11/debian/dirs pciutils-2.1.11/debian/dirs
> --- pciutils-2.1.11/debian/dirs
> +++ pciutils-2.1.11/debian/dirs
> @@ -6,0 +7 @@
> +var/lib/pciutils
>
> and git-apply says:
>
> error: debian/dirs: already exists in working directory
>
> I suspect it's confused by the '-x,0' thinking that means "file does not
> exist" rather than "we have 0 context for this diff".

There are a few safety checks we perform assuming that the patch
has a few lines of context, and this is falsely triggering one
of them.  It incorrectly thinks that seeing _no_ context nor old
lines in the patch means this is a file creation patch, and
complains because it knows the file being patched already
exists.

I am looking into a way to handle a context-less patch line the
one quoted, without breaking the sanity check we have.

In the meantime you should be able to work things around by not
feeding --unified=0 diff output.
