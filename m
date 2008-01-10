From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 13:01:21 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net>
 <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:03:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD4YZ-0005iG-IQ
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbYAJVCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752946AbYAJVCw
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:02:52 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33738 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752778AbYAJVCv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2008 16:02:51 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0AL1MBW028154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Jan 2008 13:01:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0AL1LlZ009113;
	Thu, 10 Jan 2008 13:01:21 -0800
In-Reply-To: <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70086>



On Thu, 10 Jan 2008, Nicolas Pitre wrote:
> 
> Here's my rather surprising results:
> 
> My kernel repo pack size without the patch:	184275401 bytes
> Same repo with the above patch applied:		205204930 bytes
> 
> So it is only 11% larger.  I was expecting much more.

It's probably worth doing those statistics on some other projects.

The kernel has for the last five+ years very much encouraged people to 
make series of small changes, so I would not be surprised if it turns out 
that the deltas for the kernel are smaller than average, if only because 
the whole development process has encouraged people to send in a series of 
ten patches rather than a single larger one.

And there are basically *no* generated files in the kernel source repo.

Maybe the difference to other repositories isn't huge, and maybe the 
kernel *is* a good test-case, but I just wouldn't take that for granted. 

Yes, delta's are bound to compress much less well than non-deltas, and 
especially for tree objects (which is a large chunk of them) they probably 
compress even less (because a big part of the delta is actually just the 
SHA1 changes), but if it's 11% on the kernel, it could easily be 25% on 
something else.

Try with the gcc repo, especially the one that has deep delta chains (so 
it has even *more* deltas in relation to full objects than the kernel has)

		Linus
