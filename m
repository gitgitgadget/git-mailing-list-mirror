From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 06/11] remote.h: add get_remote_capabilities,
 request_capabilities
Date: Wed, 27 May 2015 02:50:31 -0400
Message-ID: <20150527065030.GE885@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-7-git-send-email-sbeller@google.com>
 <CAPig+cRfJKAQ8Q5PF1VfTAGA1njXAshC0RbnMv9cEp4bH_MN7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 27 08:50:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxVAn-0002a4-9i
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbbE0Gue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 02:50:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:36486 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750812AbbE0Gud (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:50:33 -0400
Received: (qmail 32196 invoked by uid 102); 27 May 2015 06:50:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 01:50:33 -0500
Received: (qmail 4965 invoked by uid 107); 27 May 2015 06:50:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:50:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 02:50:31 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cRfJKAQ8Q5PF1VfTAGA1njXAshC0RbnMv9cEp4bH_MN7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270026>

On Tue, May 26, 2015 at 11:25:05PM -0400, Eric Sunshine wrote:

> > +               len = packet_read(in, &src_buf, &src_len,
> > +                                 packet_buffer, sizeof(packet_buffer),
> > +                                 PACKET_READ_GENTLE_ON_EOF |
> > +                                 PACKET_READ_CHOMP_NEWLINE);
> > +               if (len < 0)
> > +                       die_initial_contact(0);
> > +
> > +               if (!len)
> > +                       break;
> > +
> > +               if (len > 4 && skip_prefix(line, "ERR ", &arg))
> 
> The 'len > 4' check is needed because there's no guarantee that 'line'
> is NUL-terminated. Correct?

I think this was just blindly copied from get_remote_heads(). And I
think that code was being overly paranoid. Ever since f3a3214 (Make
send/receive-pack be closer to doing something interesting, 2005-06-29),
the pkt-line reader will add an extra NUL to the buffer to ease cases
like this.

-Peff
