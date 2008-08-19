From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT RFC] JGit mavenization done right
Date: Tue, 19 Aug 2008 07:44:24 -0700
Message-ID: <20080819144424.GC20947@spearce.org>
References: <7bfdc29a0808162152y4329303dte8f82bfea646180d@mail.gmail.com> <20080818055502.GE7376@spearce.org> <7bfdc29a0808172333g1cbe2102n6e76ae98a1943411@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 16:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVSSf-0006Pv-QS
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 16:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbYHSOo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 10:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbYHSOoZ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 10:44:25 -0400
Received: from george.spearce.org ([209.20.77.23]:34429 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbYHSOoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 10:44:25 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9355338375; Tue, 19 Aug 2008 14:44:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7bfdc29a0808172333g1cbe2102n6e76ae98a1943411@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92867>

Imran M Yousuf <imyousuf@gmail.com> wrote:
> On Mon, Aug 18, 2008 at 11:55 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Imran M Yousuf <imyousuf@gmail.com> wrote:
> >> I would like to request you all to test out JGit from
> >> http://repo.or.cz/w/egit/imyousuf.git. Please checkout the branch
> >> 'unified_tst_rsrc' and try to build it with both maven and Eclipse
> >> (i.e. as was built earlier)
> 
> Thanks, it would nice to know whether it works in the original build
> process or not :).

Well, it did break it in Eclipse:

$ git diff-tree --abbrev -r -M --diff-filter=D orcz-pub/master HEAD
:100644 000000 9d7d138... 0000000... D  org.spearce.jgit.test/.gitignore
:100644 000000 987d6be... 0000000... D  org.spearce.jgit.test/.project
:100644 000000 8bfa5f1... 0000000... D  org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
:100644 000000 fce94cf... 0000000... D  org.spearce.jgit.test/.settings/org.eclipse.jdt.ui.prefs
:100644 000000 304e861... 0000000... D  org.spearce.jgit/.classpath
:100644 000000 ba077a4... 0000000... D  org.spearce.jgit/.gitignore
:100644 000000 7d38455... 0000000... D  org.spearce.jgit/.project
:100644 000000 709a440... 0000000... D  org.spearce.jgit/.settings/org.eclipse.jdt.ui.prefs

Removing this stuff was not so good.  The Eclipse projects are
busted and can't be used anymore.  We need them back.

The make_jgit.sh however seems to produce a valid JAR.  Given the
file-level differences I didn't expect it to fail.

Also, I wonder if JGitTestUtil is better handled by placing the
method in RepositoryTestCase and making sure everyone subclasses
that if they need a test resource file?  I'm fairly certain they
already do, and its a lot easier to invoke a method you inherited
than one in another class.  (Well, easier for the guy writing the
test case anyway, Java obviously doesn't care either way.)

If we are going to take this in upstream I'd like a flattened/cleaned
up history.  Being able to bisect the misstep of using symlinks
(the old Maven approach) isn't very valuable in the long-term view
of the history.

Robin, any thoughts?
 
-- 
Shawn.
