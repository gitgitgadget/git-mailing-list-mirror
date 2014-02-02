From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] userdiff: update Ada patterns
Date: Sun, 2 Feb 2014 18:35:31 -0500
Message-ID: <20140202233531.GE16196@sigill.intra.peff.net>
References: <52EE234C.1060002@redneon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adrian Johnson <ajohnson@redneon.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 00:35:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA6Ze-0001Qw-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 00:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbaBBXfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 18:35:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:43370 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752554AbaBBXfe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 18:35:34 -0500
Received: (qmail 416 invoked by uid 102); 2 Feb 2014 23:35:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 02 Feb 2014 17:35:34 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Feb 2014 18:35:31 -0500
Content-Disposition: inline
In-Reply-To: <52EE234C.1060002@redneon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241391>

On Sun, Feb 02, 2014 at 09:21:56PM +1030, Adrian Johnson wrote:

> - Allow extra space in "is new" and "is separate"
> [...]
> -	 "!^(.*[ \t])?(is new|renames|is separate)([ \t].*)?$\n"
> +	 "!^(.*[ \t])?(is[ \t]+new|renames|is[ \t]+separate)([ \t].*)?$\n"

I do not know anything about Ada syntax, but this change looks obviously
sensible.

> - Fix bug in word regex for numbers
> -	 "|[0-9][-+0-9#_.eE]"
> +	 "|[-+0-9#_.eE]+"

This makes "E" or "_" a number. Is that right?

I think the intent of the original was "starts with a digit, and then
has one or more of these other things after it". You do not describe the
bug, but I guess it would be that it does not match obvious things like
"5". Should it be "zero or more" instead, like:

  [0-9][-+0-9#_.eE]*

? Also, should -/+ be hoisted to the front?

  [-+]?[0-9][0-9#_.eE]*

Again, I am just guessing, as I am not familiar enough with Ada.

-Peff
