From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] translate bad characters in refnames during git-svn fetch
Date: Sat, 28 Jul 2007 07:23:11 +0000 (UTC)
Message-ID: <loom.20070728T091909-416@post.gmane.org>
References: <20070715130548.GA6144@piper.oerlikon.madduck.net> <20070716033050.GA29521@muzzle> <20070716111509.GC18293@efreet.light.src> <20070715130548.GA6144@piper.oerlikon.madduck.net> <20070716033050.GA29521@muzzle> <20070716174731.GA4792@lapse.madduck.net> <20070717122852.GA21372@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 09:25:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEgfo-0000cU-Uv
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 09:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759943AbXG1HZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 03:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759927AbXG1HZJ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 03:25:09 -0400
Received: from main.gmane.org ([80.91.229.2]:45087 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbXG1HZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 03:25:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IEgfe-0000S7-8K
	for git@vger.kernel.org; Sat, 28 Jul 2007 09:25:04 +0200
Received: from APuteaux-153-1-62-229.w82-124.abo.wanadoo.fr ([82.124.140.229])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 09:25:02 +0200
Received: from mh by APuteaux-153-1-62-229.w82-124.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 09:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.124.140.229 (Epiphany/2.18.3-1 (Debian) Gecko/1.8.1.5-1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54001>

Eric Wong <normalperson <at> yhbt.net> writes:
> martin f krafft <madduck <at> madduck.net> wrote:
> > also sprach Eric Wong <normalperson <at> yhbt.net> [2007.07.16.0530 +0200]:
> > > The major issue with this is that it doesn't handle odd cases
> > > where a refname is sanitized into something (say "1234~2"
> > > sanitizes to "1234=2"), and then another branch is created named
> > > "1234=2".
> > 
> > Well, we can't please everyone, can we? :)
> > 
> > I like Jan's proposal about using the % escape, even though it
> > doesn't make pretty branch names.
> 
> I like it, too.  How about something like the two functions below?  This
> will break things a bit for people currently using % in refnames,
> however.
> 
> I think this will work rather nicely once I've figured out how the path
> globbing code works[1] and where to sanitize/desanitize the refnames
> properly.
> 
> It would be far easier to take your approach and sanitize them only
> for the command-line, but storing unsanitized git refnames into the
> .git/config is something I want to avoid:
> 
>   Somebody naming directories on the SVN side with the path component
>   ":refs/remotes" in them could screw things up for us.

Why not "simply" allow some form of escaping in refs, such that special
characters CAN be used anywhere. Then git-svn would just have to escape these
characters.

Something like:
git update-ref "refs/remotes/tags/sometag\~1" $sha1

I'm pretty sure that could help fix a lot of other similar issues.

Mike
