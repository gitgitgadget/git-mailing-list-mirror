From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: "git svn fetch" slow
Date: Sat, 31 Jan 2009 14:14:57 +0100
Message-ID: <200901311414.58205.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 31 14:16:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTFi0-0006pM-HM
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 14:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbZAaNPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 08:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbZAaNPC
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 08:15:02 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:43168 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbZAaNPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 08:15:00 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2E2F7F9BA4F9;
	Sat, 31 Jan 2009 14:14:59 +0100 (CET)
Received: from [89.59.86.74] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LTFgZ-0002PP-00; Sat, 31 Jan 2009 14:14:59 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX189bLfxNQcJYTbLemtSdlwbWO5elqg0MDOp7gCB
	ZsXg9vq9vx71u9cahOH6syXG+3KotxjwFkaw4hGeZAWx7cdeL7
	4vHf+qTPiCk3lZ3C2PQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107921>

Hi,

since several days "git svn fetch" didn't seem to work any more. I
bisected it down to

    commit dbc6c74d0858d77e61e092a48d467e725211f8e9
    git-svn: handle empty files marked as symlinks in SVN
    2009-01-11

In the new function _mark_empty_symlinks() there is a loop that takes
about 36 seconds for me. That means each svn revision takes 36+x seconds
for downloading. So it still works, but I aborted it before waiting so
much time, so I thought, it didn't work any more.

The loop loops over each blob ("git ls-tree -r git-svn | wc -l" times).
The project I'm using git-svn with is Buildroot and it has currently
3074 blobs in the tree. Printing a loop counter every time the loop is
executed, I can see that it mostly goes really fast, but there are
files, where it needs much time then.

Could there be a way to avoid this time consuming step?

Markus
