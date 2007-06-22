From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Possible BUG in 'git log -z' last commit is not '\0'
 terminated
Date: Fri, 22 Jun 2007 14:56:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706221451570.3593@woody.linux-foundation.org>
References: <e5bfff550706221227x4b785698taabfa7572bf8204b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 23:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1r7B-00073d-U6
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 23:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbXFVV4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 17:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbXFVV4U
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 17:56:20 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48761 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753761AbXFVV4T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2007 17:56:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5MLuGk6028432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jun 2007 14:56:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5MLuA2Q004217;
	Fri, 22 Jun 2007 14:56:11 -0700
In-Reply-To: <e5bfff550706221227x4b785698taabfa7572bf8204b@mail.gmail.com>
X-Spam-Status: No, hits=-2.553 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50710>



On Fri, 22 Jun 2007, Marco Costalba wrote:
>
> It seems '-z' option is not honoured by the last revision printed that
> is just '\n' terminated.

It's not a bug - it's by design.

What the -z option does is to replace the normal "\n" that delineates 
commits from each other with a "\0".

And we only put that delimeter in *between* commits, not *after* commits. 
The reason? It's prettier. Do a 

	git log -1

to get a single commit, and notice how we do *not* add an empty line at 
the end (or beginning), and compare that to

	git log -2

that shows two commits, and has an empty line in *between*.

Now, add the "-z" flag, and notice how that empty line is now replaced by 
a "\0" character instead.

So you should think of the "\0" as being a delimeter that goes between
commits, not something that "ends" the commit. It's not a "end of record" 
thing, it's a "between records" thing.

		Linus
