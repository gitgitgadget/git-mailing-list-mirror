From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Disable dumb HTTP fallback with GIT_CURL_FALLBACK=0
Date: Wed, 19 Sep 2012 23:52:31 -0400
Message-ID: <20120920035231.GB32313@sigill.intra.peff.net>
References: <1348109753-32388-1-git-send-email-spearce@spearce.org>
 <CAJo=hJtx25=5Lb3sgu_o42=VrcXkRE1DF_noPpjqyjE1zuzKJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 05:52:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEXog-0004U0-B4
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 05:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab2ITDwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 23:52:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50445 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482Ab2ITDwd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 23:52:33 -0400
Received: (qmail 11370 invoked by uid 107); 20 Sep 2012 03:52:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 23:52:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 23:52:31 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJtx25=5Lb3sgu_o42=VrcXkRE1DF_noPpjqyjE1zuzKJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206030>

On Wed, Sep 19, 2012 at 08:22:58PM -0700, Shawn O. Pearce wrote:

> On Wed, Sep 19, 2012 at 7:55 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > From: "Shawn O. Pearce" <spearce@spearce.org>
> 
> I can't explain why git send-email did this. I obviously didn't need
> the extra From header here. format-patch didn't write it to the patch
> file, it was injected by send-email. My .git/config is pretty simple,
> the name/email are derived from there:
> 
>   [user]
> 	name = Shawn O. Pearce
> 	email = spearce@spearce.org
> 
> Ick. I really don't want to debug this right now so I'm just going to
> pretend it wasn't written.

I was looking at the send-email author comparison code a month or three
ago, and I remember noticing that it totally fails to canonicalize
before comparing.  Without even looking at it again, I'm fairly sure
that it thinks '"Shawn O. Pearce"' and 'Shawn O. Pearce' (i.e., with and
without the quotes) are different, and therefore author != committer.

In your case it is particularly egregious because the quotes are
introduced (correctly) by format-patch, so it is not even like you have
configured two different versions of your name. 

I think the same bug exists for different rfc2047 encodings of a name
with non-ascii characters. Fixing both would involve canonicalizing the
names before comparing. I wonder if it would be simpler to just compare
the email addresses and ignore the names entirely.

-Peff
