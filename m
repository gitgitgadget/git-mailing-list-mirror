From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/10] Introduce get_octopus_merge_bases() in commit.c
Date: Fri, 6 Jun 2008 13:30:34 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061305490.1783@racer>
References: <cover.1212698317.git.vmiklos@frugalware.org> <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org>
 <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org>
 <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org> <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org>
 <e13c0c2e9c8b0ebef84ac062bf05c05f729b3b20.1212698317.git.vmiklos@frugalware.org> <7vk5h3xlt9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 14:33:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4b7m-0002Yb-0A
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbYFFMcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbYFFMcA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:32:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:54132 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753814AbYFFMcA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:32:00 -0400
Received: (qmail invoked by alias); 06 Jun 2008 12:31:58 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 06 Jun 2008 14:31:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9tDtTtWH9FCTbFYMFRFLMOiCLC8Loa8HH91VNHl
	NNBaPK6PJgPJO1
X-X-Sender: gene099@racer
In-Reply-To: <7vk5h3xlt9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84057>

Hi,

On Thu, 5 Jun 2008, Junio C Hamano wrote:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > This is like get_merge_bases() but it works for multiple heads, like
> > show-branch --merge-base.
> 
> In what sense is this "like show-branch --merge-base"?
> 
> The only similarlity I can spot is that it can take more than two heads, 
> but what it computes and the way it computes it seem to be different.  
> It certainly looks much less efficient as it does not walk the ancestry 
> chain in one-go like show-branch does.

Ah, you are right.  I thought that in the typical case (where the initial 
commits are independent), it will never traverse any commit twice.  I did 
not really understand your example quickly enough, so I made up my own:

A - B - C - D - E
  \           X
    F - G - H   I
      \   X   \
        J   \   K
             \
              - L 

Now, let's get the merge bases with Miklos' algorithm for E, I, K and L.

First it will find the merge base for E and I, which is D.  Then it 
calculates the merge base between that merge base and the third head, K, 
which leads us all the way back to A.

Now, calculating the merge base between that merge base and L will 
traverse the commits F, G and H _again_.

Ciao,
Dscho
