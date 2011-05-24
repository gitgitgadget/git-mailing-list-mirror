From: Jeff King <peff@peff.net>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Tue, 24 May 2011 15:13:37 -0400
Message-ID: <20110524191337.GB584@sigill.intra.peff.net>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
 <4DDA618E.4030604@drmicha.warpmail.net>
 <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
 <20110523181147.GA26035@sigill.intra.peff.net>
 <20110523201529.GA6281@sigill.intra.peff.net>
 <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
 <20110523234131.GB10488@sigill.intra.peff.net>
 <7v39k4aeos.fsf@alter.siamese.dyndns.org>
 <4DDB5C0F.1080102@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 24 21:13:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOx33-0004Iu-F1
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 21:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719Ab1EXTNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 15:13:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50012
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563Ab1EXTNj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 15:13:39 -0400
Received: (qmail 20984 invoked by uid 107); 24 May 2011 19:13:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 15:13:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 15:13:37 -0400
Content-Disposition: inline
In-Reply-To: <4DDB5C0F.1080102@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174335>

On Tue, May 24, 2011 at 09:19:43AM +0200, Michael J Gruber wrote:

> > It is conceivable that we _could_ newly define a "combined external diff
> > driver" that would take 3 or more files, and compute and show the combined
> > result by itself, but that will certainly not go through the codepath you
> > touched with the textconv patch. Calling out to such a new type of
> > external diff driver would have to happen at the level where we have 1+N
> > blob object names for a N-parent commit, namely, at the beginning of
> > show_patch_diff(), bypassing the entire contents of that function and
> > instead letting the new n-way external diff driver do everything.
> > 
> > I however highly doubt that such an interface would make sense. For
> > example, what would be the desirable format to compare three versions of
> > "What's cooking" postings, and how would the updated compare-cooking.perl
> > script would look like?
> 
> Yeah, currently --cc with external makes no sense, but there are several
> external tools which could present a 3-way diff in a useful way (or even
> n-way with n>3), e.g. vimdiff, kdiff3, meld.

I agree with Junio that we would need a new config option and external
interface for "n-way combined diff". However, isn't what things like
vimdiff and meld do the reverse of our combined diff? That is, don't
they assume the 3 trees are: ours, theirs, and ancestor (i.e., merge
base)? Whereas in a combined diff, it is actually: merge parent 1
(ours), merge parent 2 (theirs), and merge _result_.

Also, do those tools generally handle n-way comparisons as opposed to
3-way?

-Peff
