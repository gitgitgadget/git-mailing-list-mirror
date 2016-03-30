From: Jeff King <peff@peff.net>
Subject: [BUG?] retrying with "am -3" doesn't work anymore
Date: Tue, 29 Mar 2016 22:15:02 -0400
Message-ID: <20160330021502.GA16077@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 04:15:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al5fB-00037U-5y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 04:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbcC3CPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 22:15:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:40547 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751128AbcC3CPG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 22:15:06 -0400
Received: (qmail 25554 invoked by uid 102); 30 Mar 2016 02:15:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 22:15:05 -0400
Received: (qmail 30873 invoked by uid 107); 30 Mar 2016 02:15:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 22:15:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 22:15:02 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290262>

I noticed that I could not get a patch from Junio to apply earlier
today, and I think it is a regression in the builtin git-am
implementation.  I had trouble reproducing with a basic test case,
though.

Basically, I picked up the three patches from this sub-thread:

  http://thread.gmane.org/gmane.comp.version-control.git/288987/focus=290222

and tried to apply them on top of v2.8.0.

Doing it with "git am -3 patches" works. But doing it with:

  git am patches
  git am -3

doesn't. Bisecting shows that it did work before 783d7e8 (builtin-am:
remove redirection to git-am.sh, 2015-08-04).

I tried to tweak t4150 to show this by replacing a "git am -3 foo" with
"test_must_fail git am foo && git am -3", but it failed even on older
git, which made me think I fumbled the test somehow.

-Peff
