From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on Subproject Support
Date: Mon, 23 Jan 2006 17:50:57 -0800
Message-ID: <7v8xt6xuke.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601222104120.25300@iabervon.org>
	<7v7j8r7e7s.fsf@assigned-by-dhcp.cox.net>
	<7v64ob1omh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601231200380.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 02:51:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1DKv-0002tx-GC
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 02:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWAXBvB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 20:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWAXBvB
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 20:51:01 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56826 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030291AbWAXBvA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2006 20:51:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060124014943.IDPI6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 Jan 2006 20:49:43 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15090>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ... Do you see an advantage to having the index only record the 
> information used for making a tree, and keeping the information for making 
> a commit in other files?

If somebody else already did the work and presented me two git
implementations, one with the index file capable of generating a
tree and uses separate files to keep track of other information
for commits, and the other with the index file with everything
needed for a commit, I'd certainly take the latter.  In that
sense, I do not see such an advantage at all.  The practical
advantage of keeping them separate is to keep things simple,
minimizing the changes.  I see the subproject support as a
secondary issue, and so far I haven't found a reason convincing
enough to tell me that it is better to put HEAD+heads/$branch
information in the index itself when used in a subproject-less
setup.  It perhaps would make us more robust when interrupted in
the middle of switching branches or making a commit, but that is
about it (I do not particularly see that a serious problem).

>> *1* One good property of "gitlink" approach is that we *could*
>> extend this blob-like object to store arbitrary human readable
>> information to represent a point-in-time from an arbitrary
>> foreign SCM system.  IOW, we do not necessarily have to require
>> `commit` line that name a git commit to be there.  It could say
>> "Please slurp http://www.kernel.org/pub/software/.../git.tar.gz
>> and extract it in git/ directory".
>> ...
> I don't think this would really be useful. The reason to have the included 
> revision stored in a way that's explicitly marked for git to find is that 
> git can do useful things with the information ...
> but more importantly, making sure that changes to what revision 
> you're working with propagate to changes in what revision you specify 
> should be there)...

My example was taking things to the extreme to be illustrative.

To be more practical, it could have pointed at "git-1.0.tar.gz"
or an "svn://" URL with explicit revision name, which ought to
be enough to recreate the exact state.
