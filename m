From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 5 Aug 2009 13:55:28 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain>
References: <20090805181755.22765.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:56:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnXa-00088T-FY
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbZHEU4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbZHEU4j
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:56:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42909 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751591AbZHEU4j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 16:56:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n75KtS1Q021367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 13:55:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n75KtSqK022119;
	Wed, 5 Aug 2009 13:55:28 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090805181755.22765.qmail@science.horizon.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124980>



On Wed, 5 Aug 2009, George Spelvin wrote:
> 
> > We can continue shipping mozilla one to help the last group.
> 
> Of course, we always need a C fallback.  Would you like a faster one?

I actually looked at code generation (on x86-64) for the C fallback, and 
it should be quite doable to re-write the C one to generate good code on 
x86-64.

On 32-bit x86, I suspect the register pressures are so intense that it's 
unrealistic to expect gcc to do a good job, but the Mozilla SHA1 C code 
really seems _designed_ to be slow in stupid ways (that whole "byte at a 
time into a word buffer with shifts" is a really really sucky way to 
handle the endianness issues).

So if you'd like to look at the C version, that's definitely worth it. 
Much bigger bang for the buck than trying to schedule asm language and 
having to deal with different assemblers/linkers/whatnot.

		Linus
