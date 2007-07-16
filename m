From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 13:21:47 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707161315120.20061@woody.linux-foundation.org>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
 <vpqd4yss1vo.fsf@bauges.imag.fr> <469BC17D.60806@slamb.org>
 <20070716200024.GD16878@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Scott Lamb <slamb@slamb.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 22:22:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAX5E-0007mp-0K
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 22:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbXGPUWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 16:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbXGPUWM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 16:22:12 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60763 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752543AbXGPUWL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 16:22:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GKLrUJ015822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2007 13:21:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GKLmT2031878;
	Mon, 16 Jul 2007 13:21:48 -0700
In-Reply-To: <20070716200024.GD16878@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=-4.631 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52715>



On Mon, 16 Jul 2007, Thomas Glanzmann wrote:
> 
> > so I think this patch is the best that can be done.
> 
> is there a reason why we call unlink and not remove?

Exactly because we only want to remove _files_.

If it's already a directory, we don't need to do anything at all (we just 
want to go to the next path component).

So what git wants is the modern "unlink()" behaviour that will return 
EPERM (oe EISDIR) for a directory. 

Not doing that in this day and age is *insane*. That whole "unlink/link" 
on directories is original UNIX, but it's original UNIX from several 
decades ago. It got fixed long long ago, and mkdir/rmdir have existed as 
system calls since at least SVR3. Nobody does the insane "unlink()" any 
more.

Except in Solaris, it would appear.

		Linus
