From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cherry-pick particular object
Date: Tue, 28 Mar 2006 15:24:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603281512260.15714@g5.osdl.org>
References: <20060328113107.20ab4c21.sebastien@xprima.com>
 <BAYC1-PASMTP02B05019F52DE48793CB39AED30@CEZ.ICE> <Pine.LNX.4.64.0603281435410.15714@g5.osdl.org>
 <20060328225429.GD27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sean <seanlkml@sympatico.ca>,
	=?ISO-8859-1?Q?S=E9bastien_Pierre?= <sebastien@xprima.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 01:24:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FONY5-0004p8-2j
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 01:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWC1XY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 18:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWC1XY0
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 18:24:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964823AbWC1XYZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 18:24:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2SNOECo032376
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Mar 2006 15:24:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2SNODKo000876;
	Tue, 28 Mar 2006 15:24:13 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060328225429.GD27689@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18141>



On Wed, 29 Mar 2006, Petr Baudis wrote:

> Dear diary, on Wed, Mar 29, 2006 at 12:44:02AM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
> > Ie you can have a tree like this:
> > 
> > 	100644 blob f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f    abc
> > 	120000 blob f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f    file
> > 
> > where the first one is a regular file called "abc" (which contains the 
> > string "abc"), and the second is the _symlink_ that points to "abc".
> > 
> > They share the exact same blob, and what distinguishes them is the 
> > filemode info from git-read-tree.
> 
> Huh? Didn't you rather want to say that "file" will point to a blob
> containing just the "abc" string (the symlink target)? ;-)

Well no, maybe I should have called the first file something else.

Both "abc" and "file" from a git perspective have the same _contents_ (the 
blob containing the data 'abc'). 

But the filemode means that those contents have totally different meaning. 
For the pth "file", it means that it's a _symlink_ to "abc", while for the 
path "abc" it's a regular file that just has the _contents_ "abc".

So the end _result_ of this is that "file" points to a file called "abc" 
that also has the contents "abc", and "cat file abc" will result in 
"abcabc".

IOW, this is the result of doing

	echo -n abc > abc
	ln -s abc file

and importing the mess into git.

		Linus
