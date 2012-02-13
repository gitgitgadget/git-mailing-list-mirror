From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-highlight: Work for multiline changes too
Date: Mon, 13 Feb 2012 17:27:02 -0500
Message-ID: <20120213222702.GA19393@sigill.intra.peff.net>
References: <20120210213209.GA7582@sigill.intra.peff.net>
 <1328910433-2539-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 23:27:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx4Mo-0005Xp-RE
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 23:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab2BMW1X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 17:27:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34489
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757685Ab2BMW1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 17:27:05 -0500
Received: (qmail 1784 invoked by uid 107); 13 Feb 2012 22:34:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Feb 2012 17:34:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2012 17:27:02 -0500
Content-Disposition: inline
In-Reply-To: <1328910433-2539-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190681>

On Fri, Feb 10, 2012 at 10:47:13PM +0100, Micha=C5=82 Kiedrowicz wrote:

>  contrib/diff-highlight/diff-highlight |   96 ++++++++++++++++++++++-=
----------
>  1 files changed, 65 insertions(+), 31 deletions(-)

Thanks for sending. I looked at a whole bunch of patches, and I was
pleasantly surprised to find how infrequently we hit false positives in
practice. In fact, the only things that looked worse with your patch
were places where your patch happened to turn on highlighting for lines
where the existing heuristics already were a little ugly (i.e., the
problem was not your patch, but that the existing heuristic is sometime=
s
non-optimal).

I ended up pulling your changes out into a few distinct commits. That
made it easier for me to review and understand what was going on (and
hopefully ditto for other reviewers, or people who end up bisecting or
reading the log later). I'll post that series in a moment.

> After looking at outputs I noticed that it can also ignore lines with
> prefixes/suffixes that consist only of punctuation (asterisk, semicol=
on, dot,
> etc), because otherwise whole line is highlighted except for terminat=
ing
> punctuation.

I missed this note when I applied the patch and started looking at the
outputs, and ended up having a similar thought. However, I don't know
that it buys much in practice, and it's nice to be fairly agnostic abou=
t
content. I did leave that open to easy tweaking in my series, though.

  [1/5]: diff-highlight: make perl strict and warnings fatal
  [2/5]: diff-highlight: don't highlight whole lines
  [3/5]: diff-highlight: refactor to prepare for multi-line hunks
  [4/5]: diff-highlight: match multi-line hunks
  [5/5]: diff-highlight: document some non-optimal cases

-Peff
