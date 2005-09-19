From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHES] CURLDIR support, more usable cmd-rename.sh
Date: Mon, 19 Sep 2005 09:34:35 -0700
Message-ID: <7vhdchqan8.fsf@assigned-by-dhcp.cox.net>
References: <1127128475.781.6.camel@divert>
	<20050919133731.GB2903@pasky.or.cz> <1127139079.781.9.camel@divert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 18:36:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHObI-0002U8-7i
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 18:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVISQeh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 12:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVISQeh
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 12:34:37 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:51624 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932463AbVISQeh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 12:34:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919163436.LSPM4028.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 12:34:36 -0400
To: Patrick Mauritz <oxygene@studentenbude.ath.cx>
In-Reply-To: <1127139079.781.9.camel@divert> (Patrick Mauritz's message of
	"Mon, 19 Sep 2005 16:11:19 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8886>

Patrick Mauritz <oxygene@studentenbude.ath.cx> writes:

> diff -ur git-core-0.99.7.orig//Makefile git-core-0.99.7/Makefile
> --- git-core-0.99.7.orig//Makefile	Mon Sep 19 12:43:04 2005
> +++ git-core-0.99.7/Makefile	Mon Sep 19 12:45:45 2005

Why not a patch from either git or cogito or stgit ;-)?
Anyway, thanks for your patch.

> -CFLAGS = -g -O2 -Wall
> +CFLAGS = -g -O2

Not relevant to the current topic as far as I can tell (unless
your non-standard curl include files trip under -Wall).

> +ifdef CURLDIR
> +CFLAGS+=-I$(CURLDIR)/include
> +endif
>  ALL_CFLAGS = $(CFLAGS) $(PLATFORM_DEFINES) $(DEFINES)
>  
>  prefix = $(HOME)
> @@ -261,7 +264,11 @@
>  git-ssh-pull: rsh.o fetch.o
>  git-ssh-push: rsh.o
>  
> +ifdef CURLDIR
> +git-http-fetch: LIBS += -L$(CURLDIR)/lib -R$(CURLDIR)/lib -lcurl
> +else
>  git-http-fetch: LIBS += -lcurl
> +endif

I do not have any objections to helping installations where CURL
is installed somewhere nonstandard, but if that is the case I am
wondering if assuming that they are all in the same directory
hierarchy covers enough.  CURLDIR=/usr/local/ would be OK and
CURLDIR=/opt/curl/ would be as well with this patch, so this
probably is fine.  Installations without ld.so.conf need -R, but
is it safe to always force -R like this?

Also I wonder if we need similar customization for openssl
stuff, but that is a separate topic.

> --- cmd-rename.sh~	Mon Sep 19 12:53:40 2005
> +++ git-core-0.99.7/cmd-rename.sh	Mon Sep 19 12:53:58 2005
> @@ -4,7 +4,9 @@
>  while read old new
>  do
>  	rm -f "$d/$old"
> +	if [ -x "$d/$new" ]; then
>  	ln -s "$new" "$d/$old"
> +	fi

No questions about this part.  Thanks for the fix.
