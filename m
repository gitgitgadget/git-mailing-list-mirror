From: Peter Eisentraut <peter_e@gmx.net>
Subject: cvsimport infinite loop
Date: Sat, 9 Feb 2008 12:45:36 +0100
Message-ID: <200802091245.38578.peter_e@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 12:46:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNoA7-0005rF-J0
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 12:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbYBILpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 06:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbYBILpm
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 06:45:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:38026 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753544AbYBILpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 06:45:41 -0500
Received: (qmail invoked by alias); 09 Feb 2008 11:45:40 -0000
Received: from xdsl-87-79-136-79.netcologne.de (EHLO colt.pezone.net) [87.79.136.79]
  by mail.gmx.net (mp037) with SMTP; 09 Feb 2008 12:45:40 +0100
X-Authenticated: #495269
X-Provags-ID: V01U2FsdGVkX18Sl51NkxgSRyQR6pF1sCykCcvsBtqZc2kdAaHJ+j
	8G2DSHckAz3Pu5
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73213>

I'm trying to convert the PostgreSQL CVS to Git, using Git 1.5.4 (but
the problem also occurs with earlier versions).  To reproduce:

$ rsync -avzCH --delete anoncvs.postgresql.org::pgsql-cvs cvsroot/
$ git-cvsimport -v -d $PWD/cvsroot pgsql

This runs for a while and then messages like this are repeating:

WARNING: Invalid PatchSet 2062, Tag REL7_1_BETA2:
    src/include/c.h:1.17=after, src/include/executor/nodeNestloop.h:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 2062, Tag REL7_1_BETA2:
    src/include/c.h:1.17=after, src/include/executor/nodeResult.h:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 2062, Tag REL7_1_BETA2:
    src/include/c.h:1.17=after, src/include/executor/nodeSeqscan.h:1.3=before. Treated as 'before'

...

WARNING: Invalid PatchSet 2064, Tag REL7_1_BETA2:
    src/include/c.h:1.18=after, src/include/executor/nodeNestloop.h:1.3=before. Treated as 'before'
WARNING: Invalid PatchSet 2064, Tag REL7_1_BETA2:
    src/include/c.h:1.18=after, src/include/executor/nodeResult.h:1.3=before. Treated as 'before'
WARNING: Invalid PatchSet 2064, Tag REL7_1_BETA2:
    src/include/c.h:1.18=after, src/include/executor/nodeSeqscan.h:1.4=before. Treated as 'before'

...
...
...

and then they start again

WARNING: Invalid PatchSet 2062, Tag REL7_1_BETA2:
    src/include/c.h:1.17=after, src/include/executor/nodeNestloop.h:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 2062, Tag REL7_1_BETA2:
    src/include/c.h:1.17=after, src/include/executor/nodeResult.h:1.2=before. Treated as 'before'
WARNING: Invalid PatchSet 2062, Tag REL7_1_BETA2:
    src/include/c.h:1.17=after, src/include/executor/nodeSeqscan.h:1.3=before. Treated as 'before'

I've let this run all night and it doesn't stop.

I don't want to exclude the possibility that the CVS repository has had some
funny business done to it over the years, but surely an infinite loop
shouldn't happen in any case.  Please advise.
