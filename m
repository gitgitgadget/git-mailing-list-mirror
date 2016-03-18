From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] pretty-print: add --pretty=noexpand
Date: Fri, 18 Mar 2016 01:08:07 -0400
Message-ID: <20160318050807.GC22327@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
 <xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
 <CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
 <xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
 <xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
 <xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
 <xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com>
 <xmqqoaacy9tm.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:09:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agmem-00031q-67
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbcCRFIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 01:08:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:33874 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752293AbcCRFIK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:08:10 -0400
Received: (qmail 14364 invoked by uid 102); 18 Mar 2016 05:08:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 01:08:10 -0400
Received: (qmail 8526 invoked by uid 107); 18 Mar 2016 05:08:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 01:08:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2016 01:08:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoaacy9tm.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289188>

On Thu, Mar 17, 2016 at 04:16:21PM -0700, Junio C Hamano wrote:

> It is reasonable for tweak the default output mode for "git log" to
> untabify the commit log message, it sometimes may be necessary to
> see the output without tab expansion.
> 
> Invent a new --pretty option to do this.  Use this to unbreak the
> test breakages, where "git shortlog" and output are tested.

Hmm. Isn't "expand tabs" orthogonal to the rest of the pretty format?
That is, couldn't one want "--pretty=fuller, but with tabs expanded"?

I don't personally care much myself, and certainly we don't need to
support "--expand-tabs" for every format until somebody actually wants
them enough to implement it. I just don't want to see us painted into a
corner where we have to support an awkward interface forever (e.g., the
way we had to retrofit the orthogonal "local" concept onto the --date
code).

E.g., start with:

  - only CMIT_FMT_MEDIUM expands tabs (and does so by default)

  - passing --no-expand-tabs suppresses this behavior

  - passing --expand-tabs is an error for now; if people care later,
    they can add support for other formats (naively this is trivial, but
    I suspect there are some corner cases around things like
    --pretty=raw, so unless somebody wants to work on it now, I don't
    think we need to).

-Peff
