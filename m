From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 16:54:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271643080.12485@woody.linux-foundation.org>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
 <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227154241.GA8228@thunk.org> <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
 <7vfy8rb2do.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org>
 <7vejob9l70.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 01:54:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMD5n-0003im-VZ
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 01:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbXB1Ayt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 19:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbXB1Ayt
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 19:54:49 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60689 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbXB1Ays (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 19:54:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1S0sKhB024941
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 16:54:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1S0sINr002036;
	Tue, 27 Feb 2007 16:54:19 -0800
In-Reply-To: <7vejob9l70.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.446 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40866>



On Tue, 27 Feb 2007, Junio C Hamano wrote:
> >
> > ... Negative object refs really don't make any sense unless you walk 
> > the object list (or you're "git diff" and know about ranges explicitly).
> 
> If you did not say "(or you're..." part, then I would agree
> to this 100%.

Well, I personally see (and think) of ".." as a "difference operator".

It very much is that, both for "git diff" and for "git log".

It's just that the "differences" are different.

In "git diff", the difference is obviously the code difference. When you 
say "git diff a..b" to "show the difference between a and b", you mean 
"show the patch". When you say "git log a..b", it's *still* a 
"difference", but now it's the *set* difference of the commits.

But "a..b" makes sense to me in both cases, exactly because to me, "a..b" 
_literally_ means "b - a" or "the difference between a and b".

Maybe I'm odd, or maybe it's because I have a fairly strong math 
background, but I have no trouble at all with a "difference operator" that 
does different things.

In real algebra (what in the US is apparently called "abstract algebra", 
and not to be confused with just "arithmetic with unknowns"), you do 
generalized arithmetic operations, and using "+" and "-" and "*" to mean 
arbitrary things that depend on the stuff you operate on, and doing 
different things depending on whether you talk about a "set of commits" 
(log) or talking about a "set of source code" (diff), makes total sense 
mathematically.


> On the other hand, as you earlier said:
> 
>     On Fri, 22 Dec 2006,...
>     > 
>     > I can understand the advantage of a shortcut like "git diff ..next",
>     > ...
> 
>     I can't understand why people complain about this.
> 
>     YOU DON'T HAVE TO USE IT. 
>     ...
>     > But, really, I still don't understand exactly _what_ "diff a..b" even
>     > means. Can you explain it to me?
> 
>     It means exactly the same as "diff a b".
> 
>     It's that simple.
> 
> which made me lol, I am very tempted to say:
> 
> 	It means exactly the same as "show a b".
> 
>         It's that simple.

No, it really makes no sense at all if you see "a..b" as being a 
"difference operator".

What is the difference between two commits? It's either the difference in 
code (diff) _or_ it's the difference in sets of commits (log), and either 
is logical, but which one should "git show" actually show?

In NO CASE is it logical to say that "git show a..b" makes the 
"difference" be the "union" of two commits. That's just confusing and odd.

> Back to serious my self, I am wondering if this is a sensible
> thing to ask:
> 
> 	$ git show master...maint
> 
> which your patch now forbids.

Again, what would that *mean*?

The "..." operator is the "symmetric difference". It has meaning both for 
code and for commit sets, but which one is "show"?

		Linus
