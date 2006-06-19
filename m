From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix PPC SHA1 routine for large input buffers
Date: Sun, 18 Jun 2006 22:02:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606182145370.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606111747110.2703@localhost.localdomain>
 <Pine.LNX.4.64.0606181223580.5498@g5.osdl.org>
 <46a038f90606181440q4fd03bebl9495ace131eb958@mail.gmail.com>
 <Pine.LNX.4.64.0606181532130.5498@g5.osdl.org> <Pine.LNX.4.64.0606181543270.5498@g5.osdl.org>
 <17557.57564.267469.561683@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 19 07:03:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsBup-00085X-IN
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 07:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWFSFDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 01:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWFSFDG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 01:03:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750756AbWFSFDF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 01:03:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5J52vgt023436
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Jun 2006 22:02:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5J52u45016114;
	Sun, 18 Jun 2006 22:02:56 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17557.57564.267469.561683@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22115>



On Mon, 19 Jun 2006, Paul Mackerras wrote:
>
> The PPC SHA1 routine had an overflow which meant that it gave
> incorrect results for input buffers >= 512MB.  This fixes it by
> ensuring that the update of the total length in bits is done using
> 64-bit arithmetic.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Linus Torvalds <torvalds@osdl.org>

This fixes git-fsck-objects for me on the mozilla archive, no more 
complaints about bad SHA1's.

And yeah, now it's taking me 14 minutes too, so the 7-minute fsck was just 
because it didn't actually check the SHA1 of the large pack fully.

(Which is actually good news - half of the time is literally checking the 
pack integrity. That implies that the individual object integrity isn't as 
dominating as I thought it would be, and that things like hw-accelerated 
SHA1 engines will help with fsck. I'd not be surprised to see things like 
that in a couple of years).

		Linus
