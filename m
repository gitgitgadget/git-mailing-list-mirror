From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] http-push: update tests
Date: Sat, 17 Jan 2009 20:37:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901172035000.3586@pacific.mpi-cbg.de>
References: <be6fef0d0901161859qbea135bwe89e48caaa69a77c@mail.gmail.com> <alpine.DEB.1.00.0901170621440.3586@pacific.mpi-cbg.de> <be6fef0d0901170040r7e11806et87cc5dc3c6f13a2a@mail.gmail.com> <7vsknh7og5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 20:39:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOH0k-0004bh-CY
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 20:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763501AbZAQThG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 14:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762118AbZAQThG
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 14:37:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:39732 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761364AbZAQThE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 14:37:04 -0500
Received: (qmail invoked by alias); 17 Jan 2009 19:37:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 17 Jan 2009 20:37:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hV6AfVYFhh4rRv68Jn6nUmPQRd1H1ch1d0w8t66
	NtJwXNtaQfL0Fu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vsknh7og5.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106097>

Hi,

On Sat, 17 Jan 2009, Junio C Hamano wrote:

> The original seems to want the push to succeed, and also it wants the 
> file refs/heads/master to be present after the push (presumably because 
> there should be that ref when the push succeeds).  If you fixed "push" 
> that used to fail to succeed, that is great, and s/failure/success/ is a 
> good thing.
> 
> But you are removing something else without explanation.  Why do you 
> need to remove the part of the test that checks if refs/heads/master is 
> present? Is it looking for a file in a wrong place?

As I mentioned with two other patches, the push does not succeed, and that 
is the reason for the "failure" in test_expect_failure.

It does not succeed for two reasons:

- due to an off-by-path_len bug, xmalloc() tries to allocate ~4GB of 
  memory, which is a bit much, so http-push die()s with an OOM.

- even with that fix, the push fails because it cannot find any common 
  refs.  It cannot find them because it does not download info/refs as it 
  is supposed to do, but it looks through refs/, missing the fact that the 
  refs are packed (which it cannot handle).

Ciao,
Dscho
