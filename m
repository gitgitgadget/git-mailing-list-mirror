From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with large files on different OSes
Date: Thu, 28 May 2009 12:49:12 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905281246330.3435@localhost.localdomain>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <m3y6siboij.fsf@localhost.localdomain> <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain> <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain> <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
 <20090527215314.GA10362@coredump.intra.peff.net> <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain> <20090528194348.GH13499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 21:49:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9lbm-0003oM-Dp
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 21:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756892AbZE1Tti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755842AbZE1Tti
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 15:49:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47810 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966AbZE1Tth (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 15:49:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4SJnDIl030246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2009 12:49:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4SJnCrS018414;
	Thu, 28 May 2009 12:49:13 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090528194348.GH13499@coredump.intra.peff.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120218>



On Thu, 28 May 2009, Jeff King wrote:
> 
> > So my "fixed chunk" approach would be nice in that if you have this kind 
> > of "chunkblob" entry, in the tree (and index) it would literally be one 
> > entry, and look like that:
> > 
> >    100644 chunkblob <sha1>
> 
> But if I am understanding you correctly, you _are_ proposing to munge
> the git data structure here. Which means that pre-chunkblob trees will
> point to the raw blob, and then post-chunkblob trees will point to the
> chunked representation. And that means not being able to use the sha-1
> to see that they eventually point to the same content.

Yes. If we were to do this, and people have large chunks, then once you 
start using the chunkblob (for lack of a better word) model, you'll see 
the same object with two different SHA1's. But it's a one-time (and 
one-way - since once it's a chunkblob, older models can't touch it) thing, 
it can never cause any long-term confusion.

(We'll end up with something similar if somebody ever breaks SHA-1 enough 
for us to care - the logical way to handle it is likely to just accept the 
SHA512-160 object name "aliases")

			Linus
