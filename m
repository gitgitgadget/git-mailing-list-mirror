From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 16:29:24 +0100
Message-ID: <1113578964.27227.65.camel@hades.cambridge.redhat.com>
References: <20050414002902.GU25711@pasky.ji.cz>
	 <20050413212546.GA17236@64m.dyndns.org>
	 <20050414004504.GW25711@pasky.ji.cz>
	 <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	 <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	 <20050414121624.GZ25711@pasky.ji.cz>
	 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
	 <1113556448.12012.269.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504150740310.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 17:29:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMSin-0004Qb-3K
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 17:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVDOPaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 11:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVDOPaZ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 11:30:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19614 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261852AbVDOP3a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 11:29:30 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DMSl3-0006ul-BB; Fri, 15 Apr 2005 16:29:26 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504150740310.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-15 at 07:53 -0700, Linus Torvalds wrote:
> Files DO NOT matter. Never have. It's an implementation limitation to 
> think they do. You'll screw yourself up, and when somebody comes up with a 
> half-way efficient way to generate inter-fiel diffs, your architecture is 
> totally and utterly unable to handle it.
> 
> I don't care what you do at an SCM level, and if the crud you put on top
> of git wants to perpetuate mistakes of yesteryear, that's _your_ issue.  
> But dammit, git is designed to do the right thing, and I will fight tooth
> and nail against anybody who thinks individual files matter.

No, really: individual files _DO_ matter. There's a reason we split
stuff up into separate files, and if you look closely you'll find that
we don't just randomly put different functions into different files with
neither rhyme nor reason -- there's a pattern to it; usually some kind
of functional grouping.

And when I'm looking for the change that broke something, I can almost
always tell which file it's in and go looking in _that_ file. It's a
_whole_ lot easier to use the equivalent of 'bk revtool' than it is to
sift through all the unrelated commits in the whole tree. If that's an
implementation limitation, then it's an implementation limitation in my
_brain_ not just in my tools.

OK, in fact it shouldn't be 'show me the history of this file'; it's
often really 'show me the history of this function' which I want. But
that's fine. All I'm suggesting is that we should include the metadata
which says "content moved from file XXX to file YYY" along with the
commit objects.

I'm certainly not suggesting that we should implement jejb's idea of
explicit 'file revision history' objects -- the tree-based philosophy is
perfectly sane and sufficient. But we do _also_ need a little
information which allows us to track content as it moves around within
the tree, and the SCM has to have a sane way to filter out the noise
when we're looking for what broke. Yes, that's part of the SCM
functionality, and can live in an xattr-type field in the commit object
-- but it does need to be stored, and in practice I suspect it _will_ be
useful for merging too.

It's not about ditching the per-tree tracking and doing per-file
tracking instead. I agree that would be wrong. It's about storing enough
information to track what happened to given content as it moved around
within the tree.

-- 
dwmw2

