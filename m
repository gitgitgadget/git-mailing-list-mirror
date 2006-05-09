From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-feed-mail-list.sh
Date: Mon, 8 May 2006 18:18:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605081805290.3718@g5.osdl.org>
References: <1146678513.20773.45.camel@pmac.infradead.org> 
 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>  <1147131877.2694.37.camel@shinybook.infradead.org>
  <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
 <4fb292fa0605081755m22e8239cjda0b1ac74b84c0d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 03:18:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGrz-0002Vf-Qj
	for gcvg-git@gmane.org; Tue, 09 May 2006 03:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWEIBS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 21:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWEIBS1
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 21:18:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751334AbWEIBS1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 21:18:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k491IItH009628
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 18:18:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k491IHhe027564;
	Mon, 8 May 2006 18:18:17 -0700
To: Bertrand Jacquin <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0605081755m22e8239cjda0b1ac74b84c0d9@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19804>



On Tue, 9 May 2006, Bertrand Jacquin wrote:

> On 5/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > Ie you could probably more easily parse the data from something like
> > 
> >         git show -B --patch-with-stat --pretty=fuller $commit
> > 
> 
> Is there a way to track merge like that ? Documentation is not very
> clear and near from empty.

Sure.

If you want to track merges and get their patches, add the "--cc" flag, 
which tells git to use the "conflict combination patch" that shows any 
visible conflicts.

(NOTE NOTE NOTE! This is _not_ the same as showing what conflicted: if you 
edited the result to match one of the original branches, it will be quiet 
in --cc, but if the result of a conflict was something that was in 
_neither_ branch, it will be shown! So most clean merges will not show any 
conflict diff at all, but the diffstat will be shown against the "first 
parent").

And you probably don't want to abbreviate the parent commit SHA1's (which 
are shown for merges, but not regular commits), so add "--no-abbrev".

If you want to show parents for _all_ commits, you could do something like

  git show --no-abbrev --cc -C --patch-with-stat --pretty=fuller --parents |
	sed '1 s/commit [0-9a-f]*/\0\nParents:   / ; /^Merge: / d'

which removes a potential "Merge: " line in favour of listing the parents 
on a "Parents:" line, and which also shows merges nicely.

That said, the diffstat for merges is usually just a lot of noise. It's 
sometimes nice (you've merged from a topic branch), but if you have merged 
from the mainline _into_ a topic branch, it's just annoying.

So the above is just a wild suggestion. Caveat emptor.

		Linus
