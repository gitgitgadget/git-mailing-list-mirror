From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Tue, 26 Apr 2005 00:18:11 +0200
Message-ID: <20050425221810.GM13467@pasky.ji.cz>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org> <426D62C0.40104@zytor.com> <Pine.LNX.4.58.0504251457510.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 00:14:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQBqA-0008Ql-Gy
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 00:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVDYWSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 18:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVDYWSt
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 18:18:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48102 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261256AbVDYWSP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 18:18:15 -0400
Received: (qmail 30631 invoked by uid 2001); 25 Apr 2005 22:18:11 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504251457510.18901@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 12:05:17AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Mon, 25 Apr 2005, H. Peter Anvin wrote:
> > 
> > It would be good if the tag object could permit junk lines before the 
> > start of the header; in particular, the standard PGP/GPG signed message 
> > format looks like:
> 
> No, I've already explained why git doesn't parse arbitrary junk: I want 
> git to have 100% repeatable behaviour. And that very much means that if 
> git doesn't understand something, it just doesn't touch it or parse it.
> 
> Here's my trivial script to generate tags in proper format. Go wild:
> 
> 	#!/bin/sh
> 	( echo -e "object $(cat .git/HEAD)\ntype commit\ntag $1\n"; cat ) > .tmp-tag
> 	rm -f .tmp-tag.asc
> 	gpg -bsa .tmp-tag && cat .tmp-tag.asc >> .tmp-tag
> 	git-mktag < .tmp-tag
> 	rm -f .tmp-tag*
> 
> and it creates objects like this one:
> 
> 
> 	torvalds@ppc970:~/git> cat-file tag 
> 	ba613c023dcd03e06158caee9c0337e6b6988854
> 	object ec4465adb38d21966acdc9510ff15c0fe4539468
> 	type commit
> 	tag test-release
> 	Testing tagging
> 	-----BEGIN PGP SIGNATURE-----
> 	Version: GnuPG v1.2.4 (GNU/Linux)
> 	
> 	iD8DBQBCbVwSF3YsRnbiHLsRAliaAKCMlb6k6VAS7hxajwUtwRdzDZn9rACffVTb
> 	dRdDS6n+pjSAYbA6Lp11bQU=
> 	=JNiv
> 	-----END PGP SIGNATURE-----

Could we please at least maintain the newline between the "header" and data,
like in the commit objects?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
