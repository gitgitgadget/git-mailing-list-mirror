From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Supressing sorting of trees
Date: Mon, 12 Oct 2009 07:20:32 -0700
Message-ID: <20091012142032.GG9261@spearce.org>
References: <loom.20091012T152113-874@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sal Mangano <smangano@into-technology.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:25:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxLpW-0003mq-QX
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbZJLOVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbZJLOVJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:21:09 -0400
Received: from george.spearce.org ([209.20.77.23]:55392 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193AbZJLOVI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:21:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 741D0381FE; Mon, 12 Oct 2009 14:20:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20091012T152113-874@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130017>

Sal Mangano <smangano@into-technology.com> wrote:
> I am using Git in a non-standard way and need to make a few twaeks in my 
> custom build. I have added a --nosort option to git mktree which will suppress
> the qsort of the tree. 
> 
> Will this break any other git functions? Are there any commands that assume 
> trees are always sorted?

_YES IT BREAKS GIT_.

You cannot do this.

A Git repository whose trees are not sorted according to the Git
specific sort ordering is severly broken and most tools will fail
horribly on it.

Almost all code which reads trees assumes the names are sorted in a
specific order.  These tools perform sorted merges against other tree
like structures.  If the names are out of order the merge will fail.
`git fsck` will complain that the tree is not sorted properly.
Tools like `git log -- foo.c` will fail randomly because they break
out of the entry lookup as soon as they find a name that is after
foo.c, as they assume the tree is sorted.

I could go on.  But there is no point.

Oh, and trust me when I say this, the tree sorting matters.  Long ago
JGit had a bug where it didn't sort trees correctly all of the time
and we had a devil of a time tracking down that corruption.

-- 
Shawn.
