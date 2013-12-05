From: Jeff King <peff@peff.net>
Subject: Re: [BUG] redundant error message
Date: Thu, 5 Dec 2013 14:15:18 -0500
Message-ID: <20131205191518.GB19039@sigill.intra.peff.net>
References: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 20:15:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoeOS-0005eJ-KC
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 20:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab3LETPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 14:15:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:51108 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750809Ab3LETPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 14:15:20 -0500
Received: (qmail 27465 invoked by uid 102); 5 Dec 2013 19:15:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Dec 2013 13:15:20 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Dec 2013 14:15:18 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238898>

On Thu, Dec 05, 2013 at 05:07:31PM +0700, Duy Nguyen wrote:

> $ git rev-parse foobar --
> foobar
> fatal: ambiguous argument 'foobar': unknown revision or path not in
> the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> 
> I already put "--" there. So it should shut up.

I think it is more than just a bad error message; if we get that
message, it means we are following the wrong code path in interpreting
"foobar":

  $ >foobar
  $ git rev-parse foobar --
  foobar
  --
  fatal: bad flag '--' used after filename

That's not right. It looks like this isn't a new breakage, though.
v1.5.0 produces the same result.

-Peff
