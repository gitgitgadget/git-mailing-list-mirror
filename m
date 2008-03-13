From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 12:55:11 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803131254580.1656@racer.site>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com> <20080313114738.GC2414@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 12:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZm2E-0004Ow-FO
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 12:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbYCMLzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 07:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbYCMLzH
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 07:55:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:38326 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752139AbYCMLzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 07:55:06 -0400
Received: (qmail invoked by alias); 13 Mar 2008 11:55:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 13 Mar 2008 12:55:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ygZkr12ZyqeHiASlM31uxsiih/F9iOhHKJhsrf1
	WwuWUXrhEV7Ht2
X-X-Sender: gene099@racer.site
In-Reply-To: <20080313114738.GC2414@genesis.frugalware.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77064>

Hi,

On Thu, 13 Mar 2008, Miklos Vajna wrote:

> On Thu, Mar 13, 2008 at 11:48:53AM +0300, Alexander Gladysh <agladysh@gmail.com> wrote:
> > I want to create a private GIT repo (without working copy) on a 
> > machine in external data-center. While I do not actually believe that 
> > it is possible that someone who has physical access to a machine would 
> > be interested in peeking into my repo, I'd like to play safe and to 
> > have this issue covered.
> > 
> > Please advise what is the best way to do it. Are there any existing 
> > solutions?
> 
> i don't think but you can write a wrapper around git receive/upload-pack 
> and use (for example) tar+gpg to keep your repo encrypted on the disc.

The problem is: you cannot decrypt on the remote side, otherwise you will 
lose all the security.

But if you do not decrypt on the remote side, you cannot store deltified 
objects (you lose all the benefits of Git's efficient storage), neither 
can you update incrementally (you lose all the benefits of Git's efficient 
transport).

The latter can be remedied (somewhat) by encrypting each object 
individually.  In that case, .gitattributes can help (you should be able 
to find a mail to that extent, which I sent no more than 2 weeks ago).  
However, you must make sure that the encryption is repeatable, i.e. two 
different encryption runs _must_ result in _identical_ output.

If it is only a single file containing all your secrets, it can also make 
sense to just encrypt it, and track the _encrypted_ file directly 
(without clean/smudge filters).

Hth,
Dscho
