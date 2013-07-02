From: John Keeping <john@keeping.me.uk>
Subject: Re: --follow is ignored when used with --reverse
Date: Tue, 2 Jul 2013 11:41:19 +0100
Message-ID: <20130702104119.GB9161@serenity.lan>
References: <20130524012324.295dec77@hugo.daonet.home>
 <20130702091936.GA9161@serenity.lan>
 <20130702093842.GA4353@blizzard>
 <87vc4t9tn5.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas Fleischer <git@cryptocrack.de>,
	Alois Mahdal <Alois.Mahdal.1-ndmail@zxcvb.cz>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 02 12:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uty1e-0003ks-H4
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 12:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761Ab3GBKla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 06:41:30 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:56730 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3GBKl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 06:41:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 22DDDCDA5BE;
	Tue,  2 Jul 2013 11:41:29 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oq+tURafieXK; Tue,  2 Jul 2013 11:41:27 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 90499CDA5A9;
	Tue,  2 Jul 2013 11:41:21 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <87vc4t9tn5.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229390>

On Tue, Jul 02, 2013 at 11:51:42AM +0200, Thomas Rast wrote:
> Lukas Fleischer <git@cryptocrack.de> writes:
> 
> > On Tue, Jul 02, 2013 at 10:19:36AM +0100, John Keeping wrote:
> [...]
> >>     $ git log --oneline --follow builtin/clone.c | wc -l
> >>     125
> >>     $ git log --oneline --follow --reverse builtin/clone.c | wc -l
> >>     3
> >
> > I just wanted to point out that it works fine when specifying the *original*
> > file name (which kind of makes sense given that everything is done in reverse
> > order):
> [...]
> > However, that also doesn't seem to work for builtin/clone.c:
> >
> >     $ git log --oneline --follow --reverse -- builtin-clone.c | wc -l
> >     65
> 
> I'm pretty sure that is simply because --follow iis a horrible hack,
> known to be broken in many ways.  I have it on my longer-term todo list
> to unify it with -L -M, which already does the Right Thing (more
> generally, not in the --reverse interaction, which it never occurred to
> me I should check).

Interesting... this tells me that --reverse doesn't work the way I
thought it did (although without any real evidence).  Given how
--reverse interacts with other options (like --max-count), I assumed it
would generate the commit list first and then simply reverse it before
display but it seems that this isn't what happens with --follow.

I guess that makes sense to avoid calculating the diff twice but I
suspect we have to pay that price to get correct output.
