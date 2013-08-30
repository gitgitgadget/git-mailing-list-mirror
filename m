From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] has_sha1_file: re-check pack directory before giving up
Date: Fri, 30 Aug 2013 00:28:01 -0400
Message-ID: <20130830042801.GA23780@sigill.intra.peff.net>
References: <20130830011052.GA21895@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 06:28:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFGJl-0004ss-IA
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 06:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992Ab3H3E2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 00:28:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:42971 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755920Ab3H3E2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 00:28:05 -0400
Received: (qmail 2048 invoked by uid 102); 30 Aug 2013 04:28:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Aug 2013 23:28:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Aug 2013 00:28:01 -0400
Content-Disposition: inline
In-Reply-To: <20130830011052.GA21895@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233391>

On Thu, Aug 29, 2013 at 09:10:52PM -0400, Jeff King wrote:

> In the case of git-fsck, which uses the
> DO_FOR_EACH_INCLUDE_BROKEN flag, this will cause us to
> erroneously complain that the ref points to an invalid
> object. But for git-repack, which does not use that flag, we
> will skip the ref completely!

Hmm. This is slightly inaccurate. fsck does not use INCLUDE_BROKEN, and
that is why it recognizes (and prints the warning) the "broken" ref.
pack-objects would also print a warning, but would dutifully ignore the
broken ref during the repack.

So it is actually something like for-each-ref, which _does_ use
INCLUDE_BROKEN, that behaves differently. And it tends to work, because
it ends up calling read_sha1_file to find out about the file rather than
checking has_sha1_file.

-Peff
