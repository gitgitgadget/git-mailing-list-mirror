From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature
 verification
Date: Mon, 16 Jun 2014 15:54:29 -0400
Message-ID: <20140616195428.GB24376@sigill.intra.peff.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
 <cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>
 <20140613080229.GJ7908@sigill.intra.peff.net>
 <539ACA8A.90108@drmicha.warpmail.net>
 <20140613110901.GB14066@sigill.intra.peff.net>
 <xmqqbntw4u4d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 21:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwczC-0005cX-5q
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 21:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857AbaFPTya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 15:54:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:45457 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755540AbaFPTy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 15:54:29 -0400
Received: (qmail 12918 invoked by uid 102); 16 Jun 2014 19:54:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 14:54:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 15:54:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbntw4u4d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251810>

On Fri, Jun 13, 2014 at 10:06:10AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I realize this isn't really your itch to scratch. It's just that when I
> > see a description like "verify a commit", I wonder what exactly "verify"
> > means.
> 
> I think that is an important point.  If a tool only verifies the
> signature of the commit when conceivably other aspect of it could
> also be verified but we cannot decide how or we decide we should not
> dictate one-way-fits-all, using a generic name "verify-commit" or
> "verify" without marking that it is currently only on the signature
> clearly somewhere might close the door to the future.
> 
>     git verify <object>::
>         Verify whatever we currently deem is appropriate for the
>         given type of object.
> 
>     git verify --gpg-signature::
> 	Verify the GPG signature for a signed tag, a signed commit,
>         or a merge with signed tags.
> 
>     git verify --commit-author <committish>::
> 	Verify the GPG signer matches the "author " header of the
> 	commit.
> 
> and more, perhaps?

That is certainly the direction I was thinking of when I suggested "git
verify".

However, I do not think it is too bad a thing to add a verify-commit
that matches verify-tag, as long as they do the exact same thing
(namely, check the gpg signature). We may find it is later obsoleted by
"git verify --gpg-signature", but given that verify-tag is already there
and will remain for compatibility, I don't think we are increasing the
cognitive load too much.

Your middle example above did make me think of one other thing, though.
As you noted, we actually have _three_ signature types:

  1. signed tags

  2. signed commits

  3. merges with embedded mergetag headers

We already have a tool for (1). Michael is adding a tool for (2). How
would one check (3) in a similar way?

-Peff
