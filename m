From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RFC: Flat directory for notes, or fan-out?  Both!
Date: Mon, 9 Feb 2009 22:12:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, peff@peff.net, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Feb 09 22:29:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdh2-0006iV-0C
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 22:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbZBIV1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 16:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbZBIV1j
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 16:27:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:48642 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752306AbZBIV1i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 16:27:38 -0500
Received: (qmail invoked by alias); 09 Feb 2009 21:11:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 09 Feb 2009 22:11:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/g0Uh3oQfgBaXQ2UJXful4dIhYdca5B2jh7SFdF2
	MCkSwNZGXmyAQw
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109135>

Hi,

Shawn triggered some well needed thinking on my part about the notes 
implementation.  At the moment, we have flat directory structure, and read 
all of them in one go (when needed).

I think we should support that, because it is relatively easy to generate 
that kind of trees for small-scale applications.

However, I think there is also a benefit to handle fan-out directory 
structures, too: they scale much nicer.

If the commit name was not found as a filename, it could be searched in 
whatever subdirectory whose name is a prefix of said commit name (first 
wins).

So I think it would be a sane plan to do the following when a commit note 
is requested:

- If not done yet, read in the whole top-level directory of the notes ref.

- If the commit name is not found, find the tree entries whose name is a 
  prefix of the commit name (we can even use the same hashmap to store 
  these "incomplete" names, as we use a linear hash, which we fill in 
  ascending order),

  - read the trees one by one, until the commit name is found (or no tree 
    entry is left), deleting the trees from the hashmap on the go.

How does that sound?

Ciao,
Dscho

	
