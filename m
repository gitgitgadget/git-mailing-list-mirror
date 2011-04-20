From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC] Rename detection and whitespace
Date: Wed, 20 Apr 2011 02:03:44 -0400
Message-ID: <20110420060343.GD28597@sigill.intra.peff.net>
References: <BANLkTikiH7bfWFGjFCDL-SnO9HQR-9Uofw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ciaran <ciaranj@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 08:03:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCQW0-00005w-P4
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 08:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab1DTGDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 02:03:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41443
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab1DTGDr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 02:03:47 -0400
Received: (qmail 16367 invoked by uid 107); 20 Apr 2011 06:04:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Apr 2011 02:04:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2011 02:03:44 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikiH7bfWFGjFCDL-SnO9HQR-9Uofw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171842>

On Tue, Apr 19, 2011 at 09:13:19PM +0100, Ciaran wrote:

> For me I tracked the behaviour down to the blob similarity calculation
> that takes place in the diffcore-delta.c#hash_chars method.  In our
> case the problem was we were adjusting the whitespace at the front of
> each line which meant that the 64 byte segment hashes were
> different/mis-aligned between the 2 equivalent files.   This code
> already 'normalises' out CRLF/LF differences by skipping any CR
> characters when followed by LF so my question is that would it be
> considered wrong/evil to ignore *all* whitespace characters when -X
> ignore-all-space has been passed.

I think what you are proposing makes sense. If the diff which spawned
the rename detection doesn't care about whitespace, then probably it
should be ignored in the rename, too. That would go for merging with "-X
ignore-all-space", but also for "git diff -w" (and probably "-b").

I do think it should be conditional on those, though. We _know_ that
CRLF versus LF in a text file is irrelevant to the file's content. But
whether whitespace is irrelevant varies from file to file.

So your patch is in the right direction, in my opinion.

-Peff
