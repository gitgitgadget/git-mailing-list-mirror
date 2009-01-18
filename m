From: Jeff King <peff@peff.net>
Subject: Re: meaning of --8<--
Date: Sun, 18 Jan 2009 12:44:44 -0500
Message-ID: <20090118174444.GB17055@coredump.intra.peff.net>
References: <200901181656.37813.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:46:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LObis-0007ZD-Jp
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933012AbZARRos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 12:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932907AbZARRoq
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:44:46 -0500
Received: from peff.net ([208.65.91.99]:32790 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932514AbZARRoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:44:46 -0500
Received: (qmail 22214 invoked by uid 107); 18 Jan 2009 17:44:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Jan 2009 12:44:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jan 2009 12:44:44 -0500
Content-Disposition: inline
In-Reply-To: <200901181656.37813.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106251>

On Sun, Jan 18, 2009 at 04:56:37PM +0100, Markus Heidelberg wrote:

> I've seen lines like "--8<--" several times on this list, but have no
> clue what it is about. OK, seems like it's used to insert diffs in the
> middle of a mail message.
> But is this a common convention or git specific and handled by git-am?
> Is it documented anywhere?

As others have explained, it is supposed to be scissors, and it is not
handled by git-am. But the real point of it is to help the person
applying (e.g., Junio) manually separate cover letter from the commit
message. So one way of sending cover material is putting it after the
"---" and before the diff:

  Subject: [PATCH] first line of commit message

  more commit message
  ---
  Here is cover letter material that doesn't go in the commit message.
  It is stripped automatically by git-am.

  diff --git ...

but that is often unnatural to read, because the cover letter material
often introduces the commit, especially when you are replying in the
middle of a thread. So then you end up with:

  Subject: Re: whatever thread you're in

  Somebody else said:
  > blah blah blah

  I disagree. You should do it like this instead:

  -- >8 --
  first line of commit message

  more commit message
  ---

  diff --git ...

git-am will put everything down to the "---" into the commit message,
but it is simple enough to amend away everything else.

So in that sense, it doesn't really matter _what_ the separator is, but
it should be visibly obvious to a human so that they can fix up the
commit message. The only exception is that it should _not_ be "---",
because that is treated specially by git-am.

-Peff
