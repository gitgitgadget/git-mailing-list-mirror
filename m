From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the reflogs
 twice
Date: Sun, 18 Jan 2009 21:59:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de> <200901171438.22504.trast@student.ethz.ch> <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de> <7vmydp5tqj.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de> <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:01:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOeln-0007Zs-N6
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811AbZARU7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 15:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756205AbZARU7l
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 15:59:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:46454 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754800AbZARU7k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 15:59:40 -0500
Received: (qmail invoked by alias); 18 Jan 2009 20:59:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 18 Jan 2009 21:59:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bMVpX4WDbzUeYTtLRnhpuyKdZrIilS6E0avG7ny
	SnkIvWNsKk4nJa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106279>

Hi,

On Sat, 17 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Note: these are the memory requirements after some really unrealistically 
> > high activity, and the memory is free()d during parameter parsing.
> >
> > A much more realistical expectation would be to switch branches maybe 20 
> > times a day, which would amount to something like 36 kilobyte.  And again, 
> > they are free()d before the action really starts.
> 
> My HEAD reflog is 7MB long with 39000 entries, and among them, 13100
> entries have "checkout: moving ".
> 
> I know I will never want to switch back to the 10000th from the last 
> branch.  I am quite sure that I would forget which branch I was on after 
> switching branches three or four times (hence my original hardcoded 
> limitation of 10 which "should be plenty").  When I know I only have to 
> keep track of 10 entries, having to keep track of 13100 entries, even if 
> it is 36kB (it would actually be 260kB in my case) feels there is 
> something wrong in the design.

Hrm.  So let's leave it as a two-pass thing?

Ciao,
Dscho
