From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] A Perforce importer for git.
Date: Sun, 4 Jun 2006 10:04:30 -0400
Message-ID: <BAYC1-PASMTP01323F67D0088CA96D86BEAE970@CEZ.ICE>
References: <BAYC1-PASMTP117796558F3B42B2C18DBCAE980@CEZ.ICE>
	<81b0412b0606020609o24ee34b4p7b1bcd013136d49a@mail.gmail.com>
	<20060602094357.ee3d8407.seanlkml@sympatico.ca>
	<20060602212005.GA7801@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: fork0@t-online.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 16:05:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmtEH-0001Y2-Fy
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 16:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWFDOFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 10:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWFDOFR
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 10:05:17 -0400
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:17076 "EHLO
	BAYC1-PASMTP01.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1751491AbWFDOFP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 10:05:15 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP01.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 4 Jun 2006 07:05:14 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id E6149644C28;
	Sun,  4 Jun 2006 10:05:12 -0400 (EDT)
To: Alex Riesen <raa.lkml@gmail.com>
Message-Id: <20060604100430.cb2789dd.seanlkml@sympatico.ca>
In-Reply-To: <20060602212005.GA7801@steel.home>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 04 Jun 2006 14:05:14.0928 (UTC) FILETIME=[E6FAA300:01C687DF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2 Jun 2006 23:20:05 +0200
fork0@t-online.de (Alex Riesen) wrote:

> Well, I'm not quite sure it's at all possible... Perforce has a
> strange ways for doing history: it is kept for each file (as in CVS),
> but you can bundle changes in many files into one "change".
> Perforce also has no branches (in the GIT's meaning of the term).
> These by Perforce are just server-side directories, without any
> relevance to the source whatsoever (just copies).

Yes, each Perforce change records a new file revision level
for each of the files involved in the changeset.
 
> I'm rather looking for a ability to manage a single branch where
> import "sync" events appear as a merge of changes to the files
> involved in the sync. I just haven't figured out yet how to "break" a
> Perforce change into changes to single files and import that broken up
> commit into git as a merge.

Ahh, so what you're really asking is for a way to maintain the perforce
merge history within git.  Whereas the current p4import script just
shows a linear history without any merges.

The problem is that Perforce doesn't merge at the commit level.  It
allows changes from other branches to be pulled one file at a time and
from any rev level.

Now, even if you break those changes into one git commit per file per
revision level (yuck!), you still couldn't use them to record Perforce
merges.  Git would still merge the entire history of such commits from
the other branch whenever you tried to merge just one.

AFAICS, the best you could do would be to create cherry-picks, plucking
just the commits from the other branch you want.  However at that point
you're not getting a git merge anyway and it doesn't seem to be any
benefit beyond what the importer already does.  Well, the importer
_could_ make a comment in the commit message describing where each
file change originated (ie. from which branch/rev).  Would that help?

Sean
