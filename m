From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFD 0/2] revision.c: --merges, --no-merges and
 --merges-only
Date: Fri, 18 Mar 2011 05:07:24 -0400
Message-ID: <20110318090724.GB16703@sigill.intra.peff.net>
References: <cover.1300359256.git.git@drmicha.warpmail.net>
 <20110317195905.GG20508@sigill.intra.peff.net>
 <4D831043.1060709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 10:07:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Vem-0005qY-6n
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 10:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab1CRJHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 05:07:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56128
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756384Ab1CRJH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 05:07:28 -0400
Received: (qmail 575 invoked by uid 107); 18 Mar 2011 09:08:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Mar 2011 05:08:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2011 05:07:24 -0400
Content-Disposition: inline
In-Reply-To: <4D831043.1060709@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169304>

On Fri, Mar 18, 2011 at 08:56:51AM +0100, Michael J Gruber wrote:

> > However, this is totally changing the meaning of an option to plumbing
> > like rev-list (among others). Is it worth the breakage? If so, what's
> > the migration plan? Did I miss a discussion somewhere?
> 
> You missed only the "D" in RFD :)

I saw it, I was just expecting you to start the "D" with some text. :)

> The meaning of a plumbing option can't be changed light-heartedly, of
> course. OTOH, the current design is *really bad* from the ui point of
> view. The expectation that
> 
> "cmd --no-foo --foo" is eq. to "cmd --foo"
> 
> and
> 
> "cmd --foo --no-foo" is eq. to "cmd --no-foo"

I absolutely agree it's bad.

> should be valid universally. In the long run, we might even try and
> convert revision.c to parse_options, thereby gaining --no-foo for every
> --foo.

Another nice side effect would be short-option bundling. Every once in a
while I try something like "git log -pb" and it fails (though it is very
rare to come across these days, since everything _except_ revision and
diff options uses parse_options, and those two have very few short
options).

> So, my RFD really consists of two things:
> 
> - provide a way to override --no-merges/no_merges

Having read Junio's much longer and more intelligent response (compared
to mine) to your initial mail, I think the multi-state selector is the
right way to do this. And it has makes the transition easy, since the
new option appears, then eventually the old options can go away or be
renamed.

> In 2.0 or so, we could change "--merges" to be an alias for
> "--merges-also" rather than "--merges-only" (but don't have to).

Right. My big question reading your patches was when this switch was
supposed to happen (in your series, --merges goes away in the first
patch :) ).

-Peff
