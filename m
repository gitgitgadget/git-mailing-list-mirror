From: Ingo Molnar <mingo@elte.hu>
Subject: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 13:01:13 +0200
Message-ID: <20080616110113.GA22945@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 13:02:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8CTb-0004UN-Ut
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 13:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbYFPLB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 07:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbYFPLBZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 07:01:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50945 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbYFPLBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 07:01:25 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1K8CSY-0005qp-IA
	from <mingo@elte.hu>; Mon, 16 Jun 2008 13:01:22 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id EEFBA3E21DC; Mon, 16 Jun 2008 13:01:14 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85176>

We are running a rather complex Git tree with heavy use of git-rerere 
(the -tip kernel tree, with more than 80 topic branches). git-rerere is 
really nice in that it caches conflict resolutions, but there are a few 
areas where it would be nice to have improvements:

 - Fixing resolutions: currently, when i do an incorrect conflict
   resolution, and fix it on the next run, git-rerere does not pick up
   the new resolution but uses the old (buggy) one on the next run. To
   fix it up i have to find the right entries in .git/rr-cache/* and
   manually erase them. Would be nice to have "git-rerere gc <pathspec>"
   to flush out a single bad resolution.

 - File deletion: would be nice if git-rerere picked up git-rm
   resolutions. We hit this every now and then and right now i know 
   which ones need an extra git-rm pass.

 - Automation: would be nice to have a git-rerere modus operandi where
   it would auto-commit things if and only if all conflicting files were 
   resolved.

 - Sharing .git/rr-cache. It's quite a PITA to share the .git/rr-cache
   amongst -tip maintainers right now. It seems to have dependencies on 
   the index file, so if we want to share the conflict resolution data, 
   we have to copy our index file (which is dangerous anyway and assumes 
   very similar repositories).

   It would be much nicer if we could share conflict resolutions with 
   each other - and with others as well. For example linux-next could 
   re-use our conflict resolution data as well - often Stephen Rothwell 
   has to re-do the same conflict resolution as well, creating 
   duplicated work.

   ( Also, it's a GPL nitpicky issue: the conflict resolution database 
     can be argued to be part of "source code" and as such it should be 
     shared with everyone who asks. With trivial merges the data is
     probably not copyrightable hence probably falls outside the scope 
     of the GPL, but with a complex topic tree like -tip with dozens of 
     conflict resolutions, the boundary is perhaps more blurred. )

	Ingo
