From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Sun, 25 Aug 2013 01:54:33 -0400
Message-ID: <20130825055433.GA7296@sigill.intra.peff.net>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
 <20130825044108.GA21300@sigill.intra.peff.net>
 <20130825054142.GM2882@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Hord <hordp@cisco.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, phil.hord@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:56:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDTJ3-0005OJ-E5
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab3HYFyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:54:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:52996 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755996Ab3HYFyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:54:35 -0400
Received: (qmail 15261 invoked by uid 102); 25 Aug 2013 05:54:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 25 Aug 2013 00:54:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Aug 2013 01:54:33 -0400
Content-Disposition: inline
In-Reply-To: <20130825054142.GM2882@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232924>

On Sat, Aug 24, 2013 at 10:41:42PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > So we are necessarily reconstructing based on what we know of the
> > syntax. And I think that your rule is OK, because we know that refnames
> > cannot contain a colon.
> 
> What happens with expressions like HEAD^{/test:}?

Ugh, right. Names are more than just refnames.

So I think the only way to do this robustly is to ask get_sha1 to
remember more about what happened. We might even be able to get away
without teaching get_sha1_with_context anything else; it already records
the path, so we should be able to just check whether that is non-empty.

But we use an object_array to store the list of objects, and it has no
room for such a bit. So we'd probably want to refactor that, too.

-Peff
