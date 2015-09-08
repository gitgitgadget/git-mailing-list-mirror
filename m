From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git_connect: clarify conn->use_shell flag
Date: Tue, 8 Sep 2015 17:40:19 -0400
Message-ID: <20150908214019.GA24159@sigill.intra.peff.net>
References: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
 <20150904125448.GA25501@sigill.intra.peff.net>
 <xmqqpp1yf3qe.fsf@gitster.mtv.corp.google.com>
 <20150904214454.GA18320@sigill.intra.peff.net>
 <20150904224008.GA11164@sigill.intra.peff.net>
 <CAOxFTcz9dZRQVnVnt+GtzAiu+GBi7CPE17d7rGo3H0v56MMAZQ@mail.gmail.com>
 <20150908083314.GB2991@sigill.intra.peff.net>
 <xmqqwpw096dq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:40:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZQct-0006i3-GO
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 23:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbbIHVkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 17:40:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:56449 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752460AbbIHVkW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 17:40:22 -0400
Received: (qmail 16911 invoked by uid 102); 8 Sep 2015 21:40:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 16:40:22 -0500
Received: (qmail 25698 invoked by uid 107); 8 Sep 2015 21:40:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 17:40:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 17:40:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwpw096dq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277524>

On Tue, Sep 08, 2015 at 10:18:41AM -0700, Junio C Hamano wrote:

> > To make the flow easier to follow, let's just set
> > conn->use_shell when we're setting up the "conn" struct, and
> > unset it (with a comment) in the historical GIT_SSH case.
> 
> Makes perfect sense.  I think another thing that falls into the same
> class wrt readability is 'putty'; if the code does putty=0 at the
> beginning of "various flavours of SSH", and sets it only when it
> checks with "various flavours of plink" when GIT_SSH_COMMAND is not
> set, the logic would be even clearer, I suspect.

Yeah, I think so.

> > Note that for clarity we leave "use_shell" on in the case
> > that we fall back to our default "ssh" This looks like a
> > behavior change, but in practice run-command.c optimizes
> > shell invocations without metacharacters into a straight
> > execve anyway.
> 
> Hmm, interesting.  I am not sure if that has to be the way, though.
> Wouldn't the resulting code become simpler if you do not do that?

Heh, I originally wrote it that way, and waffled between sending one or
the other.

> That is, is is what I have in mind on top of your patch.  Did I
> break something?
> 
>  connect.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

I think both changes are correct, and the result looks nice to read.
Feel free to squash them in as you apply.

-Peff
