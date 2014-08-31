From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] teach fast-export an --anonymize option
Date: Sun, 31 Aug 2014 11:53:51 -0400
Message-ID: <20140831155350.GE17449@peff.net>
References: <20140827165854.GC1432@peff.net>
 <20140827170127.GA6138@peff.net>
 <CACsJy8B3gFC7kLf-cLhAk3BgQ+v427rMXWHTqjU4LYP3NQte7Q@mail.gmail.com>
 <20140828123257.GA18642@peff.net>
 <CAPig+cSKfxAsr+RQp8N8GAOe9fa_6kGPi_-X99Vs-2bYbBoC8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 17:54:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XO7S5-00029d-Ap
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 17:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbaHaPxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 11:53:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:41923 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751244AbaHaPxx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 11:53:53 -0400
Received: (qmail 19501 invoked by uid 102); 31 Aug 2014 15:53:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 31 Aug 2014 10:53:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Aug 2014 11:53:51 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSKfxAsr+RQp8N8GAOe9fa_6kGPi_-X99Vs-2bYbBoC8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256292>

On Sun, Aug 31, 2014 at 06:34:08AM -0400, Eric Sunshine wrote:

> >> I feel like this should be part of git-fast-export.txt, just to
> >> increase the user's confidence in the tool (and I don't expect most
> >> users to read this commit message).
> >
> > Hmph. Whenever I say "I think this patch is done", suddenly the comments
> > start pouring in. :)
> 
> Considering that the value of --anonymize is not yet known, is such an
> invasive change to fast-export.c warranted? Would it make sense
> instead to provide "anonymize" functionality as a contrib/ script or a
> distinct git-anonymize-foo command which accepts a fast-import stream
> as input and anonymizes it as output?

I considered that, but there's a non-trivial amount of work in the
parsing of the stream (I had originally thought to just ship a perl
script to operate on the stream). And while there's a fair bit of code
added to fast-export.c, none of it is ever called unless --anonymize is
set.

So while I am not 100% sure that the idea is a good one, I do not think
it is hurting the current fast-export in any meaningful way. Two things
we could do to minimize that are:

  1. Move the anonymization code into a separate C file to keep the
     fast-export source a little more pristine. I avoided doing this
     just because the interfaces to the functions are fairly tailored to
     what fast-export wants.

  2. Have a separate git-anonymize command which is basically running
     "git fast-export --anonymize" under the hood. This avoids polluting
     fast-export from the user's perspective (they do not need to care
     that it is running fast-export under the hood).

-Peff
