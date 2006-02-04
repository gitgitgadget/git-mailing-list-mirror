From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: Rummage through ~/.gitrc as well as the repository's config.
Date: Sat, 04 Feb 2006 04:17:48 -0800
Message-ID: <7vhd7f1fo3.fsf@assigned-by-dhcp.cox.net>
References: <20060203203332.2718.13451.stgit@metalzone.distorted.org.uk>
	<7vacd7c4bm.fsf@assigned-by-dhcp.cox.net>
	<slrndu9042.2i8.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 13:17:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5MMT-0002d8-LP
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 13:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWBDMRv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 07:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWBDMRv
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 07:17:51 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:4038 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932340AbWBDMRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 07:17:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204121648.UNAM3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 07:16:48 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrndu9042.2i8.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Sat, 4 Feb 2006 10:22:58 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15590>

Mark Wooding <mdw@distorted.org.uk> writes:

> Argh.  In every terminal and screen window, restart Emacs, ...  Logging
> out looks like the better plan.

So you do mean environment variables?  Then what's the aversion
against using GIT_AUTHOR_EMAIL instead of using user.email in
every repository?  If you use the same value everywhere, you
can do the environment thing _today_ and re-logging in needs to
be done only once, so I do not find it such a big deal.  If you
do _not_ use the same value everywhere, then user.email per
repository is a good thing to have, but ~/.gitrc would not help.

Having said that, there are good uses for per-user configuration
that is used across different repositories.  Especially when we
start adding new features, we would not want to invent new
environment variable every time.  Under ~/ would be a logical
place to put that information.

If you want to propose a search order of multiple configuration
files and how they interact with each other (what happens if
~/.gitrc and $GIT_DIR/config say different things, especially
for multi-valued configuration items), go wild.  I think the
simplest single-value cases should be resolved by taking what
$GIT_DIR/config says and if the configuration is not found there
then look at ~/.gitrc (IOW, $GIT_DIR/config takes precedence),
but I am not sure even if that is true in general.  I suspect
that some configuration items are more of personal nature and
some configuration items are more of per-project attribute.  For
example, merge resolve strategy would be affected more by the
nature of changes that happen to the project's files than which
strategy the user feels easier to work with; $GIT_DIR/config may
have core.gitproxy and user.email, maybe by historical reasons,
which you may rather want to override with ~/.gitrc (e.g. git
proxy may require proxy authentication which would need to be
supplied per user).

Especially problematic would be user.email.  Some people might
want to use different identity depending on what project they
work on, in which case they would want $GIT_DIR/config to take
precedence.  But sometimes you may need to go to your colleagues
repository and help him with his work, and when you make a
commit there you would want your name, not user.email in
$GIT_DIR/config that records his identity, to be used for that
commit.
