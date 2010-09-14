From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Coping with the pull-before-you-push model
Date: Tue, 14 Sep 2010 12:49:17 -0400
Message-ID: <20100914164917.GA3730@thunk.org>
References: <4C8866F9.1040705@workspacewhiz.com>
 <AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com>
 <4C88F2A9.2080306@workspacewhiz.com>
 <AANLkTikdV3W1d7uNokKRRiT4FeznL1uM=Y9SQLDqgAic@mail.gmail.com>
 <20100910141527.GA6936@sigill.intra.peff.net>
 <4C8EFE62.7080908@workspacewhiz.com>
 <D4360EBB-7891-457E-A6AC-7159CADCAC6C@mit.edu>
 <4C8F99FA.3040003@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jon Seymour <jon.seymour@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 18:49:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvYhK-0005Gv-Tl
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 18:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab0INQt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 12:49:28 -0400
Received: from THUNK.ORG ([69.25.196.29]:35833 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509Ab0INQt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 12:49:28 -0400
Received: from root (helo=tytso-glaptop)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OvYhA-0000FA-LJ; Tue, 14 Sep 2010 12:49:24 -0400
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OvYh9-0001Ir-Iq; Tue, 14 Sep 2010 12:49:23 -0400
Content-Disposition: inline
In-Reply-To: <4C8F99FA.3040003@workspacewhiz.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156201>

On Tue, Sep 14, 2010 at 09:51:22AM -0600, Joshua Jensen wrote:
> How does the integration with Gerrit work here?  The only thing that
> comes to mind is that you do something like:
> 
> git push gerrit HEAD:refs/for/merged-master

So we'll push to something to, say, refs/heads/fs/ext4/for-merged on
the gerrit server, and let gerrit do its thing.  After a colleague
approves all of the patches in the branch, gerrit will release the
commits to the branch, and only then will the mergitator script
attempt to do a trial merge of the effort branch with the
merged/master branch.  If the trial merge succeeds, then it will
attempt to do a trial compile.  If the trial compile succeeds then the
merged/master branch will be updated with the commit id of the trial
merge, and then the mergitator script will move on to the next effort
branch will has been updated.  If the mergitator fails to merge a
particular branch, then an e-mail is sent out explanining the cause of
the merge failure, so a human can fix things up.  This could be done
by cherry-picking a commit from merged/master which caused the merge
conflict, and then fixing up the merge conflict, for example.

A wise developer will do a trial merge on their own *before*
submitting their effort branch to gerrit for code review, but this is
not strictly speaking required.

						- Ted
