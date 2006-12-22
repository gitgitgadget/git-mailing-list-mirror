From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Sat, 23 Dec 2006 00:00:12 +0100
Organization: At home
Message-ID: <emhnsm$iuo$1@sea.gmane.org>
References: <38b2ab8a0612210424o4ec5fcd5kb5086c52ccd76491@mail.gmail.com> <Pine.LNX.4.64.0612211013500.3394@woody.osdl.org> <87slf83erg.wl%cworth@cworth.org> <Pine.LNX.4.64.0612212009370.3536@woody.osdl.org> <877iwjinda.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Dec 22 23:57:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxtKn-0006Tz-Gj
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 23:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbWLVW5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 17:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbWLVW5o
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 17:57:44 -0500
Received: from main.gmane.org ([80.91.229.2]:47837 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbWLVW5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 17:57:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxtKX-0007Lp-TO
	for git@vger.kernel.org; Fri, 22 Dec 2006 23:57:33 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 23:57:33 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 23:57:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35243>

[Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>
 git@vger.kernel.org]

Carl Worth wrote:

> On Thu, 21 Dec 2006 20:13:52 -0800 (PST), Linus Torvalds wrote:
>> I do it all the time, I never even use the old-fashioned syntax any more.
>> It's much more concise and easy to read, and it has all the nice shortcuts
>> (like empty meaning "HEAD", so you can do "git diff ..next" to see the
>> diff from HEAD to another branch).
> 
> I can understand the advantage of a shortcut like "git diff ..next",
> but I still don't understand why it's the comparison of HEAD and next
> that's really interesting here. Wouldn't comparing the merge-base to
> next be more desirable? For example, if I'm considering whether to
> merge in next or not, why should I care to see in the diff all the
> irrelevant stuff that's happened on HEAD since next branched off?
> 
> But, really, I still don't understand exactly _what_ "diff a..b" even
> means. Can you explain it to me?

For me, it's just a bit of syntactic sugar (I always have in mind that
git-log and friends outputs commit list and use revisions range, while
git-diff and friends needs two (or less) revisions) allowing to
copy'n'paste arguments from "git log a..b" to "git diff a..b"
 
> Presumably the rev-parse magic is happening to the arguments. So does
> the diff code just end up seeing the expanded equivalent of "b ^a" and
> then just use the ^ to decide which tree to be on the left side or
> something?

And that is just implementation. I don't think anyone uses "git diff b ^a".

>> It's also useful exactly because of the semantics of things like "...".
> 
> And now I'm really confused. If I'm not mistaken, rev-parse will turn
> "a...b" into something like "a b ^$(merge-base a b)", right? So does
> the diff code now end up seeing three different tree specifiers? What
> does it do with that? And how is this useful? (As you said before,
> diff is always going to end up acting on only two items, so I don't
> see where there could be an interesting distinction from how you
> obtain two items from "a..b" compared to "a...b".) But it might be
> just that I'm really confused here.

I would have thought that it would be combined diff of a and b against
it's merge base... but it is not.

"git diff a...b" is turned into "git diff a b ^$(git merge-base a b)",
and by a bit of magic (and by a convention) it is turned into
"git diff ^$(merge-base a b) a" (and a...b ceases to be _symmetric_
for git-diff).

I'd like for "git diff --cc a...b" to do 'the right thing' and show
git diff --cc for pretended merge (I'm not sure if with or without
resolving trivial conflicts).

>> So "git diff a b" doesn't even look good to me any more, because it's
>> literally missing that mental "to" that the ".." adds for me when I read
>> it.
> 
> OK, that's fine. But can you comment on why you want the comparison
> between the tips and not something based on a comparison from the
> merge-base to a tip?

a..b does not imply merge-base, a...b does.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
