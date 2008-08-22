From: Petr Baudis <pasky@suse.cz>
Subject: Re: Linux 2.6.27-rc3: kernel BUG at mm/vmalloc.c - bisected
Date: Fri, 22 Aug 2008 19:16:51 +0200
Message-ID: <20080822171651.GP10544@machine.or.cz>
References: <48A36838.3050309@hp.com> <20080819124602.9e8e69f7.akpm@linux-foundation.org> <48AEDD3D.4060507@hp.com> <20080822092549.ddcb7e79.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alan D. Brunelle" <Alan.Brunelle@hp.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754886AbYHVRRH@vger.kernel.org Fri Aug 22 19:18:15 2008
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754886AbYHVRRH@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWaH6-0002yz-RU
	for glk-linux-kernel-3@gmane.org; Fri, 22 Aug 2008 19:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbYHVRRH (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 22 Aug 2008 13:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbYHVRQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2008 13:16:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59695 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbYHVRQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2008 13:16:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C9DA63939BDC; Fri, 22 Aug 2008 19:16:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080822092549.ddcb7e79.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93329>

On Fri, Aug 22, 2008 at 09:25:49AM -0700, Andrew Morton wrote:
> On Fri, 22 Aug 2008 11:37:33 -0400 "Alan D. Brunelle" <Alan.Brunelle@hp.com> wrote:
> 
> > I /did/ bisect it down to the aforementioned merge, the question is: How
> > to crack open that merge into it's composite pieces? (Where do I go to
> > bisect within that?)
> 
> urgh, it's irritating when git-bisect directs you to a merge commit - it
> hasn't done it for me for ages.

Hmm, but doesn't that happen only when it's actually really the merge
commit that introduces the bug? Both parents of the merge commit were
marked as good by the user, so...

> One (probably wrong) approach is to run
> 
> 	gitk 1c89ac55017f982355c7761e1c912c88c941483d
> 
> then peer at the output, work out which real commits were in that
> merge.
> 
> It looks like the merge ended with
> b1b135c8d619cb2c7045d6ee4e48375882518bb5 and started with
> 40c42076ebd362dc69210cccea101ac80b6d4bd4, so perhaps you can do
> 
> 	git bisect bad b1b135c8d619cb2c7045d6ee4e48375882518bb5
> 	git bisect good 40c42076ebd362dc69210cccea101ac80b6d4bd4

...I don't quite get this - according to the bisection log,

	# good: [b1b135c8d619cb2c7045d6ee4e48375882518bb5] fix spinlock recursion in hvc_console

and now you want to mark it as bad?

You could try to revert some of the merged commits at the point of the
merge, though.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
