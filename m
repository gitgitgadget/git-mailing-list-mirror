From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation/git-filter-branch: add a new commit-filter
	example
Date: Sat, 23 Feb 2008 23:04:33 +0100
Message-ID: <20080223220433.GG31441@genesis.frugalware.org>
References: <20080223193058.GE31441@genesis.frugalware.org> <7vejb3319j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:16:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT2fx-0001ZH-EG
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbYBWWQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbYBWWQV
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:16:21 -0500
Received: from virgo.iok.hu ([193.202.89.103]:58094 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbYBWWQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:16:20 -0500
X-Greylist: delayed 703 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Feb 2008 17:16:20 EST
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E1D671B24FA;
	Sat, 23 Feb 2008 23:04:34 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B69C244668;
	Sat, 23 Feb 2008 23:02:06 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4AB6411901F6; Sat, 23 Feb 2008 23:04:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vejb3319j.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74862>

There is a commit-filter example already which skips commits but there is no
example on how to edit commit messages.

One can figure out this example by carefully reading the git-filter-branch and
git-commit-tree documentation but I think it isn't trivial so this example is
helpful.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Feb 23, 2008 at 11:45:28AM -0800, Junio C Hamano
<gitster@pobox.com> wrote:
> People who are not interested in git-svn at all may still want
> to fix up their commit log messages, and I think starting a
> paragraph with 'git-svn-blah' would risk them skipping it
> without reading (I certainly would).  Probably we would want to
> add a sentence before "To remove ...", like this:
>
>       You can rewrite the commit log messages using `--commit-filter`.
>       For example, `git-svn-id` strings in a repository created with
>       `git-svn` can be cleaned up this way:

second try follows :)

>
> > +------------------------------------------------------------------------------
> > +git filter-branch --commit-filter 'sed "/^git-svn-id:/d" |git
> > commit-tree "$@"'
> > +------------------------------------------------------------------------------
>
> Please try to keep them a bit shorter for reviewing pleasure on
> 80-column terminals after your message was quoted once or
> perhaps a few times.  The example is easier to read if you write
> like this, I think:
>
> ----------------------------------------------------------------
> git filter-branch --commit-filter '
>       sed -e "/^git-svn-id:/d" | git commit-tree "$@"
> '
> ----------------------------------------------------------------
>

ok. i used 72 in my mails and 80 in the code, but now i'm using 72 in
the code as well.

> I am not sure if git-svn people condone or encourage such
> removals, though.

i think it's only useful if you use git-svn for an svn -> git
conversion, provided that the project switches to git (there will be no
more svn commits and noone wants to push back git commits to svn).

 Documentation/git-filter-branch.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index e22dfa5..367064b 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -240,6 +240,15 @@ committed a merge between P1 and P2, it will be propagated properly
 and all children of the merge will become merge commits with P1,P2
 as their parents instead of the merge commit.
 
+You can rewrite the commit log messages using `--commit-filter`.  For
+example, `git-svn-id` strings in a repository created by `git-svn` can
+be removed this way:
+
+-------------------------------------------------------
+git filter-branch --commit-filter '
+	sed -e "/^git-svn-id:/d" | git commit-tree "$@"
+'
+-------------------------------------------------------
 
 To restrict rewriting to only part of the history, specify a revision
 range in addition to the new branch name.  The new branch name will
-- 
1.5.4.2
