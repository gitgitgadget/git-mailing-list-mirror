From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT and repo-config
Date: Fri, 26 Jan 2007 18:53:02 +0100
Message-ID: <20070126175302.GG4083@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070125225512.GF4083@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701251545w1b34a0dcg545eeab08d767e38@mail.gmail.com> <Pine.LNX.4.63.0701260052590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 26 18:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAVHz-0002r2-C4
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 18:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbXAZRyL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 12:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbXAZRyK
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 12:54:10 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:36210 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161099AbXAZRyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 12:54:09 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 80352591C;
	Fri, 26 Jan 2007 18:54:07 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 206443005; Fri, 26 Jan 2007 18:53:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701260052590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37880>

On Fri, Jan 26, 2007 at 12:58:38AM +0100, Johannes Schindelin wrote:
> On Thu, 25 Jan 2007, Catalin Marinas wrote:
> > What I'd like it to have is a single initial call to git-repo-config 
> > --list (in config_setup) and all the options cached in a dictionary (so 
> > that .git/config options would override the global ~/.gitconfig ones). 
> > The dictionary should also be pre-populated with the default values 
> > (only in memory, not going to the config file on disk).

Pre-filling with default value has a drawback: it will create lots of
useless entries, especially for per-branch settings.  I'd rather let
the accessors return the default value when needed.  We can still
group all defaults in a single dictionnary.


> I then proposed to have a simple --dump option to repo-config, which 
> outputs NUL separated key/value pairs (substituting "true" for keys 
> without -- not with empty! -- values). But somehow the discussion petered 
> out before anything came out of it.

Even if that was to be done in git, it would surely be post-1.5, so we
need another way to do things in the meantime.


> The most important point (to me) which came out of the discussion: It is 
> not at all easy, or straight-forward, to handle multi-vars, i.e. multiple 
> values for the same key.

Right, at least for filling a dictionnary.  We would need to declare
multi-valued parameters as such, which basically means we must only
try to read those config items we know about, which has all sorts of
consequences for config.py :)

It would seem reasonable to start without a cache dictionnary, at
least for now.  After all, there are not so many config items to know
about in a single stgit run, so IIMHO we're only going to notice a
difference for the time needed to run the testsuite.

Best regards,
-- 
Yann.
