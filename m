From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Buffer overflows
Date: Thu, 30 Aug 2007 21:09:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708302050170.25853@woody.linux-foundation.org>
References: <1188502009.29782.874.camel@hurina>
 <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org>
 <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Timo Sirainen <tss@iki.fi>
X-From: git-owner@vger.kernel.org Fri Aug 31 06:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQxp4-000504-4u
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 06:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbXHaEJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 00:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbXHaEJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 00:09:26 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55933 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699AbXHaEJ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 00:09:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7V49HKn001516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Aug 2007 21:09:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7V49G9g022719;
	Thu, 30 Aug 2007 21:09:16 -0700
In-Reply-To: <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi>
X-Spam-Status: No, hits=-2.745 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.30__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57109>



On Fri, 31 Aug 2007, Timo Sirainen wrote:
> > 
> > Perhaps because your patch was using a totally nonstandard and slow
> > interface, and had nasty string declaration issues, as people even pointed
> > out to you.
> 
> Slow?

Having a string library, and then implementing "str_append()" with a 
strlen() sounds pretty disgusting to me. 

Gcc could have optimized the strlen() away for constant string arguments, 
but since you made the thing out-of-line, it can't do that any more.

So yes, I bet there are faster string libraries out there.

> The code should be easy to verify to be secure, and with some kind of a safe
> string API it's a lot easier than trying to figure out corner cases where
> strcpy() calls break.

I actually looked at the patches, and the "stringbuf()" thing was just too 
ugly to live. It was also nonportable, in that you use the reserved 
namespace (which we do extensively in the kernel, but that's an 
"embdedded" application that doesn't use system header files).

So the API was anything but "safe".

I think something like that could work, but it really should be done 
right, or not at all.

		Linus
