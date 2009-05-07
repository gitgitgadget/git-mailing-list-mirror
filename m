From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [JGIT PATCH 2/2] Make Repository.isValidRefName compatible with
 Git 1.6.3
Date: Thu, 7 May 2009 16:29:21 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905071620240.4983@localhost.localdomain>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org> <1241708714-20326-2-git-send-email-spearce@spearce.org> <200905080102.44053.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 01:32:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2D5E-0005zF-1P
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 01:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbZEGXcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 19:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753997AbZEGXca
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 19:32:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40301 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752599AbZEGXc3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 19:32:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47NTMko004485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 May 2009 16:29:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47NTLLr018754;
	Thu, 7 May 2009 16:29:21 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <200905080102.44053.robin.rosenberg@dewire.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.962 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118541>



On Fri, 8 May 2009, Robin Rosenberg wrote:
> 
> In 3e262b95c509 I taught C Git to disallow refs whose names end in
> ".lock".

Btw, I think we should revert that, and instead change our naming for 
lock-files.

It's a silly limitation, and for a stupid reason, I think. I can well 
imagine people using a branch naming policy of using '.' instead of 
spaces, and then It makes perfect sense to call a branch "fix.vm.lock" 
when you have a VM locking issue you want to fix.

So I think we should remove that stupid "*.lock" rule from the C version 
(and then obviously from the JGIT one too).

Now, that leaves what we _should_ call the lock-files, and the only sane 
thing to do is to pick a sequence that is already invalid for other 
reasons. We could make the lockfile end in "..lock", for example (".." is 
not legal in names due to the confusion with the "a..b" range notation), 
or just end or begin with a "." (same issue, except "..." now).

Or just make it end in '~' which is also invalid for similar reasons.

		Linus
