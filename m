From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 12:58:07 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171256280.17650@racer.site>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org> <7vodblpmyc.fsf@gitster.siamese.dyndns.org> <20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net>
 <20080117110132.GB12285@hashpling.org> <478F4CDC.2090703@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Charles Bailey <charles@hashpling.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 17 13:58:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFUKR-0006QF-TX
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 13:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbYAQM6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 07:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYAQM6P
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 07:58:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:53585 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751681AbYAQM6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 07:58:14 -0500
Received: (qmail invoked by alias); 17 Jan 2008 12:58:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 17 Jan 2008 13:58:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TVjJwE8kT/mwzC9hef56nCKE/MR0K/qpeYCiQPP
	KURowQgPZxtuQk
X-X-Sender: gene099@racer.site
In-Reply-To: <478F4CDC.2090703@viscovery.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70855>

Hi,

On Thu, 17 Jan 2008, Johannes Sixt wrote:

> Charles Bailey schrieb:
> > On Thu, Jan 17, 2008 at 11:52:23AM +0100, Johannes Sixt wrote:
> >> I observed the same (on Windows). The reason is that above-mentioned
> >> commit introduces a call to parse_objects(). But by the time that
> >> fast-import calls write_ref_sha1() (and, hence, this new parse_objects())
> >> it has not yet written a pack file, and parse_objects() fails. I don't
> >> have a clue how to fix this short of reverting the commit.
> >>
> > 
> > OK, so it's not just Mac OS X, then.  From your description and my
> > initial poke at the code,  I can't immediately see a good reason why
> > the test should succeed on Linux, though.
> 
> My analysis is not correct. The pack file is present, but it seems to be
> incomplete.
> 
> The reason is the NO_MMAP build flag. If you compile with
> NO_MMAP=YesPlease on Linux, t9301 fails as well. Does this ring a bell?

Just a wild guess... Could it be that the mmap() happened before contents 
were written to that fd?  The faked mmap() is just a malloc() && pread(), 
and would thus miss out on changes written after the mmap() call.

Ciao,
Dscho
