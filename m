From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] user-manual: Add section "Why bisecting merge commits
 can be harder ..."
Date: Sat, 10 Nov 2007 11:10:51 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711101105340.15101@woody.linux-foundation.org>
References: <B622E814-D7D1-4DC8-A724-666BA0A1220F@zib.de>
 <1194702594213-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:12:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqvkZ-00059V-HE
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 20:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbXKJTL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 14:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbXKJTL4
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 14:11:56 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58099 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752092AbXKJTLz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 14:11:55 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAAJAqBw027331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 10 Nov 2007 11:10:54 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAAJAplN026653;
	Sat, 10 Nov 2007 11:10:51 -0800
In-Reply-To: <1194702594213-git-send-email-prohaska@zib.de>
X-Spam-Status: No, hits=-3.238 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64369>



On Sat, 10 Nov 2007, Steffen Prohaska wrote:
> +
> +But if you already made a merge C instead of rebasing, all
> +is not lost.  In the illustrated case, you can easily rebase
> +one parent branch on top of the other after the fact, just
> +to understand the history and to make the history more
> +easily to bisect.

I simply don't think this is true. 

You can *not* easily rebase after the fact. Both the parents may have lots 
of merges independently of each other, and rebase won't be able to do 
*anything* with such a case. In fact, the only reason you think you can 
easily rebase after-the-fact is that you made the example history be 
trivial. In real life, if the example history is that trivial (just a 
single merge of two otherwise linear histories), you'd probably generally 
not have this problem in the first place.

The facts are:

 - git bisect can handle merges quite well, and points to the right 
   commit (which is *usually* not a merge).

 - but merges by definition introduce changes from two independent lines 
   of development, and while both lines may work well on their own, it is 
   possible that (a) the merge itself was done incorrectly or (b) the two 
   (or more) features that were introduced simply clash.

 - "git rebase" won't do a thing for this after the fact, except in 
   trivial cases, and even then it will generate a new history that simply 
   isn't compatible with the original history, so while it could in theory 
   help bisect things further in some limited and simple cases, in general 
   it's simply not that useful an approach.

..and I think it's simply wrong to even *try* to imply that "git rebase" 
can somehow change any of this.

			Linus
