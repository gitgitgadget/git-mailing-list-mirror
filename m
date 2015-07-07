From: Jeff King <peff@peff.net>
Subject: Re: Git force push fails after a rejected push (unpack failed)?
Date: Tue, 7 Jul 2015 10:13:06 -0400
Message-ID: <20150707141305.GA629@peff.net>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: X H <music_is_live_lg@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 16:13:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTcY-0007xf-If
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361AbbGGONL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:13:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:56765 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755270AbbGGONJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:13:09 -0400
Received: (qmail 22534 invoked by uid 102); 7 Jul 2015 14:13:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 09:13:08 -0500
Received: (qmail 8865 invoked by uid 107); 7 Jul 2015 14:13:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 10:13:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jul 2015 10:13:06 -0400
Content-Disposition: inline
In-Reply-To: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273519>

On Tue, Jul 07, 2015 at 03:45:50PM +0200, X H wrote:

> remote: error: unable to write sha1 filename objects/d9/4bfb39cd0be7497e493bd4045111a7b1158134: Permission denied
> remote: fatal: failed to write object
> error: unpack failed: unpack-objects abnormal exit

It looks like the permissions of one or more of the .git/objects/*
directories on the server is not right. Just a guess, but this may be
because you have multiple accounts pushing to it, and need to set umasks
or use git's core.sharedrepository config to set the permissions for
each object.

You'll probably have to ssh to the server and "chown" or "chmod" some
directories to fix it in the first place, though.

> Is it the intended behaviour? I try to reproduce this and it seems it
> doesn't happen always.

Probably only some object directories have the problem, so it would
depend on the set of exact objects you are sending, and possibly even
the number of objects (if you send a large number of objects, git will
store them as a pack, not as loose objects).

-Peff
