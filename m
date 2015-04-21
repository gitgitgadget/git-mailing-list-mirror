From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Tue, 21 Apr 2015 10:24:56 -0400
Message-ID: <20150421142455.GA14521@peff.net>
References: <1429117143-4882-1-git-send-email-karthik.188@gmail.com>
 <xmqqmw29jg78.fsf@gitster.dls.corp.google.com>
 <20150415221824.GB27566@peff.net>
 <20150417142310.GA12479@peff.net>
 <xmqqd232hgj8.fsf@gitster.dls.corp.google.com>
 <20150417205125.GA7067@peff.net>
 <xmqq4moepijp.fsf@gitster.dls.corp.google.com>
 <553548D2.7010904@gmail.com>
 <20150420185122.GA13718@peff.net>
 <553633D0.9020804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 16:25:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkZ6n-0005U1-2y
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 16:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbbDUOY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 10:24:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:48077 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755054AbbDUOY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 10:24:58 -0400
Received: (qmail 12358 invoked by uid 102); 21 Apr 2015 14:24:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 09:24:58 -0500
Received: (qmail 1482 invoked by uid 107); 21 Apr 2015 14:25:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 10:25:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2015 10:24:56 -0400
Content-Disposition: inline
In-Reply-To: <553633D0.9020804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267530>

On Tue, Apr 21, 2015 at 04:56:08PM +0530, karthik nayak wrote:

> >>+       status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
> >
> >I wonder if we would feel comfortable just running this NUL-check as
> >part of unpack_sha1_header (i.e., in all code paths). It _shouldn't_
> >trigger in normal use, but I wonder if there would be any downsides
> >(e.g., maliciously crafted objects getting us to allocate memory or
> >something; I think it is fairly easy to convince git to allocate memory,
> >though).
> >
> But why would we want it to be a part of unpack_sha1_header?

Just to reduce the number of functions and the complexity of the caller.
But I guess it doesn't help that much if the caller would then need to
speculatively pass in a strbuf. So it's probably not a good idea.

-Peff
