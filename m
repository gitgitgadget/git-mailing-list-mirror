From: sean <seanlkml@sympatico.ca>
Subject: Re: My first git success [not quite]
Date: Sat, 14 Jan 2006 10:55:04 -0500
Message-ID: <BAYC1-PASMTP10B423DC1B2FC1F8C9992BAE190@CEZ.ICE>
References: <dq8epd$k28$1@sea.gmane.org>
	<Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
	<dqb5vg$a09$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 16:59:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExnoX-0003zx-BB
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 16:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWANP7d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 10:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWANP7d
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 10:59:33 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:57912 "EHLO
	BAYC1-PASMTP10.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932275AbWANP7c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 10:59:32 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 14 Jan 2006 08:00:12 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id ABEEC644C23;
	Sat, 14 Jan 2006 10:59:30 -0500 (EST)
To: walt <wa1ter@myrealbox.com>
Message-Id: <20060114105504.157248db.seanlkml@sympatico.ca>
In-Reply-To: <dqb5vg$a09$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 14 Jan 2006 16:00:12.0390 (UTC) FILETIME=[99F11060:01C61923]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 14 Jan 2006 07:39:28 -0800
walt <wa1ter@myrealbox.com> wrote:

> Linus Torvalds wrote:
> > 
> > On Fri, 13 Jan 2006, walt wrote:
> >> And it was all so easy I never broke a sweat.  Amazing!
> 
> >  ...Most people don't bother to 
> > explain their problems well...
> 
> I see I still have a problem:  my mental model of how git
> works is still wrong.
> 
> I used 'git-checkout -b test' to create a disposable place
> to test the patch I was given.
> 
> Okay, making sure I'm now sitting in 'test', I apply the
> patch to foo.c and do my testing.
> 
> Now, intending to delete my 'test' branch, I do git-checkout
> master.  My mental model predicts that 'master' should still
> be identical to 'origin' because I did the patching in 'test'.
> Am I right so far?
> 
> The problem I see is that, after switching back to 'master',
> foo.c is the patched version, not your original version.  I
> figured that the git-checkout would overwrite any changes I
> made to foo.c, but that doesn't seem to be the case.  To get
> your original version back I had to delete foo.c and do a
> git-checkout foo.c (or git-checkout -f master).
> 
> So, I clearly don't understand what git-checkout does.  It
> doesn't seem to touch the already-checked-out sources at
> all, which is what I would expect it to do.
> 
> Can someone hit me with the clue-stick here?  Thanks!
> 

Hi Walt,

When you switch branches _uncommitted_ changes will stay in
your working directory.   This lets you change to a different
branch before committing something you're working on for
instance.   So likely, even though you had switched to your
test branch to apply the patch, you didn't actually commit
it into that branch before switching back to master.

Here's a little example that should show the difference:


Create a test repo:
	$ mkdir walt ; cd walt
	$ git-init-db
	defaulting to local storage area

Create a simple file and commit it on the master branch:
	$ echo A > file
	$ git add file
	$ git commit -m "initial"
	Committing initial tree a9e3325a07117aa5381e044a8d96c26eb30d729d

Create and checkout a new branch named "test":
	$ git checkout -b test
	$ git branch
	  master
	* test

Modify (ie. patch) the file:
	$ echo B > file
	$ cat file
	B

Now, if you switch back to the master branch, the file is still patched:
	$ git checkout master
	$ cat file
	B

Switch back to the test branch and commit the change this time:
	$ git checkout test
	$ git commit -m "test branch" file
	$ cat file
	B

Now, this time when you switch back to master, you'll get what you expect:
	$ git checkout master
	$ cat file
	A


HTH,
Sean
