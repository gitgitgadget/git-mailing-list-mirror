From: Jeff King <peff@peff.net>
Subject: [PATCH 0/10] color and pager improvements
Date: Wed, 17 Aug 2011 21:58:24 -0700
Message-ID: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 06:58:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtugf-0005gk-84
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 06:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab1HRE6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 00:58:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35416
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab1HRE6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 00:58:30 -0400
Received: (qmail 18118 invoked by uid 107); 18 Aug 2011 04:59:09 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 00:59:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 21:58:24 -0700
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179557>

While looking at the pager and color code today, I decided to tackle two
long-standing bugs, which entailed a lot of refactoring of the color
code. The result fixes some minor bugs, and is a little nicer for
calling code to use.

  [01/10]: t7006: modernize calls to unset
  [02/10]: test-lib: add helper functions for config
  [03/10]: t7006: use test_config helpers

These three are just cleanup I noticed before adding new tests to t7006;
I hope that the helpers in 02/10 will be useful in a lot of other
places, though.

  [04/10]: setup_pager: set GIT_PAGER_IN_USE

This fixes Ingo's problem from:

  http://article.gmane.org/gmane.comp.version-control.git/179430

Namely that:

  git -p stash show

fails to use colors properly.

  [05/10]: diff: refactor COLOR_DIFF from a flag into an int
  [06/10]: git_config_colorbool: refactor stdout_is_tty handling
  [07/10]: color: delay auto-color decision until point of use

These three fix the problem Steffen mentioned here:

  http://article.gmane.org/gmane.comp.version-control.git/177792

Namely that pager.color doesn't work in many cases. This has been a
problem for years, but spread due to some pager-ordering changes late
last year (see the comments in 07/10). I actually wonder if anyone is
really using pager.color, as we haven't seen many complaints about it.

  [08/10]: config: refactor get_colorbool function
  [09/10]: diff: don't load color config in plumbing
  [10/10]: want_color: automatically fallback to color.ui

These three are refactoring that is made possible by 07/10. I think they
make the code cleaner, and hopefully the diffstat of 10/10 speaks for
itself.

-Peff
