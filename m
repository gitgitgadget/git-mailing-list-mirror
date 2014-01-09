From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Thu, 09 Jan 2014 22:40:52 +0100
Message-ID: <52CF1764.40604@web.de>
References: <20140107194503.GA26583@odin.tremily.us> <20140107223858.GB10782@sandbox-ub> <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com> <20140108010504.GE26583@odin.tremily.us> <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com> <20140109000338.GM29954@odin.tremily.us> <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com> <52CE5E51.4060507@web.de> <20140109173218.GA8042@odin.tremily.us> <52CEF71B.5010201@web.de> <20140109195522.GT29954@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 09 22:41:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1NLY-0000CO-FF
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 22:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757893AbaAIVk4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jan 2014 16:40:56 -0500
Received: from mout.web.de ([212.227.15.4]:54774 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757571AbaAIVky (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 16:40:54 -0500
Received: from [192.168.178.41] ([84.132.136.118]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lm4PJ-1VS2Wi0S4P-00ZieW for <git@vger.kernel.org>;
 Thu, 09 Jan 2014 22:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140109195522.GT29954@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:Snnf81RQ6D+qV0ePiMy8jAcmwD3a6AhkzSlwk6YR2oxGCQ6DtpM
 6yaVujeVngopPddjFrNMMbBBpJ896x4sKZQdt0iWPgA3I/t5KvJw4/s4pouabJCpDu4vP5W
 /rVg+vB9PF0GZqZ1kqaRLWuiXWPYOANBfxl8tJDU8b8/PRULBayE4B6kNdtx4mkHPbs6XLq
 ped2xD+cAlS6HsZkG3mbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240274>

Am 09.01.2014 20:55, schrieb W. Trevor King:
> On Thu, Jan 09, 2014 at 08:23:07PM +0100, Jens Lehmann wrote:
>> Am 09.01.2014 18:32, schrieb W. Trevor King:
>>>  However, the local-branch setting needs to be both
>>> per-submodule and per-superproject-branch, so .git/config doesn't w=
ork
>>> very well.  I think it's better to use something like my
>>> .git/modules/<submodule-name>/config implementation [1] to set this
>>> override.
>>
>> Yes, the local branch should be set in the submodule's .git/config
>> to make operations done inside the submodule work seamlessly.
>=20
> Once you're inside the submodule my local-branch setting shouldn't
> matter, because it just connects superproject branches with submodule
> branches. The submodule's config is just a convenient out-of-tree
> place to store per-submodule overrides.

Now I get it, you want to be able to override a submodule branch for
every superproject branch. I'm not sure I'd add that in the first
iteration though, as it seems to add quite some complexity and I'm
not convinced yet users really need it (but I won't object when we
find real world use cases for that).

>>> This lack of per-superproject-branch overrides applies to all of th=
e
>>> submodule.<name>.* settings, but you're unlikely to want an
>>> out-of-tree override for 'path' or a per-superproject-branch overri=
de
>>> for 'url', 'ignore', 'update', or 'chRecurseSubmodules'.
>>
>> Unlikely it is not ;-) We do have people who set update=3Dnone in
>> the .git/config of the superproject for submodules they don't have
>> access to (and which is not necessary for their work).
>=20
> That is not a per-superproject-branch override.  local-branch is the
> only per-submodule config I can think of where I can imagine a sane
> person actually wanting an out-of-tree per-superproject-branch
> override.

Oops, again I managed to miss the per-superproject*-branch* part.

>> And it isn't a "per-superproject-branch override" but a
>> "per-superproject-branch default" which can be overridden in
>> .git/config (except for 'update', but I intend to fix that).
>=20
> You're talking about .gitmodules vs. .git/config here, but for
> local-branch, I'm talking about a fallback chain like [1]:
>=20
> 1. superproject.<superproject-branch>.local-branch in the submodule's
>    config (superproject/.git/modules/=E2=89=A4submodule-name>/config)=
=2E
> 2. submodule.<submodule-name>.local-branch in the superproject's
>    config (.git/config).
> 3. submodule.<submodule-name>.local-branch in the superproject's
>    .gitmodules file.
> 4. default to 'master'
>=20
> Only #1 is a new idea.

Thanks for the explanation, now I understand what you're aiming at.

>>> On the other hand, maybe an in-tree .gitmodules is good enough,
>>> and folks who want a local override can just edit .gitmodules in
>>> their local branch?  I've never felt the need to override
>>> .gitmodules myself (for any setting), so feedback from someone who
>>> has would be useful.
>>
>> That way these changes would propagate to others working on the same
>> branch when pushing, which I believe is a feature.
>=20
> Sure.  Unless they don't want to propagate them, at which point they
> use an out-of-tree override masking the .gitmodules value.  The
> question is, would folks want local overrides for local-branch (like
> they do for submodule.<name>.update), or not?  Since it's easy to do
> [1], I don't see the point of *not* supporting per-superproject-branc=
h
> overrides.

Unless actual use cases are shown I'd vote for YAGNI here. A new
config option means considerable maintenance burden, no matter how
easy it is to implement in the first place.

>>>> It have the impression that attaching the head to the given
>>>> branch for merge and rebase might be the sensible thing to do,
>>>> but it would be great to hear from users of merge and rebase if
>>>> that would break anything for them in their current use cases for
>>>> these settings.
>>>
>>> Which local branch would you attach to before merging?  I think
>>> 'git submodule update' should always use the current submodule
>>> state (attached branch or detached HEAD) [3], and we should have a
>>> separate call that explicitly checked out the desired submodule
>>> branch [4].
>>
>> Like we currently do with "git submodule update --remote" (where you
>> have to have an explicit command telling git when to advance the
>> branch)? Having a separate call that does something *after* a git
>> command is exactly the problem I'm trying to fix with recursive
>> update, so I'm not terribly excited ;-)
>=20
> I'm all for rolling my 'git submodule checkout' into 'git checkout
> --recurse-submodules' [2].  It was just faster to mock up in shell
> while we decide how it should work.

Sure. As I said that's perfectly fine for testing this approach,
but we should do that right in "git checkout" and friends and not
add yet another submodule command.

>>>>> If it's not the first clone, you should take no action (and your
>>>>> original patch was ok about this).
>>>>
>>>> I'm not sure this is the right thing to do, after all you
>>>> configured git to follow that branch so I'd expect it to be
>>>> updated later too, no? Otherwise you might end up with an old
>>>> version of your branch while upstream is a zillion commits
>>>> ahead.
>>>
>>> Non-clone updates should not change the submodule's *local* branch
>>> *name*.  They should change the commit that that branch references,
>>> otherwise 'git submodule update' would be a no-op ;).
>>
>> Okay, I seem to have misunderstood that. But what happens when the
>> branch setting in .gitmodules changes, shouldn't that be updated?
>=20
> Not by 'git submodule update'.  If there are no out-of-tree overrides
> and the user calls 'git submodule checkout' with a new local-branch i=
n
> .gitmodules, *that* should checkout a new submodule branch.

Hmm, but isn't "submodule sync" the command that copies changed
upstream config values (currently only the url) into the local config?
Then a subsequent "submodule update" could do the actual checkout.

>>>> First I'd like to see a real consensus about what exactly should
>>>> happen when a branch is configured to be checked out (and if I
>>>> missed such a summary in this thread, please point me to it ;-).
>>>
>>> I don't think we have a consensus yet.  A stand-alone outline of my
>>> current position is in my v3 RFC [5], but I don't have any buy-in y=
et
>>> ;).
>>
>> I'll volunteer to prepare a table explaining the different modes
>> in my github wiki. Will scan this thread and your pointers for input
>> and will come back soon when I have something ready.
>=20
> Thanks :).

A first - rather basic - attempt can be seen at:

   https://github.com/jlehmann/git-submod-enhancements/wiki/Submodule-m=
odes

Input of any kind is very welcome!

>>>> And we should contrast that to the exact checkout and floating
>>>> branch use cases.
>>>
>>> With my v3 series, there are no more detached HEADs.  Folks using
>>> checkout updates get a local master branch.  I do not change any of
>>> the exact checkout (superproject gitlinked sha1) vs. floating
>>> (subproject's remote submodule.<name>.branch via 'update --remote')
>>> logic, because that already works well.  The problem is the local
>>> branch handling, not the update/integration logic.
>>
>> Ok. Maybe we could use the "<remote>:<local>" notation to store both
>> remote and local branch in a single setting?
>=20
> Meh :p.  I'm fine with (remote-)branch and local-branch as separate
> settings, or a single combined '<remote>:<local>' setting.  However, =
I
> think the local branch name is going to be more closely associated
> with the superproject branch than with the subproject's remote branch=
,
> and expect folks to want to override the local-branch on a
> per-superproject-branch basis much more often then they'll override
> the latter.

Okay. This is a detail we can decide later.

>>>> later updates,
>>>
>>> The same thing that currently happens, with the exception that
>>> checkout-style updates should use reset to update the
>>> currently-checked out branch (or detached-HEAD), instead of always
>>> detaching the HEAD.
>>
>> Won't the user loose any modifications to his local branch here?
>=20
> They just called for a checkout-style update, so yes.  If they want t=
o
> keep local modifications, chose an integration mode that preserves
> local changes.

Hmm, as current "submodule updates" already makes it too easy to
loose commits, this does not look right to me. I'd prefer to stop
at that point and tell the user what he can do to solve the conflict.

>>>> updates where the local and the remote branch diverged,
>>>
>>> The same thing that currently happens.  For local (non --remote)
>>> updates, the integrated branch is the superproject's gitlinked sha1=
=2E
>>> For --remote updates, the integrated branch is the remote subprojec=
t's
>>> submodule.<name>.branch.  We integrate that with the
>>> currently-checked-out local branch (or detached HEAD) using the use=
r's
>>> preferred submodule.<name>.update strategy.
>>
>> And for checkout I can easily overwrite the upstream branch with
>> my local changes?
>=20
> ?  I don't understand.  How would you overwrite something in the
> upstream repository?

If the update doesn't overwrite the user-updated local branch (what
I assumed it would do to protect his changes) and he pushes that.

> Maybe you meant "for checkout I can easily
> overwrite the local changes with the upstream branch", which is what =
I
> understand checkout to do.

But which I find really unfriendly and would not like to see in a new
feature. We should protect the user from loosing any local changes,
not simply throw them away. Recursive update makes sure it won't
overwrite any local modification before it checks out anything and
will abort before doing so (unless forced of course).

>>>> when superproject branches are merged (with and without conflicts)=
,
>>>
>>> I don't think this currently does anything to the submodule itself,
>>> and that makes sense to me (use 'submodule update' or my 'submodule
>>> checkout' if you want such effects).  We should keep the current lo=
gic
>>> for updating the gitlinked $sha.  In the case that the
>>> .gitmodule-configured local-branches disagree, we should give the
>>> usual conflict warning (and <<<=3D=3D=3D>>> markup) and let the use=
r resolve
>>> the conflict in the usual way.
>>
>> For me it makes lots of sense that in recursive checkout mode the
>> merged submodules are already checked out (if possible) right after
>> a superproject merge, making another "submodule update" unnecessary
>> (the whole point of recursive update is to make "submodule update"
>> obsolete, except for "--remote").
>=20
> If you force the user to have the configured local-branch checked out
> before a non-checkout operations with checkout side-effects (as we
> currently do for other kinds of dirty trees), I think you'll avoid
> most (all?) of the branch-clobbering problems.

I'm thinking that a local branch works in two directions: It should
make it easy to follow an upstream branch and also make changes to it
(and publish those) if necessary. But neither local nor upstream
changes take precedence, so the user should either use "merge" or
"rebase" as update strategy or be asked to resolve the conflict
manually when "checkout" is configured and the branches diverged.
Does that make sense?
