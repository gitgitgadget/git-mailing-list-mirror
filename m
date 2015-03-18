From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: Need help deciding between subtree and submodule
Date: Wed, 18 Mar 2015 18:04:19 -0500
Message-ID: <CAEtYS8T6STrgVW2AWkUKbxjeazXvLT2+0bRCA_L9hpUj2Ag4GA@mail.gmail.com>
References: <CAHd499DN1FUzxGYBtUmZ_gKcCvXWJdR6-6XYXsN6BRn0LVO84g@mail.gmail.com>
	<CAFOYHZCCUUjLnv3qpMBVPExR+4jdu09y5c8BcN8SNT0HWzqpHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 00:04:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYN0l-0003No-8K
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 00:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059AbbCRXEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 19:04:23 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36350 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362AbbCRXEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 19:04:21 -0400
Received: by lbblx11 with SMTP id lx11so18630045lbb.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IGt22Mt3MZqbACaLSoWU9DDQZFXIqbmFdvRoGJC+Wj8=;
        b=OkQFgVLa+vyLvy0EfyPZJHAR35VxDYbihGMm8Ccw+DlORZ86pd7VpIw2ZoI9WSbAxr
         FvowjF3m3+aTv4fmyNXuzXf5rNJEXv+QrauuYROdDlu5rXM+6EFYlg6OSiBooISQFDum
         H7w/LlBjA/wfOMqRellvdxqEiWCp+bQKoKj3U4AxxBhrxvWC086nAVs5ecQntH1OA08+
         pl7nWMWrqXjanEMA1xQS12t9nNBbapkeosIyKv3nCJvhVUj8PBvmK1rR6tjK9AlQjz6k
         qLmbywawMORj9otYWLxK4ftQwR0Qun6+V6CywrIuytW6tJTVQcUkIoiDOYneZOotkMZ7
         292A==
X-Received: by 10.112.89.71 with SMTP id bm7mr38836432lbb.20.1426719859678;
 Wed, 18 Mar 2015 16:04:19 -0700 (PDT)
Received: by 10.25.81.145 with HTTP; Wed, 18 Mar 2015 16:04:19 -0700 (PDT)
In-Reply-To: <CAFOYHZCCUUjLnv3qpMBVPExR+4jdu09y5c8BcN8SNT0HWzqpHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265773>

On Wed, Mar 18, 2015 at 3:20 AM, Chris Packham <judge.packham@gmail.com> wrote:
> My $0.02 based on $dayjob
>
> (disclaimer I've never used subtree)
>
> On Wed, Mar 18, 2015 at 11:14 AM, Robert Dailey
> <rcdailey.lists@gmail.com> wrote:
>> At my workplace, the team is using Atlassian Stash + git
>>
>> We have a "Core" library that is our common code between various
>> projects. To avoid a single monolithic repository and to allow our
>> apps and tools to be modularized into their own repos, I have
>> considered moving Core to a subtree or submodule.

$DAYJOB has actually tried both... with varying levels of success.  As
you note, subtree looks wonderful from a user perspective, but behind
the scenes, it does have issues.  In our case, subtree support was
modified into Gerrit, and this became cumbersome and difficult to
maintain (which is the reason we eventually dropped support for
subtree).  Submodules have more of a labor-intensive aspect, but
are far more obvious about what actions have been taken (IMHO).
Either way, both our developers' needs were satisfied: the code was
tracked cleanly, and there wasn't a configuration mismatch where
a dependency was able to change versions without implicit direction.

>
> Our environment is slightly different. Our projects are made up
> entirely of submodules, we don't embed submodules within a repo with
> actual code (side note: I know syslog-ng does so it might be worth
> having a look around there).
>
> Day to day development is done at the submodule level. A developer
> working on a particular feature is generally only touching one repo
> notwithstanding a little bit of to-and-fro as they work on the UI
> aspects. When changes do touch multiple submodules the pushes can
> generally be ordered in a sane manner. Things get a little complicated
> when there are interdependent changes, then those pushes require
> co-operation between submodule owners.

We've done both (all of the above? a hybrid approach?)... We've gone so
far to create 30 modules for every conceivable component, then tried to
work that way with submodule, and our developers quickly revolted as it
became too much of a maintenance burden.  The other direction (with
hugely monolithic code) is also problematic since the module boundaries
become blurred.  For us, usually cooperation between modules isn't so
difficult, but the problem comes about when attempting to merge the
changes.  Sometimes, it can take significant effort to ensure conflict-free
merges (going so far as to require "merge lock" emails to ask other
developers to hold off on merging commits until the change lands
completely and the project is stable).

>
> The key to making this work is our build system. It is the thing that
> updates the project repo. After a successful build for all targets (we
> hope to add unit/regression tests one day) the submodules sha1s are
> updated and a new baseline (to borrow a clearcase term) is published.
> Developers can do "git pull && git submodule update" to get the latest
> stable baseline, but they can also run git pull in a submodule if they
> want to be on the bleeding edge.
>
>> I tried subtree and this is definitely far more transparent and simple
>> to the team (simplicity is very important), however I notice it has
>> problems with unnecessary conflicts when you do not do `git subtree
>> push` for each `git subtree pull`. This is unnecessary overhead and
>> complicates the log graph which I don't like.
>>
>> Submodule functionally works but it is complicated. We make heavy use
>> of pull requests for code reviews (they are required due to company
>> policy). Instead of a pull request being atomic and containing any app
>> changes + accompanying Core changes, we now need to create two pull
>> requests and manage them in proper order. Things also become more
>> difficult when branching. All around it just feels like submodule
>> would interfere and add more administration overhead on a day to day
>> basis, affecting productivity.
>
> We do have policies around review etc. With submodules it does
> sometimes require engaging owners/reviewers from multiple
> repositories. Tools like Gerrit can help, particularly where multiple
> changes and reviewers are involved.

Conflicts are definitely going to be a difficulty with either subtree or
submodule (if multiple users could be changing the submodule), but
if you have additional tools, such as Gerrit to look out for, submodule
is the way to go since subtrees aren't supported within Gerrit. (Other
tools may support it better: I'm honestly not sure?)  That would be
my one word of caution: I don't know how well Stash supports subtree.

You are absolutely correct about the difficulty of integrating submodule
pull requests taking two steps.  This was an issue we worked hard
to mitigate here, but at the end of the day, the work is necessary.
Basically, we could also use a feature within Gerrit to automatically
bring up a specific branch of the "superproject" when the submodule
project on a certain branch changes, but this also rolls the dice a bit
since it bypasses any code review or CI step.

>
>> Is there a third option here I'm missing? If only that issue with
>> subtree could be addressed (the conflicts), it would be perfect enough
>> for us I think. I have done all the stackoverflow reading and research
>> I can manage at this point. I would really love some feedback from the
>> actual git community on what would be a practical solution and
>> structure here from a company perspective.
>
> There's the thing google use for android, I think it's called "repo".
> There's a few googlers around here so mybe one of them will chime in.

Repo is an interesting middle ground.  It does expect to interact with Gerrit,
I believe, and it handles the splitting of changes/commits and reassembling
them. (And, since it uses a manifest to track the submodules, it can handle
pointing to a specific commit, the latest commit on a branch, etc.) The rumor
I've heard around repo, however, is that there are plans to ensure parity
(as much as possible) in submodule and eventually remove the need for
repo.  But, this could also be a pipe dream...

Perhaps it's worth noting another possibility: using and releasing the core
library as an actual "library" which is tracked independently from the
remainder of the code, and integrated at build/run time by your build tools.
This would be closer to Maven's approach in the Java world, or a package
manager in a system environment.  Even in the embedded world, tools in
the Yocto project can handle gathering the dependencies in some sort of
"recipe." I know this is a somewhat idealistic view, however... after all,
there are reasons we're still using submodules ourself. :)

--Doug
