From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Make mktag a builtin.
Date: Mon, 12 May 2008 11:41:13 -0700
Message-ID: <7vej87z7p2.fsf@gitster.siamese.dyndns.org>
References: <1210299589-10448-1-git-send-email-drafnel@example.com>
 <1210299589-10448-2-git-send-email-drafnel@example.com>
 <7689656.1210299528037.JavaMail.teamon@b301.teamon.com>
 <7v63tk6992.fsf@gitster.siamese.dyndns.org>
 <48285DAB.2040707@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon May 12 20:42:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvcya-0005i1-61
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbYELSlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756031AbYELSlb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:41:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025AbYELSla (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:41:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E2BAC4ABC;
	Mon, 12 May 2008 14:41:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0DA134ABA; Mon, 12 May 2008 14:41:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 076118FA-2053-11DD-A42E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81898>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> I didn't think I should move the non-builtin mktag.c to builtin-mktag.c,
> and then after I modified mktag to be a builtin I knew I was moving it
> to builtin-tag.c so I didn't see a point to renaming it.

I see.  I did not realize that the eventual shape would be to have both
mktag and tag to be in builtin-tag.c, just like builtin-log.c supports
many other commands from the log family, and that was where my question
came from.

But I think the arrangement to have both in builtin-tag.c actually makes
sense --- mktag needs to be kept supported but most of its internal should
be shared with tag anyway.

> Also, I decided about those things _before_ I realized how small the changes
> would be to mktag to make it a builtin.
>
> Do you think the modified patch you posted conflicts with the idea that
> "code move should be separate from code change"?

Yes, it does, but I do not subscribe to the "idea".  Therefor I do not see
any problem.

If you were to stop at making mktag a builtin, then the patch I sent would
be the change that is necessary to do so.  A code movement can and often
does need some adjustment (e.g. if you move "a.c" to "src/a.c", its
'#include "a.h"' may need to become '#include "../a.h"' (or preferably to
'#include <a.h>' with appropriate -I.. option in the Makefile).  It does
not help anybody to insist on a blanket dogma that forbids modification
and movement at the same time.

We do discourage rolling unrelated things in one commit, but creating a
builtin "foo" typically involves creation of builtin-foo.c and associated
changes to the Makefile and builtin.h, and in this case the initial
contents of builtin-mktag.c happens to come from an existing file mktag.c,
while making the original mktag.c obsolete and unnecessary along the way.
That is a single logical change, and I do not think there is anything
wrong to do it in one commit. In fact, splitting such a change into more
than one commit is just plain silly and wrong, isn't it?
