From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Forcing rewrite of files in working tree
Date: Fri, 3 Aug 2007 12:55:56 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708031251130.8184@woody.linux-foundation.org>
References: <200708031345.47127.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 21:56:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH3G4-0000nG-04
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 21:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbXHCT4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbXHCT4H
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 15:56:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39738 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751043AbXHCT4E (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 15:56:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l73Ju2Ri026666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Aug 2007 12:56:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l73JtuMQ025509;
	Fri, 3 Aug 2007 12:55:57 -0700
In-Reply-To: <200708031345.47127.andyparkins@gmail.com>
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54749>



On Fri, 3 Aug 2007, Andy Parkins wrote:
> 
> I want to write a little recipe in a Makefile that ensures the $Id$ field in a 
> series of text files is correct.  In case it's relevant, I'm including a load 
> of asciidoc files as subsections into one master file; each file has a $Id$ 
> field in the header, which very nicely prints out at the start of each 
> section.  However, the $Id$ field is only written on checkout (not on checkin 
> for fairly obvious reasons).  That means that for any files I've changed, the 
> $Id$ is wrong.  Before I generate output using ASCIIdoc I'd like to ensure 
> the $Id$ is correct.
> 
> How do I do it?

Something like

	git read-tree HEAD
	git checkout -f

should do it.

The read-tree basically invalidated the index, by forcing it to the HEAD 
tree (and *without* doing a merge with the old index, so it doesn't get 
any of the size/date/inode fields right). And at that point, git thinks 
that all files are stale, so "git checkout -f" will force the checkout for 
all of them.

I'm sure you can do it other ways too, but that's the "obvious" one.

			Linus
