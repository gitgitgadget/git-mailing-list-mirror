From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Two ideas for improving git's user interface
Date: Sat, 4 Feb 2006 08:03:45 +0000
Message-ID: <200602040803.45617.alan@chandlerfamily.org.uk>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0602011656130.21884@g5.osdl.org> <Pine.LNX.4.64.0602011732560.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Feb 04 09:03:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5IOb-00056y-J3
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 09:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946340AbWBDIDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 03:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946343AbWBDIDr
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 03:03:47 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:43197
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1946340AbWBDIDq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 03:03:46 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F5IOV-0006Gt-Aq
	for git@vger.kernel.org; Sat, 04 Feb 2006 08:03:43 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <Pine.LNX.4.64.0602011732560.21884@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15577>

On Thursday 02 February 2006 01:44, Linus Torvalds wrote:
> On Wed, 1 Feb 2006, Linus Torvalds wrote:
> > And notice how I commit the _merge_ without actually committing my dirty
> > state in the tree - and whether the files involved in my standard dirty
> > changes ("Makefile") are part of the state that the merge changed or not
> > is _totally_ irrelevant.
>
> If you get the feeling that merging is special, then to some degree, yes,
> you'd be right.
>
> Merging (especially with conflicts) is the _one_ operation where you
> absolutely have to know about the index. If you don't know about how the
> index works, you can get the conflict resolution right kind of by
> accident, simply because the default workflow of
>
> 	.. edit conflict to look ok ..
> 	git commit file/with/conflict
>
> actually happens to do exactly the right thing (very much on purpose,
> btw), but the fact is, to actually figure out more complicated conflicts
> and to _understand_ what happens, you absolutely need to be aware of the
> index. Not being aware of it just isn't an option for any serious git
> user.
>
> (Btw, I think this is where cogito falls down. Cogito tries to hide the
> index file, but I don't think you really _can_ hide the index file and
> also do merges well at the same time. Anybody who has non-trivial merges
> should use raw git - not just because the "recursive" strategy just works
> better, but exactly because of the index file issue).


Wow - light comes on.

I have been using git (or rather to be exact git with cg-add, cg-rm and 
cg-commit) for about 6 months (bearing in mind I am only a part time 
programmer in the evenings for fun - even though I work in the computer 
industry the last time I was paid to write code was in 1979 - so I don't 
really need to be a power user).  Although I knew about the index file since 
the beginning I never really groked what it was about before.

Of course I knew of its existance, and I even knew that it could be used as a 
staging area, but up to now I had always thought of it as a necessary 
inconvenience to enable git to run as blazingly fast as it does - not as an 
essential part of work flow it complex situations

I think the problem is with three crucial bits of documentation. Firstly, the 
document is full of the git doesn't do prorcelain statements - pushing towards 
cogito which then hides the existance of the index file.  Git not doing 
porcelain was true at the very beginning, but I don't think that it is true 
any longer.

Secondly the tutorial.  The examples given start by using commands to 
explicitly update the index and them they move on to show how you don't need 
to do that by using the more advanced commands of git-add and git-commit.  So 
as I was trying to learn how to use git, I followed through this and thought 
that you just try an avoid using it directly.  Whats more, viewed in this 
light git-commit seemed to be a rather poor implementation of cogito's 
superior cg-commit command

[Incidentally there is a use case that doesn't seem to have been discussed in 
this thread which I use cg-commit all the time for and will now have to see 
if there is a use index file equivalence for.  That is, I am developing a web 
application and in the running version the database framework (iBatis) is 
using Tomcats connection pooling.  In order to run my JUnit test harness, I 
don't have tomcat, so I need to define a different version of iBatis 
configuration file to used its own database connection.  So I have created a 
test branch and edited the configuration file in that branch, and I update 
both code and tests in a edit/compile/fix and text loop until I have written 
or changed both code and tests.  I then do a cg-commit which lists the files 
I have changed.  I ONLY commit those in the test harness - by deleting the 
others from cogito's list of files to commit - and then repeat the commit 
commiting the rest].  I then switch back to my master branch and cherry pick 
commit that is the code changes - not the text harness] 

Thirdly,  "discussion" of the index file at the bottom end of the git man page 
(The "index" aka "Current Directory Cache") really concentrates on what it is 
and what operations you can perform with it in the normal situation.

I tried looking at the core tutorial looking at what I might be a way of bring 
this to the attention of the new learner into git and produced the following 
(partial) patch to the core-tutorial (It needs a whole set of examples on 
resolving merge problems which I have no idea at the moment how to do - this 
has been the real area which never understood - basically because the 
tutorial itself says skip that part).

--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -212,15 +212,22 @@ was just to show that `git-update-index`
 actually saved away the contents of your files into the git object
 database.

+The Index File
+--------------
+
 Updating the index did something else too: it created a `.git/index`
 file. This is the index that describes your current working tree, and
-something you should be very aware of. Again, you normally never worry
-about the index file itself, but you should be aware of the fact that
-you have not actually really "checked in" your files into git so far,
-you've only *told* git about them.
+something you should be very aware of.  It is a staging area between your
+working tree and the object store described above.
+
+In normal circumstances you do not worry about the index file itself, but you
+should be aware of the fact that you have not actually really "checked in"
+your files into git so far, you've only *told* git about them.  Later you
+will see how you can exploit the fact that there is this separate index
+file to undertake more complex operations.

-However, since git knows about them, you can now start using some of the
-most basic git commands to manipulate the files or look at their status.
+However, since git knows about these files, you can now start using some of
+the most basic git commands to manipulate them or look at their status.

 In particular, let's not even check in the two files into git yet, we'll
 start off by adding another line to `hello` first:
@@ -1188,8 +1195,8 @@ How does the merge work?
 We said this tutorial shows what plumbing does to help you cope
 with the porcelain that isn't flushing, but we so far did not
 talk about how the merge really works.  If you are following
-this tutorial the first time, I'd suggest to skip to "Publishing
-your work" section and come back here later.
+this tutorial the first time, I'd suggest to skip to "Resolving Merge
+Problems" section and come back here later.

 OK, still with me?  To give us an example to look at, let's go
 back to the earlier repository with "hello" and "example" file,
@@ -1332,6 +1339,10 @@ merge for you to resolve.  Notice that t
 unmerged, and what you see with `git diff` at this point is
 differences since stage 2 (i.e. your version).

+Resolving Merge Problems
+------------------------
+
+NOT SURE WHAT GOES HERE

 Publishing your work
 --------------------

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
