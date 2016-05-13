From: Stefan Beller <sbeller@google.com>
Subject: Re: Improve initial setup of submodules
Date: Fri, 13 May 2016 11:13:28 -0700
Message-ID: <CAGZ79kaJy40DPC4wzyvzPr2myn3SStyaqeLoATMmWXXUnbp8Fw@mail.gmail.com>
References: <87posplv7t.fsf@bernoul.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonas Bernoulli <jonas@bernoul.li>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 13 20:13:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Hag-00008x-Ni
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 20:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbcEMSNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 14:13:31 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35040 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbcEMSNa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 14:13:30 -0400
Received: by mail-ig0-f176.google.com with SMTP id bi2so17220859igb.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ETcLtsaKSx+956Kde1uDdEOZ556fvh5bisefVYpJ4N0=;
        b=Vh+heyzFCn4lqD3NB4xP5akQQSrNLmardlkfnXp2icUF6kz9MHaHh13FrCwRW9+GNG
         j+55+9ejbT8oblz5foJZ2z8U1F0ndMOHa+IG6eFnyPyMuzCux7b/WRSxudQldRQNedH7
         zz4mp6AbY7ll4au8Pb6p4C6F0+YUtJ+E55sjn0tyKozKPPOcB3V+fCFQU3OAvQsTQpVx
         TLDxoRWBmXovn2weZYEQwaP80tmXkYnoRm8CZqh99AX5xarRDw6arQtNEXYnLQrUz8Bz
         HxYIHkE3+vDz6kixNnV86oySO56Mc6R4HsMkP7nhJflePmv3ckzwMKwAFlHnZT6V8E7K
         zKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ETcLtsaKSx+956Kde1uDdEOZ556fvh5bisefVYpJ4N0=;
        b=hzWfkInVJ7TQwkqO0l/Dofm+hD8/0em5MziFmXodYylgiqIv3ZJaIlR0FZFWCkZTfS
         lJEDvYF4b0L4DdkvRdkTnseAeabvJKwnoPZurp8ryuEW3VW3U9NZJaFm8t65LDc60ntW
         FGsY/4Zgh+C8Ezf8rqAYlNNlYvMbi/Oey3f1SE0wFLChFyLJfy6hTQDHKz0Q6B4+z1mo
         N2AEU0jjy29zm/sWwVG/i/9iSjkZPEgFPCkaDc2Y4FLtZ1EKAiFvQePiw5ZcEsFI1WFT
         +tHCmLrY5nLqnI9wvBEIWCL04RHjb6L3BhjbDx7s37IEHWcnqkrUD14BZYZMmVG2PPNX
         XRAw==
X-Gm-Message-State: AOPr4FXd1PywGj8i9UDhEfVcYYz5jV8dcY8AOJbpyWu2/48e/NcrZQC8Daw8ZrhDoyhCOqWdXo/RPOR8iObo0WBl
X-Received: by 10.50.29.45 with SMTP id g13mr1671045igh.93.1463163208909; Fri,
 13 May 2016 11:13:28 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 13 May 2016 11:13:28 -0700 (PDT)
In-Reply-To: <87posplv7t.fsf@bernoul.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294553>

+cc Heiko and Jens as they are submodule experts.

On Fri, May 13, 2016 at 10:32 AM, Jonas Bernoulli <jonas@bernoul.li> wrote:
> Hello,
>
> Currently "git submodule update" appears to be optimized for updating
> existing submodules - which isn't surprising given its name.  However it
> is also used for the "initial setup" of submodules, i.e. right after
> running "git submodule init" or with the "--init" argument.
>
> Below you find a list of features I wish existed during the initial
> setup.  It might make sense to add an additional subcommand named
> e.g. "bootstrap" or "setup" to accomplish this, but maybe a
> "--bootstrap" argument might also suffice.

Would the "--bootstrap" be an argument to "submodule init" ?
So "submodule update --init" is the same as "submodule init --bootstrap" ?
How about "submmodule init --update" ?

>
> The goal is for a submodule to be "ready for use" after running "git
> submodule init" and "git submodule bootstrap"/"git submodule update
> --bootstrap".

Ideally you'd only use the submodule command for specifics on submodules.
e.g. add a new submodule, configure a submodule update strategy or such.
This is similar to the "remote command", which ought to be used only for remote
configuration etc. Historically there is "remote update", but nowadays the
suggested way would rather be "git fetch/pull"

"git clone" has "--recurse-submodules", which does the bootstrapping for you.
(i.e. run submodule update --init).

Currently there are 3 states for submodules:
 (1) not initialized
 (2) initialized but not checked out
 (3) checked out

To go from (1) to (2) you'd use "submodule init"
for going (2) to (3) you'd use "submodule update"
Going from (3') to (3) you'd also use "submodule update".
(e.g. checking out the latest HEAD)

To go back from (3) to (2), you would use "rm -rf submodule" (no
git command available). Heiko recently proposed another command
to go from either (3) to (2) as  "deinit --light" IIUC[1].

To go back from either (3) or (2) to (1) you can use "submodule deinit [-f]".

The state (2) is a bit confusing I would think as it's somewhere in the middle
of "have" or "have not", so an easy command to go from (1) to (3) would
be nice as then (2) becomes less exposed to users.

[1] http://thread.gmane.org/gmane.comp.version-control.git/293478/focus=294009


>
> * Add additional remotes.
>
>   "submodule update" can only add a single remote, but a submodule might
>   require additional remotes, i.e. "origin" and "my-fork".  It's likely
>   that "my-fork" contains commits that are not available from "origin"
>   and that such a commit is tracked as the HEAD of the submodule.
>
>   When that is the case and if "submodule.<name>.url" points to the
>   upstream repository, then "submodule update <name>" would fail because
>   the commit is not available.
>
>   To deal with that the user would have to set "url" to the url of the
>   fork repository.  But then "submodule update" would name that remote
>   "origin".  And the user would then have to rename that to "my-fork"
>   and also add the real "origin".

So rather fetching from multiple sources until we find the right commit,
but pushing to only one?

>
>   It would be nice if it were possible to configure additional remotes
>   in .gitmodules or elsewhere and if "submodule bootstrap/update" could
>   be told to setup these remotes before attempting to checkout the
>   tracked commit.
>
>   Since Git doesn't support nested config sections I am unsure what
>   would be the best way to store this information in ".gitmodules".  A
>   hacky implementation could use something like this:
>
>     [submodule "example"]
>             url = git://example.com/upstream.git
>             remote = my-fork git@example.me:my-fork.git
>             remote = third-party git://example.com/with-patches.git
>
>   Of course Git usually doesn't use a single variable to define multiple
>   values, so that's not really an option except while experimenting.

This is not hacky I would think. It's the same as git push urls work[2]

[2] http://stackoverflow.com/a/14290145

>
>   Another alternative might be to use separate files located in a
>   directory ".gitmodule.d", e.g. the remotes of the module
>   ".gitmodule.d/example" could contain:
>
>     [remote "origin"]
>             url = git://example.com/upstream.git
>     [remote "my-fork"]
>             url = git@example.me:my-fork.git
>     [remote "third-party"]
>             url = git://example.com/with-patches.git

We already have so many .git{stuff} things (the .git directory,
.gitignore, .gitattributes, .gitmodules}, so I would suggest not
adding more of that.

>
> * Attach HEAD.
>
>   I think it makes sense for "submodule update" to default to using
>   "checkout" as "submodule.<name>.update" method, since it is the safest
>   option which doesn't do any harm.

If the submodule is in detached HEAD state and you checkout another
commit, you may loose commits?

>
>   It's also nice that there are some alternatives, "rebase", "merge" and
>   "none", and even support for custom commands. (By the way "ff-only"
>   and "ff-only-else-checkout" would be nice to have.)
>
>   However neither "rebase" nor "merge" are suitable during bootstrap.
>
>   During "submodule bootstrap" (but not "submodule update") a "rewind"
>   variant might make sense.  During bootstrap, after cloning but before
>   checkout/merge/update, we might have history like this:
>
>     A---B---C origin/master, master -> origin/master, HEAD
>         ^
>         |
>         commit recorded for submodule
>
>   The "rewind" update variant (actually boostrap variant) would then do
>   a "git reset --hard B", resulting in:
>
>     A---B---C origin/master
>         ^
>         |
>         master > origin/master, HEAD, commit recorded for submodule
>
>   Of course the situation might be more complicated:
>
>     A---B---C origin/master, master -> origin/master, HEAD
>         \
>          D---E---F my-fork/master
>              ^
>              |
>              commit recorded for submodule
>
>   Here "rewind" would fail because "master" cannot be rewound to E.  In
>   some cases that might be the right thing to do, but another
>   alternative would be a "reset" variant, which does a "git reset
>   --hard" even if the recorded commit isn't an ancestor of the checked
>   out branch.
>
>     A---B---C origin/master, HEAD
>         \
>          D---E---F my-fork/master
>              ^
>              |
>              master -> origin/master, HEAD, commit recorded for submodule
>
>   Other, smarter, variants could be implemented, but the key point I am
>   trying to make is that I would like to use diffent "update methods"
>   during "submodule bootstrap" and "submodule update", and that "rewind"
>   and "reset" should be available during "boostrap" by default.
>
> * Preserve additional information.
>
>   If a mechanism such as the ".gitmodules.d/<name>" file I suggested
>   above were used to add additional remotes, then that could be used to
>   distribute other information from ".git/modules/<name>/config".  This
>   could also be used by the various "bootstrap" variants.
>
>   As I have shown above ".gitmodules.d/example" could for example
>   contain this:
>
>     [remote "origin"]
>             url = git://example.com/upstream.git
>     [remote "my-fork"]
>             url = git@example.me:my-fork.git
>     [remote "third-party"]
>             url = git://example.com/with-patches.git
>
>   Here "origin.url" would be redundant because the same value is already
>   set in "submodule.example.url".  However this could be used to allow
>   setting an alternative remote name:
>
>   (in .gitmodules)
>
>     [submodule "example"]
>             remote = upstream
>
>   (in .gitmodules.d/example)
>
>     [remote "upstream"]
>             url = git://example.com/upstream.git
>
>   But that's just a minor detail.  What I really would like to be able
>   to do is this:
>
>   (in .gitmodules)
>
>     [submodule "example"]
>             remote = origin
>             bootstrap = rewind-either
>
>   (in .gitmodules.d/example)
>
>     [remote "origin"]
>             url = git://example.com/upstream.git
>     [remote "my-fork"]
>             url = git@example.me:my-fork.git
>     [branch "master"]
>             remote = origin
>             merge = refs/heads/master
>             pushRemote = my-fork

both of .gitmodules and .gitmodules.d/example are part of the tree?


>
>   With such a setup the second example from above makes more sense:
>
>     A---B---C origin/master, HEAD
>         \
>          D---E---F my-fork/master
>              ^
>              |
>              master -> origin/master, HEAD, commit recorded for submodule
>
>   And a new bootstrap variant "rewind-either" could make sense: if the
>   commit recorded for the submodule is reachable from either the
>   upstream branch *or* from "branch.<name>.pushRemote", then rewind,
>   else checkout a detached HEAD.
>
>   Additionally the settings from ".gitmodules.d/<name>" should be copied
>   to ".git/modules/<name>/config", just like those from ".gitmodules"
>   are copied to ".git/config":
>
>   (in .git/modules/example/config)
>
>     [remote "origin"]
>             url = git://example.com/upstream.git
>             fetch = +refs/heads/*:refs/remotes/origin/*
>     [remote "my-fork"]
>             url = git@example.me:my-fork.git
>             fetch = +refs/heads/*:refs/remotes/my-fork/*
>     [branch "master"]
>             remote = origin
>             merge = refs/heads/master
>             pushRemote = my-fork
>
>   Most of these variables are "copied" by adding the remotes, but
>   "branch.master.pushRemote" would have to be explictily set.
>
>   It should also be possible to checkout another branch by setting
>   "submodule.<name>.branch", and to automatically create additional
>   branches by adding additional "branch" sections to
>   ".gitmodules.d/<name>".
>
>   In addition to "branch.<name>.pushRemote" it would be nice if
>   "remote.pushDefault" could be set in ".gitmodules.d/<name>".
>
> So what do you think?  Is there a change that such features could be
> added to Git (using the suggested mechanisms or something else)?

The selling point is not obvious to me, yet. (Why is that better,
which feature makes the big difference?)

Thanks for starting a discussion!

Stefan

>
>   Best regards,
>   Jonas Bernoulli
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
