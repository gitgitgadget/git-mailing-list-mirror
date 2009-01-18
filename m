From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the reflogs
 twice
Date: Sun, 18 Jan 2009 02:12:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de> <200901171438.22504.trast@student.ethz.ch> <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de> <7vmydp5tqj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 02:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOMG6-0004lA-9M
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 02:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbZARBLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 20:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754480AbZARBLj
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 20:11:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:43021 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754713AbZARBLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 20:11:39 -0500
Received: (qmail invoked by alias); 18 Jan 2009 01:11:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 18 Jan 2009 02:11:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uYyQ8/IZuiwMxjb9y7HCKsFWHVq8IobryiWPBrT
	sl7tDdsuXKbh/2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vmydp5tqj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106124>

Hi,

On Sat, 17 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > That is correct.  But this is such a highly uncritical code path that 
> > I'd like to keep this simple rather than fast.
> 
> I actually not worried about "fast" at all; it was more about unbounded 
> memory consumption.

Let's just assume that I make a branch switch per minute, continuously, 
for 90 days (until the reflogs are expired), and let's say that all my 
branchnames have 20 characters.  Conservatively, the memory requirement 
would be 100 * 2000 * 30 = 3 megabyte.

Note: these are the memory requirements after some really unrealistically 
high activity, and the memory is free()d during parameter parsing.

A much more realistical expectation would be to switch branches maybe 20 
times a day, which would amount to something like 36 kilobyte.  And again, 
they are free()d before the action really starts.

Ciao,
Dscho
