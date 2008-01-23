From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 09:09:46 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801230906000.1741@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <7vabmxqnz8.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801221844570.1741@woody.linux-foundation.org> <7vprvtngxk.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801231224300.5731@racer.site>
 <alpine.LFD.1.00.0801230817390.1741@woody.linux-foundation.org> <alpine.LSU.1.00.0801231630480.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:17:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHjEW-0008Q7-Jy
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 18:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbYAWRRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 12:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbYAWRRZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 12:17:25 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53532 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754571AbYAWRRY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 12:17:24 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NH9lBK022792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jan 2008 09:09:48 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NH9knY017386;
	Wed, 23 Jan 2008 09:09:47 -0800
In-Reply-To: <alpine.LSU.1.00.0801231630480.5731@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71558>



On Wed, 23 Jan 2008, Johannes Schindelin wrote:
>
> > End result: practically all projects will never notice anything at all for 
> > 99.9% of all files. One extra well-predicted branch, and a few more hash 
> > collissions for cases where you have both "Makefile" and "makefile" etc.
> 
> Well, that's the point, to avoid having both "Makefile" and "makefile" in 
> your repository when you are on case-challenged filesystems, right?

Right. But what I'm saying is that this is *really* cheap to test for for 
US-ASCII-only characters, and if only 0.1% of all filenames have unicode 
in them, the fact that they are much mroe expensive isn't even going to be 
noticeable. Except for some very odd-ball environments.

> > It's quite possible to do
> > 
> > 	utf8_nfd_strcmp(a,b)
> > 
> > and (a) do it tons and tons faster and (b) never have to modify the 
> > strings themselves. Same goes (even more) for hashing.
> 
> Okay.  Point taken.

Note that one reason the above is tons faster is that even with complex 
unicode, the *common* case is going to be that the names match with a 
binary compare.

> But I really hope that you are not proposing to use the case-ignoring 
> hash when we are _not_ on a case-challenged filesystem...

I actually suspect that we could, and nobody will notice. The hash would 
cause a few more collissions, but not so you'd know.

And the thing is, people who work with other people who are on 
case-challenged systems would still want to have the case-insenstive 
compare too - although it should just warn, not actually "work".

			Linus
