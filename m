From: Jeff King <peff@peff.net>
Subject: Re: Re* [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 15:00:52 -0400
Message-ID: <20111020190052.GA25360@sigill.intra.peff.net>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
 <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
 <20111020043448.GA7628@sigill.intra.peff.net>
 <7vr5289mlu.fsf@alter.siamese.dyndns.org>
 <20111020071356.GA14945@sigill.intra.peff.net>
 <7vehy7a4sf.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 21:00:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGxrP-000860-4t
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 21:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab1JTTAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 15:00:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36281
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab1JTTAy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 15:00:54 -0400
Received: (qmail 12150 invoked by uid 107); 20 Oct 2011 19:01:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Oct 2011 15:01:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2011 15:00:52 -0400
Content-Disposition: inline
In-Reply-To: <7vehy7a4sf.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184036>

On Thu, Oct 20, 2011 at 11:36:48AM -0700, Junio C Hamano wrote:

> It probably is not worth it for most applications, but this fix-up to a
> fairly recent one is worth doing, I would suspect.
> 
> -- >8 --
> Subject: parse_signed_commit: really use the entire commit log message
>
> ... even beyond the first NUL in the buffer, when checking the commit
> against the detached signature in the header.

Yeah, that is worth fixing, I think. It's one thing to be a little lazy
in pretty-printing for "git log", but I think signature verification
should be more careful.

Patch itself looks sane to me. There's still some use of str-like
functions, but they would prevent us from even seeing the signature
headers in the first place, so anything with a NUL that high is just
broken and crappy.

I didn't check, but I wonder if fsck does/should check that there is a
proper end-of-header blank line before we hit any NUL.

-Peff
