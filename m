From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] daemon.c: fix segfault on OS X
Date: Mon, 27 Apr 2009 11:09:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904271103050.7741@intel-tinevez-2-302>
References: <49F4BD9F.6070709@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 13:06:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyMqJ-0006px-Ss
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 11:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbZD0JJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 05:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbZD0JJO
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 05:09:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:42808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750898AbZD0JJN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 05:09:13 -0400
Received: (qmail invoked by alias); 27 Apr 2009 09:09:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 27 Apr 2009 11:09:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5XYhtd9257fvoJi3NTs95/8IR436H+pZlc8N5st
	Q9N+83QKZk+VJg
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49F4BD9F.6070709@googlemail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117654>

Hi,

Disclaimer: if you are offended by constructive criticism, or likely to
answer with insults to the comments I offer, please stop reading this mail
now (and please do not answer my mail, either). :-)

Still with me?  Good.  Nice to meet you.

Just for the record: responding to a patch is my strongest way of saying
that I appreciate your work.

On Sun, 26 Apr 2009, Benjamin Kramer wrote:

> On OS X (and maybe other unices) getaddrinfo(3) returns NULL
> in the ai_canonname field if it is called with an IP address.
> 
> steps to reproduce:
> $ git daemon --export-all
> $ git clone git://127.0.0.1/frotz
> => git daemon's fork (silently) segfaults.
> 
> Remove the pointless loop while at it.

Why is it pointless?  You have to explain why there is no possiblity to 
get multiple addrinfos back.  (And come to think about it, I think it is 
perfectly possible for getaddrinfo to return multiple addresses for the 
same hostname.)

But what is more puzzling to me is what your patch is actually trying to 
do: fix the segfault.  I have to assume -- as you were pretty scarce with 
information on that -- that the ip_address is never set, and that is 
causing the segfault.  Now, with your patch, it seems to me that the 
ip_address will just be the empty string, which is hardly correct.

Am I wrong?

Ciao,
Dscho
