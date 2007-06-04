From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make the installation targets a little less chatty
Date: Mon, 04 Jun 2007 00:48:51 -0700
Message-ID: <7vvee4jh24.fsf@assigned-by-dhcp.cox.net>
References: <20070603010044.GA4507@spearce.org>
	<20070603130745.GC2495@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 09:49:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv7JE-00089v-PD
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 09:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbXFDHsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 03:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbXFDHsw
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 03:48:52 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40126 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbXFDHsw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 03:48:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070604074852.ORLZ5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 Jun 2007 03:48:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7Kor1X0031kojtg0000000; Mon, 04 Jun 2007 03:48:51 -0400
In-Reply-To: <20070603130745.GC2495@steel.home> (Alex Riesen's message of
	"Sun, 3 Jun 2007 15:07:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49077>

Alex Riesen <raa.lkml@gmail.com> writes:

> by default. V=1 works as usual.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> Updated. BTW, where does "no $(call) in Makefile" came from?
> It could simplify the thing a lot

Probably, but first let's make it "work right" while not
introducing new stuff.

> diff --git a/Makefile b/Makefile
> index cac0a4a..6409b9c 100644
> --- a/Makefile
> +++ b/Makefile
> ...
> @@ -972,34 +975,53 @@ check: common-cmds.h
>  
>  ### Installation rules
>  
> +ifeq ($(QUIET),@)
> +INST_0   = arg=
> +INST_1   = &&echo  "    INSTALL $$arg"&&$(INSTALL) "$$arg" # space
> +BSETUP_0 = arg=
> +BSETUP_1 = &&echo  "    SETUP BUILTIN $$arg"&& \
> +	   rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" && \
> +	   ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$(X)' \
> +	   '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" # space
> +else
> +INST_0   = $(INSTALL) # space to separate "install" and its first arg
> +INST_1   =
> +BSETUP_0 = arg=
> +BSETUP_1 = &&rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" && \
> +	   ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$(X)' \
> +	   '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" # space
> +endif
> +
>  install: all
>  	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'

I found Shawn's "DEST = $this_directory" quite decent.  Forgot
to port it?
