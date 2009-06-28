From: Jeff King <peff@peff.net>
Subject: Re: Parallell Development / Switching to GIT
Date: Sun, 28 Jun 2009 14:47:14 -0400
Message-ID: <20090628184714.GA8634@sigio.peff.net>
References: <loom.20090625T095000-90@post.gmane.org> <4A434D6F.2090105@op5.se> <B81058949321C8439B9D742F5F8D8FCA01A75C1D@hpserver.intranet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: "Patrick Neuner - Futureweb.at" <neuner@futureweb.at>
X-From: git-owner@vger.kernel.org Sun Jun 28 20:46:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKzOH-0006n4-LT
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 20:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbZF1SpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 14:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757000AbZF1SpX
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 14:45:23 -0400
Received: from peff.net ([208.65.91.99]:34893 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195AbZF1SpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 14:45:22 -0400
Received: (qmail 8644 invoked by uid 1000); 28 Jun 2009 18:47:14 -0000
Content-Disposition: inline
In-Reply-To: <B81058949321C8439B9D742F5F8D8FCA01A75C1D@hpserver.intranet.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122416>

On Sun, Jun 28, 2009 at 07:51:26PM +0200, Patrick Neuner - Futureweb.at wrote:

> 1) What if I only want to merge a specific file/directly, but not the
> whole branch, is there a way?
> [...]
> The reason is, that external developers will only commit to
> development branch.  They are working on new features, and sometimes
> some small bugfixes, or design templates.  Those need to be merged
> separately, and we try to not have more branches. As developers can
> access our testserver and then see what they have done and test
> functionality.

For the situation you describe, it is not about merging a specific
_file_, but rather you want to pick specific _commits_ from the
development branch that have the bugfixes (or whatever) that you need,
and merge the changes introduced by those commits (but not the rest of
the history).

And that is easy to do; it is called cherry-picking, and you can use
"git cherry-pick" to pick specific commits from development to master.

> 2) We are using gitosis to give external developers access to the
> branches and have some kind of access restriction.  But we are only
> able to limit push rights, not pull rights. In most cases, that's not
> a problem, if they see master And development, but sometimes (like for
> external designers), we might want them to only be able to checkout
> some directories.

There are two ways you can split access, and one will work but the other
will not.

In git, you generally cannot split your data by _tree_. That is, you
cannot say "here is all of the history for the master branch, but you
are only allowed to look at some subset of the files." Because at a
fundamental level, git is about tracking changes to the _whole_ set of
files over time, and it makes the assumption that if you have commit X,
which points to tree Y, which points to files A, B, and C, that you will
have the data for X, Y, A, B, and C in your repository.

However, if you have your data split by _history_, that might work. That
is, if you have a "master" branch and a "development" branch, you can in
theory say "you may look at the history of master, but not of
development". The usual way to do that is to actually keep "master" and
"development" in two different repositories, and only grant read
permission in the filesystem for the "master" one (which obviously
implies doing your reading over something authenticated, like ssh).

Hope that helps,
-Peff
