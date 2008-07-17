From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: git submodules and commit
Date: Thu, 17 Jul 2008 10:47:29 +0100
Message-ID: <320075ff0807170247g7bb18252ma50b202e1d762296@mail.gmail.com>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com>
	 <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
	 <32541b130807160843k25f1d7d3u8bfecd6c1c6eab91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 11:48:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJQ6C-0007yJ-8b
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 11:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbYGQJrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 05:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbYGQJrd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 05:47:33 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:30290 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbYGQJrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 05:47:32 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1935884yxm.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IktikmfU9lWfBuiGBWwfh0pSisDzjy0QyYFyMNV3/98=;
        b=kQvCIJD5koa3gvNwleRx1RJ+e9tgiPZtXw9jHvoePi2EdBTIA8L+16S/QjZT8ktgQd
         e/tsg0oCH0JnSfwei/o7HXXCkbqm6povz7mYIS5M/gL3XdF8Vij3fwt9iYXUJIxcu/wd
         of0MSPh6I6UoUQDirneV5fepWJQDay6mFIZH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vccgtnJZG11LJV/sN79AnAK5BFPcOmy1e0/cOK9cCXmX6JEhLP9pswJNKfItBim3Iq
         NItbvm9/2vdP2Ne6J2H6FD4AizeJyH0fiFS+PVh2Mbpn4Tzdc/g9lHbHFAp+N+fS7Lkb
         uXp1PmvRoC4GJ2EkA9Xm6gtJ8Ati/EqayO3Y8=
Received: by 10.103.24.17 with SMTP id b17mr1722833muj.107.1216288049841;
        Thu, 17 Jul 2008 02:47:29 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Thu, 17 Jul 2008 02:47:29 -0700 (PDT)
In-Reply-To: <32541b130807160843k25f1d7d3u8bfecd6c1c6eab91@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88822>

On Wed, Jul 16, 2008 at 4:43 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On 7/16/08, Nigel Magnay <nigel.magnay@gmail.com> wrote:
>> I wonder if this is a fairly common pattern. We tend to have modules
>>  as git repositories, and projects that tie together those git
>>  repositories as submodules. [and submodules are necessary because they're
>>  shared between multiple supermodules].
>
> I have exactly the same problem as you, and have been working on
> improving my own workflow so that someday I can offer patches that
> might be generally applicable.
>
> In the meantime, my solution is... some shell scripts checked in at
> the top level of my project. :)
>
> In one of my applications, I have a /wv submodule, which provides a
> cross-platform build environment.  That environment respectively
> contains a /wv/wvstreams submodule, which is a library that we use.
>
> When I make a change to wvstreams that's needed for my application, I
> need to check into wvstreams, then check that link into wv, then check
> that link into the application.  Then, when I push, I have to make
> sure to always push wvstreams first, then wv, then application, or
> else other users can end up with "commit id xxxxxx not found" type
> errors.
>
> So basically, committing is always harmless, since I can do anything I
> want in my own repo (and I want to be able to update wvstreams
> *without* always updating wv, and so on).  The tricky part is pushing.
>  Here's the script I wrote to make sure I don't screw up when pushing:
>
>
> ~/src/vx-lin $ cat push-git-modules
> #!/bin/sh -x
> set -e
> test -e wv/wvstreams/Makefile
> (cd wv/wvstreams && git push origin HEAD:master) &&
> (cd wv && git push origin HEAD:master) &&
> git push origin HEAD:master ||
> echo "Failed!"
>
>
> Now, this script is pretty flawed.  Notably, it always pushes to the
> 'master' branch, which is stupid.  However, it works in our particular
> workflow, because wvstreams isn't being modified by too many
> developers and it's okay if we all commit to master.  This is also
> aided by the fact that people are trained to push only after they've
> made all the unit tests pass, etc.  And further, individual apps don't
> have to update their wvstreams to the latest anyway unless they really
> need the latest changes, which is a wonderful feature of git
> submodules.
>

Yes - I use something rather similar on my desktop. The unfortunate
thing is that I know how submodules work, and am happy with the
scripts. My users are sometimes in the 'git gui' types - not as
technically literate, and likely on Windows.

> Now, sometimes the above push script will fail.  In my experience,
> this is only when someone else has pushed in something before you,
> which means a fast-forward is not possible on at least one of the
> repos.  When that happens, you have to pull first, using this script:
>
> ~/src/vx-lin $ cat newest-git-modules
> #!/bin/sh -x
> set -e
> test -e wv/wvstreams/Makefile
> git pull origin master &&
> (cd wv && git pull origin master) &&
> (cd wv/wvstreams && git pull origin master) ||
> echo "Failed!"
>
> This pulls in the latest version of application, wv, and wvstreams, in
> that order, and stops in case of any merge conflicts so that you can
> resolve them by hand.  It's safe to run the above script more than
> once in case you're not sure if it's done or not.
>
> After pulling the new modules, you may need to make new commits to
> update to the latest submodule commits - if that's indeed what you
> want.  And then you can run push-git-modules, and be reasonably
> assured that it will work (unless someone made another push while you
> were fixing conflicts).
>

Yeah - this happens a lot. If someone else commits to the
super-project before you, it's always a conflict. What's annoying is
there's no way around it (though resolution is easy - force to current
- but it this is a big bit of what confuses my users. They say 'but I
already resolved the merges in the submodule itself'. I'm not sure
there's an easy way around it though - and this is part of my worry
that there's hidden complexity with trying to make it 'look like 1 big
repo').

> Finally, I have another script that retrieves the *currently linked*
> version of the git modules.  I wish git-checkout would do this
> automatically, but it doesn't, for apparently-difficult-to-resolve
> safety reasons.  Anyway, note that this script uses the existence of
> submodule/Makefile as "proof" that the submodule was checked out
> correctly.
>
>
> ~/src/vx-lin $ cat get-git-modules
> #!/bin/sh -x
> set -e
> git submodule init
> git submodule update
> test -e wv/Makefile
> (cd wv && git submodule init && git submodule update)
> test -e wv/wvstreams/Makefile
>
>
>>  I guess it probably gets sticky when there are merge conflicts. Is
>>  anyone working on this kind of thing; I might be able to give some
>>  time to help work on it?
>
> So as you can see, my scripts are crappy.  However, they have already
> drastically reduced the number of mistakes made by developers in my
> group (especially commits lost due to 'git submodule update' at the
> wrong time, and pushes of the supermodule before the submodule).
>

Yeah. I have an additional usecase, which is around pulling from
another user. If they've made changes in their tree(s) that they want
to get reviewed, normally I could do something like

git fetch ssh://joebloggs.computer/blah +refs/heads/*:refs/remotes/joebloggs/*

But if they've made cross-module changes, I'm SOL, as fetching their
super-project will have references to commits that aren't in the repo
mentioned in .gitmodules (only in joebloggs's tree) - so doing git
submodule update doesn't help. I have to go into each submodule and
explicitly fetch. It feels wierdly centralised for this otherwise
distributed tool.

> If you want to work with me on my new submodule workflow (and I'd
> certainly appreciate it!) then I'd suggest one or more of the
> following starting points:
>
> - Take the recursive push, pull, and update operations described
> above, make them general (ie. not referring to my submodules by name
> :)), and add them as commands in the real git-submodule script.  The
> trickiest part here will be figuring out which remote branch to
> push/pull.
>

What's bugging me is I'm not sure that it's the right place. It seems
(to me) that having the only place that knows about submodules being
the 'git submodules' script isn't right. What users want is 'git fetch
<blah>' to do the lot - that, for the most, it ought to do the
submodule init, update and clever stuff automatically. That if 'git
fetch' is porcelain, then the porcelain needs to call the
git-submodule stuff.

But - perhaps it's best to approach it as scripts for now :)

> - Perhaps add a "recursive commit" operation that recursively
> auto-commits submodule refs, for use after running the
> newest-git-modules script.  The commit message could be auto-generated
> using something like "git-whatchanged" on the submodule.
>
Hm - I'd be happy with the same commt message in all modules. What I
want is to be able to do (from the top) 'git commit -a' or the same
with the GUI, and see all the files to be committed regardless of
whether they're in a submodule or not.

I'm guessing you probably need to build a tree of submodules, and
commit from the tips backwards towards the top level superproject.

This is what the users want - something that mirrors 'svn ci' at the
top level - "Please Check All My stuff in".

> - See what can be done about making git-checkout automatically
> git-submodule-update *if and only if* the currently checked-out commit
> of the submodule exactly matches the one that was checked out last
> time, *and* the desired commit is already available in the submodule
> repo (which is not necessarily the case, if you haven't fetched it
> yet).  That is, as with any file in git, if it hasn't changed from the
> one in the repo, you know you won't lose any information if you just
> auto-replace it with the new version.
>
> - Fix git-submodule-update to not just switch submodule branches if
> you've made checkins in that submodule.  Right now, commits to a
> submodule by default don't go to any branch, so if you subsequently
> run git-submodule-update, your commits are lost (except for the
> reflog).  This is very un-git-like in general, and
> git-submodule-update should be much more polite.
We always move back onto a branch immediately after submodule update,
which is another thing to forget!

>
> Note that git-submodule is only about 800 lines of shell.  It's
> remarkably straightforward to make it do whatever you want.  The hard
> part is figuring out what you want, and making sure you don't stomp on
> *other* people's workflows while you're there.
>
Totally.

> Also note that even if you don't contribute any of the above, I'm
> planning to someday make time to do it myself :)  But don't hold your
> breath.  I've been busy.
>
Ditto.

> Have fun,
>
> Avery
>
