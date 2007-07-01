From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document git-stash
Date: Sun, 1 Jul 2007 04:07:57 -0400
Message-ID: <20070701080757.GA6093@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0706301853400.4438@racer.site> <200707010533.l615XiH6006728@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 10:08:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4uTl-0008E6-02
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 10:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206AbXGAIIE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 1 Jul 2007 04:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbXGAIIE
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 04:08:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4433 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbXGAIIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 04:08:00 -0400
Received: (qmail 31870 invoked from network); 1 Jul 2007 08:08:20 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 1 Jul 2007 08:08:20 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Jul 2007 04:07:57 -0400
Content-Disposition: inline
In-Reply-To: <200707010533.l615XiH6006728@mi1.bluebottle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51282>

On Sun, Jul 01, 2007 at 02:26:08PM +0900, =E3=81=97=E3=82=89=E3=81=84=E3=
=81=97=E3=81=AA=E3=81=AA=E3=81=93 wrote:

> This describes the git-stash command.

A few minor language nits follow (Junio, I can provide a patch, but if
you haven't pushed it out, it might be simpler to just --amend). Some
are obviously correct, and some are minor or matters of taste. Feel fre=
e
to ignore the latter. :)

> +The modifications stashed away by this command can be listed with
> +`git-stash list`, inspected with `git-stash show`, and restored
> +(potentially on top of a different commit) with `git-stash apply`
> +commands.  The default operation when called without options is to
> +save the changes away.

The 'commands' at the end of the first sentence doesn't quite work. It
needs to be either "with the `foo` command" or "with `foo`" (I think th=
e
latter is preferable, since the list structure makes the article sound
awkward).

> +The latest stash you created is stored in `$GIT_DIR/refs/stash`; old=
er
> +stashes are found in the reflog of this refererence and can be named=
 using

s/refererence/reference/

> +the usual reflog syntax (e.g. `stash@{1}` is the stash one previousl=
y made,
> +`stash@{2}` is the one before it, `stash@{2.hours.ago}` is also poss=
ible).

"the stash one previously made" is a bit ambiguous (they've all been
previously made!). How about "is the most recently created stash"?

> +(no subcommand)::
> +
> +	Save your local modifications to a new 'stash', and run `git-reset
> +	--hard` to revert them.

=46or orthogonality's sake, should this be 'git-stash save', aliased to
just 'git-stash'? It would make this heading a little more intuitive,
and the very first paragraph (describing all of the modes) a little mor=
e
clear.

I can work up a patch if there's agreement.

> +list::
> +
> +	List the stashes that you currently have.  Each 'stash' is listed
> +	with its name (e.g. `stash@{0}` is the latest stash, `stash@{1} is
> +	the one before),

"...the one before, etc.)" is slightly more clear to me.

>   the name of the branch that was current when the
> +	stash was made, and a short description of the commit the stash was
> +	based on.

"the name of the branch that was current when the stash was made" seems
a bit awkward, but it's actually quite accurate.

> +	Show the changes recorded in the stash.  When no `<stash>` is given=
,
> +	shows the latest one.  By default, the command shows diffstat, but
> +	you can add `-p` option (i.e. `git stash show -p stash@{2}`) to vie=
w
> +	it in patch form.

s/shows diffstat/shows the diffstat of the changes/

s/i.e./e.g./

Also, you can use any diff options. So maybe the whole thing would be
better written as (Is there a better term for "original parent" here?):

  Show the changes recorded in the stash as a diff between the the
  stashed state and its original parent. When no `<stash>` is given,
  shows the latest one. By default, the command shows the diffstat, but
  it will accept any format known to `git-diff` (e.g., `git-stash show
  -p stash@{2}` to view the second most recent stash in patch form).

We refer to "the changes" a lot...maybe it would be better to introduce
and define a term like "stash changes" early on and then use it. But
without that, I'm not sure it's clear that the stash can really be
thought of as a diff (since, after all, git stores states, stashes
included). I guess we talk about that later, but at this point in the
manual I think it's a little confusing.

> +apply [<stash>]::
> +
> +	Restores the changes recorded in the stash on top of the current

s/Restores/Restore/ to match the imperative of the other command
descriptions.

> +	working tree state.  When no `<stash>` is given, applies the latest
> +	one.  The working directory must match the index.  When the changes
> +	conflict, you need to resolve them by hand and mark the result with
> +	`git add` as usual.  When the changes are cleanly merged, your
> +	earlier local changes stored in the stash becomes the differences
> +	between the index and the working tree (i.e. `git diff`), except
> +	that newly created files are registered in the index (i.e. `git dif=
f
> +	--cached` is necessary to review the newly added files).

I'm not quite sure I understand what this is saying.

> +clear::
> +	Removes all the stashed states.

Maybe a note to indicate that this can lose data? Something like:

  ...stashed states. Note that those states will then be subject to
  pruning, and may be difficult or impossible to recover.

> +When you are in the middle of something, you learn that there are
> +changes that possibly are relevant to what you are doing in the
> +upstream.  When your local changes do not conflict with the changes =
in
> +the upstream, a simple `git pull` will let you move forward.

The first sentence would be more clear if we moved the prepositional
phrase "in the upstream":

  When you are in the middle of something, you learn that there are
  changes in the upstream that are possibly relevant to what you are
  doing.

or even:

  When you are in the middle of something, you learn that there are
  upstream changes that are possibly relevant to what you are doing.

> ++
> +However, there are cases in which your local changes do conflict wit=
h
> +the upstream changes, and `git pull` refuses to overwrite your
> +changes.  In such a case, you can first stash your changes away,
> +perform a pull, and then unstash, like this:

I think the "first" in the last sentence is confusing, since we don't
use a "then" in the second step ("perform a pull") to indicate that we
have gone on to the second step.

> +When you are in the middle of something, your boss comes in and
> +demands you to fix something immediately.  Traditionally, you would

s/demands you to fix/demands that you fix/

> +make a commit to a temporary branch to store your changes away, and
> +come back to make the emergency fix, like this:

"come back" is pretty vague here. Maybe "return to your original
branch"?

Otherwise, I think the page is very well written, and the examples are
very clear.

-Peff
