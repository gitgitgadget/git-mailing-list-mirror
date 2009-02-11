From: Sam Vilain <sam@vilain.net>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Wed, 11 Feb 2009 16:30:10 +1300
Message-ID: <49924642.6000609@vilain.net>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <200902100158.46884.bss@iguanasuicide.net> <20090210131600.GD17305@coredump.intra.peff.net> <200902101958.21284.bss@iguanasuicide.net> <alpine.LFD.2.00.0902101825360.3590@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 04:32:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX5pq-0002ub-9P
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 04:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbZBKDa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 22:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbZBKDa1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 22:30:27 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:51380 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbZBKDa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 22:30:27 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 8072221D5BF; Wed, 11 Feb 2009 16:30:17 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	PLING_QUERY autolearn=no version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id AC22721D141;
	Wed, 11 Feb 2009 16:30:10 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.2.00.0902101825360.3590@localhost.localdomain>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109370>

Linus Torvalds wrote:
> That sounds unnecessarily complicated. It also really sucks for the case 
> you want to optimize: small differences between trees, where you don't 
> need to even linearize the common parts.
>
> Why not make it just a straight fixed 12-bit prefix, single-level trie.
>   

My solution suffers from that problem too, but I personally still don't
think that the answer is to fix the trie boundary.

The only case where it hurts is when you want to merge. Nothing else
should care. So, if a merge of these note trees sees two different trie
sizes then it can convert the shorter one to the longer length first,
and then try the merge again. So you get the pain, but only once. And
when a project decides that its split is too small, it can split then
and it should "silently" spread out to others.

Sam.
