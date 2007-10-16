From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to Import a bitkeeper repo into git
Date: Mon, 15 Oct 2007 17:45:44 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>
 <20070709173720.GS29994@genesis.frugalware.org>
 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
 <4713FA4A.5090501@bluelane.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Pete/Piet Delaney <pete@bluelane.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 02:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhaZn-0007vl-77
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 02:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbXJPAqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 20:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756547AbXJPAqQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 20:46:16 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59590 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752882AbXJPAqP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 20:46:15 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9G0jjdQ009799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Oct 2007 17:45:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9G0jikx001234;
	Mon, 15 Oct 2007 17:45:45 -0700
In-Reply-To: <4713FA4A.5090501@bluelane.com>
X-Spam-Status: No, hits=-2.718 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61059>



On Mon, 15 Oct 2007, Pete/Piet Delaney wrote:
> 
> I imported the CVS repository to git and it worked great. Since all
> of our other repository are in bitkeeper the management would like to
> stick with CVS. With git apparently still being weak in the area of
> supporting difftool on different version that seems somewhat reasonable
> for the time being.

I can't see how bk's difftool could possibly have any relevance to the 
"reasonable to stick with CVS" decision, but hey, I'm always surprised by 
peoples inventiveness in rationalizing their decisions ;)

I don't know what difftool does that a simple

	git diff -U99 | viewdiff -

wouldn't do, but in all honesty, I don't think I ever used difftool (I 
found the other tools in bk much more useful - eg mergetool, renametool)

I don't actually know of any sane programs to view unified diffs, but you 
can script one with little trouble. Here's a really hacky one I just came 
up with:

	#!/bin/sh
	cat "$@" > /tmp/diff
	grep '^[ -]' /tmp/diff > /tmp/orig
	grep '^[ +]' /tmp/diff > /tmp/result
	meld /tmp/orig /tmp/result

which fools 'meld' into showing a unified diff in a nice graphical manner.

[ Quite frankly, I don't understand why tools like meld and kdiff3 can't 
  just take the unified diff directly - they have *all* the logic, it 
  should be trivial to do, and very useful to view diffs for those people 
  who like that graphical bling. ]

> The folks at bitmover are converting you kernels to bk and it's
> maintaining the branch history and I'd like to do the same. So far
> they haven't help us convert the git repository to bk. Do you happen
> to know of someone else that might now how to do this in case the
> folks at bitmover can't provide the scripts to convert this git
> repository to bk?

Hmm. Converting from git to bk should not be that hard at least 
conceptually, but no, I have no idea how to script it sanely and 
efficiently. The obvious solutions all would want to have multiple active 
heads of development open at the same time (Larry calls them "LOD's" not 
branches), and would also require some way to set the result of a merge. 
Neither of which I would know how to do in BK (I created a lot of merges 
in BK, but I always let BK do the merging - I wouldn't know how to specify 
the merge result by hand).

		Linus
