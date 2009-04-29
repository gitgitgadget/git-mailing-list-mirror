From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Wed, 29 Apr 2009 14:13:29 -0400
Message-ID: <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com>
References: <20090427201251.GC15420@raven.wolf.lan>
	 <32541b130904281353k572fed5la468de65f73ccd19@mail.gmail.com>
	 <20090428223728.GE15420@raven.wolf.lan>
	 <32541b130904282019n4b930f80g1ed22b2dde22510a@mail.gmail.com>
	 <20090429160129.GF15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 20:13:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEHz-000557-Pp
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbZD2SNc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 14:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494AbZD2SNb
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:13:31 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:33695 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbZD2SNa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 14:13:30 -0400
Received: by gxk10 with SMTP id 10so2777784gxk.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=tuU4oO0tog3NyYucf+aIm5FQiu4w/wSDsD5ieA2aFxk=;
        b=bfyZ0shjwvgsKONbaDM55PNvm+br8KRitTt8xEm/P0t7yFxHh+OS4FCE0YXuC7ojnS
         7qvg3M2FUCWvWdyrP78VlkHBF/ketyIAjIe5FRs+rXZ7XmbNFFcUWRWFUqE8Sd2NVdr8
         +R4KGd0OqtGfykrwsyZ46nSzx6fuuufXSdTYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Wc94XOxVYkMxM0EOqBwRtrWCgwspZcFyx1d9sacnhVfPxtC5fJs5sG+cdDfV/lb1sb
         OCnn/jgtMzbAK4OBVsrLz6MPDfss97sdeBm2k/zAUbnx4y+xsYcgtz59jEyZYQ26CXoM
         6AcpqMGT3uoN2rVPngHaasuKJOvIkApXhgl74=
Received: by 10.151.113.11 with SMTP id q11mr1901666ybm.4.1241028809630; Wed, 
	29 Apr 2009 11:13:29 -0700 (PDT)
In-Reply-To: <20090429160129.GF15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117908>

On Wed, Apr 29, 2009 at 12:01 PM, Josef Wolf <jw@raven.inka.de> wrote:
> On Tue, Apr 28, 2009 at 11:19:51PM -0400, Avery Pennarun wrote:
>> Okay, I think I'm following you. =A0And I think the difficulty of yo=
ur
>> solution will depend on how important it is to cherry-pick each
>> individual commit from each repo vs. just merging everything as a
>> batch.
>
> I've already done the cherry-picking.

So you're saying that from now on, *all* changes from *both* branches
need to be integrated in both directions?  If so, you're done with
cherry-picking.  If not, you're not.

> =A0Basically, I've done this:
>
> =A0# first, move patches from second-svn to first-svn
> =A0git checkout first-svn
> =A0git svn rebase
> =A0git cherry-pick sha1 # repeat as needed
> =A0git merge -s ours second-svn
>
> =A0# Now, the other way around
> =A0git checkout second-svn
> =A0git svn rebase
> =A0git cherry-pick sha1 # repeat as needed
> =A0git merge -s ours first-svn
>
> The first git-svn-rebase after the merge causes all the (already pick=
ed)
> commits from the other branch to be pulled into the current branch.
> Adding the --no-ff option does not help. =A0Omitting the cherry-picki=
ng
> does not help, either.

Hmm, I don't see any 'git svn dcommit' in there.  The steps I listed
referred to dcommit, but explicitly left out calls to 'git svn
rebase'.

I think it's likely that your problems stem from this. The git svn
documentation refers to the 'git svn rebase' operation a lot, but it's
only really useful for one thing: linearizing history to make it look
(to svn) like git was never involved. This is handy for people who
want to use git at work without their boss knowing about it, but it
*loses information* and will mess up future merges.

In general, 'git svn rebase' should be avoided for all the same
reasons that 'git rebase' should be avoided.  They're both great when
used carefully, but they shouldn't be your main day-to-day activity.
Unfortunately git svn encourages you to use rebase in your day-to-day
activity... but the workflow I'm talking about actually avoids this
problem completely.  What you want most of the time is really just
'git svn fetch'. and 'git svn dcommit'.

I think I was also a bit too offhand in my previous email when
expanding my suggestion to work with multiple svn hosts.  The clearest
way to do this is with three branches:

  - 1 remote branch: git-svn-1
  - 1 remote branch: git-svn-2
  - 1 local branch: master

So the steps are something like this.  (Again, WARNING: I'm not
running these as I type them, so I could be screwing up just about
anything.)

Getting started:

  git checkout master
  ... Use 'git svn fetch' to update git-svn-1 and git-svn-2 ...
  ... git merge/cherry-pick what you want from git-svn-1 and
git-svn-2.  ALWAYS use --no-ff if using git merge
  git merge --no-ff -s ours git-svn-1
  git merge --no-ff -s ours git-svn-2
    # now master has everything from both svn repositories

=46rom now on:

  # Update git-svn-1 with the latest master
  git checkout git-svn-1
    # since git-svn-1 is a remote branch, you now have a detached HEAD
  git merge --no-ff master
  git svn dcommit

  # Update git-svn-2 with the latest master
  git checkout git-svn-2
    # since git-svn-2 is a remote branch, you now have a *different*
detached HEAD
  git merge --no-ff master
  git svn dcommit

  # Update master with the latest svn
  git checkout master
    # HEAD is now attached to master
  git merge --no-ff git-svn-1
  git merge --no-ff git-svn-2
    # no need for '-s ours' in the above merge, as no rebasing means
no merge history was lost

>> At Versabanq, we're using git for a bunch of stuff including our
>> autobuilder (http://github.com/apenwarr/gitbuilder) and my own
>
> Interesting project. =A0One question: the README mentions that the
> gitbuilder as capable to update itself. =A0But I can not actually see
> this functionality in the scripts. =A0Is that just a typo or am I mis=
sing
> something?

I guess you're reading the line that says, "Now that your gitbuilder
is working, you probably want to have it continue
to update itself automatically."  This is actually talking about
*running* itself automatically, as in "upating the build results to
the latest copy of your project."  I can see how it's a very unclear
word to use there.  Thanks for the feedback.

>> As long as you "git config merge.summary true" (to make the merge
>> commit list all the commits it's merging)
>
> How does this option influence the merge operation? =A0Or is this mea=
nt
> to provide additional information to the person who does the next mer=
ge?

When you *merge* (as opposed to rebase or cherry-pick) into an svn
branch, you only create a *single* svn commit that contains *all* the
changes.  The above config setting just makes the merge commit contain
a list of all the commits it contains.

>> Now, your problem is a little more complex, because it sounds like
>> people are checking in two types of things on both sides: private
>> things and public things. =A0So if you want *only* the private thing=
s,
>
> I want both. =A0The difference is that I (usually) want to pull the p=
ublic
> things unmodified, while I want to generalize/localize the private th=
ings.
> So when merging the private part, I would not want to pick the specif=
ic
> entries. =A0But I still want to pick the _structure_ (possibly removi=
ng or
> modifying the localized entries).

If you're going to be mangling things so thoroughly, then you might
just have to resort to cherry-picking everything one by one from one
branch to the other.  It doesn't sound very fun, but if other people
are being so uncooperative by mixing public and private stuff in their
repositories, there's no way I can see to automate it anyhow.

If you're using cherry-pick for everything, there's no reason to use
tricks like 'merge -s ours'.  Just leave out the merging entirely and
don't pretend that what you're doing is merging; it isn't.  (You still
don't need 'git svn rebase' for anything.  Just checkout the branch
you want to change, cherry-pick stuff into it, and 'git svn dcommit'
if appropriate.)

If the situation ever changes, you can always do one last 'merge -s
ours' and mark the histories as combined.  Then future merges will
bring in any future changes.

Good luck.

Avery
