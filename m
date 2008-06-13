From: Jon Loeliger <jdl@jdl.com>
Subject: git format-patch documentation anomaly
Date: Thu, 12 Jun 2008 19:37:11 -0500
Message-ID: <E1K6xHz-0002y4-Dv@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 02:38:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6xJ5-0006s4-5a
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 02:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbYFMAhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 20:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755876AbYFMAhP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 20:37:15 -0400
Received: from jdl.com ([208.123.74.7]:48810 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755739AbYFMAhP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 20:37:15 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>)
	id 1K6xHz-0002y4-Dv
	for git@vger.kernel.org; Thu, 12 Jun 2008 19:37:13 -0500
X-Spam-Score: -2.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84817>


Git-ites,

I noticed that there is a bit of an anomaly with
the "git-format-patch" documentation.  The option
for --ignore-if-in-upstream reads like this:

    --ignore-if-in-upstream::
        Do not include a patch that matches a commit in
        <until>..<since>.  This will examine all patches reachable
        from <since> but not from <until> and compare them with the
        patches being generated, and any patch that matches is
        ignored.

First, the English on the <until>..<since> is a bit odd,
and directly opposite the corresponding ordering from git-log:

    <since>..<until>
        Show only commits between the named two commits. When either
        <since> or <until> is omitted, it defaults to HEAD, i.e. the tip
        of the current branch. For a more complete list of ways to spell
        <since> and <until>, see "SPECIFYING REVISIONS" section in
        git-rev-parse(1).

But the real issue is that git-format-patch doesn't
even mention <since>..<until> (or <until>..<since>)
as its revision range specifier anywhere.  It says

    [ <since> | <revision range> ]

in its synopsis.

And I wonder if it is just me or not, but I had to read this
paragaph about 3 times and compare it to my already-known
mental model of what format-patch does before I figured out
what it was trying to say:

    A single commit, when interpreted as a <revision range> expression,
    means "everything that leads to that commit", but if you write git
    format-patch <commit>, the previous rule applies to that command
    line and you do not get "everything since the beginning of the
    time". If you want to format everything since project inception to
    one commit, say "git format-patch --root <commit>" to make it clear
    that it is the latter case.

Granted, that is a little out of context ("the previous rule" refers
to this:

    1. A single commit, <since>, specifies that the commits leading to
       the tip of the current branch that are not in the history that
       leads to the <since> to be output.

So, at the risk of complaining and not contributing, I'll
offer this rewrite or clarification for the confusing paragraph
and, if needed, followup with a patch unless someone else
beats me to it.

    Other Git commands that receive a single commit, <commit>,
    parameter as part of a range generally mean "every commit
    that contributes to and leads up to <commit>".  However,
    in the context of git-format-patch, that is generally not
    the desired behavior; instead a single commit is interpreted
    as a "<since>" parameter as if "<commit>..HEAD" were requested,
    and specifies the commits leading to the tip of the current
    branch that are not in the history up to and including <commit>.
    If all commits from the root of the history up to the specified
    commit are wanted, use "--root <commit>".

Is a single commit, in fact, identical to "<commit>..HEAD"?
Should we just state that straight up and be done with it?

jdl
