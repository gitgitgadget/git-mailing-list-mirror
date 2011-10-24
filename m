From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Mon, 24 Oct 2011 15:45:58 -0700
Message-ID: <20111024224558.GB10481@sigill.intra.peff.net>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 <7vobx863v3.fsf@alter.siamese.dyndns.org>
 <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
 <7vipng5k80.fsf@alter.siamese.dyndns.org>
 <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
 <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
 <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 00:46:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RITHZ-0008Fx-2z
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 00:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab1JXWqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 18:46:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55690
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484Ab1JXWqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 18:46:06 -0400
Received: (qmail 10050 invoked by uid 107); 24 Oct 2011 22:51:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.21)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Oct 2011 18:51:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Oct 2011 15:45:58 -0700
Content-Disposition: inline
In-Reply-To: <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184189>

On Sun, Oct 23, 2011 at 09:40:51PM -0700, Junio C Hamano wrote:

> >> But as Duy mentions, we have an encoding header. Shouldn't we treat it
> >> like binary goo until we do reencode_log_message, and _then_ we can
> >> break it into lines?
> >
> > That's sensible. If we go that route, I think the "one allocation of
> > separate struct commit_buffer pointed from a pointer field in struct
> > commit to replace the current member 'buffer'" is a reasonable thing
> > to do.
> 
> Having given that "sensible" comment, I am not convinced if this is worth
> it. We are talking about what is left in the ephemeral COMMIT_EDITMSG by
> the chosen editor, but are there really editors that can _only_ write in
> UTF-16 and not in UTF-8, and is it worth bending backwards to add support
> such an editor?

Couldn't you make the same argument about iso8859-1, or any other
encoding? The user has some encoding that they want to use, for whatever
reason[1]. We have a slot for an encoding header; is there a reason that
git would allow some encodings and not others?

I mean, besides the obvious that UTF-16 is annoying and contains
embedded NULs and newlines.

-Peff

[1] English is my first language, so it's rare for me to even step
outside of ASCII, let alone latin1. But aren't there some languages in
which utf-16 is more efficient than utf-8?
