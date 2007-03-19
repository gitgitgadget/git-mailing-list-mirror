From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-init: set core.workdir when GIT_WORK_DIR is specified
Date: Mon, 19 Mar 2007 15:24:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703191523520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net>
 <20070317143452.GA21140@moooo.ath.cx> <7vr6rnlyzt.fsf@assigned-by-dhcp.cox.net>
 <20070318211836.GA12456@moooo.ath.cx> <7vk5xensjn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 15:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTInB-0008Pr-5B
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 15:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbXCSOYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 10:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbXCSOYz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 10:24:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:55850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750821AbXCSOYy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 10:24:54 -0400
Received: (qmail invoked by alias); 19 Mar 2007 14:24:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 19 Mar 2007 15:24:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dmtVUWDpdYuqE+tpCAgtgzS1a1+6rhWNZZSy2K9
	sSkYBMN05RdlY3
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vk5xensjn.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42623>

Hi,

On Sun, 18 Mar 2007, Junio C Hamano wrote:

> Matthias Lederhofer <matled@gmx.net> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >> Matthias Lederhofer <matled@gmx.net> writes:
> >> >  * is_bare_repository() in general
> >> 
> >> There is a bit of chicken and egg involved in is_bare, because
> >> we need to find out where GIT_DIR is in order to find where to
> >> read GIT_DIR/config from, and only after reading the file we
> >> would know if the user explicitly told us the repository is
> >> bare, and setup_gently does not want to cd-up if the repository
> >> is bare (i.e. there is no "top" to move to).
> >
> > How about changing setup_git_directory_gently to do the following:
> >
> > Find the git directory ($GIT_DIR, .git in parent directories and "."
> > at last).
> >
> > Read configuration for core.bare and core.worktree.  If core.bare is
> > not specified do the old guessing.
> >
> > if core.bare = true:
> >     Set GIT_DIR if it isn't set yet and stop (don't change the
> >     directory).
> >
> > if core.bare = false:
> >     GIT_DIR specified:
> >         use GIT_WORK_TREE, core.worktree or "." as working tree
> >     found repository as .git directory:
> >         use the parent directory of the .git directory as working tree
> >     found repository in ".":
> >         use "." as working tree
> >
> >     if cwd is below the working tree:
> >         change to working tree
> >         inside_work_tree = 1
> >         return prefix
> >     if cwd is outside of the working tree:
> >         inside_work_tree = 0
> >         return NULL
> 
> Luckily, this is an area that two of the most active git
> regulars have touched, and I can rely on their judgement to help
> me ;-)
> 
> What you describe sounds like a sane outline to me.

Yes, I like it, too (that is, I did not find an obvious flaw in it).

Ciao,
Dscho
