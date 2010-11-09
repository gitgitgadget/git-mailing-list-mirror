From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Tue, 9 Nov 2010 17:11:42 -0500
Message-ID: <20101109221142.GB5617@sigill.intra.peff.net>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 23:12:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFwQ1-00032H-5n
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 23:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab0KIWLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 17:11:46 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46920 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060Ab0KIWLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 17:11:45 -0500
Received: (qmail 10580 invoked by uid 111); 9 Nov 2010 22:11:43 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.34)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Nov 2010 22:11:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Nov 2010 17:11:42 -0500
Content-Disposition: inline
In-Reply-To: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161101>

On Tue, Nov 09, 2010 at 11:53:19AM -0800, Junio C Hamano wrote:

> * jk/tag-contains (2010-07-05) 4 commits
>  - Why is "git tag --contains" so slow?
>  - default core.clockskew variable to one day
>  - limit "contains" traversals based on commit timestamp
>  - tag: speed up --contains calculation
> 
> The idea of the bottom one is probably Ok, except that the use of object
> flags needs to be rethought, or at least the helper needs to be moved to
> builtin/tag.c to make it clear that it should not be used outside the
> current usage context.

This, btw, is still on my todo list. I got pleasing performance results
using a notes tree to store a list of commits with bogus timestamps, so
I need to clean that up and submit. I think that may spin off into its
own topic entirely, as it is about handling clock skew better
everywhere, not just in the newly introduced "tag --contains" code.

I'm also still trying to figure out if there is a way to avoid the
depth-first search of the "tag --contains" patch. It can have worse
performance in a few corner cases than the merge-base approach (i.e., we
end up going to the roots sometimes when we make an unlucky depth-first
traversal). Though with the commit-time optimization (which depends on
sane skew handling from above), that goes away, so maybe it is not worth
caring too much.

-Peff
