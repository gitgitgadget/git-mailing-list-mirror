From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Mon, 26 Mar 2007 11:31:43 +0400
Message-ID: <20070326073143.GB44578@codelabs.ru>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org> <20070321051406.GW96806@codelabs.ru> <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070321115004.GB14837@codelabs.ru> <Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070321144008.GE14837@codelabs.ru> <Pine.LNX.4.63.0703211630160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070321160126.GH14837@codelabs.ru> <7v1wji371q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 09:32:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVjgb-0001Wc-L3
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 09:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbXCZHby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 03:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbXCZHbx
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 03:31:53 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:59284 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbXCZHbw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 03:31:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=Lgjo5G2b6E0Ge14Fa3vzUr3VhiV3MtNLpL7s8G/RtAbzwDK8Ae5sGsqw2sjepSUeIWzOm4FVodauSPp+4Sa07Qp74DLZDt0dt7vD4DBe7RRe00wCeRdMFF2mR/Rum/LXnnUAF2Wl6nJn40GjNwljBfHh+twUbBm4t8TQPLS7dPM=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HVjgC-000Bbv-Fo; Mon, 26 Mar 2007 11:31:48 +0400
Content-Disposition: inline
In-Reply-To: <7v1wji371q.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-3.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43118>

Junio, good day.

Wed, Mar 21, 2007 at 09:17:21AM -0700, Junio C Hamano wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
> 
> > Technically, the checks in Makefile will look as 'ifndef NO_GUI && NO_TCL_TK'
> > instead of 'ifndef NO_GUI'. Later they can diverge as the software will
> > evolve.
> >
> > Are people happy with such plan?
> 
> Maybe later you might even want to view the graphical history
> from the server displaying on remote X, who knows?

Not sure: I don't like X on the servers ;)) But others can...

> We have NO_CURL and such because lack of the necessary libraries
> and headers prevent your build from completing, but in the case
> of git-gui and gitk, they are just scripts and you would not
> have any trouble in building.  I do not know if adding more
> conditional to Makefile in order to skip them is worth it.

OK, I reworked the patch following the suggestion of Jakub and Johannes:
now configure has the built-in detection of the Tcl/Tk binary and has
the --with-tcltk/--without-tcltk options. To implement this I still
need the NO_TCLTK knob in the Makefile. Moreover, the configure's
switch --with-tcltk=/path/to/binary works as expected: the location
of the Tcl/Tk interpreter will be rewritten in the gitk and git-gui.
The patch follows on this thread.

And regarding the building troubles and the additional knob in the
Makefile: the trouble is in the packaging process. For example, RPM
or FreeBSD ports are looking at what is really installed, so if
user do not want the Tcl/Tk part, then no package parts that depend
on it should be installed. And the bare 'make install' installs all
things. Sure, you can make 'make install && rm -f <not needed
files>', but it is always a pain for the package builders to get
the idea about the precise file list. So I just wanted to integrate
the desired behaviour in the mainstream Git to make packager's life
a bit easy. May be by the cost of making developer's life a bit
harder: he should watch for the NO_TCLTK in his Makefiles.
-- 
Eygene
