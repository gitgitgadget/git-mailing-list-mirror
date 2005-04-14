From: Christopher Li <git@chrisli.org>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 16:24:21 -0400
Message-ID: <20050414202421.GC25468@64m.dyndns.org>
References: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org> <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 01:31:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDo6-0007Ce-BZ
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVDNXe4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVDNXet
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:34:49 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:14525 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261652AbVDNXeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 19:34:22 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc11) with ESMTP
          id <200504142334220110029oi5e>; Thu, 14 Apr 2005 23:34:22 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 409CF3F1EF; Thu, 14 Apr 2005 16:24:21 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I think if the merge tree belong to plumbing, you can do
even less in the merge.perl. You can just print out the
instruction for the upper level SCM what to to without
actually doing it yourself.

So you don't have to do touch anything in the tree.
That is the way I use in my previous python script.
You just print out some easy to modify  

e.g. in my python script it prints: (BTW, poor choice of print out name)

check out tree 253290af8b9ebc8565dd8de4cda24d0432a92b57
modify pre-process.c 7684c115a87e41a9226ce79478101c746cf22c34
3way-merge check.c dcb970cc1c5a83284dc5986abf07b6da76a8758c f77bfe119c19d928879091e0e3ee6debe3f1e1bf d315b43b025350d0107568a4d42cc2494d38621d

Your merge tree can do the smae.

Then the supper level SCM can easily follow instruction.
Save your effort and make no assumption what SCM module is.

Chris

On Thu, Apr 14, 2005 at 04:12:34PM -0700, Junio C Hamano wrote:
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> I think you are contradicting yourself for saying the above
> after agreeing with me that the script should just work on trees
> not commits.  My understanding is that the tools is just to
> merge two related trees relative to another ancestor tree,
> nothing more.  Especially, it should not care what is in the
> working directory---that is SCM person's business.
> 
> I am just trying to follow my understanding of what Linus
> wanted.  One of the guiding principle is to do as much things as
> in dircache without ever checking things out or touching working
> files unnecessarily.
> 
> PB> This will give the tool maximal flexibility.
> 
> I suspect it would force me to have a working directory
> populated with files, just to do a merge.
> 
> PB> I'm all for an -o, and I don't mind ,, - I just don't want it uselessly
> PB> long. I hope "git~merge~$$" was a joke... :-)
> 
> Which part do you object to?  PID part?  or tilde?  Would
> git~merge do, perhaps?  It probably would not matter to you
> because as an SCM you would always give an explicit --output
> parameter to the script anyway.
> 
> PB> By the way, what about indentation with tabs? If you have a
> PB> strong opinion about this, I don't insist - but if you
> PB> really don't mind/care either way, it'd be great to use tabs
> PB> as in the rest of the git code.
> 
> I do not have a strong opinion, but it is more trouble for me
> only because I am lazy and am used to the indentation my Emacs
> gives me.  I write code other than git, so changing Perl-mode
> indentation setting globally for all .pl files is not an option
> for me.  I'll see what I can do when I have time.
> 
> PB> Is there a fundamental reason why the directory cache
> PB> contains the ancestor instead of the destination branch?
> 
> Because you are thinking as an SCM person where there are
> distinction between tree-A and tree-B, two heads being merged.
> There is no "destination branch" nor "source branch" in what I
> am doing.  It is a merge of two equals derived from the same
> ancestor.
> 
> PB> I think the script actually does not fundamentally depend on it. My main
> PB> motivation is that the user can then trivially see what is he actually
> PB> going to commit to his destination branch, which would be bought for
> PB> free by that.
> 
> And again the user is *not* commiting to his "destination
> branch".  At the level I am working at, the merge result should
> be commited with two -p parameters to commit-tree --- tree-A and
> tree-B, both being equal parents from the POV of git object
> storage.
> 
> PB> And this is another thing I dislike a lot. I'd like merge-tree.pl to
> PB> leave my directory cache alone, thank you very much. You know, I see
> PB> what goes to the directory cache as actually part of the policy part.
> 
> Remember I am not touching *your* dircache.  It is a dircache in
> the temporary merge area, specifically set up to help you review
> the merge.  
> 
> Can't the SCM driver do things along this line, perhaps?
> 
>  - You have your working files and your dircache.  They may not
>    match because you have uncommitted changes to your
>    environment.  You want to merge with Linus head.  You know
>    its SHA1 (call it COMMIT-Linus).  Your SCM knows which commit
>    you started with (call it COMMIT-Current).
> 
>  - First you merge the tree associated with COMMIT-Current.  Use
>    it and COMMIT-Linus to find the common ancestor to use.
> 
>  - Now use the tree SHA of COMMIT-Current, tree SHA1 of
>    COMMIT-Linus, and tree SHA1 of the common ancestor commit to
>    drive git-merge.perl (to be renamed ;-).  You will get a
>    temporary directory.  Have your user examine what is in
>    there, and fix the merge and have them tell you they are
>    happy.
> 
>  - You go to that temporary directory, do write-tree and
>    commit-tree with -p parameter of COMMIT-Linus and
>    COMMIT-Current.  This will result in a new commit.  Call that
>    COMMIT-Merge.
> 
>  - You, as an SCM, should know what your user have done in the
>    working directory relative to COMMIT-Current.  Especially you
>    should know the set of paths involved in that change.  Go in
>    to the temporary area, checkout-cache those files if you have
>    not done so.  Apply the changes you have there.  Optionally
>    have the user examine the changes and have him confirm.  Lift
>    those files into the user's working directory.
> 
>  - Do your bookkeeping like "echo COMMIT-Merge >.git/Head", to
>    make the user's working files based on COMMIT-Merge, and run
>    read-tree using the COMMIT-Merge in the user's working
>    directory.  At this point, show-diff output should show what
>    the changes your user have had made if he had started working
>    based on COMMIT-Merge instead of starting from
>    COMMIT-Current.
> 
> I think the above would result in what SCM person would call
> "merge upstream/sidestream changes into my working directory".
> 
