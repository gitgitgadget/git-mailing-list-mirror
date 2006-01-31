From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] shallow clone
Date: Tue, 31 Jan 2006 14:31:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601311422400.7918@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
 <43DDFF5C.30803@hogyros.de> <Pine.LNX.4.63.0601301305100.20228@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmld7c2g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601311127490.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <43DF608C.1060201@hogyros.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 14:32:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3vbk-0002ko-6e
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 14:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWAaNbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 08:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWAaNbH
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 08:31:07 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:36263 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750810AbWAaNbG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 08:31:06 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 78BA0146B85; Tue, 31 Jan 2006 14:31:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 6AFF48FB;
	Tue, 31 Jan 2006 14:31:03 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 36454146B80; Tue, 31 Jan 2006 14:31:03 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <43DF608C.1060201@hogyros.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15314>

Hi,

On Tue, 31 Jan 2006, Simon Richter wrote:

> Well, the important thing would be that commands that can work (a merge only
> needs to find the most recent common ancestor, etc) do work, and commands that
> cannot ("log") emit sensible diagnostics.

No it would not.

A commit is a very small object which points (among others) to a tree 
object.

A tree object corresponds to a directory (that is, it can point to a 
number of tree and blob objects).

A blob object corresponds to a file (that is, git never parses its 
contents).

If two separate revisions contain the same file (i.e. same contents), this 
is not duplicated, but the corresponding tree objects point to the same 
object.

If you pull, upload-pack will think you have *every* object depending on 
every ref you have stored.

Say you have three revisions, A -> B -> C, and A and C contain the 
same file bla.txt, and the client says it has B, the upstream upload-pack 
assumes you have bla.txt.

> I know far too little about the internal workings for that, [...]

I hope I clarified the important aspect.

> > If you now rely on the grafts file to determine what was a cutoff, you may
> > well end up with bogus cutoffs.
> 
> Exactly that was my concern earlier; my database design gut feeling tells me
> that information duplication is not good either, [...]

You only have two choices: you proposed code duplication, and yours truly 
proposed data duplication.

As is known from good database design: a few redundancies here and there 
are typically needed for good performance.

Ciao,
Dscho
