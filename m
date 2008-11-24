From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] bisect: teach "skip" to accept special arguments
 like "A..B"
Date: Mon, 24 Nov 2008 01:28:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811240126430.30769@pacific.mpi-cbg.de>
References: <20081123220249.2e7f30a5.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1770779698-1227486486=:30769"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Nov 24 01:21:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4PD5-0004I5-LD
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 01:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbYKXAUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 19:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbYKXAUE
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 19:20:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:50249 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750990AbYKXAUD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 19:20:03 -0500
Received: (qmail invoked by alias); 24 Nov 2008 00:20:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp022) with SMTP; 24 Nov 2008 01:20:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+07lphz1i07ncAnbNKiPIe9fU2QGzMCohtoL9Sb/
	c/4RKemrgF4xsE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081123220249.2e7f30a5.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101581>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1770779698-1227486486=:30769
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 23 Nov 2008, Christian Couder wrote:

> The current "git bisect skip" syntax is "git bisect skip [<rev>...]"
> so it's already possible to skip a range of revisions using
> something like:
> 
> $ git bisect skip $(git rev-list A..B)
> 
> where A and B are the bounds of the range we want to skip.
> 
> This patch teaches "git bisect skip" to accept:
> 
> $ git bisect skip A..B
> 
> as an abbreviation for the former command.
> 
> This is done by checking each argument to see if it contains two
> dots one after the other ('..'), and by expending it using
> "git rev-list" if that is the case.

s/expend/expand/

> Note that this patch will not make "git bisect skip" accept all
> that "git rev-list" accepts, as things like "^A B" for exemple
> will not work. But things like "A B..C D E F.. ..G H...I" should
> work as expected.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  git-bisect.sh |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)
> 
> 	Dscho wrote:
> 	> Would it not be more intuitive to have support for
> 	>
>         > git bisect skip A..B
> 	>
> 	> ?
> 
> 	Here is a patch to do that. I am not sure it's worth it
> 	because this is a special case in many ways.

Why not have something like

	skip)
		for arg in $(git rev-list "$@")
		do
			bisect_state skip $arg
		done

?

Ciao,
Dscho
--8323328-1770779698-1227486486=:30769--
