From: Steffen Prohaska <prohaska@zib.de>
Subject: limiting rename detection during merge is a really bad idea
Date: Mon, 11 Feb 2008 07:19:32 +0100
Message-ID: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 07:19:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOS0X-0008M0-18
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 07:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbYBKGSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 01:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbYBKGSi
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 01:18:38 -0500
Received: from mailer.zib.de ([130.73.108.11]:43512 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbYBKGSh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 01:18:37 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m1B6IZSp011844
	for <git@vger.kernel.org>; Mon, 11 Feb 2008 07:18:36 +0100 (CET)
Received: from [192.168.178.21] (brln-4db82954.pool.einsundeins.de [77.184.41.84])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m1B6IYhw012470
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 11 Feb 2008 07:18:35 +0100 (MET)
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73470>

I almost lost faith in git's merging capabilities because merge-
recursive limits rename detection to the default limit if not
configured otherwise.  I tried to do a large merge and was pretty
convinced that git would handle the merge easily.  But it
unexpectedly failed to detect the renames.  The reason is that
merge-recursive uses the diff_rename_limit_default, which is 100,
and this was too low in my case.

After debugging all the merge and diff machinery I found out that
I just need to set diff.renamelimit=0 and everything works smoothly.

Well, it was an interesting debugging experience and I learnt a
lot about the diffcore.  Nonetheless this was one of the worst
experiences I had with git and it kept me from doing more important
work.

I think that limiting rename detection during merge is a really
bad idea.  Either we should set it to unlimited, or at least we
should print a BIG WARNING that rename detection is limited
during the merge.  I'd propose to override diff.renamelimit
to unlimited for a merge, even if diff.renamelimit is explicitly
configured by the user.  It doesn't make sense not to detect
renames during a merge.

Opinions?

	Steffen
