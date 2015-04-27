From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-p4: prevent --chain-lint failure
Date: Mon, 27 Apr 2015 19:02:23 -0400
Message-ID: <20150427230223.GA22403@peff.net>
References: <1430173228-22004-1-git-send-email-luke@diamand.org>
 <1430173228-22004-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:02:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yms2p-0000eP-A9
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 01:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbbD0XC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 19:02:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:50849 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964884AbbD0XC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 19:02:26 -0400
Received: (qmail 1906 invoked by uid 102); 27 Apr 2015 23:02:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Apr 2015 18:02:26 -0500
Received: (qmail 9726 invoked by uid 107); 27 Apr 2015 23:02:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Apr 2015 19:02:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Apr 2015 19:02:23 -0400
Content-Disposition: inline
In-Reply-To: <1430173228-22004-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267886>

On Mon, Apr 27, 2015 at 11:20:28PM +0100, Luke Diamand wrote:

> t9814 has a test that simply sets up a pre-requisite for
> another test, and as such, always succeeds. The way it was
> written doesn't quite work with the test lint checks introduced
> with the --chain-lint option.
> 
> Add an additional layer of {} to prevent the --chain-lint
> code getting confused.

Thanks for looking into this. I tried to fix any existing tests I could,
but I missed ones whose prerequisites aren't met on my system.

Using {} is reasonable in general; that's how the fixes in 9ddc5ac (t:
wrap complicated expect_code users in a block, 2015-03-20) worked.
However, I think your case is somewhat simpler, in that you really just
want a big conditional to set a prereq based on whether or not a command
succeeds.

Would it make sense to convert this whole thing to just:

  test_lazy_prereq P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW '
	p4 configure show run.move.allow >out &&
	egrep ^run.move.allow: out
  '

?

-Peff
