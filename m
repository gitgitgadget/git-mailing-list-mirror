From: Jeff King <peff@peff.net>
Subject: Re: How can I get a list of checkout history?
Date: Mon, 15 Feb 2016 11:56:03 -0500
Message-ID: <20160215165603.GD25364@sigill.intra.peff.net>
References: <CAHd499D5nMvFQ-eok_3tMZTNp+9JdcMZSL9XrXqkdUNxmRq_eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 17:56:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVMRX-0008Pw-VE
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 17:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbcBOQ4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 11:56:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:42191 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751496AbcBOQ4G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 11:56:06 -0500
Received: (qmail 21158 invoked by uid 102); 15 Feb 2016 16:56:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 11:56:05 -0500
Received: (qmail 9278 invoked by uid 107); 15 Feb 2016 16:56:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 11:56:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 11:56:03 -0500
Content-Disposition: inline
In-Reply-To: <CAHd499D5nMvFQ-eok_3tMZTNp+9JdcMZSL9XrXqkdUNxmRq_eQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286210>

On Mon, Feb 15, 2016 at 09:18:50AM -0600, Robert Dailey wrote:

> As you know, I can checkout the Nth checked out branch via this syntax:
> 
> $ git checkout @{-N}
> 
> Is there a built-in mechanism to get a listing of previously checked
> out refs? Basically, this would be similar to 'history' command in
> linux where instead of actual commands, it lists like this:
> 
> HEAD@{-1}: master
> HEAD@{-2}: topic1
> HEAD@{-3}: 3f556e9 (detached)
> 
> Seems like reflog should be able to do this, and maybe it can, but I'm
> not sure. Any tips? I'd be fine making a convenient alias for this if
> it ends up being a series of piped commands.

The "@{-N}" syntax works by reading the HEAD reflog backwards and
grepping for "checkout: moving from ...". The implementation is in
grab_nth_branch_switch.

You could do it yourself like:

  git reflog HEAD |
  perl -lne '/checkout: moving from (\S+) to/ and print $1'

That includes detached HEADs, too. If you want just "real" branaches,
you could possibly omit entries which match [0-9a-f]{40}. But that's
just a heuristic (you _could_ have a branch that matches that).

-Peff
