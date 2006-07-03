From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Make clear_commit_marks() clean harder
Date: Mon, 3 Jul 2006 23:12:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607032309190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
 <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
 <20060701232958.GC2513@lsrfire.ath.cx> <7vejx3rq33.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607031553570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmfqqxlh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 23:12:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxVid-0003wq-Rn
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 23:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWGCVMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 17:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWGCVMZ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 17:12:25 -0400
Received: from mail.gmx.de ([213.165.64.21]:52117 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932116AbWGCVMX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 17:12:23 -0400
Received: (qmail invoked by alias); 03 Jul 2006 21:12:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 03 Jul 2006 23:12:22 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmfqqxlh.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23212>

Hi,

On Mon, 3 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > Don't care if objects have been parsed or not and don't stop when we
> >> > reach a commit that is already clean -- its parents could be dirty.
> >> 
> >> There is something quite wrong with this patch.
> >
> > I always had the feeling that it was wrong to traverse not-yet-parsed 
> > parents: How could a revision walk possibly come to a certain commit 
> > without at least one continuous history of now-parsed objects?
> >
> > Also, AFAIK the revision walk sets flags for each commit it touched, and 
> > we should not try to be smart-asses about the flags, but just unset these 
> > flags.
> 
> The main points were made by Linus already.
> 
> Traversing is not needed -- not clearing not-yet-parsed is
> obviously wrong.

Traversing is actually wrong. Clearing the marks does not mean to clear 
them on commits we did not even mark!

But clearing on commits we _have_ -- but not parsed -- is important, 
obviously.

> > BTW some very quick tests showed that the clear_commit_marks() thing that 
> > I sent to the list was much faster than traversing all objects (which was 
> > in my original version).
> 
> I have a crude workaround pushed out last night but will be
> replacing it with something less drastic.  I think the final
> version should be what you had, perhaps minus not looking at the
> parsed flag for unmarking purposes.

Isn't the right way to go about it to just clear the marks if we have a 
commit that has at least one of the marks set, but traverse further only 
if _in addition to having at least one mark set_ the commit has been 
parsed already?

That would not be a crude workaround.

BTW what cases could have a commit, being seen by the revision walk, not 
have the SEEN mark set?

Ciao,
Dscho
