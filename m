From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tight submodule bindings
Date: Mon, 13 Jan 2014 14:13:46 -0800
Message-ID: <xmqqk3e35y3p.fsf@gitster.dls.corp.google.com>
References: <cover.1389247320.git.wking@tremily.us>
	<20140112010847.GJ29954@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Jan 13 23:14:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2plg-0001fs-PT
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 23:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbaAMWN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 17:13:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727AbaAMWNy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 17:13:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C8D7614D9;
	Mon, 13 Jan 2014 17:13:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1ZPOw6Ce64s6p8QU0JtFvlZghxI=; b=bqCb5h
	7VxdiRsRT/nxG6mqwqImamQTp1UdSyGF4fsHKm7PmNMixI2p5b3Q5Kb+a284Rxp1
	dDsVac8TKhzA9s1OnKUfXggqkKKWFL4CCeamq2HLZntf+hB1eKnHxOxMk2Iws5oo
	ajyuVBTrJmi5KboUCQq85XVz+Jgkqpbo3++oI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tenP9+GUw6F0bRPbRYinHNeOHvf98eap
	ZisLGNwAvz8eHV2YTpQAFdLup+ryVPtH8L4uhOm03yNVKKcxUWlAuU38IFHw3GGK
	u7GEB59FA52j9OeqkuSmc7aJKztTHwUun1V+XkdQo+lIQ1MvXiqT4h0ax7BEKud8
	iYc2Ubf+4gM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 793A3614D6;
	Mon, 13 Jan 2014 17:13:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F13A2614D0;
	Mon, 13 Jan 2014 17:13:48 -0500 (EST)
In-Reply-To: <20140112010847.GJ29954@odin.tremily.us> (W. Trevor King's
	message of "Sat, 11 Jan 2014 17:08:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FA368BCE-7C9F-11E3-9042-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240375>

"W. Trevor King" <wking@tremily.us> writes:

> Additional metadata, the initial checkout, and syncing down
> -----------------------------------------------------------
>
> However, folks who do local submodule development will care about
> which submodule commit is responsible for that tree, because that's
> going to be the base of their local development.  They also care about
> additional out-of-tree information, including the branch that commit
> is on.

Well, please step back a bit.

They do not have to care about what local branch they use to build
follow-up work based on that commit.  In fact, they would want to be
able to develop more than one histories on top, which means more
than one branches they can name themselves.

The only thing they care about is where the result of their
development _goes_, that is the URL and the branch of the remote
they are pushing back to.

I have a feeling that this is not specific for submodules---if you
did this:

	git init here
        cd here
        git fetch $there master
        git reset --hard FETCH_HEAD

and are given the resulting working tree to start hacking on, you
would not know where the history came from, or where your result
wants to go.  

So "the branch that commit is on" is a wrong thing to focus on.
"The branch the history built on top of the commit wants to go" may
be closer and these two are different.

>  For already-initialized submodules, there are existing places
> in the submodule config to store this configuration:
>
> 1. HEAD for the checked-out branch,
> 2. branch.<name>.remote → remote.<name>.url for the upstream
>    subproject URL,
> 4. branch.<name>.rebase (or pull.rebase) to prefer rebase over merge
>    for integration,
> 5. …

What happened to 3 ;-)?

And also branch.<name>.merge may say on which of _their_ branch the
commit you learn in the superproject tree would be found.  If you
are using centralized workflow, that would be the branch at your
central repository to update with your push, too.

In any case, "local-branch" is wrong from two aspects:

 1. (obvious) It does not follow our naming convention not to use
    dashed-names for configuration variables.

 2. You do not care about the names you use locally.  The only thing
    you care about is where people meet at the central repository,
    i.e. where your result is pushed to.


> Syncing up
> ----------
>
> In the previous section I explained how data should flow from
> .gitmodules into out-of-tree configs.

s/should/you think should/, I think, but another way may be not to
copy and read from there, which may be a lot simpler.  Then upon
switching branches of top-level superproject (which would update
.gitmodules to the version on the new branch), you may get different
settings automatically.  But see below.

> ...  Since you *will* want to share the upstream URL, I
> proposed using an explicit submodule.<name>.active setting to store
> the “do I care” information [2], instead of overloading
> submodule.<name>.url (I'd auto-sync the .gitmodule's
> submodule.<name>.url with the subproject's remote.origin.url unless
> the user opted out of .gitmodules syncing).

It may not be a good idea to blindly update to whatever happens to
be in .gitmodules, especially once submodule.*.url is initialized.

I think we would need a bit more sophisticated mechanism than "use
from .git/config if set, otherwise use from .gitmodules", at least
for the URL.  It may not be limited to the URL, and other pieces
of metainformation about submodules may need similar handling, but
I'd refrain from extending the scope of discussion needlessly at
this point.

Imagine that your embedded appliance project used to use a submodule
from git://k.org/linux-2.6 as its kernel component and now the
upstream of it is instead called just git://k.org/linux; the URL
specified by submodule.kernel.url in .gitmodules for the entry
submodule.kernel.path=kernel would have changed from the former to
the latter sometime in the superproject's history.  Switching back
to an old version in the superproject to fix an old bug in the
maintenance track of the superproject would still want to push
associated fixes to the kernel to k.org/linux, not linux-2.6, the
latter of which may now be defunct [*1*].  One way to make it work
semi-automatically is to keep track of what the user has seen in
.gitmodules and offer chances to update entries in .git/config.  If
you cloned the superproject recently, you would only know about the
new git://k.org/linux URL and that would be copied to .git/config
(which the current code does).  In addition, you would remember that
we saw git://k.org/linux URL (which the current code does not).
Upon switching back to an old version, we could notice that the URL
in .gitmodules, which is git://k.org/linux-2.6, is not something the
user has seen, and at that point we could ask the user to tell us
what URL should be used, record the answer _and_ the fact that we
saw that old URL as well.  Then until the superproject updates the
URL the next time to a value that we have never seen, the user can
keep using the right URL without being asked [*2*].


> 2. Checkout the new superproject branch.
>
>    2.1. For each old submodule that doesn't exist in the new branch,
>         blow away the submodule directory (assuming a new-style
>         .git/modules/… layout, and not an old-style submod/.git/…
>         layout).

Sure.

>    2.2. For each gitlinked submodule that didn't exist in the old
>         branch, setup the submodule as if you were doing the initial
>         cloning checkout (forcing a new local-branch to point at the
>         gitlinked commit).  If you find local out-of-tree
>         *superproject* configs that conflict with the .gitmodules
>         values, prefer the superproject configs.  Clobber submodule
>         configs and local branches at will (modulo
>         submodule.<name>.sync), because any submodule configs that the
>         user wanted to keep should have been added to the superproject
>         branch earlier (or stashed).

See above.


[Footnote]

*1* On the other hand, the switch of the submodule URL in the
superproject may have been between two separate projects (e.g. you
used to build your embedded appliance using BSD kernel but recent
versions use Linux kernel)---in such a project, you would want the
submodule URL to follow what is in .gitmodules when you switch
between old and new versions in the superproject.  But our
recommendation in such a case is to use different names for
submodules that is bound at the same path in the superproject so
that we can keep them as two separate repositories in .git/mdoules/
of the superproject.  So at least for the URL, there is no reason to
use the old version that appears in .gitmodules of the superproject
even when you checkout an old version of it.

*2* This "remembering" may have to be more than "have we seen this"
one-bit per different values. For URL, I think the one-bit is
enough, but for other things, it might make sense to keep track of
"In the version of superproject with X in .gitmodules, the user
wants to use value Y" for each values X the user has seen.
