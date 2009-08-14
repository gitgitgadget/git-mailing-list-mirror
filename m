From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Fix "unpack-objects --strict"
Date: Fri, 14 Aug 2009 11:30:27 +0200
Message-ID: <20090814093027.GA14475@mail-vs.djpig.de>
References: <20090813103231.GY14475@mail-vs.djpig.de> <20090813111933.GZ14475@mail-vs.djpig.de> <7vd46zbjae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 11:30:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbt7d-0001u9-D7
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 11:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbZHNJaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 05:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbZHNJai
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 05:30:38 -0400
Received: from pauli.djpig.de ([78.46.38.139]:46013 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbZHNJag (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 05:30:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id F34CF9007F;
	Fri, 14 Aug 2009 11:30:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U+dZItH4n0tL; Fri, 14 Aug 2009 11:30:27 +0200 (CEST)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 84ACE9007C;
	Fri, 14 Aug 2009 11:30:27 +0200 (CEST)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.69)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1Mbt7D-0005OJ-5F; Fri, 14 Aug 2009 11:30:27 +0200
Content-Disposition: inline
In-Reply-To: <7vd46zbjae.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125921>

On Thu, Aug 13, 2009 at 12:33:45PM -0700, Junio C Hamano wrote:
> When unpack-objects is run under the --strict option, objects that have
> pointers to other objects are verified for the reachability at the end, by
> calling check_object() on each of them, and letting check_object to walk
> the reachable objects from them using fsck_walk() recursively.
> 
> The function however misunderstands the semantics of fsck_walk() function
> when it makes a call to it, setting itself as the callback.  fsck_walk()
> expects the callback function to return a non-zero value to signal an
> error (negative value causes an immediate abort, positive value is still
> an error but allows further checks on sibling objects) and return zero to
> signal a success.  The function however returned 1 on some non error
> cases, and to cover up this mistake, complained only when fsck_walk() did
> not detect any error.
> 
> To fix this double-bug, make the function return zero on all success
> cases, and also check for non-zero return from fsck_walk() for an error.

I've applied this patch and your small follow-up patch here and the error
indeed disappears. I can't comment on the semantical correctness of the
patch.

Thanks,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
