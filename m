From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: let remote clients get reachable commits
Date: Fri, 22 Feb 2013 12:27:10 -0500
Message-ID: <20130222172710.GB17475@sigill.intra.peff.net>
References: <1361456643-51851-1-git-send-email-gurugray@yandex.ru>
 <20130221155208.GA19943@sigill.intra.peff.net>
 <995301361532360@web22h.yandex.ru>
 <7vehg8s295.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergey Sergeev <gurugray@yandex.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:27:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8wPJ-0001Gn-QP
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 18:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149Ab3BVR1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 12:27:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57188 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757929Ab3BVR1M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 12:27:12 -0500
Received: (qmail 6188 invoked by uid 107); 22 Feb 2013 17:28:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Feb 2013 12:28:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2013 12:27:10 -0500
Content-Disposition: inline
In-Reply-To: <7vehg8s295.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216845>

On Fri, Feb 22, 2013 at 09:10:46AM -0800, Junio C Hamano wrote:

> I personally think that it is OK to limit the scope to expressions
> that start from the tip of ref and expressions that start with the
> SHA-1 at the tip of ref, e.g.
> 
>     master~12:Documentation
>     v2.6.11:arch/alpha
>     5dc01c595e6c6ec9ccda	# tag v2.6.11
>     26791a8bcf0e6d33f43a:arch	# tag v2.6.12
>     26791a8bcf0~12:arch		# starting at 26791a8b and dig down
> 
> are OK, while forbidding the following:
> 
>     c39ae07f393806ccf406        # tree of tag v2.6.11
>     9ee1c939d1cb936b1f98	# commit v2.6.12^0
>     9ee1c939d1cb936b1f98:	# tree of commit v2.6.12^0
>     9ee1c939d1cb936b1f98:arch	# subtree of commit v2.6.12^0
> 
> which will make it significantly easier to implement the necessary
> validation in a robust way.

How are you proposing to verify master~12 in that example? Because
during parsing, it starts with "master", and we remember that? Or
because you are doing a reachability traversal on all refs after we
parse?

-Peff
