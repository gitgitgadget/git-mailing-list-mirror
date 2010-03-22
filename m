From: Jeff King <peff@peff.net>
Subject: Re: "git add -i" with path gives "Argument list too long"
Date: Sun, 21 Mar 2010 20:39:15 -0400
Message-ID: <20100322003915.GA3212@coredump.intra.peff.net>
References: <45CD9D1B-6774-46F2-A444-654B1DEF7F69@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 01:39:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtVfw-0002NT-2k
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 01:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab0CVAjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 20:39:19 -0400
Received: from peff.net ([208.65.91.99]:43586 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404Ab0CVAjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 20:39:19 -0400
Received: (qmail 29382 invoked by uid 107); 22 Mar 2010 00:39:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 21 Mar 2010 20:39:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Mar 2010 20:39:15 -0400
Content-Disposition: inline
In-Reply-To: <45CD9D1B-6774-46F2-A444-654B1DEF7F69@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142879>

On Sun, Mar 21, 2010 at 09:52:56PM +0100, Wincent Colaiuta wrote:

> Back in January I reported a wart in "git add -i" and discussion kind
> of petered out and I forgot about the bug until today when I ran into
> it again. Now I have a few more cycles to burn I have the time to sort
> it out.

Thanks for following up.

> To summarize and expand a bit upon what Jeff noted in that last post:
> 
>   - given _tracked_ file "foo.c" and _untracked_ file "bar.c"
>   - "git add '*.c'" ignores the tracked file and stages the untracked file
>   - "git add -i '*.c'" ignores the untracked file and operates on the
>   tracked file
> [...]
> So, as a first step I'd like to make some test cases to serve as a
> specification for what we want the desired behavior to be. I saw in

I'm pretty sure the behavior that we want eventually is for both the
diff family (including diff-files), and "git add" to learn about the
globbing pathspecs that ls-files uses. That will make "git add" and "git
add -i" consistent, and once diff-files understands it, we can drop the
call to ls-files in add--interactive, which will solve your "argument
list too long" problem.

And yes, I am being intentionally vague about the behavior beyond saying
"do what ls-files does". Personally I am not too familiar with the
globbing pathspecs, so I am not qualified to give an exhaustive list of
their behavior. Junio could probably say more, or you will have to read
the code.

-Peff
