From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 13:19:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021315510.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
 <vpq4pji3zwm.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:20:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGZfI-0005mN-ED
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 14:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbXHBMUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 08:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755156AbXHBMUX
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 08:20:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:50002 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754892AbXHBMUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 08:20:22 -0400
Received: (qmail invoked by alias); 02 Aug 2007 12:20:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 02 Aug 2007 14:20:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+trJraBP+UgOhOBN8APAUZFS9Vt4WDSirAyDSar
	+TiEHiDijkvfyX
X-X-Sender: gene099@racer.site
In-Reply-To: <vpq4pji3zwm.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54544>

Hi,

On Thu, 2 Aug 2007, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The default should be tuned for users who perform manual editing
> > with status checks.  And power users like yourself who run "bulk
> > touch indiscriminately but modify only some" scripts should
> > learn to run git-status (or "update-index --refresh") after such
> > operation.  Swapping the defaults to optimize for the abnormal
> > case is madness.
> 
> I fully agree that git should be optimized for the common case. But
> even for the common case, I also find the feature strange. You didn't
> answer that part of my message, but I still fail to see a rationale
> for making "git-diff; git-status" different from "git-status; git-diff".

For performance reasons, git always compares the files' stat information 
with that stored in the index.

By updating the file, you make that check fail always.

Without updating the index (which is not a read-only operation, and 
therefore must not be done when doing a read-only operation like diff), 
you will therefore _destroy_ the main reason of git's kick-ass 
performance.

So when you do "git diff" and it tells you all those diff lines, while no 
file was really changed, it tells you "get your act together!  You just 
_willfully_ slowed down git's performance".

Okay?

Ciao,
Dscho

P.S.: I wish we had something similar for the cases that you did not "git 
gc", so that people, posting to their blogs all over the world that they 
became benchmark experts overnight and tested git and it sucks, would know 
that it is not git that sucks.
