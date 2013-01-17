From: Max Horn <max@quendi.de>
Subject: Re: git pull - reporting that I modified files, but I did not
Date: Thu, 17 Jan 2013 23:59:09 +0100
Message-ID: <01F1EFBD-CD9C-4335-BC2C-746AE29C9301@quendi.de>
References: <CADq_mb-k8mP6PAsPciYEkx6fvFNdGK+ejsFEZ4nCJVcUQ6odGg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jay Vee <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 23:59:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvyQo-0005bI-Fh
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 23:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab3AQW7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 17:59:13 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:52211 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750790Ab3AQW7M convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 17:59:12 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TvyQQ-0006wH-9Z; Thu, 17 Jan 2013 23:59:10 +0100
In-Reply-To: <CADq_mb-k8mP6PAsPciYEkx6fvFNdGK+ejsFEZ4nCJVcUQ6odGg@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1358463552;c2c5889d;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213889>


On 17.01.2013, at 20:29, Jay Vee wrote:

> When I do a git pull, I am getting a messages that changes to local
> files would be overwritten by a merge, but  I have not changed these
> files locally at all, I have not opened them in my IDE.
> This happens every now and then.
> 
> 1) Why does this happen?

This is hard to tell given the little information you provide. But clearly *something* modified those files, whether consciously triggered by you or not. But files don't magically change themselves :-). I recommend that you run "git diff" on those files to figure out in what way they changed -- this will likely provide a clue to the cause for this.

All I can say is that it is extremely unlikely that git did this, unless it happens to be something you (or somebody who has access to your git config resp. the repository config) explicitly activated and thus requested from git (e.g. via clean or smudge filters in gitattributes).



> 2) How do I prevent this from happening in the future?

As this largely depends on the cause, it can't be answered before 1) is answered...

> 
> 3) How do I get out of this state so that I can do a git pull and
> rebuild my code?

At least over here, when I do a "git status", it actually prints a nice message that explains how to do this. For example, I see something like this:

# On branch next
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   src/MyClass.java
#	deleted:    src/AnotherClass.java
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   src/MyModifiedClass.java
#	deleted:    src/YetAnotherClass.java
...


But I would strongly urge you to first review those changes, to make sure that they are really OK to discard. For example, you wouldn't want to throw away a change you did make on purpose but forgot to commit.


> 
> ---
> In other instances, when I do a git pull (not getting the message
> above,  I will see something like:
> M      src/MyClass.java      <= a file that I did not touch or modify
> D       src/AnotherClass.java   <= a file that I did not delete or touch
> M     src/MyModifiedClass.java   <= a file that I indeed modified for
> which in the pull there are no merge conflicts.

Hmm, where is this output from?

> 
> and the pull is successful, (then I want to push my changes), but I
> did not change either of the above two files

Did you try to find out what the change in them is? E.g. using "git diff" ? My guess would be that the nature of the changes would give a big clue as to their cause. E.g. did indention change? Line breaks? Where RCS keywords expanded / contracted? Was a random piece of code inserted somewhere?


> 
> If I see the above, am I OK to push?  My thinking is that git thinks I
> changed 'src/MyClass.java' and if I do a diff there are differences,
> but I do not want to push because I NEVER TOUCHED THAT FILE IN ANY
> WAY.

Shouting doesn't help :-). Something on your computer *did* touch the file. Git does not magically change your stuff -- unless in very special cases, but then only when *explicitly* configured to do so by somebody.

> 
> What is going on here?  Maybe this is normal and I simply do not
> understand correctly.

It doesn't sound "normal", but it doesn't sound like an issue with git either, more like one with your particular setup. It is hard to say more since you give us very little concrete information. E.g. what kind of changes are in those files? Which git version, and what OS are you on? Do you use git via the command line exclusively, or do you use a frontend(s) for it? etc.


> 
> What is happening?  I would expect to see only line items 'M' and 'D'
> for files that I personally have modified and deleted.

What do you mean by "personally"? Is a cron job you setup and forgot counting towards this, too? What about automatic changes caused by an IDE or a Git frontend? What about automatic changes caused by a git config setting you or a friendly co-worker setup in your gitconfig but you forgot about? 


> If I push at this point, will I overwrite changes in the repo pushed
> by others and muck things up?

A push will only push any commits you made. And a commit will only include changes you explicitly staged via "git add", or told "git commit" to include by listing files when doing the commit... So if you worry that what you are about to push is broken, I'd recommend to a) review all local commits and their contents before pushing them, and b) testing your work before pushing it.


Cheers,
Max