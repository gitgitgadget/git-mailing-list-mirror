From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Hmm.. Try harder to find the common commits in git protocol?
Date: Mon, 28 Apr 2008 09:41:09 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804280936080.3119@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:43:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWRT-0007sD-MR
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934101AbYD1QmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 12:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934011AbYD1QmP
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:42:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59465 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933811AbYD1QmO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 12:42:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SGfAmX031573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Apr 2008 09:41:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SGf98V004175;
	Mon, 28 Apr 2008 09:41:09 -0700
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.479 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80559>


So we've had a huge number of merges in this last kernel merge window, and 
as a result it seems that a number of the pulls I do get way too many 
objects, because the git protocol doesn't try hard enough to find the 
minimal set of common commits. 

Example from today:

	remote: Counting objects: 50084, done.
	remote: Compressing objects: 100% (6489/6489), done.
	remote: Total 43343 (delta 37381), reused 42777 (delta 36836)
	Receiving objects: 100% (43343/43343), 8.85 MiB | 144 KiB/s, done.
	Resolving deltas: 100% (37381/37381), completed with 5097 local objects.
	Merge made by recursive.
	 kernel/hrtimer.c |   15 +++++++++++++--
	 1 files changed, 13 insertions(+), 2 deletions(-)

	git rev-list --objects ORIG_HEAD.. | wc -l
	7

ie it downloaded 43343 objects totalling almost 9MB of data, even though 
it actually only needed seven objects. In fact, I guess three of the seven 
new objects were due to the merge (commit, top-level tree, and 'kernel' 
tree), so only four objects actually came from the source repository.

I haven't thought about the why's so much (because I'm busy merging), but 
I thought I'd mention this in case somebody else has already looked at it.

		Linus
