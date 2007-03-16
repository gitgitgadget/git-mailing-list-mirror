From: linux@horizon.com
Subject: Re: cleaner/better zlib sources?
Date: 16 Mar 2007 02:08:41 -0400
Message-ID: <20070316060841.19946.qmail@science.horizon.com>
Cc: git@vger.kernel.org
To: torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Fri Mar 16 07:08:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS5cO-00089Y-9Y
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 07:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbXCPGIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 02:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbXCPGIo
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 02:08:44 -0400
Received: from science.horizon.com ([192.35.100.1]:14594 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753422AbXCPGIn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 02:08:43 -0400
Received: (qmail 19947 invoked by uid 1000); 16 Mar 2007 02:08:41 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42328>

Er, it's a little hard to see, but zlib spends the bulk of its time
in inflate_fast().  This is the fast path, invoked as long as there's
at least 6 bytes of input and 258 bytes of output space available.

The code in inflate.c just handles the last few bytes when near
one limit or the other.  Are you sure it's a performance problem?


There's equivalent inflate code in the PGP 5.0i distribution
(src/lib/pgp/compress/pgpZInflate.c) that's in the public domain AFAICT
(it says "Not copyrighted", and "You can do whatever you like with this
source file, though I would prefer that if you modify it and redistribute
it that you include comments to that effect with your name and the
date."), and uses switch statements only for resuming after a pause.

It's presumably well tested, but it's got a strong nasty-old-MSDOS
code smell about it, some truly bizarre indenting (don't look at lines
1118-1126 with a full stomach), and would require a lot of massaging to
integrate with zlib.
