From: Matt Draisey <mattdraisey@sympatico.ca>
Subject: Re: symlinked directories in refs are now unreachable
Date: Thu, 18 Aug 2005 17:56:36 -0400
Message-ID: <1124402196.1557.41.camel@della.draisey.ca>
References: <1124073677.27393.15.camel@della.draisey.ca>
	 <7v64u7941c.fsf@assigned-by-dhcp.cox.net>
	 <1124089116.749.39.camel@della.draisey.ca>
	 <1124171194.762.74.camel@della.draisey.ca>
	 <7vbr3yl7oz.fsf@assigned-by-dhcp.cox.net>
	 <1124246082.776.54.camel@della.draisey.ca>
	 <7vslx8thx9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:02:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5sSo-0003m4-3j
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 00:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVHRWCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 18:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVHRWCP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 18:02:15 -0400
Received: from tomts36.bellnexxia.net ([209.226.175.93]:50150 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932484AbVHRWCP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 18:02:15 -0400
Received: from Windsor-ppp121588.sympatico.ca ([216.209.168.73])
          by tomts36-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050818220213.HSBI16985.tomts36-srv.bellnexxia.net@Windsor-ppp121588.sympatico.ca>;
          Thu, 18 Aug 2005 18:02:13 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslx8thx9.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thanks for committing my one-character patch.  In the commit message you
said 

> Come to think of
> it, maybe we should disallow symlink inside .git/refs hierarchy;
> we update the files there by creat/rename pair, so having
> symlinks would not work anyway when you do anything that would
> update them.]

I agree, linking at the file level makes no sense ---  create/rename
pairs will clobber symlinked files (as they would for hardlinked files).
If you accept their use at all, symlinked directories are the only way
to go.

The alternatives to symlinked directories are:

(1) adding a command line option to fsck that supplies a path to an
external refs directory

(1a) adding a subtool to create a commandline list of sha from a
supplied path to an external refs directory

(2) adding an environment variable to do the same

(3) adding a .git configuration file which contains a path --- this is
just a userspace symlink

(4) create a monster (refcounting objects?) (true cross-references?)
(conservative garbage collectors that scan your entire hard disk for
potential references)

(I believe the same arguments hold for the pulling code as for fsck)

Case (1) is easy to implement. (I whipped up a working patch yesterday)
The hardest part is thinking up a good name for the command line
argument.  Case (1a) is too ugly.  Both of these cases place a
considerable burden on the user, and require some Porcelain work.  Case
(2) makes sense but is too intrusive for me to contemplate.  I defer to
a core developer.  Case (3) offers no advantages over a symlinked
directory under refs.  Case (4) is probably patented by Microsoft.

I like symlinks for their simplicity, and that they work now.  Otherwise
I am a really only submitting a feature request.

Matt
