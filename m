From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Mon, 6 Jan 2014 18:47:58 +0100
Message-ID: <CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com> <20140105203349.GB3737@book.hvoigt.net>
 <CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com> <20140106140627.GA27265@t2784.greatnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:48:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0EHo-00058Y-4E
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbaAFRsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:48:20 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:42511 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbaAFRsT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 12:48:19 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp18so18748439obc.16
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 09:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NpXFdevANfcun5W2B6vb3fBedPQ8Dud1blJz1wuIIrw=;
        b=FrXPQAuvt4jEAZTAuHf42q0fl0vaS55zY/14xrb/nDV+8t2pRZPnv7zqCH/06Jza2W
         VTMs/9oQdEwhG5YgtoqUS81q6JCJKjfhdEWPUGoB1CVzWHTPSBZ9lykbBpfXIwur947G
         JBkJ0EMjcZhNIFZatPMnXN33QP2+HzThOydQGtKPV+wdWyJkspCTHeJazmpUdx92d7hn
         S7t8T56MZdu22mngdqPRb5/IJmGOtw0UYV/FZ0qghRrnMI6N5sfw8UV82os7gb1TkOjB
         3FXqlbtVNnLk81LoQMUDYMrMCqpVQPzwcFi3FToLRxaBkyHw1MgArDQo9Bm/pB7NvNii
         X84w==
X-Received: by 10.60.124.138 with SMTP id mi10mr2182926oeb.57.1389030498654;
 Mon, 06 Jan 2014 09:48:18 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Mon, 6 Jan 2014 09:47:58 -0800 (PST)
In-Reply-To: <20140106140627.GA27265@t2784.greatnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240038>

Dear Heiko, my replies below. I also take a couple excerpts from other
emails, as I prefer to not flame on different threads :) .

2014/1/6 Heiko Voigt <hvoigt@hvoigt.net>:
> On Sun, Jan 05, 2014 at 10:46:11PM +0100, Francesco Pretto wrote:
>> It means he doesn't need to control other developers commit to be
>> checked out so he sets "submodule.<name>.ignore" to "all". In this way
>> he and the developers can work actively in their submodule copy.
>
> So practically speaking: You mean that the value of
> submodule.<name>.ignore is set to "all" in the master branch of the
> superproject? From your other email referring to svn:externals I figure
> that.
>

Correct, but this works also if the branch of the superproject is a
different branch than "master". I think you are right in a point, see
the next reply.

> The workflow could always be changed to allow recording revisions. Which
> is why you use git in the first place right? If you discard revisions
> for submodules tracking down regression bugs can become a big problem or
> completely impossible. Try using git bisect on such a history.
>

Ok, you are right: setting "submodule.<name>.ignore" to "all" by
default with a switch "--attached" in "git submodule add" is too much.
My point is just make sure users will checkout an attached HEAD.

>> "submodule.<name>.branch" is one setting that is not copied in
>> ".git/config" by "git submodule init". "git submodule update" will use
>> the setting in ".gitmodules" if not overridden voluntarily by the
>> developer in ".git/config". The maintainer can change that setting in
>> ".gitmodules" and commit the change. Modifies will be propagated by
>> the next "git pull && git submodule update" of the developer in the
>> superproject.
>
> I do not understand how does that ensure you get the correct submodule
> revision when checking out a tagged release? To get a precise revision
> the superproject needs to track a sha1 of a submodule commit. I do not
> see how that has anything to do with submodule.<name>.branch?
>

"submodule.<name>.attacched" set to true implies "--remote". sha1 of
the latest commit is taken from "origin/$branch". In this way you get
the latest commit of that branch, and you do a 'merge', 'rebase',
'checkout' or '!command' according to the configured ''. This
mechanism is already in the patch at the current state.

>> >  - In which situations does the developer or maintainer switch between
>> >    your attached/detached mode?
>>
>> The developer/maintainer does so optionally and voluntarily and it
>> effects only its private working tree.
>
> This does not answer my question. I would like to find out the reason
> why one would do the switch.
>

The developer does it voluntarily, at his responsibility, because he
may decide to partecipate more actively to the development of the
submodule and still want to use a simple "git submodule update" to
updates his submodules, overriding its configuration as it can be done
for other properties like, for example, "branch". This ability is of
course already possible reattaching the HEAD manually but you loose
the convenient ability to use "git submodule update".

>> The branch of course must exist prior submodule adding. In this
>> use-case it does not really matter who creates it and who merges into
>> it. Everyone with the right to merge into it has to work in the
>> submodule seamlessly, as it was working on separate clone of the same
>> repository used as the submodule.
> o
> Here is the same. I am searching for a description like:
>
> If the developer works on a feature that needs a submodule change he:
>   - creates a submodule branch
>   - configures that submodule branch in the superproject:
>         git config -f .gitmodules submodule.common.branch dev/some-feature
>         git commit -am "TEMP: track submodule common on branch"
>  - and pushes out his superproject branch
>
> The submodule branch is then posted for review and continued to work on.
>
> Once everyone involved is happy with the submodule change the branch in
> there gets merged to master.
>
> Now the branch in the superproject is modified to drop the change in
> .gitmodules and the sha1 reference in the superproject is updated to the
> current master of the superproject.
>
> The superproject branch is posted for review.
>
> ...
>
> Could you describe something like this for your workflow? A complete
> change lifecycle when a developer works, as you call it, "actively" in a
> submodule?
>

I'm really sorry, I thought this was already clear from the first
patch iteration. I will go more in depth:

Say we have our actual projects "project1" and "project2". Say we have
a project "common". This "common" project is *not* independent: it
exists only to serve "project1" and "project2" and it's tested only in
the scope of "project1" and "project2". Also "common" is very actively
developed and follows the same lifecyle of "project1" and "project2"
on separate branches. I think that it's important that you get this
point: developers of "common" don't clone it separately, as it would
be impossible to test it, they clone "project1" and "project2" and
expect to find it inside one of these.

Let say now how "common" can be shared between "project1" and
"project2" so developers of "project1" don't break "project2" working
on "common" and the other way around. "common" has the following
stable branches:
- master;
- master-project1;
- master-project2;

The maintainer of "project1" at master branch sets "common" as
submodule at branch "master-project1". The maintainer of "project2" at
master branch sets "common" as submodule at branch "master-project2".
Periodically a maintainer of "common" will pull both master-project1
and master-project1 on a branch "next". Maintainers of both "project1"
and "project1", in coordination, are responsible to make next to be
merged in master, so they can both sync their master-project1 and
master-project2 in the "common" submodule.

Let say now how for example {"project1" and "common"} can evolve. As
told, these can't really evolve separately. Maintainer of "project1"
prepares a branch called "staging-featureA". "featureA" is big and
will require more people to work on the same feature for days/weeks.
Maintainer of "project1" also prepares a branch
"project1-staging-featureA" on "common" and set ".gitmodules" of
"project1" to point to "project1-staging-featureA". Developers of
featureA would like to do this:

$ git pull
$ git checkout staging-featureA
$ git submodule update      # clones an attached HEAD of common on the branch
                                        #
'submodule.common.project1.staging-featureA'
$ .... start coding in common seamlessly as they where in project1 ....

Also developers do frequently rebase:
$ git pull --rebase
$ git submodule update

Or maybe a shortcut of this: "git submodule update" should be given
the possibility to go "--remote" by default.  Of course if "common" of
the developer is in a branch different that 'submodule.<name>.branch'
"git submodule update" has not to switch the branch.

>> Maybe who coded submodules at first was thinking that the best way to
>> contribute to a project is to checkout that repository, and not work
>> in the submodule. As said, this works well when the submodule
>> repository is a full project, and not a bunch of shared code.
>
>Why not work in the submodule? See explanation above.
>

Because, as said above, the submodule is not independent. It does not
have proper code that test it and the best test case is using the
submodule in the scope of the superproject.

>> >  - What are these subsequent "merge" or "rebase" update operations? Do
>> >    you mean everyone has submodule.name.update configured to merge or
>> >    rebase?
>> >
>>
>> subsequent "merge" or "rebase" update operations are just the ones
>> after the initial clone/checkout, nothing particular.
>
> To clarify you are talking about issuing "git merge" or "git rebase"
> commands in the superproject?
>

No, I'm talking about "git submoudule update" with "--merge" or
"--rebase switches or "submodule.name.update" configured.

2014/1/6 Heiko Voigt <hvoigt@hvoigt.net>:
> I am not so sure. svn:externals was IMO a hack in SVN to bind projects
> together. It does not record the revision and so has nothing to do
> with version control. If you simply want to always checkout the
> development tip of some project you could do something like this:
>
>        git submodule foreach 'git fetch && git checkout origin/master'

This can be very unconvenient if the reccomended *starting* branch to
where attach the HEAD is not "master":

git submodule foreach 'branch="$(git config -f $toplevel/.gitmodules
submodule.$name.branch)"; git checkout origin/$branch

Of course the developer after they may want to move to a local branch
(or may not: please don't forget shared repositories), but the above
command may difficult to be taught. Also with the comit[1] that blocks
copying of !command to ".git/config" and sets default "none", you made
it harder to offer a mantainer decided default update behavior like
the one I described.

> The demand for this 'missing feature' which we call the 'floating
> submodules' model has been around for some time but until now we could
> convince people that its not a feature but you are actually loosing
> history information.
>

Putting your reasoning to the extreme consequences: why does not "git
clone" clone a dettached HEAD? In your workflow I should probably
never start coding from "master", but people frequently do instead.
Also, as you observed, it's possible to track submodule revision sha1
also on an attached HEAD. If I don't want anyone to track the revision
I can already set 'ignore' property.

My bottom line:
- For what I understand, detached HEAD it's a way to say "hey, you
have to stay on this commit. Also don't even think you can push to the
upstream branch". This sometimes can't be spurious, as in the use case
I wrote above: access control on the remote repositories should be
enough. I think maintainers should have the option to make developers
to clone a repository starting with an attached HEAD on the branch
suggested in submodule.$name.branch;
- "git submodule update" is missing a property to do automatically
"--remote". I think in the use case I wrote it's really handy to have
a "git submodule update" to act like this.

Thank you for reading and sorry for the long email :)

Greetings,
Francesco

[1] http://marc.info/?l=git&m=138610752125816&w=2
