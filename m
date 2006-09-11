From: Paul Mackerras <paulus@samba.org>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 18:36:15 +1000
Message-ID: <17669.8191.778645.311304@cargo.ozlabs.ibm.com>
References: <20060910190332.17667.qmail@science.horizon.com>
	<Pine.LNX.4.64.0609101254590.27779@g5.osdl.org>
	<17668.38032.20688.991295@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609101949580.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, jonsmirl@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 10:37:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMhI4-00069L-HX
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 10:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWIKIg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 04:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWIKIg0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 04:36:26 -0400
Received: from ozlabs.org ([203.10.76.45]:35239 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751265AbWIKIgZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 04:36:25 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 47A7D67B71; Mon, 11 Sep 2006 18:36:23 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609101949580.27779@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26842>

Linus Torvalds writes:

> So we could generate a "pack of references", but then any modifications 
> would be done with the current loose "file objects" approach, and just 
> have the filesystem override the pack-files. The problem then actually 
> becomes one of _deleting_ branches, because then we'd have to add a 
> "negative branch" loose object. Ugly.

Could we do a cache of the refs that stores the stat information for
each of the files under .git/refs plus the sha1 that the ref points
to?  In other words this cache would do for the refs what the index
does for the working directory.  Reading all the refs would mean we
still had to stat each of the files, but that's much quicker than
reading them in the cold-cache case.  In the common case when most of
the stat information matches, we don't have to read the file because
we have the sha1 that the file contains right there in the cache.

Ideally we would have two sha1 values in the cache - the sha1 in the
file, and if that is the ID of a tag object, we would also put the
sha1 of the commit that the tag points to in the cache.

Paul.
