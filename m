From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: --amend -m '' silently fails to wipe message
Date: Thu, 7 Apr 2016 15:02:11 -0400
Message-ID: <20160407190210.GA4478@sigill.intra.peff.net>
References: <20160406171503.GA2345@dinwoodie.org>
 <20160407044219.GA29710@sigill.intra.peff.net>
 <20160407044837.GA28859@sigill.intra.peff.net>
 <xmqqshyxz3ss.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
	Chris Webb <chris@arachsys.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:02:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFC9-0006GA-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbcDGTCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:02:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:46001 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751964AbcDGTCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:02:16 -0400
Received: (qmail 27680 invoked by uid 102); 7 Apr 2016 19:02:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 15:02:15 -0400
Received: (qmail 29390 invoked by uid 107); 7 Apr 2016 19:02:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 15:02:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Apr 2016 15:02:11 -0400
Content-Disposition: inline
In-Reply-To: <xmqqshyxz3ss.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290950>

On Thu, Apr 07, 2016 at 11:12:19AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I guessed that this might have come from the conversion of "message"
> > form a pointer (which could be NULL) into a strbuf. And indeed, it looks
> > like f956853 (builtin-commit: resurrect behavior for multiple -m
> > options, 2007-11-11) did that.
> 
> Yikes.  That is a quite ancient breakage.
> 
> The funny thing is that we did address the same breakage in 25206778
> (commit: don't start editor if empty message is given with -m,
> 2013-05-25), but didn't notice that there are other breakages of the
> same nature.
> 
> I think all message.len check can and should be have_option_m
> instead.
> 
>  - The one in the first hunk is a fix for the issue that "-m ''" is
>    ignored and we read from use_message etc., which is the original
>    issue in this thread.
> 
>  - The second one is a fix for your "git commit -m '' -F f" example
>    that does not error out.
> 
>  - The last one is a fix for "git -c commit.template=f commit -m ''"
>    that still uses the template file 'f'.

Yes, FWIW, those were the sites and reasons I identified last night.
Your patch looks like the right thing to me.

-Peff
