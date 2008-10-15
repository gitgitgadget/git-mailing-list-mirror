From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 12:49:49 -0700
Message-ID: <20081015124949.b657a8db.akpm@linux-foundation.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
	<alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
	<alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
	<alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:51:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCOk-0000mL-Av
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbYJOTt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbYJOTt5
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:49:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44878 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752899AbYJOTt5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 15:49:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FJnnE0006263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Oct 2008 12:49:50 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m9FJnn1n028528;
	Wed, 15 Oct 2008 12:49:49 -0700
In-Reply-To: <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.869 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98311>

On Wed, 15 Oct 2008 12:31:40 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Wed, 15 Oct 2008, david@lang.hm wrote:
> > 
> > the fact that git will happily leave modified things in the working directory
> > appears to be very helpful for some developers, but it's also a big land mine
> > for others.
> 
> Hmm. It doesn't actually do that normally. If you switch between trees, 
> git will (or _should_) remove the old files that it knows about. If you 
> get a lot of left-over turds, there's something wrong.
> 
> It could be a git bug, of course. That said, especially considering the 
> source of this, I wonder if it's just that Andrew ends up using all those 
> non-git scripts on top of a git tree, and then that can result in git 
> *not* knowing about a certain file, and then when switching between trees 
> (with either git checkout or with git reset), the data that was created 
> with non-git tools gets left behind and now git will be afraid to 
> overwrite it.

I treat my git directory as a read-only thing.  I only ever modify it
with git commands.

> So yes, there are ways to force it (both "git checkout -f"  and "git reset 
> --hard" having already been mentioned), but the need for that - especially 
> if it's common - is a bit discouraging.
> 
> Especially since it's still possible that it's some particular mode of git 
> usage that leaves those things around. Andrew - have you any clue what it 
> is that triggers the behavior?

Sorry, no, I haven't seen a pattern.

> (By the filename, I realize it's a file that doesn't exist in one tree or 
> the other, and which doesn't get removed at some point. But have you had 
> merge failures, for example? Is it perhaps a file that was created during 
> a non-clean merge, and then got left behind due to the merge being 
> aborted? It would be interesting to know what led up to this..)

That's certainly a possibility - I get a lot of merge failures.  A real
lot.  And then quite a bit of rebasing goes on, especially in
linux-next.  And then there's all the other stuff which Stephen does on
top of the underlying trees to get something releasable happening.
