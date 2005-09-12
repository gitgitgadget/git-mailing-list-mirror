From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [RFH] Merge driver
Date: Mon, 12 Sep 2005 23:08:13 +0200
Message-ID: <20050912210813.GA6644@c165.ib.student.liu.se>
References: <7v1x407min.fsf@assigned-by-dhcp.cox.net> <431F34FF.5050301@citi.umich.edu> <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net> <4320536D.2010706@citi.umich.edu> <7v7jdrwlih.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509081012540.3208@g5.osdl.org> <43207FE6.2030108@citi.umich.edu> <Pine.LNX.4.58.0509081131070.5940@g5.osdl.org> <432089D8.4060507@citi.umich.edu> <7v3boen0rb.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, cel@citi.umich.edu,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 23:10:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEvXQ-0006ev-0B
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 23:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVILVIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 17:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVILVIY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 17:08:24 -0400
Received: from [85.8.31.11] ([85.8.31.11]:61932 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932247AbVILVIY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 17:08:24 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A19644119; Mon, 12 Sep 2005 23:13:14 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EEvXB-0001rM-00; Mon, 12 Sep 2005 23:08:13 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3boen0rb.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8429>

On Fri, Sep 09, 2005 at 12:44:40AM -0700, Junio C Hamano wrote:

...

> *1* Fredrik, I have been wondering if we can just say that lack
> of '-u' flag implies '-i'.  Is there a good reason that
> 'git-read-tree -m O A B' without '-u' should care if working
> tree is up to date for the paths involved?

No, I don't think so. But it would be nice if one could use '-i'
together with '-u'.

The current git-merge-fredrik.py does not use '-i' together with '-u',
but I plan to change that. Currently we assume that the index is
uptodate when we start the merge. If the two branches have more than
one common ancestor those ancestors are merged into a temporary tree,
lets call it T, without touching the working directory.

The final steps of the merge are currently the following steps (lets
say we want to merge A with B):

git-read-tree A
git-update-cache --refresh
git-read-tree -u -m T A B

We need the second step because otherwise git-read-tree will complain
that the cache isn't uptodate. But we _know_ that the contents are
uptodate, so the second step is unnecessary and just eats time. So,
instead of doing the above we should be able to do:

git-read-tree A
git-read-tree -u -i -m T A B

I have a patch which implements this and it _seems_ to work fine. Is
it reasonable to things this way or have I missed something?


- Fredrik
