From: Paul Jakma <paul@clubi.ie>
Subject: Re: impure renames / history tracking
Date: Wed, 1 Mar 2006 21:25:08 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603012105230.13612@sheen.jakma.org>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
 <4405C012.6080407@op5.se> <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
 <46a038f90603011005m68af7485qfdfffb9f82717427@mail.gmail.com>
 <Pine.LNX.4.64.0603011851430.13612@sheen.jakma.org> <7v3bi2ey63.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andreas Ericsson <ae@op5.se>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 22:25:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEYpT-0004rI-IP
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 22:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWCAVZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 16:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbWCAVZs
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 16:25:48 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:3206 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751926AbWCAVZs
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 16:25:48 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1/AUcdu74vQV8pqTvfSUJlioKhjYrozCds@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k21LP9w9003937;
	Wed, 1 Mar 2006 21:25:22 GMT
X-X-Sender: paul@sheen.jakma.org
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bi2ey63.fsf@assigned-by-dhcp.cox.net>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17014>

Hi Junio,

On Wed, 1 Mar 2006, Junio C Hamano wrote:

> Interestingly enough, there are two levels of "rename tracking" the 
> current git does.  Whey you run "git whatchanged -M", you are 
> looking at renames between each commit in the commit chain, one 
> step at a time.  There as long as the rename+rewrite does not 
> amount to too much rewrite, you would see what should be detected 
> as rename to be detected as renames.

Right.

> I found the current default threshold parameters to be about right, 
> maybe a bit too tight sometimes, though.  If you want to loosen the 
> default, you can specify similiarity index after -M.

That's one option.

I'm wondering though if we couldn't also allow for users to 
additionally encode naming 'hints', to aid this 'similarity' 
detection process.

> The way recursive merge strategy uses the rename detection, unlike 
> what whatchanged shows you, does not use chains of commits down to 
> the common merge base in order to detect renames (my recollection 
> may be wrong here -- it's a while since I looked at the recursive 
> merge the last time).  It just looks at the two heads being merged, 
> and detects similarility between them.  So it does not make _any_ 
> difference with the current implementation of recursive merge if 
> you kept a history full of "honest but disgusting" commits or 
> collapsed them into a history with small number of "cleaned up" 
> commits.

I'm going to have to stare at this paragraph a lot longer and harder 
to understand it :).

> One thing it _could_ do (and you _could_ implement as another merge 
> strategy and call it "pauls-rename" merge) is to follow the commit 
> chain one by one down to the common merge base from both heads 
> being merged, and analyze rename history on the both commit chains.

Right, I was just thinking that while making tea actually. This could 
be part of the 'collapsing' process. (or call it "coalesce 
too-detailed commits" process if that is less offensive to ones sense 
of process ;) ).

Actually, you're sort of suggesting following the chains in parallel, 
right? Ie in wall-clock time order, rather than chain order. And 
doing name resolution across the 'to-be-merged' chains at each step 
of the way? Sort of a lesser subset of how other SCMs maintain state 
for names globally?

It's not so much /resolving/ names I'm worried about in the first 
place. It's there simply being no information in the first place to 
indicate (from one single-parent commit to the next) which names were 
renamed.

> Then, you would get better rename+rewrite detection than what it 
> currently does.

But if I follow the commit chain in order to try extract

> HOWEVER.

> If you have that kind of rename-following merge, a workflow that 
> collapses a useful history into a single huge commit "Ok, this 
> commit is a roll-up patch between version 2.6.14 and 2.6.15" 
> becomes far less attractive than it currently already is.  At that 
> point, you _are_ throwing away useful history.

Yes, I agree. And I am, as part of arguing git's case (several SCMs 
are being evaluated and considered, I'm the git proponent at the 
moment), I'm going to suggest workflow ought to be re-evaluated to 
ensure it is generally reasonable, rather than be kept for the sake 
of it keeping (particularly as it may be tailored to the 
needs/limitations of $TRADITIONAL_SCM).

However, I suspect at least some level of collapsing will be desired 
(just as it is with Linux and git).

The workflow issue is seperate from the 'impure rename' issue though, 
even if the workflow I gave as an example excerbates the issue, 
"rename and rewrite half of it" and hard-to-detect renames can still 
occur in the detailed git/linux workflows, surely?

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
If you really knew C++, you wouldn't even joke about putting it
in the kernel.

 	- Richard Johnson on linux-kernel
