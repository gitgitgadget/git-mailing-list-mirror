From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Sun, 18 Jan 2009 19:38:06 -0800
Message-ID: <7vr630rmn5.fsf@gitster.siamese.dyndns.org>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com>
 <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de>
 <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com>
 <7vhc3x1874.fsf@gitster.siamese.dyndns.org>
 <20090118094113.GE11992@leksak.fem-net>
 <20090118153928.GA16664@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Jonas =?utf-8?Q?Flod=C3=A9n?= <jonas@floden.nu>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 19 04:39:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOkzD-0008Nn-0Q
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 04:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544AbZASDiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 22:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757525AbZASDiQ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 22:38:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298AbZASDiP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 22:38:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 72D5491824;
	Sun, 18 Jan 2009 22:38:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4A6EA91820; Sun,
 18 Jan 2009 22:38:08 -0500 (EST)
In-Reply-To: <20090118153928.GA16664@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 18 Jan 2009 10:39:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A410660-E5DA-11DD-85D1-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106312>

Jeff King <peff@peff.net> writes:

> Yes, I'm surprised Junio doesn't remember the mass conversions we already had
> to do (4b7cc26a and 293623ed). But looking at the date, I guess it _has_
> been a year and a half. :)

Ok, I forgot, sue me ;-).

Anyway, thanks for spotting.  I'll fix it up like this.

-- >8 --
Subject: git-am: re-fix the diag message printing

The $FIRSTLINE variable is from the user's commit and can contain
arbitrary backslash escapes that may be (mis)interpreted when given to
"echo", depending on the implementation.  Use "printf" to work around the
issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ae2fe56..cf3d4a7 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -501,7 +501,7 @@ do
 	fi
 	if test $apply_status != 0
 	then
-		echo "Patch failed at $msgnum $FIRSTLINE"
+		printf 'Patch failed at %s %s\n' "$msgnum" "$FIRSTLINE"
 		stop_here_user_resolve $this
 	fi
 
-- 
1.6.1.245.gdd9f9
