From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining cg-*-id
Date: Mon, 19 Sep 2005 17:50:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509191746130.2553@g5.osdl.org>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz>
 <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org> <20050919225422.GG18320@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	fonseca@diku.dk, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 02:51:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHWLG-0006c7-8m
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVITAug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVITAuf
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:50:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46271 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964810AbVITAuf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 20:50:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8K0oMBo022218
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 17:50:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8K0oLUi026976;
	Mon, 19 Sep 2005 17:50:21 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050919225422.GG18320@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8941>



On Tue, 20 Sep 2005, Petr Baudis wrote:
> 
> Currently, in Cogito it is basically:
> 
> 	git-rev-list --min-age="$(date --date=$id +%s)" --max-count=1 HEAD

Yes, for git-rev-list it makes sense, because that already more or less
"serializes" things by date.

> But that semantics sucks, and I wouldn't mind changing it at all. I
> think taking the previous commit works for everything but the start of
> cg-log range, and it is how CVS behaves.

The thing is, it may have sensible behaviour for CVS, but only because CVS 
doesn't have any notion of concurrent development (even a branch isn't 
concurrent - it's totally separate, and when you merge it, it becomes just 
one big diff at the time of the merge).

So I'd love to have

	git diff yesterday..

but the fact is, there's no sensible semantics for it. _which_ yesterday? 
There might be five different points that are "close to 24 hours ago", 
along five different paths backwards in the history.

I suspect that the date-based thing really doesn't make sense as a
revision, only as a git log cut-off (ie the "--min-age=" flag is as close
to sensibility as you can get).

		Linus
