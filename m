From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 03:23:59 +0200
Organization: Organization?!?
Message-ID: <85hcnytuq8.fsf@lola.goethe.zz>
References: <858x9ez1li.fsf@lola.goethe.zz> <7vk5svxt1f.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707201210550.27249@woody.linux-foundation.org> <200707202302.57788.johan@herland.net> <alpine.LFD.0.999.0707201421110.27249@woody.linux-foundation.org> <Pine.LNX.4.64.0707202320300.16498@reaper.quantumfyre.co.uk> <alpine.LFD.0.999.0707201712150.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 21 03:24:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC3ht-0000q6-U8
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 03:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939273AbXGUBYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 21:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933780AbXGUBYZ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 21:24:25 -0400
Received: from main.gmane.org ([80.91.229.2]:37313 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935962AbXGUBYX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 21:24:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IC3hc-0001Ul-6r
	for git@vger.kernel.org; Sat, 21 Jul 2007 03:24:12 +0200
Received: from dslb-084-061-018-134.pools.arcor-ip.net ([84.61.18.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 03:24:12 +0200
Received: from dak by dslb-084-061-018-134.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 03:24:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-018-134.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:BhRnkGiFhjKJdv8YQG7Sqq023Pk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53130>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The really sad part about this discussion is that the ".gitignore
> trick" is really technically no different at all from the one that
> David Kastrup has been advocating a few times, except he calls his
> ".gitignore" just ".", and seems to think that it's somehow
> different.

Oh no, I don't think at all that it is somehow different: actually
this is _exactly_ the reason why I think that the implementation will
be doable even by an idiot like myself, and that is because at least
in my first iteration, "."  will appear as an empty regular file to
git, just like ".gitignore".  The main worry I had was that putting
"." inside of a gitignore entry might stop "git add ." from working
like previously.  But I tried it, and it works just like it would with
".gitignore".  Or rather like it would with ".notignore" since
".gitignore" _is_ specially treated by git, after all.

> It is true that ".gitignore" and "." _are_ different.
>
> But they are actually different in the sense that the ".gitignore"
> thing is something you can control, while the "." thing is something
> that is in all directories on UNIX, which is exactly why it
> _must_not_ be used by git to mark existence.

But I don't plan to have it used by git to mark existence.  The
_existence_ can be taken for granted.  But what can't be taken for
granted, like with any other file, is that the file is actually being
tracked by git.  To have it tracked, you need to add it, and it must
not be covered by gitignore.

> Exactly because it has thus lost its ability to be something you can
> tune per-directory in the working tree!

But it should not let the user lose his ability to let or let not git
track the file.

> That said, I actually like my patch, because the git tree structures
> actually lend themselves very naturally to the "empty tree", and I
> know people have even built up those kinds of trees on purpose, even
> if the index doesn't support that notion.

And that is the reason I will be working with the "empty file ."
metaphor: it would be way above my head to make the index support new
file types or even structures, and change the evaporate-when-empty
semantics of trees and so on, while catching all special cases.

I have no chance in hell to implement a new feature with a reasonable
amount of time and work.  That's a task for people with a larger brain
than mine who have my full admiration and respect.  The best I can
hope to achieve is a clever hack.

And if that works, people can still pile exceptions on it and redo it
as a "proper feature".

You are _perfectly_ correct that my proposal is _not_ a jot different
from registering a regular empty file ".notignore", and it is on
_purpose_, because I could not handle the complications if it were.

The only difference is that I am calling the file ".".  Which is in
_all_ respects nothing more than a naming convention.

However, this convention has distinct advantages over ".notignore":

a) I don't have to depart as far from reality.  Whenever I try
registering ".", I can rely on the work directory actually _having_
"." as a _real_, not a pseudofile.  It will not actually be a
_regular_ file as I'll tell git: that's a wart of my prototype
implementation which will, no doubt, eventually be fixed by others
_if_ the code does its job fine apart from being ugly to look at.  It
may not be even necessary internally to think of "." other than as an
empty regular file, but git should probably not talk too loud about it
lest people laugh at it.

b) it already means something to people.  Now this is a two-edged
sword, since "almost, but not quite, entirely unlike" concepts are not
necessarily helpful in computing.  In this case, however, I think the
match is close enough to help people understand what is going on
rather than the other way round.  "." was introduced because people
wanted to have a good way to refer to a directory as an element of
itself.  So using "." as a self-reference for a directory is quite in
the spirit of that name.

> So in that sense, teaching the index about an empty tree is in some
> ways the "right thing" to do, if only because it means that the
> index can finally express something that the tree objects themselves
> have always been able to validly encode.

If you define the tree objects by the physical in-memory or
in-repository data structures encoding them, then you are correct.  I
am somewhat reluctant to parade around another red cape, but in this
particular case, the size of the wet spot in my pants does not as much
relate to the physical layout of the data structure (big deal,
probably 30 lines of code all around), but rather to the extent and
assumptions of functions accessing it.  Namely, data layout and
accessor functions _together_ constitute a tree object.  So for me the
"evaporate-when-empty" property, while not inherent in the physical
layout of the object, is still an inherent part of its structure which
I would not want to touch: finding and fixing and debugging all code
elements which explicitly or implicitly rely on that assumption is
something I would not entrust myself with.

I might have been more inclined to dabble with that approach if the
tree stuff were written in something more object-oriented, say, clean
and concise C++, except that clean and concise C++ code in the wild is
even more of a mythical beast than clean and concise TeX code, and C++
itself is such a mindboggingly complex contraption...  I digress.

All the best,

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
