From: Jeff King <peff@peff.net>
Subject: Re: [BUG] redundant error message
Date: Thu, 5 Dec 2013 15:03:06 -0500
Message-ID: <20131205200306.GA13443@sigill.intra.peff.net>
References: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
 <20131205191518.GB19039@sigill.intra.peff.net>
 <xmqqsiu73w6n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 21:03:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vof8k-00053z-QD
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 21:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab3LEUDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 15:03:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:51162 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751725Ab3LEUDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 15:03:08 -0500
Received: (qmail 30467 invoked by uid 102); 5 Dec 2013 20:03:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Dec 2013 14:03:08 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Dec 2013 15:03:06 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsiu73w6n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238906>

On Thu, Dec 05, 2013 at 12:00:16PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   $ >foobar
> >   $ git rev-parse foobar --
> >   foobar
> >   --
> >   fatal: bad flag '--' used after filename
> >
> > That's not right.
> 
> Hmph, it looks like it is following the usual "zero-or-more dashed
> options, zero-or-more revs and then zero-or-one double-dash and then
> zero-or-more paths" rule to parse the thing.  "foobar" is a file and
> not a rev, so "--" should not be there, no?
> 
> Confused why you think it is not right...

Because once you say "--", then all ambiguity goes away, no? Everything
to the left is a rev, not a filename, and everything to the right is a
filename. E.g.:

  $ git log foobar --
  fatal: bad revision 'foobar'

I think rev-parse is not following the same rules that the rest of the
revision-parsing programs do.

-Peff
