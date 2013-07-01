From: Jeff King <peff@peff.net>
Subject: Re: [RFH] "git reset --hard" broken???
Date: Mon, 1 Jul 2013 17:47:56 -0400
Message-ID: <20130701214756.GA13962@sigill.intra.peff.net>
References: <7vli5qezqj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 23:48:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utlx6-0001qM-J3
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 23:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230Ab3GAVsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 17:48:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:51163 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100Ab3GAVr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 17:47:59 -0400
Received: (qmail 28280 invoked by uid 102); 1 Jul 2013 21:49:08 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Jul 2013 16:49:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jul 2013 17:47:56 -0400
Content-Disposition: inline
In-Reply-To: <7vli5qezqj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229329>

On Mon, Jul 01, 2013 at 02:28:52PM -0700, Junio C Hamano wrote:

> I have no time to dig this down, but I just noticed this by accident:
> 
> 	$ make
>         $ cd t
>         $ sh ./t7011-skip-worktree-reading.sh -d
>         $ cd trash*.t7011*
>         $ git reset --hard HEAD
>         error: Entry '1' not uptodate. Cannot merge.
> 	fatal: Could not reset index file to revision 'HEAD'.
> 
> which looks quite bogus.  "reset --hard" is meant to be the last
> resort "no matter what, please match the working tree to the commit"
> and should not ever error out with "not uptodate Cannot merge"
> message.

Yeah, I would agree. I do not think this is a new breakage. It behaves
the same way all the way back to v1.7.0 (the first commit with t7011).
Trying to go back further (by snapshotting the state of the trash
directory and just running the reset on it) doesn't work, as older
versions do not understand the skip-worktree bit.

I'm not sure yet if it's just a problem with skip-worktree entries, or
if you can trigger the problem another way, though.

-Peff
