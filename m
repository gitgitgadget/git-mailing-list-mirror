From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix read-tree merging more than 3 trees using 3-way
 merge
Date: Thu, 16 Aug 2007 19:32:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708161930100.30176@woody.linux-foundation.org>
References: <600399.61066.qm@web52807.mail.re2.yahoo.com>
 <7vbqd8o1qs.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708161750550.30176@woody.linux-foundation.org>
 <7vbqd6j4a0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Perrin Meyer <perrinmeyer@yahoo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 04:32:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILrdx-0007v1-NP
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 04:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762801AbXHQCcw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 22:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762633AbXHQCcv
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 22:32:51 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40947 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757985AbXHQCcu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Aug 2007 22:32:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7H2WeCF022506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Aug 2007 19:32:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7H2WYT6017960;
	Thu, 16 Aug 2007 19:32:35 -0700
In-Reply-To: <7vbqd6j4a0.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-4.75 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56042>



On Thu, 16 Aug 2007, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > 
> > Sorry. I didn't even realize people did this. Oops.
> 
> This is no big deal.  It would have triggered if you are using
> resolve strategy _and_ did a multi merge-base merge, the former
> of which is quite unusual these days.

Yeah, ok. I see what's up. 

Anyway, it sounds like we should just increase MAX_TREES to get the old 
behaviour (and that requires applying my trivial one-liner patch too, 
otherwise "git read-tree" will refuse to do more than 4 trees anyway).

Even if nothing apparently actually does it.

The alternative, I think, would be to just say that the three-way merge is 
really just three ways, and remove the test that tests four different 
trees. That would allow simplifying the logic in unpack_trees(). But since 
the logic already exists, there's no real upside.

		Linus
