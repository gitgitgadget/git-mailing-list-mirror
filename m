From: Jeff King <peff@peff.net>
Subject: Re: [BUG/RFC] Raw diff output format (git-diff-tree) and
 --relative[=<path>] option
Date: Thu, 8 Jul 2010 07:41:25 -0400
Message-ID: <20100708114125.GA2427@sigill.intra.peff.net>
References: <201007051015.26995.jnareb@gmail.com>
 <201007051744.54266.jnareb@gmail.com>
 <201007081300.18712.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 13:41:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWpTy-0007r2-Dz
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 13:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab0GHLl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 07:41:29 -0400
Received: from peff.net ([208.65.91.99]:34301 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631Ab0GHLl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 07:41:29 -0400
Received: (qmail 2549 invoked by uid 107); 8 Jul 2010 11:42:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 08 Jul 2010 07:42:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Jul 2010 07:41:25 -0400
Content-Disposition: inline
In-Reply-To: <201007081300.18712.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150565>

On Thu, Jul 08, 2010 at 01:00:17PM +0200, Jakub Narebski wrote:

> Last there is filename munging, done using strip_prefix function.
> This is done using prefix_length only, and that is the cause of
> the bug:
>   $ git diff-tree --abbrev -r --raw HEAD --relative=sub
>   a3a8425fe5496c61921010cb1e7b455a1f52bb86
>   :100644 100644 d90bda0... cefcae0... M	/quux
> 
> if one uses '--relative=sub' instead of '--relative=sub/'.

Is that a bug or a feature? You need to say "sub/" to get what you want,
which is annoying. But it means you can also you "--relative=su" to get
"b/quux". In that example, it's probably useless, but consider a set of
filenames "foo-1" through "foo-5". You don't always want to break on a
directory boundary.

I believe "git-archive --prefix" has the same behavior for the same
reason.

-Peff
