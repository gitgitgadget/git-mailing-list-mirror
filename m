From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Mon, 15 Dec 2008 12:03:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812151201300.30933@intel-tinevez-2-302>
References: <20081210201259.GA12928@localhost> <20081215004651.GA16205@localhost> <7v63lm1c76.fsf@gitster.siamese.dyndns.org> <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812151032230.14632@racer>
 <7vljuhwwtg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 12:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCBG7-0006x7-Cb
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 12:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbYLOLDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 06:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbYLOLDr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 06:03:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:58733 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752198AbYLOLDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 06:03:46 -0500
Received: (qmail invoked by alias); 15 Dec 2008 11:03:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 15 Dec 2008 12:03:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AqwVdr5pAI9VsiX/dqYJKkFBdccCYFoqJM4pxUE
	uX8veGHTswmw1v
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vljuhwwtg.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103156>

Hi,

On Mon, 15 Dec 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> merge-recursive: do not clobber untracked working tree garbage
> >> ...
> >> +static int would_lose_untracked(const char *path)
> >> +{
> >> +	int pos = cache_name_pos(path, strlen(path));
> >> +
> >> +	if (pos < 0)
> >> +		pos = -1 - pos;
> >> +	while (pos < active_nr &&
> >> +	       !strcmp(path, active_cache[pos]->name)) {
> >> +		/*
> >> +		 * If stage #0, it is definitely tracked.
> >> +		 * If it has stage #2 then it was tracked
> >> +		 * before this merge started.  All other
> >> +		 * cases the path was not tracked.
> >> +		 */
> >> +		switch (ce_stage(active_cache[pos])) {
> >> +		case 0:
> >> +		case 2:
> >> +			return 0;
> >> +		}
> >> +		pos++;
> >> +	}
> >> +	return file_exists(path);
> >
> > I wonder if it is cheaper to test file_exists() when the index contains a 
> > lot of files...
> 
> "cheaper" than what?

Oops.  I meant "cheaper to test file_exists() _first_".  But thinking 
about it again, it is probably way more expensive, especially in the cold 
cache case.

Sorry for the noise,
Dscho
