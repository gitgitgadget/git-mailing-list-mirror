From: Stefan Zager <szager@google.com>
Subject: Re: Fix potential hang in https handshake.
Date: Fri, 19 Oct 2012 13:37:06 -0700
Message-ID: <CAHOQ7J8D-8++vgMh=c0rcTtAKrhWUCQx2nSd_spBzFe=QdXwBw@mail.gmail.com>
References: <5080761e.IEDySUuQzlCwL6fM%szager@google.com>
	<7vd30fl736.fsf@alter.siamese.dyndns.org>
	<20121019103627.GA29366@sigill.intra.peff.net>
	<CAJo=hJvWV0WPN5rCYK-JxfaEPWp7syUM1H0w4=Eb27=50+pXjg@mail.gmail.com>
	<20121019202723.GA24184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Shawn Pearce <sop@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 22:37:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPJJr-0005C6-Pu
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 22:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379Ab2JSUhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 16:37:10 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:56026 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030370Ab2JSUhI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 16:37:08 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so548852lag.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=dRkTgfplaB/WfTCwrkWlhTJW8r0hFV3/tKeXm7o5jOc=;
        b=KS/GGDBMABz0nXpsChHEkEE/001adpOLRk/VVfCuWI0Ww+e3WIA2py4DW1wrnbAYkB
         xuxDXJQeEyZuYIH0WS9X5RlzfabgQ+y4EVf8ojAgAa7IDjG3Niu2iEJqSkzlocTv+IDv
         vTcD/3KOo/fV0P/SnmxB0trRV06leLQXdxQsF2NL9ANsmNIf67Vxu7HBRMBztVVBA3Mi
         gEa72FUYUbp2rgcWsiDMDPWxgbMXnZ2O3FrUplwKLO05XuLhijsMS56HIYgwldJigfmR
         m1FbxQHpyESRWLE0nvkqOSnIBv/9uOuEo0n2ALDKijpo0pIV3ITa9/8Toyu/Am7T5Ozp
         Fa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=dRkTgfplaB/WfTCwrkWlhTJW8r0hFV3/tKeXm7o5jOc=;
        b=W+l5dFKQrONqDsV5RXCasOsxnl51KD1U1RdzNvk7PNW11qke10EZMAL+oPyBD3+sYw
         6a4gQhrTZXexm8fUOjT0pgvQ69pxJ7bqW5rMFykbSMNhk0NrvCqqlhK415SF+86QDWEN
         Foxcsoln3YL/OfbWKMek5u1c9f2R1PZYedCCBkSNiYHV7SxuKEIdP2AmV8iygzyiFkpe
         uTV/yN9ow4nMkMpcn5vF6AZCoMPEXnX15BOVomwUwZ2Jk0azeuS6kqIs6oVjA4UVyJW8
         GWDsJbxcnO1twWgPO5MFK7Ds9SuyF0ZTqA5GeZDOfjDK6Z7YlZIOyyYOsjIHQlRlQ3rz
         z6+Q==
Received: by 10.152.102.234 with SMTP id fr10mr2109515lab.28.1350679026892;
 Fri, 19 Oct 2012 13:37:06 -0700 (PDT)
Received: by 10.112.10.70 with HTTP; Fri, 19 Oct 2012 13:37:06 -0700 (PDT)
In-Reply-To: <20121019202723.GA24184@sigill.intra.peff.net>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQkTsODGJ8jPQLRJrtKo1v3MZbPx1cAUrvaMcFxbJaz1mQGg7lfWgsgOY0O495JUkQKihYTPfYvZlnOaW54KtfTyXsuby0C9WVnMqd0VaAaEtU/tnxLWhcOWV2RNt/gCt512mZfZT+ro71Edoq92PDUsTgBJCQpRXJUgwPJbKYVXX4aVPCBUiVJjhhDU5wqbNAk+UFaR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208060>

On Fri, Oct 19, 2012 at 1:27 PM, Jeff King <peff@peff.net> wrote:
>
> On Fri, Oct 19, 2012 at 07:10:46AM -0700, Shawn O. Pearce wrote:
>
> > > IOW, it seems like we are _already_ following the advice referenced in
> > > curl's manpage. Is there some case I am missing? Confused...
> >
> > The issue with the current code is sometimes when libcurl is opening a
> > CONNECT style connection through an HTTP proxy it returns a crazy high
> > timeout (>240 seconds) and no fds. In this case Git waits forever.
> > Stefan observed that using a timeout of 50 ms in this situation to
> > poll libcurl is better, as it figures out a lot more quickly that it
> > is connected to the proxy and can issue the request.
>
> Ah. That sounds like a bug in curl to me. But either way, if we want to
> work around it, wouldn't the right thing be to override curl's timeout
> in that instance? Like:
>
> diff --git a/http.c b/http.c
> index df9bb71..cd07cdf 100644
> --- a/http.c
> +++ b/http.c
> @@ -631,6 +631,19 @@ void run_active_slot(struct active_request_slot *slot)
>                         FD_ZERO(&excfds);
>                         curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
>
> +                       /*
> +                        * Sometimes curl will give a really long timeout for a
> +                        * CONNECT when there are no fds to read, but we can
> +                        * get better results by running curl_multi_perform
> +                        * more frequently.
> +                        */
> +                       if (maxfd < 0 &&
> +                           (select_timeout.tv_sec > 0 ||
> +                            select_timeout.tv_usec > 50000)) {
> +                               select_timeout.tv_sec = 0;
> +                               select_timeout.tv_usec = 50000;
> +                       }
> +
>                         select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>                 }
>         }
>
> -Peff

I have no objection to this; any one else?

Stefan
