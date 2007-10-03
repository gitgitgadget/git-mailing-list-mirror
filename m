From: Bruno Haible <bruno@clisp.org>
Subject: Re: git: avoiding merges, rebasing
Date: Thu, 4 Oct 2007 01:01:52 +0200
Message-ID: <200710040101.52137.bruno@clisp.org>
References: <200709301421.52192.bruno@clisp.org> <200710021350.54625.bruno@clisp.org> <6C9F1445-8826-4E6F-A10C-290A57A4C826@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bug-gnulib@gnu.org, git@vger.kernel.org
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Oct 04 01:02:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdDEM-0007BQ-H2
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 01:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbXJCXCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 19:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbXJCXCG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 19:02:06 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:18420 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbXJCXCF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 19:02:05 -0400
Received: from linuix.haible.de ([81.210.217.73])
	by post.webmailer.de (mrclete mo12) (RZmta 13.4)
	with ESMTP id N00b79j93KDxeV ; Thu, 4 Oct 2007 01:02:03 +0200 (MEST)
	(envelope-from: <bruno@clisp.org>)
User-Agent: KMail/1.5.4
In-Reply-To: <6C9F1445-8826-4E6F-A10C-290A57A4C826@lrde.epita.fr>
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY7QaSDm1JE
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59905>

Benoit SIGOURE wrote:
> >>> Is there some shorthand for this process, such as a "git-recover"
> >>> command?
> >>
> >> you can run git fsck and look for
> >> a dangling commit (which can be inspected with git show <sha1>) where
> >> you are most likely to find your stash (unless you run git-gc or this
> >> sort of thing).
> >
> > Cool! This information would be worth mentioning in the git-stash  
> > manual page or in an FAQ. It can be a real life-saver.
> 
> True.  Propose a patch :-)

Here's a proposed patch.

--- git-1.5.3.4/Documentation/git-stash.txt.bak	2007-10-03 21:44:53.000000000 +0200
+++ git-1.5.3.4/Documentation/git-stash.txt	2007-10-04 01:00:48.000000000 +0200
@@ -154,6 +154,28 @@
 ... continue hacking ...
 ----------------------------------------------------------------
 
+Recovering a lost stash::
+
+`git stash clear` clears all stashes without asking for confirmation.
+If you did not intend this, you can recover the lost changes by running
+`git fsck`, looking for dangling commits, and using `git show <commit>`.
++
+----------------------------------------------------------------
+... hack hack hack ...
+$ git stash
+... hack no coffee hack ...
+$ git stash clear
+... panic panic ...
+$ git fsck
+dangling commit f62c4fa05422fd4fb8610bdb02a7160121657893
+dangling commit 773024d2ffc33ac80baddcf2b673535b627af0da
+dangling commit 9e509390a2b26b562f3b008eacc65b6765d48339
+$ git show 773024d2ffc33ac80baddcf2b673535b627af0da
+$ git diff 773024d2ffc33ac80baddcf2b673535b627af0da > recovered.diff
+$ patch -p0 -R < recovered.diff
+... continue hacking ...
+----------------------------------------------------------------
+
 SEE ALSO
 --------
 gitlink:git-checkout[1],
