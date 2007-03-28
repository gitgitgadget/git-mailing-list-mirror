From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] commit: fix pretty-printing of messages with "\nencoding "
Date: Wed, 28 Mar 2007 15:10:07 -0700
Message-ID: <7v7it1f29s.fsf@assigned-by-dhcp.cox.net>
References: <20070328215209.GA13672@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 00:10:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWgLM-0001LH-Rx
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 00:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933602AbXC1WKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 18:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933669AbXC1WKJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 18:10:09 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:45403 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933602AbXC1WKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 18:10:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328221007.QBXG1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 28 Mar 2007 18:10:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gNA61W00p1kojtg0000000; Wed, 28 Mar 2007 18:10:07 -0400
In-Reply-To: <20070328215209.GA13672@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Mar 2007 17:52:09 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43394>

Jeff King <peff@peff.net> writes:

> I wonder, though, if this function before or after is actually correct;
> if there is no encoding header, we exit the function immediately. But if
> we are changing the encoding from utf8 to a non-utf8 value, we
> presumably should continue and actually insert the new encoding header.

The function is correct; the only reason it may recode to
non-utf8 is the user (or Porcelain such as qgit or gitk)
explicitly asked to do so -- from the final output they will get
the message in user-native encoding and without the extra
encoding header, thus we retain the backward compatible
behaviour before the re-encoding feature was introduced.
