From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] xdiff-interface.c (buffer_is_binary): Remove buffer size
 limitation
Date: Mon, 3 Dec 2007 16:00:10 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712031559480.8458@woody.linux-foundation.org>
References: <20071201160113.GA20849@nomad.office.altlinux.org> <7vlk8e42qb.fsf@gitster.siamese.dyndns.org> <20071203215007.GA14697@basalt.office.altlinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 01:02:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzLFF-0002If-2f
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 01:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbXLDACQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 19:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbXLDACQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 19:02:16 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34590 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751081AbXLDACP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 19:02:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB400Bn0030708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Dec 2007 16:00:12 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB400A9k024151;
	Mon, 3 Dec 2007 16:00:10 -0800
In-Reply-To: <20071203215007.GA14697@basalt.office.altlinux.org>
X-Spam-Status: No, hits=-4.724 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66980>



On Tue, 4 Dec 2007, Dmitry V. Levin wrote:
>
> Average file size in the linux-2.6.23.9 kernel tree is 10944 bytes,

Don't do "average" sizes. That's an almost totally meaningless number.

"Average" makes sense if you have some kind of gaussian distribution or 
similar. File sizes tend to be exponential distributions, and what makes 
much more sense is to look at the median. That doesn't show the effect of 
a few larger files, and also gives you a much better "half the files are 
smaller than x" idea.

And the median filesize for the kernel is just a few bytes over 4k.

Of the 23,000+ files in the current kernel, about 15,500 are less than 
8kB. And 17,179 are smaller than the 10944 bytes you mention.

I'd argue that 8kB (or even 4kB) is probably a good number for things like 
that: it catches the bulk of all files in their entirety, but it *avoids* 
spending tons of time on the (few) really large files.

			Linus
