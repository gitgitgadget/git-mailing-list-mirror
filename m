From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] multi item packed files
Date: Fri, 22 Apr 2005 19:55:14 -0400
Message-ID: <200504221955.15422.mason@suse.com>
References: <200504211113.13630.mason@suse.com> <Pine.LNX.4.58.0504221230020.2344@ppc970.osdl.org> <200504221632.26278.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Halasa <khc@pm.waw.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 01:51:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP7vb-0008BC-0Z
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 01:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVDVXzq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVDVXzp
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:55:45 -0400
Received: from ns.suse.de ([195.135.220.2]:46229 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261353AbVDVXzX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 19:55:23 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id CD0CB160AEEF;
	Sat, 23 Apr 2005 01:55:19 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <200504221632.26278.mason@suse.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Friday 22 April 2005 16:32, Chris Mason wrote:

> If I pack every 64k (uncompressed), the checkout-tree time goes down to
> 3m14s. That's a very big difference considering how stupid my code is  .git
> was only 20% smaller with 64k chunks.  I should be able to do better...I'll
> do one more run.
>

This run also packed tree files together (everything produced by write-tree 
went into a packed file), but not the commits.  I estimate I could save about 
another 168m by packing the tree files and commits into the same file with 
the blobs, but this wouldn't make any of the times below faster.

git - original (28k commits)	                packed
FS size                2,675,408k			1,723,820k
read-tree            24.45s				18.9s
checkout-cache   4m30s				3m5s
patch time	   2h30m				1h55m

The format for the packed files could be smarter, such that it didn't require 
decompressing the whole packed file to read one item.  I would guess I could 
get another 20% checkout-cache performance out of it via more tuning, and 
probably another 10% of space savings.

Of course, none of this is likely to convince you ;)  If you decide later on 
it's worthwhile, I don't think it would be difficult to add then.

-chris
