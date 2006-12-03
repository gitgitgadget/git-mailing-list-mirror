X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to
 the index
Date: Sun, 03 Dec 2006 00:03:56 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612022335350.2630@xanadu.home>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home>
 <7vpsb36yem.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 3 Dec 2006 05:04:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vpsb36yem.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33096>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqjWE-0006mU-R5 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 06:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424951AbWLCFD6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 00:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424954AbWLCFD6
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 00:03:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58534 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1424951AbWLCFD5
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 00:03:57 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9O004AZM2KQMK0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Sun,
 03 Dec 2006 00:03:56 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, 1 Dec 2006, Junio C Hamano wrote:

> > +Contrary to other SCMs, with GIT you have to explicitly "add" all the
> > +changed file content you want to commit together to form a changeset
> > +with the 'add' command before using the 'commit' command.
> 
> ... "before a new commit is made"; it is not an offence to leave
> local changes outside the index.  Staging such changes to all
> files is done using the "-a" flag and that is done "before a new
> commit is made", but not "before using the 'commit' command" --
> it is done at the same time.

Sorry but I don't think this is a good idea to tell that.  At least not 
here.  Opening all the possibilities too fast at once is a good way to 
create distrust.  Let's focus on what the user needs to know about the 
add command only.  

The newbie that becomes not so newbie aftera while will deduce that he 
actually _can_ leave local changes outside the index and he'll go "wow, 
that is cool!" especially if he deduce this by himself.  And that 
deduction will happen in time while using the tool when the opportunity 
for leaving local changes outside the index arises which is a much 
better way to grasp the power of the index than by just being told about 
it.

AS to the commit -a ... I think it is better to refer to the commit man 
page once it has been refactored with the writeup you posted yourself 
and simply direct the user with "You may also have a look at the 
git-commit documentation for alternative ways to add content to a 
commit."

> > +This is not only for adding new files.  Even modified files must be
> > +added to the set of changes about to be committed. This command can
> > +be performed multiple times before a commit. The 'git status' command
> > +will give you a summary of what is included for the next commit.
> > +
> > +Note: don't forget to 'add' a file again if you modified it after the
> > +first 'add' and before 'commit'. Otherwise only the previous added
> > +state of that file will be committed. This is because git tracks
> > +content, so what you're really 'add'ing to the commit is the *content*
> > +of the file in the state it is in when you 'add' it. Of course there are
> > +legitimate usage cases for not updating an already added file content
> > +in order to commit a previous file state, but in this case you better
> > +know what you're doing.
> 
> May be we could hint the reader that a faster-to-type
> alternative exists here.  Perhaps...

Perhaps not.

> > +GIt tracks content not files
> 
> s/I/i/

Yup

> > +But here's a twist. If you do 'git commit <file1> <file2> ...' then only
> > +the  changes belonging to those explicitly specified files will be
> > +committed, entirely bypassing the current "added" changes. Those "added"
> > +changes will still remain available for a subsequent commit though.
> > +
> > +There is a twist about that twist: if you do 'git commit -i <file>...'
> > +then the commit will consider changes to those specified files _including_
> > +all "added" changes so far.
> > +
> 
> I think there is another twist more deserving of mention than -i twist.

Actually I removed the -i twist entirely.  It is simply too much for the 
context of the tutorial and it is of no advantage for a newbie to even 
know that -i exists just yet.

> If you jump the index using --only, what is committed with that
> commit becomes part of what is staged for the commit after that,
> and in order to prevent data loss, we disallow this sequence:
> 
> 	$ git checkout
> 	$ edit foo
>         $ git add foo ;# your new add to update the existing entry.
> 	$ edit foo
>         $ git commit foo
> 
> If we did not have the second edit (the behaviour is the same if
> we did not have "git add foo" there), this commit:
> 
>  * commits the changes to 'foo' (not because you staged it
>    earlier with 'git add', but only because you said "commit
>    foo" to invoke the '--only' semantics), obviously;
> 
>  * updates 'foo' in the index to what was committed.
> 
> So if we allowed the above sequence to succeed, we would commit
> the result of the second edit, and after the commit, the index
> would have the result of the second edit.  We would lose the
> state the user wanted to keep in the index while this commit
> jumped the index, and that is why we disallow it.

Great.  This is perfectly fine behavior.  But I think this definitely 
doesn't belong in the tutorial.  the probability for a newbie to perform 
the above sequence is rather low, and even then the explanation belongs 
in the failure message not in the tutorial.  It can be as short as 
"Please see git-commit man page and look for xyz for explanation about 
this failure" if the inline explanation would be too long.

> > +But for instance it is best to only remember 'git add' + 'git commit'
> > +and/or 'git commit -a'.
> > +
> > +No special command is required when removing a file; just remove it,
> > +then tell `commit` about the file as usual.
> 
> I wonder if this sequence should do the same as "git rm -f foo":
> 
> 	$ /bin/rm foo
>         $ git add foo

Well I think Linus' suggestions about git-rm are really sane.  When 
git-rm has been updated then it could be mentioned here, along with 
git-mv.  In the mean time I simply removed that paragraph.


