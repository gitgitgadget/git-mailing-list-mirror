From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Auto update submodules after merge and reset
Date: Fri, 9 Dec 2011 18:57:18 -0500
Message-ID: <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de>
 <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de> <4EE07FCD.8090702@ursus.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: andreas.t.auer_gtml_37453@ursus.ath.cx
X-From: git-owner@vger.kernel.org Sat Dec 10 00:57:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZAK1-0001LC-PT
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab1LIX5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 18:57:41 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38157 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab1LIX5k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 18:57:40 -0500
Received: by wgbdr13 with SMTP id dr13so6592986wgb.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 15:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mlOTbED8ixG0uezkK8bdAxbWvO+5gJjAbsZR6RzkzvM=;
        b=I1wH+8GJ+VdJdIgq1A2/dZM2wNRNT+R4h4kptoreF2CbiD2LUD/RQ9ydUUqB8BZEYf
         Q/nVs7SNY+yuNmS3oj3hKhxHUJt3oPb+LWuVdVtuUj+aXdTLdK3PMfMj/PESeLCT0dnI
         YNzxXO82OzWsUTbauJy/oE/r2MA0wWXUBkKmU=
Received: by 10.227.203.131 with SMTP id fi3mr9405761wbb.17.1323475059408;
 Fri, 09 Dec 2011 15:57:39 -0800 (PST)
Received: by 10.216.120.199 with HTTP; Fri, 9 Dec 2011 15:57:18 -0800 (PST)
In-Reply-To: <4EE07FCD.8090702@ursus.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186711>

On Thu, Dec 8, 2011 at 4:13 AM,  <andreas.t.auer_gtml_37453@ursus.ath.c=
x> wrote:
>
> On 07.12.2011 23:23 Jens Lehmann wrote:
>> > If you have tracking branches, the supermodule can just update the
>> > corresponding branch. If this branch is currently checkedout and
>> > the work area is clean, then the work area is updated, too. If
>> > there is currently a local branch or a diffent super-branch
>> > checked out then the working area should be considered "detached"
>> > from the superproject and not updated.
>>
>> =A0This sounds a lot like the "follow branch tip" model we discussed
>> =A0recently (which could be configured via .gitmodules), but I'm not
>> =A0sure you really are in the same boat here.
>
> When I understood that correctly it was just a configuration to what =
branch
> should be automatically checked out in the submodule. This seems to b=
e too
> complicated IMO, because when you have different branches in the
> superproject then you may want to have different branches in the subm=
odules,
> too, but you would need to configure that submodule branch in .gitmod=
ules
> for each branch separately. I.e. in the master branch the .gitmodule =
may
> contain "master", in the maint branch the .gitmodules may have "maint=
" as
> the branch to follow.

Yes, but maybe you can update this information in the .gitmodules file
easily with a command.  Maybe it could be something simpler than "git
sync-gitmodules-branches", but that is essentially what it would do:
it would save the current branch in each submodule as the "tracked"
branch in the .gitmodules file.

The advantages to this, I think, are that

1. Your "submodule A follows branch X" information is explicit in the
=2Egitmodules file and so it is not hidden when I examine your patch.
(It sounds to me like the refs/super/* branches would necessarily be
hard to find since the refs/ hierarchy is usually meta data about
local and remote branches.  Maybe I should think about tags and notes
more, though.)

2. When you change to "submodule A now follows branch Y", this
information can be unambiguously saved in the commit where it occurred
rather than tucked away, again, in refs/super/*.

The disadvantage, maybe, are that you must now use 'git submodule
sync' or something like that to put any .gitmodules changes into
effect.
Or maybe that is an advantage.  How often will this branch tracking cha=
nge?

I like where you are going, though.  But I have trouble following your
meaning when you toss around words like "ref" and "HEAD" and "branch"
and "super-branch".  Maybe we can set up a strawman repo (virtually or
on github) where you can explain what happens now and what you wish
would happen instead.

=46or example, I have some repos like this:

super
   +--subA
   +--subB

I wish I could do this:
   cd super && checkout master

to get this:
   super   (master)
      +--subA  (master)
      +--subB  (master)

Or, if I have SubB on super/'master' tracking 'foo', I could get this:
   super   (master)
      +--subA  (master)
      +--subB  (foo)



And I wish these commands would work as if this was all one repository:
   cd super && git diff master maint

   cd super && git grep foo
   cd subA && git grep foo -- :/

   cd super && git status
   cd subA && git status

But I wonder what this would do:
   cd super && git remote -v &&
   cd subA && git remote -v


> I do want to follow the tip of the branch, if the superproject has th=
at
> currently checked out. If the superproject checks out a tagged versio=
n for a
> rebuild, then the submodule should not follow the tip, but should get=
 a
> detached HEAD of the corresponding commit, just as the superproject. =
When
> the superproject goes back to the branch, the submodule should go bac=
k to
> its tracking branch.

Now this makes sense.  I want the same thing.  I want to preserve
history on "old" commits, but I want to "advance to tip" on "new"
commits.

The trouble, I think, is in telling the difference between "old" and
"new".  I think it means there is a switch, like --auto-follow (or
--no-auto-follow for the alternate if core.auto_follow is set).  But
having a config option as the default is likely to break lots of
scripts.

So maybe I need a new command that does this:
    git checkout master && git submodule foreach 'git checkout master'

Maybe it's called "git checkout master --recurse-submodules".  But I
seem to recall this is already a non-starter for some reason, and
anyway it doesn't solve the "variant branches in some submodules"
problem.

Which brings us back to .gitmodules.

>> > With this concept you could even switch branches in the
>> > superproject and the attached submodules follow - still having no
>> > detached HEAD. When you want to do some local work on the
>> > submodule you checkout a local branch and merge back into the supe=
r
>> > branch later.
>>
>> =A0You lost me here. How can you merge a submodule branch into one o=
f
>> =A0the superproject?
>
> It wouldn't work, if the super/* branch would contain a superproject'=
s
> SHA-1, that is right. But as explained above, it points to a commit o=
f the
> submodule.
>>
>>
>> =A0But we would want to have a deterministic update procedure, no? (=
And
>> =A0what has more freedom than a detached HEAD? ;-)__
>
> I think my proposal would be deterministic.
> And everything where you can commit to has more freedom than a detach=
ed HEAD

You can commit to a detached HEAD.  I do it all the time.  The trick
is in not switching away from a detached HEAD with your local commits
still on it.  :-)

>> > Even though it will raise a lot of detailed questions like "should
>> > the refs/super/* be pushed/pulled when syncing the submodule
>> > repositories".
>>
>> =A0I doubt that is a good idea, as that might conflict with the same
>> =A0submodule sitting in a different superproject. But I'm interested=
 to
>> =A0hear how you want to solve that.
>
> The first answer to my question was "yes, you need to transfer the re=
fs or
> you get unreferenced objects" and "no, you can't transfer the refs, b=
ecause
> they are owned by the superproject, not the submodule."
> But binding a submodule to a superproject makes perfect sense if it i=
s _one_
> project that is split into submodules. In that case you only have one
> superproject for a submodule and for that purpose it would be good wo=
rkflow.

This is not useful to me, though.  Sorry.

> It is even nice to see which commits in the submodule belong to what
> branches in the superproject or to what release version (so tracking
> superproject tags would make sense, too). If you have a submodule tha=
t has
> more than one superproject but these are well-defined, it could be so=
lved
> using refspecs (e.g. refs/super/foo/* for one and refs/super/bar/* fo=
r the
> other superproject), but currently I can't think of a context where t=
his
> makes sense.

I can, but this does put the cart before the horse.  The submodule is
subservient to the super project in all my setups.  The submodule is
not aware who owns him.  He is a bit like the DAG in reverse.  He
knows one direction only (children), not the other (parents).


Phil
