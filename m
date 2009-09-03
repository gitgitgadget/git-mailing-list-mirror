From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] Request for help
Date: Thu, 3 Sep 2009 08:52:19 -0700
Message-ID: <20090903155219.GI1033@spearce.org>
References: <4A9EFFB1.9090501@codeaurora.org> <alpine.DEB.1.00.0909030157090.8306@pacific.mpi-cbg.de> <20090903012207.GF1033@spearce.org> <2c6b72b30909030545y4465b5c8j4b2b5587a07762c0@mail.gmail.com> <20090903144227.GH1033@spearce.org> <2c6b72b30909030838q10b88705gb8c553f2c2d74379@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nasser Grainawi <nasser@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 17:52:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjEbr-0002yc-Q4
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 17:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbZICPwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 11:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbZICPwR
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 11:52:17 -0400
Received: from george.spearce.org ([209.20.77.23]:39353 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZICPwR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 11:52:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BC150381FE; Thu,  3 Sep 2009 15:52:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2c6b72b30909030838q10b88705gb8c553f2c2d74379@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127658>

Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> On Thu, Sep 3, 2009 at 10:42, Shawn O. Pearce<spearce@spearce.org> wrote:
> > Actually, now that we have forked out of the egit.git repository,
> > I want to refactor the layout of the JGit project to be more maven
> > like, and have a proper top-level pom to build things.
> 
> What kind of module structure do you have in mind? Do you want to move
> some of the modules/subdirectories?
> Some refactoring of the maven setup for JGit back was done back in
> April in sonatype's (a maven company) JGit clone. It is not
> signed-off, but can serve as a reference.

Yea, I was hoping they would contribute this back as patches,
but thus far they haven't.
 
> The Maven layout in the sonatype clone simply uses the Eclipse project layout.
> 
> pom.xml: JGit :: Parent
>  |- org.spearce.jgit/pom.xml: JGit :: Core
>  |- org.spearce.jgit.pgm/pom.xml: JGit :: Programs
>  `- org.spearce.jgit.test/pom.xml: JGit :: Test
> 
> However, having tests in a separate module can be both good/bad. For
> example, they will not automatically get run when you only build the
> Core module.

Yea, I know.  This is one area where Maven is just whack, by putting
the tests in the same project the Maven plugin for Eclipse puts
them into the same classpath, which means you can see test code
from project code.  Wrong.  They should be different projects so
the test classpath is isolated.

However.  This is a bug in the Eclipse plugin I think, not
necessarily with Maven's approach of trying to keep tests alongside
the code they test.  Thus we probably want:

  pom.xml: JGit :: Parent
   |- jgit-lib/pom.xml: JGit
   |     src/main/java  <-- from org.spearce.jgit/src
   |     src/test/java  <-- from org.spearce.jgit.test/src
   |
   `- jgit-pgm/pom.xml: JGit pgm
         src/main/java  <-- from org.spearce.jgit.pgm/src

IIRC there is Maven support to create proper MANIFEST.MF files for
OSGI bundles, which is what we need for the Eclipse plugin support.
That should be able to replace the META-INF/MANIFEST.MF in the top
of each of the current directories.

> Anyway, I would like to help.

Please post patches; formatted with -M.  I do want to do this, I just
don't have the patience and Maven-fu to write the new poms myself.

-- 
Shawn.
