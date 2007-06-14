From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 22:21:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org>
References: <18031.64456.948230.375333@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 07:21:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyhmG-0004qL-MN
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 07:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbXFNFVr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 01:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbXFNFVr
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 01:21:47 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37951 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750775AbXFNFVq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2007 01:21:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5E5LilQ010595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Jun 2007 22:21:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5E5LcQi018502;
	Wed, 13 Jun 2007 22:21:38 -0700
In-Reply-To: <18031.64456.948230.375333@lisa.zopyra.com>
X-Spam-Status: No, hits=-2.636 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50167>



On Wed, 13 Jun 2007, Bill Lear wrote:
>
> We have some CVS users who complain that they cannot do a pull
> into a dirty working tree, as they could under CVS.

Well, a lot of people have told you that the answer is "don't do that", 
but I actually somewhat disagree.

I think it might be perfectly fine to allow for a *fast-forward* pull to 
do a three-way merge on the working tree, assuming the index is clean in 
the paths that got modified.

For a real merge (not just a fast-forward), we really *really* must not do 
it, for a very simple reason: we have no sane way to handle conflicts if 
we have both a merge from the pull itself _and_ a merge from the working 
tree. Don't get me wrong: I'm sure it's possible in theory, I just think 
that in practice it's such a total hairball that it's not worth it!

So I think we could actually try to allow "git pull" with a fast-forward 
pull and a dirty working tree.

(We obviously _already_ allow a working tree that is dirty in the paths 
that don't actually get changed at all! I use that all the time. So this 
is strictly limited to the "dirty state actually overlaps with what got 
pulled!)

It might make it a bit easier for CVS people to get used to the git model: 
keep your dirty working tree, and do "git pull" to update it, and fix up 
any conflicts in the working tree. That's how CVS works - it's a bad 
model, but it's a model that may be worth supporting just to get people 
more easily into the _good_ model.

		Linus
