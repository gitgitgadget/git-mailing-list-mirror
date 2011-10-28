From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: imap-send badly handles commit bodies beginning with "From <"
Date: Fri, 28 Oct 2011 16:21:22 -0500
Message-ID: <20111028212122.GB3966@foghorn.codeweavers.com>
References: <20111028180044.GA3966@foghorn.codeweavers.com>
 <20111028203256.GA15082@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Eikum <aeikum@codeweavers.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 28 23:21:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJtrm-0004lK-LG
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 23:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933414Ab1J1VVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 17:21:25 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:57417 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933393Ab1J1VVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 17:21:24 -0400
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>)
	id 1RJtrg-0006DF-0Y; Fri, 28 Oct 2011 16:21:24 -0500
Content-Disposition: inline
In-Reply-To: <20111028203256.GA15082@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184434>

On Fri, Oct 28, 2011 at 01:32:57PM -0700, Jeff King wrote:
> Mbox does have this problem, but I think in this case it is a
> particularly crappy implementation of mbox in imap-send. Look at
> imap-send.c:split_msg; it just looks for "From ".
> 
> It should at least check for something that looks like a timestamp, like
> git-mailsplit does. Maybe mailsplit's is_from_line should be factored
> out so that it can be reused in imap-send.

Since we have a program called "mailsplit," wouldn't it make more
sense to have imap-send use its implementation to split mail instead
of sharing just the From line detection?

> Want to work on a patch?

I was hoping it'd be a quick matter of pulling mailsplit's
implementation out of builtin and into the top level, but I see it's
got some global variables that are tangled enough that I actually have
to understand the code before I can pull it apart :)

If no one beats me to it, I'll work on this next week. It's late on
Friday and I'm moving house this weekend.

Quick question, since I'm not intimately familiar with Git's code: I
was thinking of creating a new compilation unit at the top level,
mailutils.{c,h}, and referencing it from both imap-send.c and
builtin/splitmail.c. Does that seem like the right approach? Is there
an existing compilation unit I should be placing splitmail's guts into
instead?

Andrew
