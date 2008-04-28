From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Yet another Git tutorial
Date: Mon, 28 Apr 2008 12:30:30 -0400
Message-ID: <4557C7EE-2B56-4836-A2AC-09EAF05FD95C@silverinsanity.com>
References: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Johan Herland <johan@herland.net>
To: John Wiegley <johnw@newartisans.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:32:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWGB-0003H2-0E
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbYD1Qae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 12:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934675AbYD1Qae
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:30:34 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:51897 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934570AbYD1Qad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:30:33 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id C73931FFD6C5;
	Mon, 28 Apr 2008 16:30:26 +0000 (UTC)
In-Reply-To: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80554>


On Apr 28, 2008, at 2:39 AM, John Wiegley wrote:

> I published another tutorial on Git today, this one describing the  
> system from a "bottom up" perspective.  I know it's been written  
> about this way before, but I was aiming at a bit more thoroughness,  
> and a paced introduction to the basics.

Very interesting tutorial.  Doesn't teach me anything, of course, but  
I've been using git for a good long time.  But I'm going to save this  
and point it out to my technical friends who are interesting in git,  
as this does a better job of teaching them what it's actually doing  
"behind the scenes" than most tutorials I've seen.

That said, my comments:

(p.4) On my system, `echo "Hello, world\!" > greeting` puts the  
backslash into greeting, which in turn changes my SHA1.  (Using bash  
3.1.17.)  Of course, leaving it out leaves an error.  To avoid  
problems with different shells perhaps you should use something like:

$ cat > greeting <<EOF
Hello, world!
EOF

Of course, this issue could also be solved by leaving out the  
exclamation point, as long as you update the hashes of the objects  
from that point on.

(p.4-5) You determine the hash for your file as  
"af5626b4a114abcb82d63db7c8082c3c4756e51b", then use `git cat-file -t  
af5626b` to find it, and print the type.  You should use this as an  
opportunity to mention the convenience of git expanding SHA1  
abbreviations, rather than leave it implicit.  In documentation, it's  
a good idea to never use something you haven't explained.

(p.5) Your reference to hand waving is unnecessary, as you defined  
HEAD in your lexicon on p.2.  Reinforcing that your current commit is  
HEAD is fine, but the apology is unneeded and distracting.  Perhaps  
something like:  "If we want to see the contents of our commit, all we  
have to do is list the tree for HEAD (which always refers to the last  
commit on the current branch):"

(p.5) Instead of using `git rev-list HEAD | head -1`, you can also  
just use `git rev-list -1 HEAD`.  And instead of that, what you really  
want to be using is `git rev-parse HEAD` since you're trying to  
convert HEAD to a SHA1, not get HEAD's history.

(p.7) I can't help but feel that telling the user to do `rm -fr *` is  
a bad plan.  `rm -rf greeting .git` is better: It will remove all the  
files you've told them to create anyway, without causing huge  
headaches if they type it in the wrong terminal.  Plus, removing and  
recreating the greeting file isn't really necessary, so why do it?

(p.8) Mentioning again that the commit SHA1 is going to be different  
would be a good idea.  And at this point you should mention why:  
different authors and dates.

On Apr 28, 2008, at 5:27 AM, Johan Herland wrote:

> (p.9) "But if I pass the -f flag to git-checkout, it becomes  
> identical to
> git-reset --hard": In the context of the command above (resetting the
> working tree to 5f1bc85) there are in fact no difference between the  
> two
> commands. However, in general, there is one crucial difference  
> between "git
> reset --hard" and "git checkout -f": "git reset --hard" will rewrite  
> which
> commit the current branch points at, whereas "git checkout -f" will  
> not.
> (I see you treat this later in "To reset, or not to reset", but I  
> think it
> should be fixed on p.9 as well.)


I really want to agree with this comment. `git reset --hard` and `git  
checkout -f` are not identical, and you shouldn't put that  
misconception into place.  It may be enough to call them similar and  
say you will explain the difference later.

(p.10) Is there a particular reason why one blob is white and the  
others have a gradient?  It makes that one square stand out for no  
apparent purpose.

On Apr 28, 2008, at 5:27 AM, Johan Herland wrote:

> (p.11-12) This entire list is prefixed with "nam[ing] commits - and  
> ranges
> of commits", so in a strict sense "name:file" and "name{tree}" does  
> not
> belong here. But you have to put them somewhere...

Perhaps you should say: "There are many way to name objects --  
commits, ranges of commits, trees, and blobs --"

(p.12) "name{tree}" should be "name^{tree}".

(p.12) "If either name1 or name2 may be omitted, HEAD is used in its  
place."  This should be "If either name1 or name2 is omitted, HEAD is  
used in its place."

(p.12) You describe --author and --committer without describing why  
these may be different.  You could introduce the difference when  
talking about rebase.

(p.12) I'd also add an example that mixes several of these options,  
just to demonstrate that it can be done.  For example: `--no-merges -- 
grep="bug fix" --since="1 month ago"`.  A sentence or two about using  
approximate dates and full dates would be nice as well.

(p.14) Spelling: "asterices" should be "asterisks".  Your spelling may  
be considered technically correct but is not the common pluralization  
by any means.  (And it threw me for a loop when I saw it.)

This is a good place to really learn the guts of Git.  But as a  
tutorial, it lacks any description of how to do the D part of DVCS.   
Sections on pull/push, remotes, and patches would be useful for a new  
user.  You could get a new user working on a copy of the git repo and  
sending a patch to the list in only a few pages describing clone,  
format-patch, and possibly send-email.  If you were ambitious you  
could add the receiving side of dealing patches working up from apply  
to am.  And of course, describing clone should also involve using  
init, remote, and pull.

But of course, there are other places to learn these things.  At the  
least adding URLs to tutorials that do describe pull, pull, and  
patches would be nice ending.

~~ Brian
