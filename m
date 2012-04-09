From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Mon, 09 Apr 2012 09:30:37 -0400
Message-ID: <1333977812-sup-4111@pinkfloyd.chass.utoronto.ca>
References: <1333935414-10389-1-git-send-email-bwalton@artsci.utoronto.ca> <m2sjgde7cs.fsf@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 15:30:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHEg6-00005F-SJ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 15:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521Ab2DINai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 09:30:38 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:55144 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab2DINai (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 09:30:38 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:48985 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SHEg1-0007Dt-4R; Mon, 09 Apr 2012 09:30:37 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SHEg1-0007GW-3U; Mon, 09 Apr 2012 09:30:37 -0400
In-reply-to: <m2sjgde7cs.fsf@linux-m68k.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195016>

Excerpts from Andreas Schwab's message of Mon Apr 09 02:40:03 -0400 2012:

> How about using 's|[^/][^/]*|..|g' instead, which should avoid the bug
> as well.

I'd be ok with that change if the changed semantics of the regex are
ok in this application.  It's essentially the same as s|[^/]+|..|g,
which requires at least one character.

In the current code, if you do:

echo '/' | sed -e 's|[^]*|..|g'

you get: ../.. (from a working implementation).

Your regex would see the result  be: /

I don't think we'd ever be passing a plain /, but we might pass a
fully qualified path /path/to/foo, which would see the result change
from ../../../.. to /../../.. and that could have unintended impact.

I'd need to look more closely to see if this is a problem in reality.
Others more familiar with this code likely know the answer already.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
