From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log --decorate: do not leak "commit" color into the next
 item
Date: Wed, 18 Feb 2015 18:07:29 -0500
Message-ID: <20150218230728.GA17302@peff.net>
References: <xmqqzj8b0w6t.fsf@gitster.dls.corp.google.com>
 <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 00:07:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YODiS-0004zU-Rt
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 00:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbBRXHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 18:07:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:50773 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750955AbbBRXHc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 18:07:32 -0500
Received: (qmail 16077 invoked by uid 102); 18 Feb 2015 23:07:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 17:07:30 -0600
Received: (qmail 22477 invoked by uid 107); 18 Feb 2015 23:07:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 18:07:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2015 18:07:29 -0500
Content-Disposition: inline
In-Reply-To: <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264070>

On Wed, Feb 18, 2015 at 01:44:54PM -0800, Junio C Hamano wrote:

> If you wanted to paint the HEAD and local branch name in the same
> color as the body text (perhaps because cyan and green are too faint
> on a black-on-white terminal to be readable), you would not want to
> have to say
> 
>     [color "decorate"]
>         head = black
>         branch = black
> 
> because that you would not be able to reuse same configuration on a
> white-on-black terminal.  You would naively expect
> 
>     [color "decorate"]
>         head = normal
> 	branch = normal
> 
> to work, but unfortunately it does not.  It paints the string "HEAD"
> and the branch name in the same color as the opening parenthesis or
> comma between the decoration elements when showing output like this:
> 
>     $ git show -s --decorate
>     commit f3f407747c1cce420ae4b4857c4a6806efe38680 (HEAD, master)
>     ...
> 
> This is because the code forgets to reset the color after printing
> the "prefix" in its own color.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Yeah, I think this is a good fix. I had a vague feeling that we may have
done this on purpose to let the decoration color "inherit" from the
existing colors for backwards compatibility, but I don't think that
could ever have worked (since color.decorate.* never defaulted to
"normal"). And I couldn't find anything on the list. I think I am
probably thinking of color.diff.func, which faced a similar issue.

Also, for your amusement:

  http://thread.gmane.org/gmane.comp.version-control.git/191102/focus=191118

Believe it or not, this was actually an item on my todo list, which is
perhaps a commentary on how sad and unrealistic my todo list is. But I'm
crossing it off anyway. Task accomplished!

-Peff
