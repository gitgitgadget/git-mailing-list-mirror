From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] attr: "binary" attribute should choose built-in
 "binary" merge driver
Date: Mon, 10 Sep 2012 10:03:17 -0400
Message-ID: <20120910140317.GA7906@sigill.intra.peff.net>
References: <7v392twlnm.fsf@alter.siamese.dyndns.org>
 <1347165639-12149-1-git-send-email-gitster@pobox.com>
 <1347165639-12149-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stephen Bash <bash@genarts.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 16:03:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB4aH-0004TF-Do
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 16:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757220Ab2IJODV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 10:03:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39583 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757068Ab2IJODU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 10:03:20 -0400
Received: (qmail 27667 invoked by uid 107); 10 Sep 2012 14:03:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 10:03:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 10:03:17 -0400
Content-Disposition: inline
In-Reply-To: <1347165639-12149-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205126>

On Sat, Sep 08, 2012 at 09:40:39PM -0700, Junio C Hamano wrote:

> The built-in "binary" attribute macro expands to "-diff -text", so
> that textual diff is not produced, and the contents will not go
> through any CR/LF conversion ever.  During a merge, it should also
> choose the "binary" low-level merge driver, but it didn't.
> 
> Make it expand to "-diff -merge -text".

Yeah, that seems like the obviously correct thing to do. In practice,
most files would end up in the first few lines of ll_xdl_merge checking
buffer_is_binary anyway, so I think this would really only make a
difference when our "is it binary?" heuristic guesses wrong.

>  Documentation/gitattributes.txt | 2 +-
>  attr.c                          | 2 +-
>  t/t6037-merge-ours-theirs.sh    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Patch itself looks good to me.

-Peff
