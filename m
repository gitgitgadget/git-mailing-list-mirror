From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH 2/3] connect.c: save symref info from server capabilities
Date: Fri, 6 Sep 2013 21:25:15 +0200
Message-ID: <20130906192515.GI12966@inner.h.apk.li>
References: <20130906155204.GE12966@inner.h.apk.li> <20130906155655.GG12966@inner.h.apk.li> <xmqqob85ygt8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 21:25:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI1es-0001bt-OV
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 21:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262Ab3IFTZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 15:25:27 -0400
Received: from continuum.iocl.org ([217.140.74.2]:51797 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab3IFTZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 15:25:26 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r86JPFU08608;
	Fri, 6 Sep 2013 21:25:15 +0200
Content-Disposition: inline
In-Reply-To: <xmqqob85ygt8.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234088>

On Fri, 06 Sep 2013 10:56:51 +0000, Junio C Hamano wrote:
> Andreas Krey <a.krey@gmx.de> writes:
> 
...
> > +		if (symref) {
> > +			ref->symref = xcalloc(symref_len + 1, 1);
> > +			strncpy(ref->symref, symref, symref_len);
> > +		}
...
> 
> This looks utterly wrong.  HEAD may happen to be the first ref that
> is advertised and hence capability list typically comes on it, but
> that does not necessarily have to be the case from the protocol's
> correctness point of view.

Ok, then I misunderstood that part. I thought we'd be going to
put the symref (if any) into 'capabilities' on the respective ref,
but putting them all in one capability list sounds saner all in all.

> I think this function should do this instead.
> 
>     - inside the loop, collect the "symref=..." capabilities;
> 
>     - after the loop, look at the "symref=..." capabilities, and
>       among the refs the loop added to the *list, find the "HEAD"
>       ref and set its ->symref to point at an appropirate ref.

Fair game. There goes the parse_feature_value; will have to iterate
another way (or look them ("symref=#{name}:") up instead of collecting
them into a hash beforehand).

Can I assume that the only capability list is always on the
first ref sent (as it is now)?

(And besides, is there something more suitable for the 
 xcalloc/strncpy combination?)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
