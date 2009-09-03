From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] Request for help
Date: Wed, 2 Sep 2009 18:22:07 -0700
Message-ID: <20090903012207.GF1033@spearce.org>
References: <4A9EFFB1.9090501@codeaurora.org> <alpine.DEB.1.00.0909030157090.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nasser Grainawi <nasser@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 03 03:22:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj11j-00073I-P2
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 03:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbZICBWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 21:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZICBWG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 21:22:06 -0400
Received: from george.spearce.org ([209.20.77.23]:40033 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbZICBWF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 21:22:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7316C381FD; Thu,  3 Sep 2009 01:22:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0909030157090.8306@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127636>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 2 Sep 2009, Nasser Grainawi wrote:
> 
> > I'm looking to add 'git patch-id' to JGit and I could use a few 
> > pointers. I'm not very familiar with the JGit code base or Java, so 
> > please excuse any blatant oversights or unintelligent questions.
> > 
> > First off, is there a "hacking JGit" document anywhere? One of those 
> > would be great right now.
> 
> There have been some mails with details about JGit from Shawn (IIRC) to 
> this very list.

Yea, for the most part I think we use Eclipse, and you just have
to import JGit's top level directory into Eclipse as it comes with
Eclipse project files.  But I know some folks only use our Maven
build (under jgit-maven/jgit) or use NetBeans.  I have no idea how
to import the project into the latter or configure its unit tests
to run.
 
> > So far I'm just trying to define the inputs and outputs. On Shawn's 
> > suggestion I'm planning on making it part of the org.spearce.jgit.patch 
> > package. C Git patch-id very generically has an input of a 'patch', so 
> > I'm thinking this implementation should use the Patch object.
> 
> C Git patch-id takes a valid patch as input; I do not think that you want 
> to use the Patch object.

I think we do want to use the Patch object.  The Patch entity in
JGit is a parsed representation of the git diff or unified diff
structure.  Its relatively easy to walk over, and all of the mess
about determining line type has already been done.

We'd probably want to do something that is a lot like the object
Patch as the output of our diff routine.  A tool (e.g. Gerrit Code
Review) might only want the EditList for a given file, and not
really care about the actual formatted patch text, as it reformats
everything itself.  I think patch-id computation is along those
same lines.

If we were to compute a patch-id off an InputStream we would probably
just send it through the Patch object first.

> This is not really difficult in Java, however, it relies on a working diff 
> implementation (and IIRC my implementation has not yet been integrated 
> into JGit).

Speaking of... where does that stand?

-- 
Shawn.
