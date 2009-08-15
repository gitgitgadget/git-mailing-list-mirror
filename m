From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] block-sha1/sha1.c: silence compiler complaints by casting
 void* to uintptr_t
Date: Fri, 14 Aug 2009 17:19:32 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908141714040.3162@localhost.localdomain>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home> <_-0l9qI_nKm-VVtKlL5hzen4bhcyRmiZ1z4jSmKK1LwECXueziRDzSTyacEehOkoqsfYIaEUlds@cipher.nrlssc.navy.mil> <alpine.DEB.1.00.0908150207270.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>, nico@cam.org,
	gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 15 02:20:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc70p-0000ey-Ad
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 02:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423AbZHOAUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 20:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756393AbZHOAUK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 20:20:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39284 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751607AbZHOAUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 20:20:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7F0JXOX020995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Aug 2009 17:19:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7F0JWdi008069;
	Fri, 14 Aug 2009 17:19:32 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0908150207270.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.462 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125969>



On Sat, 15 Aug 2009, Johannes Schindelin wrote:
> 
> I am confused.  Is sizeof(*(uintptr_t)NULL) not larger than 1

You can't do that. "uintptr_t" isn't actually a pointer. It's just a 
unsigned integer value large enough to contain a pointer.

So it's _not_ a "pointer to uint". It's "uint that can contain all the 
bits of a poitner".

> and as a consequence ((uintptr_t)p)+1 not different from ((void *)p)+1?

No, they're the same.

That said, I suspect it might as well be cast to "const char *", and then 
hopefully you only need one cast.

So maybe it could be written as

	data = (const char *) data + len;

instead, and avoid the second cast (because the assignment should be ok, 
since it's assigning back to a "const void *").

		Linus
