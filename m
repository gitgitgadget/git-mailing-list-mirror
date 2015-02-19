From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Fri, 20 Feb 2015 00:29:30 +0100
Message-ID: <CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 00:29:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOaXc-00012t-8b
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 00:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbbBSX3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 18:29:51 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:64463 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbbBSX3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 18:29:51 -0500
Received: by mail-ob0-f180.google.com with SMTP id vb8so20672330obc.11
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 15:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=X/PQ4ftFJ0ADmSXi91cMVwJl4AUVKJbJByVj6QG0aag=;
        b=yHNTuK4+WpBHcr/WYmtWVtD6gny0WK499xyV6URDtiyjczj5/oEFiZuhjy2UMZzvOj
         MI7yt4xyxCD/ai7DzGI+rj8449rTWH43L35wAXFBDS+NwNud8KwWFnJFVYP6uOEDWtrt
         ZgVHuxaFUNRsuGdYpr1aXu050Ucp8ZVA1COjTb5wfOK9SWJQA1JutkJ9JNUUp2q0owN2
         w6tKP6FZF8f+Z/edGlGSilYjwRd5cltEA2bpGPuT/ubHFTKlHi50HDCs5cc1YVowg1Jn
         OG5eoM7Y6YcKmXFdjeL8hUo91EB9dRVX5bdcQloPeo3C7xlhUYB2bVO7bNZb2rH8D3yE
         dA1A==
X-Received: by 10.202.53.84 with SMTP id c81mr4340174oia.120.1424388590773;
 Thu, 19 Feb 2015 15:29:50 -0800 (PST)
Received: by 10.76.82.1 with HTTP; Thu, 19 Feb 2015 15:29:30 -0800 (PST)
In-Reply-To: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264119>

On Thu, Feb 19, 2015 at 10:26 PM, Stephen Morton
<stephen.c.morton@gmail.com> wrote:
> I posted this to comp.version-control.git.user and didn't get any response. I
> think the question is plumbing-related enough that I can ask it here.
>
> I'm evaluating the feasibility of moving my team from SVN to git. We have a very
> large repo. [1] We will have a central repo using GitLab (or similar) that
> everybody works with. Forks, code sharing, pull requests etc. will be done
> through this central server.
>
> By 'performance', I guess I mean speed of day to day operations for devs.
>
>    * (Obviously, trivially, a (non-local) clone will be slow with a large repo.)
>    * Will a few simultaneous clones from the central server also slow down
>      other concurrent operations for other users?
>    * Will 'git pull' be slow?
>    * 'git push'?
>    * 'git commit'? (It is listed as slow in reference [3].)
>    * 'git stautus'? (Slow again in reference 3 though I don't see it.)
>    * Some operations might not seem to be day-to-day but if they are called
>      frequently by the web front-end to GitLab/Stash/GitHub etc then
>      they can become bottlenecks. (e.g. 'git branch --contains' seems terribly
>      adversely affected by large numbers of branches.)
>    * Others?
>
>
> Assuming I can put lots of resources into a central server with lots of CPU,
> RAM, fast SSD, fast networking, what aspects of the repo are most likely to
> affect devs' experience?
>    * Number of commits
>    * Sheer disk space occupied by the repo
>    * Number of tags.
>    * Number of branches.
>    * Binary objects in the repo that cause it to bloat in size [1]
>    * Other factors?
>
> Of the various HW items listed above --CPU speed, number of cores, RAM, SSD,
> networking-- which is most critical here?
>
> (Stash recommends 1.5 x repo_size x number of concurrent clones of
> available RAM.
> I assume that is good advice in general.)
>
> Assume ridiculous numbers. Let me exaggerate: say 1 million commits, 15 GB repo,
> 50k tags, 1,000 branches. (Due to historical code fixups, another 5,000 "fix-up
> branches" which are just one little dangling commit required to change the code
> a little bit between a commit a tag that was not quite made from it.)
>
> While there's lots of information online, much of it is old [3] and with git
> constantly evolving I don't know how valid it still is. Then there's anecdotal
> evidence that is of questionable value.[2]
>     Are many/all of the issues Facebook identified [3] resolved? (Yes, I
> understand Facebook went with Mercurial. But I imagine the git team nevertheless
> took their analysis to heart.)

Anecdotally I work on a repo at work (where I'm mostly "the Git guy") that's:

 * Around 500k commits
 * Around 100k tags
 * Around 5k branches
 * Around 500 commits/day, almost entirely to the same branch
 * 1.5 GB .git checkout.
 * Mostly text source, but some binaries (we're trying to cut down[1] on those)

The main scaling issues we have with Git are:

 * "git pull" takes around 10 seconds or so
 * Operations like "git status" are much slower because they scale
with the size of the work tree
 * Similarly "git rebase" takes a much longer time for each applied
commit, I think because it does the equivalent of "git status" for
every applied commit. Each commit applied takes around 1-2 seconds.
 * We have a lot of contention on pushes because we're mostly pushing
to one branch.
 * History spelunking (e.g. git log --reverse -p -G<str>) is taking
longer by the day

The obvious reason for why "git pull" is slow is because
git-upload-pack spews the complete set of refs at you each time. The
output from that command is around 10MB in size for us now. It takes
around 300 ms to run that locally from hot cache, a bit more to send
it over the network.

But actually most of "git fetch" is spent in the reachability check
subsequently done by "git-rev-list" which takes several seconds. I
haven't looked into it but there's got to be room for optimization
there, surely it only has to do reachability checks for new refs, or
could run in some "I trust this remote not to send me corrupt data"
completely mode (which would make sense within a company where you can
trust your main Git box).

The "git status" operations could be made faster by having something
like watchman, there's been some effort on getting that done in Git,
but I haven't tried it. This seems to have been the main focus of
Facebook's Mercurial optimization effort.

Some of this you can "solve" mostly by doing e.g. "git status -uno",
having support for such unsafe operations (e.g. teaching rebase and
pals to use it) would be nice at the cost of some safety, but having
something that feeds of inotify would be even better.

It takes around 3 minutes to reclone our repo, we really don't care
(we rarely re-clone). But I thought I'd mention it because for some
reason this is important to Facebook and along with inotify were the
two major things they focused on.

As far as I know every day Git operations don't scale all that badly
with a huge history. They will a bit since everything will live in the
same pack file, and this'll become especially noticable when your
packfiles are being evicted out of the page cache.

However operations like "git repack" seem to be quite bad at handling
these sort of repos. It already takes us many GB of RAM to repack
ours. I'd hate to do the same if it was 10x as big.

Overall I'd say Git would work for you for a repo like that, I'd
certainly still take it over SVN any day. The main thing you might
want to try out is partitioning out any binary assets you may have.
Usually that's much easier than splitting up the source tree itself.

I haven't yet done this, but I was planning on writing something to
start archiving our tags (mostly created by [2]) along with
aggressively deleting branches in the repo. I haven't benchmarked that
but I think that'll make the "pull" operations much faster, which in
turn will make the push contention (lots of lemmings pushing to the
same ref) better since the pull && push window is reduced.

I do ask myself what we're going to do if we just keep growing and all
the numbers I cited will be multiplied by 10-50x. With the current Git
limitations on the git implementation I think we'd need to split the
repo. The main reason we don't do so is because we like being able to
atomically change a library and its users.

However there's nothing in the basic Git file repository format that
inherently limits Git from being smarter about large repos, it just
seems to be hard to implement with the way the current client is
structured. In particular nothing would stop a Git client from:

 * Partially cloning a history but still being able to push upstream.
You could just get a partial commit/tree/blob graph and fetch the rest
on-demand as needed.
 * Scaling up to multi TB or PB repos. We'd just have to treat blobs
as something fetched on-demand, sort of like what git-annex does, but
built-in. We'd also have to be less stupid about how we pack big blobs
(or not at all)
 * Being able to partially clone a Git working tree. You could ask the
server for the last N commit objects and what you need for some
subdirectory in the repo. Then when you commit you ask the server what
the other top-level tree objects you need to make a commit are.
 * Nothing in the Git format itself actually requires filesystem
access. Not having to deal with external things modifying the tree
would be another approach to what the inotify effort is trying to
solve.

Of course changes like that will require a major rehaul of the current
codebase, or another implementation. Some of those require much more
active client/server interaction than what we have now, but they are
possible, which gives me some hope for the future.

Finally, I'd like to mention that if someone here on-list is
interested in doing work on these scalability topics in Git we'd be
open to funding that effort on some contract basis. Obviously the
details would have to be worked out blah blah blah, but that came up
the last time we had discussions about this internally. Myself and a
bunch of other people at work /could/ work on this ourselves, but
we're busy with other stuff and would much prefer just to pay someone
to fix them.

1. https://github.com/avar/pre-receive-reject-binaries
2. https://github.com/git-deploy/git-deploy
