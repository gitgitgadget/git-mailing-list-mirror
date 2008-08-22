From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Linux 2.6.27-rc3: kernel BUG at mm/vmalloc.c - bisected
Date: Fri, 22 Aug 2008 10:51:36 -0700
Message-ID: <20080822105136.a8432875.akpm@linux-foundation.org>
References: <48A36838.3050309@hp.com>
	<20080819124602.9e8e69f7.akpm@linux-foundation.org>
	<48AEDD3D.4060507@hp.com>
	<20080822092549.ddcb7e79.akpm@linux-foundation.org>
	<20080822171651.GP10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alan.Brunelle@hp.com, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 22 19:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWaoa-0008Ul-W4
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 19:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbYHVRvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 13:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbYHVRvo
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 13:51:44 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46570 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094AbYHVRvn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 13:51:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7MHpb3i018683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Aug 2008 10:51:38 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m7MHpa1m008256;
	Fri, 22 Aug 2008 10:51:36 -0700
In-Reply-To: <20080822171651.GP10544@machine.or.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.837 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93334>

On Fri, 22 Aug 2008 19:16:51 +0200
Petr Baudis <pasky@suse.cz> wrote:

> On Fri, Aug 22, 2008 at 09:25:49AM -0700, Andrew Morton wrote:
> > On Fri, 22 Aug 2008 11:37:33 -0400 "Alan D. Brunelle" <Alan.Brunelle@hp.com> wrote:
> > 
> > > I /did/ bisect it down to the aforementioned merge, the question is: How
> > > to crack open that merge into it's composite pieces? (Where do I go to
> > > bisect within that?)
> > 
> > urgh, it's irritating when git-bisect directs you to a merge commit - it
> > hasn't done it for me for ages.
> 
> Hmm, but doesn't that happen only when it's actually really the merge
> commit that introduces the bug? Both parents of the merge commit were
> marked as good by the user, so...

A merge commit doesn't contain any kernel changes?  It's the individual
commits (aka "patches") which were in that merge which broke stuff. 
Confused.

We're trying to dive inside that merge commit to find out which of the
real commits caused the regression.

> > One (probably wrong) approach is to run
> > 
> > 	gitk 1c89ac55017f982355c7761e1c912c88c941483d
> > 
> > then peer at the output, work out which real commits were in that
> > merge.
> > 
> > It looks like the merge ended with
> > b1b135c8d619cb2c7045d6ee4e48375882518bb5 and started with
> > 40c42076ebd362dc69210cccea101ac80b6d4bd4, so perhaps you can do
> > 
> > 	git bisect bad b1b135c8d619cb2c7045d6ee4e48375882518bb5
> > 	git bisect good 40c42076ebd362dc69210cccea101ac80b6d4bd4
> 
> ...I don't quite get this - according to the bisection log,
> 
> 	# good: [b1b135c8d619cb2c7045d6ee4e48375882518bb5] fix spinlock recursion in hvc_console
> 
> and now you want to mark it as bad?

<what bisection log?>

I assume that Alan's bisection search ended up saying that the merge
commit (1c89ac55017f982355c7761e1c912c88c941483d) was the first bad
commit.

Now I don't know what's going on.

> You could try to revert some of the merged commits at the point of the
> merge, though.
