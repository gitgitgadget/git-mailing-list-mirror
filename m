From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: Another memory overrun in http-push.c
Date: Fri, 2 Mar 2007 13:03:57 +0300
Message-ID: <20070302100356.GE57456@codelabs.ru>
References: <20070301160911.GU57456@codelabs.ru> <7vwt20giw3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 11:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN4cY-0005cP-VE
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 11:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422996AbXCBKEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 05:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422997AbXCBKEL
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 05:04:11 -0500
Received: from pobox.codelabs.ru ([144.206.177.45]:61401 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422996AbXCBKEK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 05:04:10 -0500
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HN4cS-000J69-A4; Fri, 02 Mar 2007 13:04:08 +0300
Content-Disposition: inline
In-Reply-To: <7vwt20giw3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-2.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_05
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41179>

Junio, good day!

> > Spotted another memory overrun in the http-push.c. In principle,
> > it is the read-only overrun, but it provokes the coredump on my
> > system.  The problem is that strlcpy(dst, src, size) returns the
> > length of the 'src' and demands it to be NULL-terminated (see
> > 'man strlcpy' and http://www.gratisoft.us/todd/papers/strlcpy.html).
> > It is not the case for the xml_cdata and possibly other places. So
> > I've just replaced strlcpy with memcpy + zero termination all over
> > the http-push.c. The patch is below.
> 
> Please check Documentation/SubmittingPatches.

Thanks, just read and enlightened.

> Use of strlcpy() in general _is_ stupid if you are computing how
> much space is needed, allocating that much as your own buffer
> and then copying.  strlcpy() needs to say how much it would have
> copied if it were given large enough buffer, and it needs to be
> able to run strlen(src), so it is not valid to give a buffer
> that may not be NUL-terminated as you say.

Yes, you're perfectly right: the strncpy, bcopy or memcpy + zero-termination
are preferrable in this situation.
-- 
Eygene
