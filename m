From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvsimport infinite loop
Date: Sun, 10 Feb 2008 17:38:01 +0100
Message-ID: <47AF2869.6030206@alum.mit.edu>
References: <200802091245.38578.peter_e@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Eisentraut <peter_e@gmx.net>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:38:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOFCf-00089a-Uu
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbYBJQiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 11:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbYBJQiS
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:38:18 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45313 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbYBJQiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:38:17 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m1AGcEDv012546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 10 Feb 2008 17:38:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre) Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <200802091245.38578.peter_e@gmx.net>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73369>

Peter Eisentraut wrote:
> I'm trying to convert the PostgreSQL CVS to Git, using Git 1.5.4 (but
> the problem also occurs with earlier versions).  To reproduce:
> 
> $ rsync -avzCH --delete anoncvs.postgresql.org::pgsql-cvs cvsroot/
> $ git-cvsimport -v -d $PWD/cvsroot pgsql
> 
> This runs for a while and then messages like this are repeating:
> 
> WARNING: Invalid PatchSet 2062, Tag REL7_1_BETA2:
>     src/include/c.h:1.17=after, src/include/executor/nodeNestloop.h:1.2=before. Treated as 'before'
> WARNING: Invalid PatchSet 2062, Tag REL7_1_BETA2:
>     src/include/c.h:1.17=after, src/include/executor/nodeResult.h:1.2=before. Treated as 'before'
> WARNING: Invalid PatchSet 2062, Tag REL7_1_BETA2:
>     src/include/c.h:1.17=after, src/include/executor/nodeSeqscan.h:1.3=before. Treated as 'before'
> 
> [...]
> 
> I've let this run all night and it doesn't stop.
> 
> I don't want to exclude the possibility that the CVS repository has had some
> funny business done to it over the years, but surely an infinite loop
> shouldn't happen in any case.  Please advise.

*Every* CVS repository contains some measure of funkiness :-).  I don't
know what caused this particular problem with cvsps, but judging from my
experience developing cvs2svn, a likely culprit would be a cycle in the
graph of dependencies between changesets that were inferred too naively.
 I had to teach cvs2svn graph theory to make it robustly handle
situations like this.

I just tried converting the pgsql repository using the trunk version of
cvs2svn (which also supports output to git [2]).  It worked fine.  If
you can work with a one-time conversion (as opposed to incremental) then
consider using cvs2svn.

Michael

[1] http://cvs2svn.tigris.org
[2] http://cvs2svn.tigris.org/cvs2git.html
