From: Jeff King <peff@peff.net>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Mon, 2 Jun 2014 23:46:19 -0400
Message-ID: <20140603034619.GA18176@sigill.intra.peff.net>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
 <CACsJy8BREpVFKq3mW=Lwn+uNm1r40Xe8f4EyXLFN2yybZRT0oA@mail.gmail.com>
 <20140529161628.GB3763@sigill.intra.peff.net>
 <xmqq7g54begk.fsf@gitster.dls.corp.google.com>
 <20140529194932.GA16665@sigill.intra.peff.net>
 <CACJZPBs2_htD=zS1K3fOW+DZ323+2+iwupWuyNDArg2XF6Qx5g@mail.gmail.com>
 <CACJZPBtJZ+gDvtHnRwi8JOO7rFAg=pPBvEQ=-FwKnp9Gr+FStw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Rodrigo Fernandes <rtfrodrigo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 05:46:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrfgA-00014Y-PT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 05:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbaFCDqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 23:46:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:36335 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751833AbaFCDqV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 23:46:21 -0400
Received: (qmail 30113 invoked by uid 102); 3 Jun 2014 03:46:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jun 2014 22:46:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jun 2014 23:46:19 -0400
Content-Disposition: inline
In-Reply-To: <CACJZPBtJZ+gDvtHnRwi8JOO7rFAg=pPBvEQ=-FwKnp9Gr+FStw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250611>

On Fri, May 30, 2014 at 09:08:57AM +0100, Rodrigo Fernandes wrote:

> Do you have any idea how does github understand that is a bug and
> fixes it automatically?
> (I'm saying this because on Github the date is correct).

I looked into this. The dates you see on GitHub's web UI are actually
parsed by Rugged/libgit2. The libgit2 parser is slightly more forgiving
in this instance; if it sees a broken timezone, it will leave the
timestamp intact, and only omit the timezone. Whereas git says "no, it's
broken, and the timestamp cannot be trusted".

I think both are equally valid strategies, and I do not even think it is
a problem that they diverge between the two implementations. I'd be OK
with a patch to make git handle errors in each independently, assuming
it is not too invasive.

-Peff
