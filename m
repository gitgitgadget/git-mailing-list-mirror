From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 23:50:39 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803122348210.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <47D83532.70103@nrlssc.navy.mil> <alpine.LSU.1.00.0803122058430.1656@racer.site> <47D83C53.7000602@nrlssc.navy.mil> <7vejaf65q0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803122153440.1656@racer.site> <7vwso74p33.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:51:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZZn1-0003Fa-O6
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 23:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbYCLWug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 18:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbYCLWuf
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 18:50:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:34032 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751804AbYCLWuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 18:50:35 -0400
Received: (qmail invoked by alias); 12 Mar 2008 22:50:32 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp002) with SMTP; 12 Mar 2008 23:50:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+H4V4yd+WHWV0IYf6nEKgegZxSnMa10PvxRXn2M+
	Jz72dplHt2po2J
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwso74p33.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77019>

Hi,

On Wed, 12 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ---prune::
> 
> I am fairly paranoid about end users wondering about what is described in
> ancient documentation and complaining that we do not talk about it
> anymore.  I am tempted to suggest:
> 
> 	This is a no-op but you may see it mentioned in older docs and
> 	scripts.  Older git-gc never ran 'prune' without being told, and
> 	this option was a way to tell it to.
> 
> but this would lead to littering the documentation with too much 
> historical information in the long run.  I dunno.  I am inclined to 
> favor the removal as your patch did, but somebody else may have clever 
> ideas.

Well, if you want to, I am quite willing to adapt the patch.  (I care 
enough about the real issue, namely that "prune" should be called 
automatically.)

> > +	if (!strcmp(var, "gc.pruneexpire")) {
> > +		if (!value)
> > +			return config_error_nonbool(var);
> > +		if (strcmp(value, "now") &&
> > +				approxidate(value) - approxidate("now") >= 0)
> > +			return error("Invalid gc.pruneExpire: '%s'", value);
> 
> Yuck; approxidate() returns ulong.  Can subtracting a ulong from another
> ever go negative?
> 
> Besides, because there is no guarantee of the order of evaluation between
> these two approxidate() calls, you may get +1 or -1 on the second boundary.
> 
> I think the reason why you did not catch it in your test is because your
> tests are half complete; they test only what you wanted to catch
> (misconfigured case) and do not test the other half (properly working
> case).

Yes, probably.  Of course, comparing a difference to 0 is absolutely 
moronic.

I should have written

				approxidate(value) >= approxidate("now"))

in the first place.

So, could you tell me, please, if I should resend the patch with your 
--prune documentation, or without?

Ciao,
Dscho
