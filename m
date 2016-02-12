From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Fri, 12 Feb 2016 15:10:02 -0500
Message-ID: <20160212201002.GA21598@sigill.intra.peff.net>
References: <56B32953.2010908@gmail.com>
 <20160204111307.GA30495@sigill.intra.peff.net>
 <xmqqsi0xu2ac.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	szeder@ira.uka.de, tr@thomasrast.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 21:10:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUK2e-0005x3-3E
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 21:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbcBLUKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 15:10:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:41188 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750714AbcBLUKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 15:10:05 -0500
Received: (qmail 17080 invoked by uid 102); 12 Feb 2016 20:10:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 15:10:05 -0500
Received: (qmail 18967 invoked by uid 107); 12 Feb 2016 20:10:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 15:10:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Feb 2016 15:10:02 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsi0xu2ac.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286075>

On Fri, Feb 12, 2016 at 12:00:43PM -0800, Junio C Hamano wrote:

> > Anyway, I this is a reasonable workaround. Errors from bash completion
> > scripts are almost always going to be useless and get in the way of
> > reading your own prompt.
> 
> I think that is absolutely the right stance to take, but then I
> wonder if it is a sensible execution to sprinkle 2>/dev/null
> everywhere.
> 
> For example, couldn't we do something like this instead?
> 
> This is just for illustration and does not remove all 2>/dev/null
> and replace them with a single redirection that covers the entire
> shell function body, but something along this line smells a lot more
> pleasant.  I dunno.

I agree it's a lot more pleasant, assuming there are no cases where we
would want to pass through an error. But I really cannot think of one.
Even explosive "woah, your git repo is totally corrupted" messages
probably should be suppressed in the prompt.

> @@ -320,7 +320,7 @@ __git_heads ()
>  			refs/heads
>  		return
>  	fi
> -}
> +} 2>/dev/null

Today I learned about yet another fun corner of POSIX shell.

-Peff
