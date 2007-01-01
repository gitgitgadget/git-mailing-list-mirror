From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 15:56:05 -0800 (PST)
Message-ID: <926020.70066.qm@web31802.mail.mud.yahoo.com>
References: <20070101131726.GA21933@thunk.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 02 00:56:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1X0m-0003b8-9G
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 00:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbXAAX4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 18:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbXAAX4J
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 18:56:09 -0500
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:41875 "HELO
	web31802.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932512AbXAAX4H (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jan 2007 18:56:07 -0500
Received: (qmail 71778 invoked by uid 60001); 1 Jan 2007 23:56:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Mv9tZ6+Ib6mcjR8w4r51MvRiAZ96LhW41GF7Hy8489t7lTJ6JSONSvi6dVh9/EhUrcgzCSAOlAu9Ubw2+xUpRXwvboqJvEYtMvkz6TlHXuzwSinvfs5e0bHNZQO9BOH1zQS9E681quRCC2stzBJaMpI7qbYGs1GQX16V046qxss=;
X-YMail-OSG: ReftsegVM1mwhqiKhF92EJ0T8m6Ho1v6xucZZrJ_4Ruzzi0_LuAIExhsTBHZ68Te8HaVBHaGny6Kj2NkBhAkqCkS2aY5nnlZtNQR6fc6W7eGiBdNJmujSf6jAJRQP0dJb22cEE776L_3mnejboBmv1CsXokk5xzQS2X.TfwXLm697RK.6pXsMJEyGTQzm_HFCutsfxs0Xts-
Received: from [71.84.31.238] by web31802.mail.mud.yahoo.com via HTTP; Mon, 01 Jan 2007 15:56:05 PST
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20070101131726.GA21933@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35747>

--- Theodore Tso <tytso@mit.edu> wrote:
> Luben,
> 
> Let me see if I can understand what you are asking for without using
> the term "branch spec", which I don't think has been adequately
> defined yet in this thread.  (Where "the SCM industry has adopted"
> isn't a definition.  :-)

You can also think of it as "the merge direction given a symbolic name".

> Currently, today, if you type:
> 
> 	git fetch <non-URL>
> 
> ... it will look up "<non-URL>" in a single global namespace, which
> (using only the new config scheme) is looked up in remote.<non-URL>
> and remote.<non-URL>.{url,fetch} is used to control the operation of
> git-fetch.

I'm talking about more in terms of git-merge, but since git-pull
is a git-fetch and git-merge, I've been using git-pull for completeness.
IOW, I've tried to concentrate on a per-repo operations (merge) as opposed
to on a multi-repo, which is currently handled by git as is expected.

> What you want to do is to change this to where:
> 
> 	git fetch <non-URL>

git-pull, for completeness.  See my paragraph above.

> ...will now lookup "<non-URL>" in a namespace which is qualified by
> the branch that you are in.  So you want to look up the information in
> branches.<current-branch>.<non-URL>.{url,fetch} instead.

More specifically,
branch.<branch-match>.<symbolic-ref match>.{fetch,merge}.

branch.<branch-match>..{fetch,merge} is allowed and defalts
to already implemented "git-pull".

branch..<symbolic-ref match>.{fetch,merge} is forbidden
since it is essentially remotes/ and is handled by the current
"remotes/" infrastructure by git.

branch.<branch-match>.<symbolic-ref match>.{fetch,merge} will
perform the fetch, which would be a no-op, since the branch
we're "fetching" is local, and the merge merges into the
current branch if it matches.

> You haven't stated it explicitly, but I assume that if
> branches.<current-branch>.<non-URL> doesn't exist, you're proposing
> that the code fall back to looking in the old configuration parameter,
> remote.<non-URL>, so that certain names that should be global can
> continue to be global, and that people who want a single global
> namespace can continue to have it?

Yes, I absolutely do not want to break existing behavior.  But
if it is extended, it should be done properly, and a general
case should be solved as to solve this once and forever.

> Is that your proposal, stripped of the arguments of why you want it,
> and of the somewhat confusing "parent" example (which is a bad one
> given that your "git pull parent" example was the semantic equivalent
> of "git pull")?

More or less.  Basically, I want local "git-pull" (fetch[no-op],merge)
to be addressable, i.e. _named_, so that I can establish a more complex
software dependency, which I currently do, my means of the order and
the type of "git-pull . <branch>" I do.

> If it is, I'm a bit nervous since it's making the git-fetch command
> modal, and modal UI's are confusing to users.

Think of "git-pull", not just of "git-fetch".  As well as think
of a setup where there are more than one branch implementing
software dependency, resolving to a software product.

> On the other hand, it's
> a fundamental modality we have already (based on the question "which
> branch am I"), and there are hacks that will allow you to put the
> current branch into your command-line.

Ah, yes.  Well, the many-branches-one-directory is confusing and
is modal.  *But*, it doesn't have to be like that.  Git allows
the freedom to define branch-per-directory-yet-single-repo which I've
absolutely always used with GIT, and other SCMs.  This way it is
absolutely unambiguous "what branch I'm at".

It is in this sense that I do "cd <branch>; git-pull . <branch>"
in a sequence, and I'd rather do "cd <branch>; git-pull <symbolic-ref>"
to define which branch is the merge coming from given the current branch
_and_ the symbolic ref.

> And as long as you are
> proposing a lookup in branches.current.branch.<non-URL> first before
> checking remotes.<non-URL> it seems mostly harmless to me.  I doubt
> I'd ever use it, but maybe it would be helpful to some.

Yes, current behavior should absolutely not be broken.
First (<current-branch>,<symbolic-ref>) is matched against
"branch.<name>.<symbolic-ref>.{fetch,merge}" modulo the 
cases I've outlined before, and then if everything else
fails, we default to remote/.

     Luben
