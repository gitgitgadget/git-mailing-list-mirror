From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] undo and redo
Date: Wed, 24 Aug 2005 11:51:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508241148480.3317@g5.osdl.org>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com> <20050824181004.GA18790@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 20:59:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E80Rp-0002N8-TK
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 20:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVHXS5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 14:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVHXS5y
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 14:57:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37047 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751387AbVHXS5y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 14:57:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7OIpXjA024480
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 Aug 2005 11:51:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7OIpWtH031184;
	Wed, 24 Aug 2005 11:51:32 -0700
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050824181004.GA18790@hpsvcnb.fc.hp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7721>



On Wed, 24 Aug 2005, Carl Baldwin wrote:
>
> Oops.  I forgot to actually exit from the script if git-diff-files is
> non-empty.
> 
> Also, looking at it now, I don't think keeping undo information in a
> stack is the right thing.  But keeping more than just one would be good.
> Oh well, my first shot is never perfect.  ;-)

I would actually argue that

	git checkout -b newbranch <undo-point>

is the perfect undo.

It leaves the old state in the old branch, and creates a new branch (and
checks it out) with the state you want to revert to. The advantage is
exactly that there is no "stack" of undo's: you can have multiple
independent undo's pending, and you can continue development at any of 
them. And merge the results together.

Of course, right now we don't have a "delete branch" command, but it's 
really as simple as

	rm .git/refs/heads/branchname

(and eventually you may want to do a "git prune" to get rid of stale
objects, but that's a separate issue).

		Linus
