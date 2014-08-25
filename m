From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Relative submodule URLs
Date: Mon, 25 Aug 2014 08:48:45 -0500
Message-ID: <CAHd499D+xAKidgah6xEVTfS8FQb7zJeo-rd=Awo5AyHKpqy_cA@mail.gmail.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
	<20140818205505.GA20185@google.com>
	<CAHd499DVf4N3Y6m5qoiy-WQGX4K54umefRzehZMsrxiWbaiZ=g@mail.gmail.com>
	<53F76907.1090904@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 15:48:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLudf-00051w-NA
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 15:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbaHYNsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 09:48:47 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:33904 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbaHYNsq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 09:48:46 -0400
Received: by mail-vc0-f175.google.com with SMTP id ik5so14974021vcb.20
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/DgCIbhSyWITzmZu/rPfkdg9ZsSXnBYoB3J+1iaJdQY=;
        b=Ke7K5HjYYxDUtPEtUgRM2367FgB7m5I2MbNfard6LhSJtg9UojRBglI310gnKXkULn
         OlxFrCFsDF+sYDh1+INfCTtDMKZhRXp41I8B9arO7Q6fWBbiXLx1bTdQ5385sIEuZtDD
         nhpRfTx0tHZI1EHAOzCDyQoTMLP+CzP4f6XpEQcilVxlbOrXj9kTHCGhC1JSrwHjscZd
         wT9oEyVt/jSiXvyMK/iJ0rQ8uaonfr7fr2M4Nb4dcaKphMlhh42fmAKAZYm7Lhne7a3b
         yBnj1XELI6P/Wg3EFsZamQ0aZsD96lEcqU9Fltzj9K728iyvaIUDztraHjY7hprI+1NW
         RoAg==
X-Received: by 10.221.24.135 with SMTP id re7mr5596988vcb.53.1408974525648;
 Mon, 25 Aug 2014 06:48:45 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Mon, 25 Aug 2014 06:48:45 -0700 (PDT)
In-Reply-To: <53F76907.1090904@xiplink.com>
X-Google-Sender-Auth: rE1mtYKXR41GOrufNAo5IVUfYFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255825>

On Fri, Aug 22, 2014 at 11:00 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> A couple of years ago I started to work on such a thing ([1] [2] [3]), mainly
> because when we tried to change to relative submodules we got bitten when
> someone used clone's -o option so that his super-repo had no "origin" remote
> *and* his was checked out on a detached HEAD.  So get_default_remote() failed
> for him.
>
> I didn't have time to complete the work -- it ended up being quite involved.
>  But Junio did come up with an excellent transition plan [4] for adopting a
> default remote setting.
>
> [1] (v0) http://thread.gmane.org/gmane.comp.version-control.git/200145
> [2] (v1) http://thread.gmane.org/gmane.comp.version-control.git/201065
> [3] (v2) http://thread.gmane.org/gmane.comp.version-control.git/201306
> [4] http://article.gmane.org/gmane.comp.version-control.git/201332
>
>> I think you're on the right path. However I'd suggest something like
>> the following:
>>
>> [submodule]
>>     remote = <remote_for_relative_submodules> (e.g. `upstream`)
>
> I think remote.default would be more generally useful, especially when
> working with detached checkouts.

Honestly speaking I don't use default.remote, even now that I know
about it thanks to the discussion ongoing here. The reason is that
sometimes I push my branches to origin, sometimes I push them to my
fork. I like explicit control as to which one I push to. I also sync
my git config file to dropbox and I use it on multiple projects and
platforms. I don't use the same push destination workflow on all
projects. It seems to get in the way of my workflow more than it
helps. I really only ever have two needs:

1. Push explicitly to my remote (e.g. `git push fork` or `git push origin`)
2. Push to the tracked branch (e.g. `git push`)

I'm also not sure how `push.default = simple` conflicts with the usage
of `remote.default`, since in the tracked-repo case, you must
explicitly specify the source ref to push. Is this behavior documented
somewhere?

> (For the record, I would also be happy if clone got rid of its -o option and
> "origin" became the sacred, reserved remote name (perhaps translated into
> other languages as needed) that clone always uses no matter what.)
>
>> [branch.<name>]
>>     submoduleRemote = <remote_for_relative_submodule>
>
> If I understand correctly, you want this so that your branch can be a fork of
> only the super-repo while the submodules are not forked and so they should
> keep tracking their original repo.

That's correct. But this is case-by-case. Sometimes I make a change
where I want the submodule forked (rare), most times I don't.
Sometimes I can get away with pushing changes to the submodule and
worrying about it later since I know the submodule ref won't move
forward unless someone does update --remote (which isn't often or only
done as needed).

> To me this seems to be going in the opposite direction of having branches
> recursively apply to submodules, which I think most of us want.
>
> A branch should fork the entire repo, including its submodules.  The
> implication is that if you want to push that branch somewhere, that somewhere
> needs to be able to accept the forks of the submodules *even if those
> submodules aren't changed in your branch* because at the very least the
> branch ref has to exist in the submodules' repositories.

There are many levels on which this can apply. When it comes to
checkouts and such, I agree. However, how will this impact *creating*
branches? What about forking? Do you expect submodule forking &
branching to be automatic as well? Based on your description, it seems
so (although a new branch doesn't necessarily have to correspond to a
new fork, unless I'm misunderstanding you). This seems difficult to
do, especially the forking part since you would need an API for this
(Github, Atlassian Stash, etc), unless you are thinking of something
clever like local/relative forks.

However the inconvenience of forking manually isn't the main reason
why I avoid forking submodules. It's the complication of pull
requests. There is no uniformity there, which is unfortunate.
Recursive pull requests are something outside the scope of git, I
realize that, but it would still be nice. However the suggestion you
make here lays the foundation for that I think.

> With absolute-path submodules, the push is a simple as creating the branch
> ref in the submodules' "home" repositories -- even if the main "somewhere"
> you're pushing to isn't one of those repositories.
>
> With relative-path submodules, the push's target repo *must* also have the
> submodules in their proper places, so that they can get updated.
> Furthermore, if you clone a repo that has relative-path submodules you *must*
> also clone the submodules.
>
> Robert, I think what you'll say to this is that you still want your branch to
> track the latest submodules updates from their "home" repository. (BTW, I'm
> confused with how you're using the terms "upstream" and "origin".  I'll use
> "home" to refer to the repository where everything starts from, and "fork"
> for the repository that your branch tracks.)  Well, you get the updates you
> want when your branch tracks a ref in the "home" repository.  But when your
> branch starts tracking a ref in another "fork" repository then you'll get the
> submodule updates in that ref's history from that "fork" repository.

My usage of 'upstream' and 'origin' were wrong. I don't use upstream
anymore, based on the explanations I've received here. I use the
following now:

origin = my central repository (authoritative)
fork = My fork of the central repo

I like your idea of forking/branching on submodules being recursive
based on the super repo, but I just don't see how this is possible.
How would git tell github to fork, for example? And would that also
work on Stash?

> Once your branch is tracking the "fork" repository, if you do a pull you
> won't get any submodule updates because the fork's branch hasn't changed.
> You need to fetch (recursively) from the "home" repo to get the submodule
> updates (assuming one of the "home" repo's branches has updated its
> submodules).  Then, with your branch checked out in the super-repo, if you
> check out the latest refs in your submodules git will tell you that you have
> uncommitted changes in your branch.  The correct way to get submodule updates
> into your branch is to commit them.  Even though you're doing a pull/rebase,
> there's nothing to rebase onto in the "fork" repository that has the updated
> submodules.

I like your ideas, assuming they are technically possible. They sound
like great solutions for the long term. However for now, the whole
process of working with remotes is very confusing. At first it was
complicated when it came to triangle workflow. Mostly because the way
you set push.default changes completely between the two, especially
when combined with various workflows.

Add on top of that the complexity of workflows for submodules, and it
becomes a complete mess. Maybe for you guys who actively develop and
understand git's internals it isn't so bad. However I don't have that
domain knowledge, so I only have a "user" perspective on the matter.
`remote.default` sounds nice but how do I use it based on my response
in my first paragraph above?

Thanks guys, this is great discussion.
