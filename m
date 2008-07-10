From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Wed, 9 Jul 2008 18:31:02 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807091825500.11076@woody.linux-foundation.org>
References: <1215638942-25010-2-git-send-email-robertshearman@gmail.com> <7v8wwa5ycf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robert Shearman <robertshearman@gmail.com>, git@vger.kernel.org,
	Robert Shearman <rob@codeweavers.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 03:32:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGl1D-0006l8-Oe
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 03:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbYGJBbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 21:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYGJBbZ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 21:31:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54026 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752751AbYGJBbZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2008 21:31:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6A1V3m7029422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 Jul 2008 18:31:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6A1V2ZO002208;
	Wed, 9 Jul 2008 18:31:02 -0700
In-Reply-To: <7v8wwa5ycf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.859 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87928>



On Wed, 9 Jul 2008, Junio C Hamano wrote:
> 
> A hack like the one attached below would make it "work" but it is too
> ugly.  Probably we need to bite the bullet and rename ours not to
> collide, so that external library headers can safely include <ctype.h>.

We should be able to safely include <ctype.h> as-is.

It should just happen _before_ including git-compat-util.h. That's why 
git-compat-util.h does all those #undef's - exactly because ctype.h does 
get included on various systems by various header files when 
git-compat-util.h includes all those other files.

So the problem with Robert's patch is that it happens after "cache.h". The 
system headers should be included at the top of git-compat-util.h, or 
before it.

		Linus
