From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdiff-interface.c (buffer_is_binary): Remove buffer size
 limitation
Date: Tue, 4 Dec 2007 01:00:39 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712040054280.27959@racer.site>
References: <20071201160113.GA20849@nomad.office.altlinux.org>
 <7vlk8e42qb.fsf@gitster.siamese.dyndns.org> <20071203215007.GA14697@basalt.office.altlinux.org>
 <alpine.LFD.0.9999.0712031559480.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 02:01:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzMAD-0001Yt-Bg
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 02:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbXLDBBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 20:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbXLDBBH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 20:01:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:39421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750818AbXLDBBG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 20:01:06 -0500
Received: (qmail invoked by alias); 04 Dec 2007 01:01:03 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp048) with SMTP; 04 Dec 2007 02:01:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xr4tPOhxxM4hjPKcQkIHOionca5WMqc8iT9N531
	BxpXD5TeehnA0k
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0712031559480.8458@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66983>

Hi,

On Mon, 3 Dec 2007, Linus Torvalds wrote:

> On Tue, 4 Dec 2007, Dmitry V. Levin wrote:
> >
> > Average file size in the linux-2.6.23.9 kernel tree is 10944 bytes,
> 
> Don't do "average" sizes. That's an almost totally meaningless number.
> 
> "Average" makes sense if you have some kind of gaussian distribution or 
> similar.

To enhance on that: Gaussian is symmetric, which cannot be the proper 
distribution for anything that is non-negative.

I see so many mis-applications of statistics/probability theory in my day 
job that I cannot resist pointing people to the Poisson distribution here 
(in whose context "average" actually makes kind of sense).

But back to the problem: if you have a truly binary file, then _every_ 
byte (absent further information, of course) has a probability of 1/256 of 
being 0.

Which means that if a file is binary, but is unusual enough to have that 
property only for half of the first 8192 bytes, you get a probability of 
1 - 1 / 256^4096 = 1 - 1 / 2 ^ 32768 that the current test succeeds.

I fail to see how this test can possibly fail for the average case.

So if it fails only for special cases, we are probably (in the common, not 
the mathematical, sense) better off asking those people encountering them 
to add git-attributes for the files.

IMHO that is not asking for too much.

Ciao,
Dscho
