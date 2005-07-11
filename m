From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/6] git-gnu-progs-Makefile: git Makefile update
Date: Mon, 11 Jul 2005 12:02:07 -0700
Message-ID: <7vk6jxupxs.fsf@assigned-by-dhcp.cox.net>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
	<20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bryan.larsen@gmail.com, junkio@cox.net, torvalds@osdl.org,
	pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 21:28:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds3ua-0004NH-PO
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 21:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVGKTIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 15:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVGKTDc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 15:03:32 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53926 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262200AbVGKTCf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 15:02:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711190208.EAUX22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 15:02:08 -0400
To: Bryan Larsen <bryanlarsen@yahoo.com>
In-Reply-To: <20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local> (Bryan Larsen's message of "Mon, 11 Jul 2005 06:15:02 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bryan Larsen <bryanlarsen@yahoo.com> writes:

> Update the git Makefile to put the results of config.sh into the scripts.  
> config.sh searches for gnu utilities cp, stat, date and xargs.
>
> Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>

> +install: $(PROG) $(SCRIPTS) config
>  	$(INSTALL) -m755 -d $(dest)$(bin)
>  	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
> +	. ./config ; \
> +	cd $(dest)$(bin) ; \
> +	for file in $(SCRIPTS); do \
> +		sed -e "s/DATE\=date/DATE=$${DATE}/" -e "s/CP\=cp/CP=$${CP}/" -e "s/XARGS\=xargs/XARGS=$${XARGS}/" -e "s/STAT\=stat/STAT=$${STAT}/" $$file > $$file.new; \
> +		cat $$file.new > $$file; rm $$file.new; \
> +	done

I am not yet convinced "one variable per GNU program" is the
right way to do (I do agree it is a problem and I appreciate
your trying to solving it; an obvious alternative cop-out would
be to fix this in the user's environment, but there might be a
saner solution).  Assuming that this is the way to go, wouldn't
it be saner if this sed munging is done in only one place, say
git-sh-setup-script, and have everybody include that?  If we
want to have some scripts usable not at the top-level GIT
directory, then git-sh-setup-script may not be a good place; in
which case introduce git-sh-compat-script and have everybody
include _that_ instead?
