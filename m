From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file
 descriptor
Date: Tue, 15 Jan 2008 09:36:12 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org>
References: <4787E981.7010200@nrlssc.navy.mil> <478C1D7A.6090103@nrlssc.navy.mil> <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org> <478CECAB.2030906@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 15 18:37:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEpj1-0000Ix-At
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 18:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbYAORgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 12:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbYAORgo
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 12:36:44 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37179 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751708AbYAORgn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 12:36:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0FHaEAg011031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 09:36:15 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0FHaCp1027356;
	Tue, 15 Jan 2008 09:36:13 -0800
In-Reply-To: <478CECAB.2030906@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70538>



On Tue, 15 Jan 2008, Brandon Casey wrote:
> 
> Do you have a suggestion for a public place to upload? I do not have
> one of my own, and I've never used any of the 'free' services. The
> strace log is about 8.5MB, compressed to about 500K.

Can you just email the compressed one to me as an attachement, I'll put it 
somewhere..

> Not that it's important, but looks like the file descriptor that
> is closed too soon is 3.

Yes and no. There obviously are several "close(3)"s in even that short 
snippet, but they are for a different kind of close - they are for the 
regular loose object open/mmap/close/munmap sequence which has re-used 
that file descriptor.

So the *incorrect* close(3) happened some time much earlier.

The other alternative is, of course, that the 3 itself is just wrong, and 
something corrupted the packfile data structures.

> > Does it reliably reproduce for any commit in the repository, or
> > reliably reproduce for one particular commit, or sometimes
> > reprooduce for one particular commit?
> 
> Reliably for one particular commit.
> 
> Additional commits on top of this commit complete successfully.

It would obviously be interesting to see the base repository and the 
commit you are trying to do - is that possibly publicly available?

		Linus
