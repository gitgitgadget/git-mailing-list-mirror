From: Jeff King <peff@peff.net>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Tue, 26 Jul 2011 00:09:04 -0600
Message-ID: <20110726060903.GA29486@sigill.intra.peff.net>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net>
 <CACsJy8Db_sYFsQ2GcbcumJJYrXZDkKmuuULSM0_Z=HWvbYh8Bg@mail.gmail.com>
 <20110726051411.GB25046@sigill.intra.peff.net>
 <CACsJy8Ay1wPXAx61_rGymHDJ=YGywAy=9epiXRfJ9e68np8x6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 08:09:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlapm-0005RZ-Bn
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 08:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab1GZGJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 02:09:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56552
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079Ab1GZGJI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 02:09:08 -0400
Received: (qmail 17357 invoked by uid 107); 26 Jul 2011 06:09:37 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Jul 2011 02:09:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jul 2011 00:09:04 -0600
Content-Disposition: inline
In-Reply-To: <CACsJy8Ay1wPXAx61_rGymHDJ=YGywAy=9epiXRfJ9e68np8x6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177844>

On Tue, Jul 26, 2011 at 12:57:46PM +0700, Nguyen Thai Ngoc Duy wrote:

> It's my itch. I'm more than happy if you take care of the Perl part,
> I'll do the rest. While you're doing the Perl part, should we have
> both --match and --no-match? One filters in. The other filters out. I
> guess people may find filter-in case more helpful than the other.

Yeah. Also, what about grep options like case-insensitivity? I don't
want to go too overboard with adding options that are unlikely to be
used. It is perl, so technically you can do "(?i:foo)" to match "foo"
case-insensitively. I don't think there's a way to do --no-match style
negation in the regex itself, though.

Speaking of which: the name "--match" is way too generic for "git add".
Something like "--hunk-match" would be better. It also is obviously only
useful with "--patch". Should it imply "--patch"? Should it actually be
"--patch=..."?

> I thought of this way initially, but I needed to split hunks in
> parse_diff and was stuck because I was not familiar with data
> structure used in git-add--interactive.

Oh yeah, you mentioned splitting before. I'm not sure how that would
interact with this feature. In some cases, you'd want to split as much
as possible, and in other cases, you'd want a bigger hunk. So I actually
think it is an orthogonal feature to "autosplit" hunks before we show
them to the user. I.e., something like:

  git add -p --autosplit-hunks --hunk-match=...

(where maybe the names could be better, but hopefully you get the
point).

-Peff
