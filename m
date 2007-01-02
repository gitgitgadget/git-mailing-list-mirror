From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Possible regression in git-rev-list --header
Date: Tue, 2 Jan 2007 23:28:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701022322030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
 <Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7iw9jftv.fsf@assigned-by-dhcp.cox.net> <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net> <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
 <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
 <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701022219050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vps9xrs9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 23:29:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1s8C-0003RC-Mh
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 23:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbXABW3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 17:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbXABW3D
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 17:29:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:38028 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964996AbXABW3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 17:29:01 -0500
Received: (qmail invoked by alias); 02 Jan 2007 22:28:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 02 Jan 2007 23:28:59 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vps9xrs9y.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35833>

Hi,

On Tue, 2 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> The reason we did the latter, by the way, does not have anything
> >> to do with helping broken parsers.  We drop the header after
> >> re-coding the log message into an encoding specified by the user
> >> (which is presumably different from what the commit was
> >> originally recorded in) because the encoding recorded on
> >> "encoding" header would not match the re-coded log message
> >> anymore.
> >
> > By the same reasoning, you'd have to rewrite the committer line to reflect 
> > the current GIT_COMMITTER_IDENT, or hide it. If you want to convince me, 
> > you have to try harder.
> 
> Sorry, but you completely lost me with that analogy.
> 
> I think showing log message in the user's preferred encoding is
> more like passing the output to the colorization mechanism and
> then to the pager.  We are interacting with humans at that
> point, and we are changing the presentation without changing the
> semantics of the data.  
> 
> I do not see why committer identity needs to be rewritten nor
> hidden by the same reasoning.
> 
> > And Marco has to fix the header parsing anyway.
> 
> No question about that.  If iconv() punts, qgit will see
> "encoding" header to deal with even when the re-coding is in
> effect.  I think it may be a sensible thing for qgit to replace
> the log message and show "log message in this encoding, which
> cannot be shown in this window" instead in such a case, but that
> is up to Porcelain.

Ah! Now I get your reasoning. But it is wrong. You are misusing headers -- 
which should be metadata describing the commit -- to pass a vital 
information to a porcelain: "re-encoding failed, please have a try 
yourself".

But the encoding header describes a certain aspect of the commit object: 
how it was _originally_ encoded.

It's just like mails: often I look at the X-Mailer: header to find out if 
the sender by any chance used Windows, or Mac, because it may help me help 
the sender when incomplete information was provided.

And just like with the mail, I would not like the tool to _hide_ the 
headers from me when I ask for them, just because it happened to use them 
already to display the characters correctly.

Ciao,
Dscho
