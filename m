From: Paul Jakma <paul@clubi.ie>
Subject: impure renames / history tracking
Date: Wed, 1 Mar 2006 14:01:28 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Wed Mar 01 15:02:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FERtu-0003zg-Dd
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 15:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWCAOBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 09:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWCAOBw
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 09:01:52 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:9601 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751142AbWCAOBv
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 09:01:51 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1+c+ur86whZ30lVHSQXF2FmkabXp2a3q8w@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k21E1Twn030219
	for <git@vger.kernel.org>; Wed, 1 Mar 2006 14:01:41 GMT
X-X-Sender: paul@sheen.jakma.org
To: git list <git@vger.kernel.org>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16975>

Hi,

I'm trying to understand git better (so I can explain it better to 
others, with an eye to them considering switching to git), one 
question I have is about renames.

- git obviously detects pure renames perfectly well

- git doesn't however record renames, so 'impure' renames may not be
   detected

My question is:

- why not record rename information explicitely in the commit object?

I.e. so as to be able to follow history information through 'impure' 
renames without having to resort to heuristics.

E.g. imagine a project where development typically occurs through:

o: commit
m: merge

    o---o-m--o-o-o--o----m <- project
   /     /              /
o-o-o-o-o--o-o-o--o-o-o <- main branch

The project merge back to main in one 'big' combined merge 
(collapsing all of the commits on 'project' into one commit). This 
leads to 'impure renames' being not uncommon. The desired end-result 
of merging back to 'main' being to rebase 'project' as one commit 
against 'main', and merge that single commit back, a la:

    o---o-m--o-o-o--o----m <- project
   /     /              /
o-o-o-o-o--o-o-o--o-o-o---m <- main branch
                        \ /
                         o <- project_collapsed

So that 'm' on 'main' is that one commit[1].

The merits or demerits of such merging practice aside, what reason 
would there be /against/ recording explicit rename information in the 
commit object, so as to help browsers follow history (particularly 
impure renames) better in a commit?

I.e. would there be resistance to adding meta-info rename headers 
commit objects, and having diffcore and other tools to use those 
headers to /augment/ their existing heuristics in detecting renames?

Thanks!

1. Git currently doesn't have 'porcelain' to do this, presumably 
there'd be no objection to one?

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
It is the quality rather than the quantity that matters.
- Lucius Annaeus Seneca (4 B.C. - A.D. 65)
