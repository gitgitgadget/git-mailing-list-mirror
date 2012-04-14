From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] i18n: use test_i18ncmp in t2020 (checkout --detach)
Date: Fri, 13 Apr 2012 22:24:52 -0400
Message-ID: <20120414022452.GA17535@sigill.intra.peff.net>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413233010.GA16663@sigill.intra.peff.net>
 <20120413234607.GE13995@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 04:25:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIsg6-0006yx-CN
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 04:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab2DNCYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 22:24:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33660
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531Ab2DNCYy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 22:24:54 -0400
Received: (qmail 15987 invoked by uid 107); 14 Apr 2012 02:25:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 22:25:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 22:24:52 -0400
Content-Disposition: inline
In-Reply-To: <20120413234607.GE13995@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195463>

On Fri, Apr 13, 2012 at 06:46:07PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > I think it is not "forgot" but "predates" in this case. The commit
> > introducing the problem is 8a5b749 (i18n: format_tracking_info "Your
> > branch is behind" message, 2012-02-02). But obviously your fix is
> > correct either way.
> 
> Oh, that makes sense.  I wonder why we didn't notice this before.
> GETTEXT_POISON support hit "master" in 2011-05-23.

Yes, but this wasn't gettext-ed at all until 2012-02-02, and then it
didn't get merged into master until the week after. How often do you
run GETTEXT_POISON tests? I know I don't, and obviously Junio does not
include them as part of his process before pushing out master.

> Yeah, I should have paid attention to the date.  A better diagnosis
> would be
> 
> 	When v1.7.9.2~28^2 (2012-02-02) marked the "Your branch is behind
> 	message for translation, it forgot to adjust tests to stop checking
> 	for that message when tests are being run with git configured to write
> 	its output in another language.
> 
> 	With this patch applied, tests pass with GETTEXT_POISON=YesPlease
> 	again.
> 
> 	Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> 	Explained-by: Jeff King <peff@peff.net>

Yeah, that makes sense to me. It seems like t6040 is broken under
GETTEXT_POISON by that commit, too (and is still broken). Probably your
patch should deal with both breakages, as their root cause is the same.

-Peff
