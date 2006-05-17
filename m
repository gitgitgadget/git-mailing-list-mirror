From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] libify git-ls-files directory traversal
Date: Tue, 16 May 2006 19:36:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605161931340.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605161859050.16475@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 17 04:37:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgBuJ-0007J5-Sf
	for gcvg-git@gmane.org; Wed, 17 May 2006 04:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWEQChA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 22:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWEQChA
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 22:37:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751149AbWEQCg7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 22:36:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4H2artH031221
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 19:36:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4H2aqJf032197;
	Tue, 16 May 2006 19:36:52 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605161859050.16475@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20156>



On Tue, 16 May 2006, Linus Torvalds wrote:
> 
> NOTE! Not all of git-ls-files is libified by this.  The index matching
> and pathspec prefix calculation is still in ls-files.c, but this is a
> big part of it.

Side note: the reason I held off on the index matching is that 
git-ls-files currently uses a pretty disgusting trick to make the index 
accesses faster for the common subdirectory case, namely it basically 
rewrites the index so that it only contains the entries defined by a 
common prefix.

Now, that's fine for git-ls-files, but it's not fine for a library 
function where the caller may well want to actually use the index that it 
has read in (eg "git add" and "git commit" both want to work with the 
full index).

So libification of that part will require more than splitting things into 
a new file and passing in a structure pointer that contains the data for 
the function.

That said, a lot of the current shell scripts seem to use mainly 
"git-ls-files" with the "--others" flag, and in that case the current 
libification should be already sufficient.

		Linus
