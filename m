From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: support --sort=version
Date: Thu, 20 Feb 2014 15:43:45 -0500
Message-ID: <20140220204345.GA3374@sigill.intra.peff.net>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
 <20140219140909.GA20128@sigill.intra.peff.net>
 <CACsJy8CL3rQx=QHf_eABCUqS+9kZXEmopUuCMiNCL+UPyvtbyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 21:43:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGaTI-0007rq-8I
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 21:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbaBTUns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 15:43:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:54007 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752540AbaBTUnr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 15:43:47 -0500
Received: (qmail 7023 invoked by uid 102); 20 Feb 2014 20:43:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Feb 2014 14:43:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Feb 2014 15:43:45 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CL3rQx=QHf_eABCUqS+9kZXEmopUuCMiNCL+UPyvtbyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242446>

On Wed, Feb 19, 2014 at 09:19:24PM +0700, Duy Nguyen wrote:

> > We don't need to do any of that immediately.  This is mostly just me
> > thinking aloud, to make sure we do not paint ourselves into a corner
> > compatibility-wise.
> 
> Good thinking. If you plan to use the exact same sort syntax f-e-r
> uses now, pick a letter (the dot I used above is probably not the
> best), I'll rewrite this patch to use the same syntax.

I think I actually prefer the full word "version", as you have already.
It's clear what it means, and we can extend the syntax generally to:

  --sort=[-][comparison:]field

like:

  --sort=-version:subject

for descending version-sort by subject.  And then as a special-case
convenience, make "version" without a field default to
"version:refname". There's no ambiguity because the set of comparison
names and field-names is fixed, and we know there is no overlap.

If want to, we can _also_ give a one-letter abbreviation to the
comparison field, like:

  --sort=v:subject

but that is not necessary.

So I think your patch is fine as-is. It is perhaps a little funny to
start with the special case and only implement the general case later,
but:

  1. We would want the special case eventually, because it is the most
     natural thing to type, and pretty clearly the most common use-case.

  2. We may not ever even end up with the general case. This is just
     about making sure that if we _do_ add it, that it fits
     syntactically with "--sort=version".

-Peff
