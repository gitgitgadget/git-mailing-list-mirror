From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] apply --whitespace: configuration option.
Date: Tue, 28 Feb 2006 01:38:14 -0800
Message-ID: <7vzmkbn7qx.fsf@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060227011832.78359f0a.akpm@osdl.org>
	<7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
	<7vacccuvxz.fsf@assigned-by-dhcp.cox.net> <440414D6.8050407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 10:38:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE1JD-0007zt-GU
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 10:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWB1JiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 04:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWB1JiQ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 04:38:16 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:53657 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932133AbWB1JiP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 04:38:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228093628.QUTG20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Feb 2006 04:36:28 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <440414D6.8050407@op5.se> (Andreas Ericsson's message of "Tue, 28
	Feb 2006 10:16:06 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16928>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> The new configuration option apply.whitespace can take one of
>> "warn", "error", "error-all", or "strip".  When git-apply is run
>> to apply the patch to the index, they are used as the default
>> value if there is no command line --whitespace option.
>
> I would think "warn-all" would be the logical thing, since "error"
> either breaks out early or prints all warnings before denying the
> patch anyway.

Actually there is some thinking behind why I did not do warn-all.
I did consider it at first but rejected.

 * If you are a busy top echelon person but cares about tree
   cleanliness, --whitespace=error is good enough.  The patch is
   rejected on WS basis whether it introduces one such trailing
   WS or hundreds.  The patch is returned to the submitter and
   the tree remains clean.

 * --whitespace=warn-all, if existed, would apply the patch
   _anyway_, so if you notice you got warnings, and if that
   bothers you enough that you would want to do something about
   it, you will have to rewind the HEAD, fix up .dotest/patch
   and reapply.  This means you are willing to clean up other
   peoples' patches.

 * But if you are that kind of person, --whitespace=error-all is
   a better choice for you.  Your tree stays clean and you do
   not have to rewind.  Instead, you get all the errors you can
   go through with your editor (e.g. Emacs users can use C-x `;
   I hope vim users have similar macros) and fix things.

 * --whitespace=warn would show some, but not all, so that you
   can continue while making a mental note to scold the patch
   submitter to be careful the next time.  You chose "warn" to
   apply the patch anyway, so there is no point showing the full
   extent of damage -- the damage is already done to your tree.

 * --whitespace=strip is for people who care about cleanliness,
   who wants to be nice to the submitters, but not nice enough
   to educate them.  They do not want to fix things by hand.
   Instead they have the tool to do the fixing for them.

The last one is somewhat risky, and the output may need to be
examined carefully depending on the contents (e.g. programming
language) the project is dealing with.
