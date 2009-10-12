From: Sal Mangano <smangano@into-technology.com>
Subject: Re: Supressing sorting of trees
Date: Mon, 12 Oct 2009 15:43:52 +0000 (UTC)
Message-ID: <loom.20091012T171550-239@post.gmane.org>
References: <loom.20091012T152113-874@post.gmane.org> <20091012142032.GG9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 17:57:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxNHE-0003Ws-V1
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 17:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbZJLPo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 11:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755084AbZJLPo4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 11:44:56 -0400
Received: from lo.gmane.org ([80.91.229.12]:37119 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752735AbZJLPoz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 11:44:55 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MxN4M-0005AK-Fu
	for git@vger.kernel.org; Mon, 12 Oct 2009 17:44:18 +0200
Received: from ool-18bd213f.dyn.optonline.net ([24.189.33.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 17:44:18 +0200
Received: from smangano by ool-18bd213f.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 17:44:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.189.33.63 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.25 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130028>

Shawn O. Pearce <spearce <at> spearce.org> writes:

> 
> Sal Mangano <smangano <at> into-technology.com> wrote:
> > I am using Git in a non-standard way and need to make a few twaeks in my 
> > custom build. I have added a --nosort option to git mktree which will 
suppress
> > the qsort of the tree. 
> > 
> > Will this break any other git functions? Are there any commands that assume 
> > trees are always sorted?
> 
> _YES IT BREAKS GIT_.
> 
> You cannot do this.
> 
> A Git repository whose trees are not sorted according to the Git
> specific sort ordering is severly broken and most tools will fail
> horribly on it.
> 
> Almost all code which reads trees assumes the names are sorted in a
> specific order.  These tools perform sorted merges against other tree
> like structures.  If the names are out of order the merge will fail.
> `git fsck` will complain that the tree is not sorted properly.
> Tools like `git log -- foo.c` will fail randomly because they break
> out of the entry lookup as soon as they find a name that is after
> foo.c, as they assume the tree is sorted.
> 
> I could go on.  But there is no point.
> 
> Oh, and trust me when I say this, the tree sorting matters.  Long ago
> JGit had a bug where it didn't sort trees correctly all of the time
> and we had a devil of a time tracking down that corruption.
> 

Thanks Shawn. I get the picture. 

Now, let's assume I am stubborn, crazy or both :-)

I can modify fsck to ignore unsorted and at the moment I don't care about 
merging trees. If I hunt down all usage of base_name_compare will that identify 
all code with the sort assumption or is there other places as well? I can go 
through the entire source to figure this out myself but I need to get something 
hacked up very quickly and would appreciate help even if you think I am nuts! 
