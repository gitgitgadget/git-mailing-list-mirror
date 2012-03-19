From: Jeff King <peff@peff.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sun, 18 Mar 2012 22:44:36 -0400
Message-ID: <20120319024436.GB10426@sigill.intra.peff.net>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Ivan Todoroski <grnch_lists@gmx.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:44:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9SaQ-0006vY-SC
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 03:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757736Ab2CSCoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 22:44:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51949
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757087Ab2CSCoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 22:44:38 -0400
Received: (qmail 26597 invoked by uid 107); 19 Mar 2012 02:44:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 Mar 2012 22:44:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Mar 2012 22:44:36 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193412>

On Mon, Mar 19, 2012 at 08:30:38AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Mon, Mar 19, 2012 at 2:07 AM, Jeff King <peff@peff.net> wrote:
> > I don't think that will work, as stateless-rpc fetch-pack already uses
> > stdin to receive the list of advertised refs from the remote. Nor would
> > you want to have multiple invocations of fetch-pack, since that would
> > mean multiple http requests and multiple pack responses (which could not
> > delta between themselves).
> 
> remote-curl functions as middle man between http client and
> fetch-pack. Can we just send ref list over fetch-pack.stdin first,
> followed by maybe empty line, then normal stuff that remote-curl feeds
> fetch-pack?

Yes, I think that would work. You'd just have to take care to pass the
residual buffer (i.e., what is left in your input buffer after you
notice that reading the list of wanted refs is finished) along to
the git-protocol code.  So it would require a little refactoring of
get_remote_heads, I think.

-Peff
