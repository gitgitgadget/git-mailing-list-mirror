From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Wed, 21 May 2014 12:42:55 -0400
Message-ID: <20140521164255.GA2040@sigill.intra.peff.net>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
 <1400572806-21092-2-git-send-email-jmmahler@gmail.com>
 <20140520082740.GB27590@sigill.intra.peff.net>
 <xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
 <20140520182443.GA30533@sigill.intra.peff.net>
 <xmqq7g5gz3s4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 18:43:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn9bZ-0001Uo-GQ
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 18:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbaEUQm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 12:42:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:56600 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751018AbaEUQm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 12:42:56 -0400
Received: (qmail 20076 invoked by uid 102); 21 May 2014 16:42:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 11:42:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 12:42:55 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g5gz3s4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249804>

On Tue, May 20, 2014 at 11:46:51AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If it were just "--signature", I'd agree. After all, nobody is even
> > complaining. But this is also in preparation for --signature-file.
> > Should the user create a file without a trailing newline?
> 
> Ahh, I missed that part.
> 
> I am fine with processing it with stripspace().

I wasn't planning on anything as drastic as stripspace. I really just
wanted to suppress the one newline, which is almost certainly the right
thing to include for "--signature", but the wrong thing for
"--signature-file" (i.e., the patch I posted earlier).

Stripspace() would drop all extra whitespace, and I wondered if people
would _want_ it in their sigs (e.g., a blank line after the "-- " but
before their .sig content).

I dunno. Maybe it is not worth caring too much about. I don't want to
hold up Jeremiah's patch for something that I suspect neither of us
cares _that_ much about (I know I am not planning on using
--signature-file myself). I just don't want to deal with a patch later
that says "oh, this spacing is wrong" and have to respond "yes, but we
have to retain it so as not to break existing users".

> By the way, at some point we may want to move that helper function
> to strbuf.c, but that is a separate issue.

Agreed. I was touching some string functions earlier today and noticed
that strbuf.c actually contains a lot of non-strbuf functions for
dealing with C strings. That's fine, I guess, but I also wondered if we
should have a separate file for C-string functions. I suppose it doesn't
matter that much either way, as long as it's in a libgit.a file (and
stripspace currently is _not_, which I assume is what you were
indicating above).

-Peff
