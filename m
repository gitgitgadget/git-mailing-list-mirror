From: Sam Hocevar <sam@zoy.org>
Subject: Re: git-p4 workflow suggestions?
Date: Mon, 16 Mar 2009 19:01:09 +0100
Message-ID: <20090316180108.GE27280@zoy.org>
References: <20090309142108.GK12880@zoy.org> <20090311125805.GA28155@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 19:04:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjHA0-0004KN-2q
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 19:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761926AbZCPSBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 14:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759272AbZCPSBO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 14:01:14 -0400
Received: from poulet.zoy.org ([80.65.228.129]:50312 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761957AbZCPSBM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 14:01:12 -0400
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 09326120412; Mon, 16 Mar 2009 19:01:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090311125805.GA28155@padd.com>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113350>

On Wed, Mar 11, 2009, Pete Wyckoff wrote:
> sam@zoy.org wrote on Mon, 09 Mar 2009 15:21 +0100:
> >    I have modified git and git-p4 to a point where they are usable in
> > my work environment. I am now faced with a new problem: Perforce's
> > composite workspaces. They allow you to "mount" parts of the repo onto
> > other directories, even nonempty ones.
> > 
> >    Take the following example repository, where a "framework" project
> > contains an example subdirectory with build files and other directories,
> > and a "project1" project contains subdirectories that are meant to
> > replace the ones in "example":
> > 
> >    //work/framework/example/src/
> >                            /include/
> > 			   /Makefile
> > 			   /...
> >    //work/project1/src/
> >                   /include/
> 
> In perforce terms, your "view mapping" looks like:
> 
>     //work/framework/example/src/... //client/src/...
>     //work/project1/src/include/...  //client/src/include/...

   Yes, like this. More precisely:

    //work/framework/example/... //client/...
    //work/project1/src/...  //client/src/...
    //work/project1/include/...  //client/include/...

> I'm not a pro with p4, but do deal with many-line mappings like
> this.  Stock git-p4 handles these, except doesn't map correctly to
> the right-hand side.  I haven't tried to see if it would correctly
> use the include files from project1 instead of framework in your
> example.

   No luck here. If I clone //work with git-p4, I get two separate
/framework and /project1 directories, and the mapping is not done.

   The "solution" I found so far was to clone //work and hack git-p4
so that it ignores //work/framework/example/src, and then symlink
//work/project1/src to //work/framework/example/src. This allows me to
pull changes with a single "git-p4 rebase" command. Unfortunately it
also requires me to clone a full, separate //work p4 workspace in order
to use "git-p4 submit" later, and that's more than 120 GiB wasted.

> If you can get git-p4 to figure out the mapping correctly, I don't
> expect any problems with respect to atomicity of commits.  As far as
> perforce goes, a server seems to manage its entire p4 space as one
> big single project.  Similarly with the git side of things---it's
> just a matter of getting this mapping correct.
> 
> I too hacked the getClientSpec() part of git-p4 to put files into
> the correct directories in the git side.  My changes are a bit
> messy, and may interfere with other usage models, hence not
> submitted.  Maybe we should make an effort to get this right though.
> Do you have any changes to show how you are modifying things?

   I'm curious to see your changes. I don't feel I completely understand
the p4 way to do things yet.

   My changes are extremely messy but I will refactor them as time goes.
There is at least one other important thing my git-p4 does, which is not
storing the whole commit in memory. Combined with the patches I sent
last week to this list, it's the only way I can import the p4 repository
we have at work. (See http://zoy.org/~sam/git/clumsily-hacked-git-p4)

   Feel free to contact me in private if you have questions or want
information that may not be mailing-list relevant. I'm all for cleaning
up things and getting a fully featured git-p4. I'm on that project for
at least three years, and there is absolutely no way my blood pressure
can stand that long with Perforce.

Cheers,
-- 
Sam.
