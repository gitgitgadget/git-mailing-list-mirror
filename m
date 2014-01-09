From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Thu, 09 Jan 2014 20:23:07 +0100
Message-ID: <52CEF71B.5010201@web.de>
References: <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com> <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com> <20140107194503.GA26583@odin.tremily.us> <20140107223858.GB10782@sandbox-ub> <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com> <20140108010504.GE26583@odin.tremily.us> <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com> <20140109000338.GM29954@odin.tremily.us> <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com> <52CE5E51.4060507@web.de> <20140109173218.GA8042@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 09 20:23:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1LCG-000565-SP
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 20:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbaAITXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 14:23:13 -0500
Received: from mout.web.de ([212.227.15.3]:54406 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbaAITXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 14:23:11 -0500
Received: from [192.168.178.41] ([84.132.136.118]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LgYi5-1VeK7M1wBh-00nx7L for <git@vger.kernel.org>;
 Thu, 09 Jan 2014 20:23:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140109173218.GA8042@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:JTPqOkZ349cQeSX40OvQlSgkJ1ajYig8B0OBZbDbRCjjtSVFwWI
 vd0O9nqvEDmDKS5TAlun9UHVbfKmRQ1QMNnnpFtqwizuYe4E8HSUvS7RDuGEkmbOyQB15A8
 zOMEMUNM8JRR+3+n8r9EPDnAM/VffpXbUim0qaqzUD8MwL61ZATjLXUMZyzs+jGx4UvtHPJ
 tsZPBAzxAGe6D/J6+M/dg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240266>

Am 09.01.2014 18:32, schrieb W. Trevor King:
> On Thu, Jan 09, 2014 at 09:31:13AM +0100, Jens Lehmann wrote:
>> Am 09.01.2014 02:09, schrieb Francesco Pretto:
>>> 2014/1/9 W. Trevor King <wking@tremily.us>:
>>>>
>>>> However, submodule.<name>.local-branch has nothing to do with remote
>>>> repositories or tracking branches.
>>>
>>> My bad: this means the feature is still not entirely clear to me.
>>>
>>>>
>>>>   [branch "my-feature"]
>>>>         remote = origin
>>>>         merge = refs/heads/my-feature
>>>>         [submodule "submod"]
>>>>             local-branch = "my-feature"
>>>>
>>>> and I don't think Git's config supports such nesting.
>>>>
>>>
>>> Aesthetically, It doesn't look very nice.
>>
>> And I'm not sure we even need that. What's wrong with having the
>> branch setting in the .gitmodules file of the my-feature branch?
>> The only problem I can imagine is accidentally merging that into
>> a branch where that isn't set, but that could be solved by a merge
>> helper for the .gitmodules file.
> 
> .gitmodules is fine so long as the config can live in the versioned
> tree.  Many (all?) .gitmodules settings can be overridden in
> .git/config.

With the exception of path, as that would make no sense at all.

>  However, the local-branch setting needs to be both
> per-submodule and per-superproject-branch, so .git/config doesn't work
> very well.  I think it's better to use something like my
> .git/modules/<submodule-name>/config implementation [1] to set this
> override.

Yes, the local branch should be set in the submodule's .git/config
to make operations done inside the submodule work seamlessly.

> This lack of per-superproject-branch overrides applies to all of the
> submodule.<name>.* settings, but you're unlikely to want an
> out-of-tree override for 'path' or a per-superproject-branch override
> for 'url', 'ignore', 'update', or 'chRecurseSubmodules'.

Unlikely it is not ;-) We do have people who set update=none in
the .git/config of the superproject for submodules they don't have
access to (and which is not necessary for their work). And it isn't
a "per-superproject-branch override" but a "per-superproject-branch
default" which can be overridden in .git/config (except for 'update',
but I intend to fix that).

>  Maybe folks
> would want per-superproject-branch overrides to 'branch', although I'd
> prefer we reuse branch.<name>.merge in the submodule's config for
> that [2].

But that might still have to be synced with what the superproject
wants. Maybe manually, maybe automatically on checkout. Dunno yet.

> On the other hand, maybe an in-tree .gitmodules is good enough, and
> folks who want a local override can just edit .gitmodules in their
> local branch?  I've never felt the need to override .gitmodules myself
> (for any setting), so feedback from someone who has would be useful.

That way these changes would propagate to others working on the same
branch when pushing, which I believe is a feature.

>>>> I can resuscitate that if folks want, but Heiko felt that my initial
>>>> consolidation didn't go far enough [2].  If it turns out that we're ok
>>>> with the current level of consolidation, would you be ok with
>>>> "non-checkout submodule.<name>.update" as the trigger [3]?
>>>
>>> For me it was ok with what you did:
>>> -------------------------------------------------
>>> if "just_cloned" and "config_branch"
>>> then
>>>      !git reset --hard -q"
>>> fi
>>> -------------------------------------------------
>>>
>>> So yes: at the first clone 'checkout' keeps attached HEAD, while
>>> 'merge' and 'rebase' attach to the branch.
>>
>> It have the impression that attaching the head to the given branch
>> for merge and rebase might be the sensible thing to do, but it
>> would be great to hear from users of merge and rebase if that
>> would break anything for them in their current use cases for these
>> settings.
> 
> Which local branch would you attach to before merging?  I think 'git
> submodule update' should always use the current submodule state
> (attached branch or detached HEAD) [3], and we should have a separate
> call that explicitly checked out the desired submodule branch [4].

Like we currently do with "git submodule update --remote" (where you
have to have an explicit command telling git when to advance the
branch)? Having a separate call that does something *after* a git
command is exactly the problem I'm trying to fix with recursive
update, so I'm not terribly excited ;-)

>>> If it's not the first clone, you should take no action (and your
>>> original patch was ok about this).
>>
>> I'm not sure this is the right thing to do, after all you
>> configured git to follow that branch so I'd expect it to be
>> updated later too, no? Otherwise you might end up with an old
>> version of your branch while upstream is a zillion commits
>> ahead.
> 
> Non-clone updates should not change the submodule's *local* branch
> *name*.  They should change the commit that that branch references,
> otherwise 'git submodule update' would be a no-op ;).

Okay, I seem to have misunderstood that. But what happens when the
branch setting in .gitmodules changes, shouldn't that be updated?

>> First I'd like to see a real consensus about what exactly should
>> happen when a branch is configured to be checked out (and if I
>> missed such a summary in this thread, please point me to it ;-).
> 
> I don't think we have a consensus yet.  A stand-alone outline of my
> current position is in my v3 RFC [5], but I don't have any buy-in yet
> ;).

I'll volunteer to prepare a table explaining the different modes
in my github wiki. Will scan this thread and your pointers for input
and will come back soon when I have something ready.

>> And we should contrast that to the exact checkout and floating
>> branch use cases.
> 
> With my v3 series, there are no more detached HEADs.  Folks using
> checkout updates get a local master branch.  I do not change any of
> the exact checkout (superproject gitlinked sha1) vs. floating
> (subproject's remote submodule.<name>.branch via 'update --remote')
> logic, because that already works well.  The problem is the local
> branch handling, not the update/integration logic.

Ok. Maybe we could use the "<remote>:<local>" notation to store both
remote and local branch in a single setting?

>> So what should happen on initial clone,
> 
> For 'add', clone the command line URL and create a new branch 'master'
> pointing at the commit referenced by the remote's HEAD (or other
> branch with --branch).
> 
> For 'update', do the same, except use a local-branch setting to
> determine the name for the local branch, falling back to 'master' if
> it is not set.

Good.

>> later updates,
> 
> The same thing that currently happens, with the exception that
> checkout-style updates should use reset to update the
> currently-checked out branch (or detached-HEAD), instead of always
> detaching the HEAD.

Won't the user loose any modifications to his local branch here?

>> updates where the local and the remote branch diverged,
> 
> The same thing that currently happens.  For local (non --remote)
> updates, the integrated branch is the superproject's gitlinked sha1.
> For --remote updates, the integrated branch is the remote subproject's
> submodule.<name>.branch.  We integrate that with the
> currently-checked-out local branch (or detached HEAD) using the user's
> preferred submodule.<name>.update strategy.

And for checkout I can easily overwrite the upstream branch with
my local changes?

>> when superproject branches are merged (with and without conflicts),
> 
> I don't think this currently does anything to the submodule itself,
> and that makes sense to me (use 'submodule update' or my 'submodule
> checkout' if you want such effects).  We should keep the current logic
> for updating the gitlinked $sha.  In the case that the
> .gitmodule-configured local-branches disagree, we should give the
> usual conflict warning (and <<<===>>> markup) and let the user resolve
> the conflict in the usual way.

For me it makes lots of sense that in recursive checkout mode the
merged submodules are already checked out (if possible) right after
a superproject merge, making another "submodule update" unnecessary
(the whole point of recursive update is to make "submodule update"
obsolete, except for "--remote").

>> on a rebase in the superproject and so on.
> 
> Same as the merge case.  Why would configuring a preferred
> local-branch that only affects checkout (and the initial clone) have
> anything to do with rebases and merges?

Because teaching --recurse-submodules to checkout is only one part,
in the full recursive update series every work tree manipulating
command (like rebase and merge) will update submodules. So it is
not only affecting checkout, but a lot of other commands too.

>> After that we can discuss about how to implement them (even though I
>> believe we won't need a new submodule command at the end of this
>> process, simply because if it isn't configurable we cannot teach git
>> checkout and friends to do that automatically for us later).
> 
> I think it is configurable, and I have an implementation that works
> (modulo bugs) [5].  I think we should teach 'git checkout
> --recurse-submodules' this logic, and then we can drop my 'git
> submodule checkout' entirely.

Okay, I have no problem with a proof of concept implementation to
play around with.

>> And from reading this discussion I believe we need another value for
>> the ignore option which only ignores changes to the SHA-1 but not to
>> work tree modifications of a submodule work tree relative to its HEAD
>> (or make that two: another one which ignores untracked files too and
>> only shows modification of tracked files). Otherwise users of the
>> floating or attached model can easily miss submodule modifications.
> 
> I am ignore-agnostic ;).  Do whatever you like here.

I was hoping someone else would jump in to do that, as I'm rather
busy with the recursive checkout topic ;-)
