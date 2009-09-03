From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: git-svn-Cloning repository with complicate nesting
Date: Thu, 03 Sep 2009 12:50:24 -0400
Message-ID: <4A9FF3D0.9040606@xiplink.com>
References: <9accb4400908270132vaccc4eegb58e2f0ee8de0797@mail.gmail.com>	 <4A9FD34A.7020101@xiplink.com> <9accb4400909030917y2e8d4c97tef1320c05d4c4e1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 19:01:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjFgm-0000ml-24
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 19:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbZICRB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 13:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbZICRBZ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 13:01:25 -0400
Received: from smtp122.dfw.emailsrvr.com ([67.192.241.122]:37710 "EHLO
	smtp122.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbZICRBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 13:01:25 -0400
X-Greylist: delayed 661 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2009 13:01:25 EDT
Received: from relay12.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay12.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 304D220802FB;
	Thu,  3 Sep 2009 12:50:27 -0400 (EDT)
Received: by relay12.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id EAF8320802A1;
	Thu,  3 Sep 2009 12:50:26 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <9accb4400909030917y2e8d4c97tef1320c05d4c4e1c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127663>

Daniele Segato wrote:
> 
> hum...
> It could be an idea but I don't know how hard could it be to check it:
> how much deep inside the tree should Git search for branch?

Well, as far as it takes.  Actually, the search should be fairly well constrained.  After checking that the entries under a particular path aren't a copy of the trunk, each entry can only represent either a branch that git-svn already knows about, or a new branch.

> what if there are branches that are completely differents?

Not sure what you mean there.  Can you come up with an example of this?

> may be the user could create and pass a "branch model" to git svn to
> make it able to decide what is a branch and what isn't.
> 
> I think there are many options
> 
> In my case It would have worked defining a structure like:
> BRANCHES/*/root -> remote/svn/branch/*
> BRANCHES/*/*/root -> remote/svn/branch/*/*
> 
> But it would be better with something like:
> BRANCHES/\([^\/]+\)/root -> remote/svn/branch/$1
> BRANCHES/\([^\/]+\)/\([^\/]+\)/root -> remote/svn/branch/$1/$2
> 
> like a grouped regex.
> 
> every branch not matching the regex will be skipped..
> only an idea.. It couln't work in every situation but it would allow a
> greater degree of freedom in the configuration.

Turning the branch refspecs into true regular expressions sounds like a good idea to me, and would probably be easier to implement than the trunk-detection stuff I proposed.  Though there'd have to be a way to stay compatible with or upgrade the current non-regex refspecs.

> I don't know if Git developers are interested in thinking on some
> features like this.. it sound like an SVN-only hack to me.

All of git-svn is already a hack for dealing with SVN.  :)  I'm sure a patch for this would be welcome.

		M.
