From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] tests: eliminate unnecessary setup test assertions
Date: Fri, 6 May 2011 18:13:00 -0400
Message-ID: <20110506221300.GB17848@sigill.intra.peff.net>
References: <20110503090351.GA27862@elie>
 <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
 <20110506205441.GA20182@elie>
 <20110506205851.GB20182@elie>
 <20110506214801.GA17848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 07 00:13:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QITGn-0001qV-QS
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 00:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab1EFWNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 18:13:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43224
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab1EFWND (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 18:13:03 -0400
Received: (qmail 14008 invoked by uid 107); 6 May 2011 22:14:58 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 May 2011 18:14:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 May 2011 18:13:00 -0400
Content-Disposition: inline
In-Reply-To: <20110506214801.GA17848@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173020>

On Fri, May 06, 2011 at 05:48:01PM -0400, Jeff King wrote:

>   pattern_authors() {
>     git grep -n "$@" |
>     while IFS=: read file line match; do
>       git blame -L "$line,$line" "$file"
>     done |
>     perl -lpe '/\((.*?) \d+-\d+-\d+/; $_=$1'
>   }

Two minor complaints on git-blame; maybe somebody can point out
something clever I've missed.

  1. blame's "-L" understands patterns already. So in theory I could
     tell it "blame all lines that match pattern X". But I don't think
     there is a way to do that (it tries looking to for _one_ range to
     blame for each -L, not a set of ranges).

  2. Parsing the human-readable output blame output sucks. But parsing
     --porcelain is annoyingly complex for quick-and-dirty things like
     this. It doesn't repeat the commit information per-line.

     I guess we could have an inefficient --line-porcelain format that
     breaks down ranges into single lines and repeats the commit info
     for each one.

     The clever among you may notice that in this particular case,
     though, I could have gotten away with regular --porcelain as I
     blame a single line at a time.

-Peff
