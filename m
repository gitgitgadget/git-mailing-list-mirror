From: Paul Jakma <paul@clubi.ie>
Subject: Re: impure renames / history tracking
Date: Thu, 2 Mar 2006 21:10:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603012129310.13612@sheen.jakma.org>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
 <4405C012.6080407@op5.se> <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
 <4405DD35.8060804@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 22:12:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEv54-0002Zz-Vm
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 22:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWCBVLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 16:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWCBVLE
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 16:11:04 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:48788 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S932545AbWCBVLD
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 16:11:03 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1/VjekrnjwdaFcTFO3wacl3LTnnFnkc/94@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k22LAcHF028040;
	Thu, 2 Mar 2006 21:10:50 GMT
X-X-Sender: paul@sheen.jakma.org
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4405DD35.8060804@op5.se>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17106>

On Wed, 1 Mar 2006, Andreas Ericsson wrote:

> Yes, but imo a poor one, as you're losing all the history.

Well, not per se. You might keep the original 'detail' branch. It's a 
terminal branch obviously, you can't pull master's changes to it once 
the aggregate patch goes into master. But you can keep it around.

> git *can* do what you want, but it was designed to maintain a long 
> history so that everyone can see it and improve on the code with 
> many chains of small and simultanous changes.

Indeed, and I appreciate that.

> Perhpas we have a nomenclature clash here. When you say "one single 
> commit", I can't help but thinking "snapshot".

I mean:

 	git diff upstream..bugfix_xyz

or:

 	git diff upstream..project_foo_phase1

type of thing.

> It's completely impossible to fold *ALL* the history into a single 
> commit, and since you want heuristics I would imagine you wouldn't 
> want that either.

I want to know whether additional meta-data to help the existing 
heuristics would be acceptable. From a discussion on #git yesterday I 
gather the best way forward would to be to first prototype something 
keeping state in a file in .git.

All that's needed really is something that relates the following 3 
things:

 	commit-id obj1-id obj2-id

Ie: For <commit-id>, <obj1-id> is similar to <obj2-id>.

Maintaining this state could be done via the git-mv/rename wrappers 
and an additional git-edit wrapper. Those who are quite happy with 
the existing diff-input only similarity heuristics wouldn't have to 
bother using a git-edit wrapper obviously, those who want to let git 
gather additional 'similarity hint' in this way could.

Aside:

Git might be easier to extend generally if it adopted just /one/ new 
core header, say "see-also" - that could serve as a pointer to 
arbitrary commit-related meta-info objects that aren't of immediate 
interest to either:

a) core git

or

b) the user

Format:

 	see-also <word> <obj-id>

E.g.:

 	see-also similars <obj-id>

Where <obj-id> would list the 'commit obj1 obj2', but just as:

 	obj1 obj2

Would ultimately be neater than fishing around in .git/, and would 
allow other extensions in the future too.

The <word> identifier preferably would need to be centrally 
co-ordinated.

> I'm confused. First you say you want to have one single mega-patch 
> for each commit, then you say you want to be able to follow history 
> back. It's like deciding to throw away your wallet and then trying 
> to get someone to pick it up and carry it around for you.

I'm not sure why think mega-patch. Collapsing a bunch of commits 
related to one project need not result in a big patch relative to the 
repository as a whole.

In Linux terms think project == "Add ATAPI support to SATA" or 
"Change the foo VFS method and update its filesystem users" type of 
thing (ok, the latter would be big enough, but still not /that/ big 
in terms of the whole Linux source base). Where the project concerned 
is like BSD, not just a kernel but a complete userland (so 1.1GB of 
source code).

I'm aware of the workflow arguments, I /do/ intend to make those but 
elsewhere ;).

> As for convincing others, shove git-bisect under their noses and 
> ask them if they'd like a tool to find their bugs for them.

;)

[snip - thanks, interesting]

> The code is mightier than the mail. Perhaps if I see an implementation of 
> this I could wrap my head around what you really mean. I'm sure I must 
> misunderstand you one way or another.

Yes, you're right. I think Junio gave me the required hints on 
directions last night on #git.

I think now at least it's quite possible to achieve without violating 
git's "track the /content/" philosophy, via .git.

Thanks!

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Factorials were someone's attempt to make math LOOK exciting.
