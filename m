From: Jeff King <peff@peff.net>
Subject: Re: Bug? diff.submodule=log adds text to commit -v message
Date: Mon, 11 Nov 2013 18:24:12 -0500
Message-ID: <20131111232412.GA14924@sigill.intra.peff.net>
References: <loom.20131110T222043-57@post.gmane.org>
 <528140F5.6090700@web.de>
 <loom.20131111T214646-550@post.gmane.org>
 <52814C35.6040205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ari Pollak <ari@debian.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 12 00:24:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0qB-00047m-S4
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab3KKXYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:24:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:37471 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752913Ab3KKXYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:24:14 -0500
Received: (qmail 25900 invoked by uid 102); 11 Nov 2013 23:24:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Nov 2013 17:24:14 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Nov 2013 18:24:12 -0500
Content-Disposition: inline
In-Reply-To: <52814C35.6040205@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237675>

On Mon, Nov 11, 2013 at 10:29:25PM +0100, Jens Lehmann wrote:

> The diff below fixes the problem you describe for me. (But I do not
> consider it a worthwhile fix in its current form because a line
> starting with "Submodule " might appear in a perfectly normal commit
> message, while "diff --git " most probably won't).

Yeah, this fix makes me nervous for that reason. "commit -v" has always
been a little bit flaky in that respect, as it is simply guessing at
the beginning of the diff text it added earlier. In addition to false
negatives, it also has false positives, stripping out people's diffs
that they meant to include in the commit message.

The "right" way to fix this is to change the format to use some more
robust marker, like:

  # Everything below this line is a diff that will be removed.

I do not know offhand if anybody's commit-template generating or parsing
scripts would be broken, but I doubt the fallout would be that big. When
last we discussed this (AFAICT), we did not yet have 0b38227 (commit:
Fix stripping of patch in verbose mode., 2008-11-12), which meant that
it would affect _everybody_. Nowadays it would only affect users of
"-v", which is presumably a much smaller population.

-Peff
