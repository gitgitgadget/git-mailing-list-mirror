From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] index-pack: protect deepest_delta in multithread code
Date: Tue, 19 Mar 2013 09:25:29 -0400
Message-ID: <20130319132529.GA6646@sigill.intra.peff.net>
References: <CACsJy8DgQZFewPjLSXSkdHHWqhQDqExoVq-pBGpKr1G8w06uvQ@mail.gmail.com>
 <1363698075-12452-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Stefan Zager <szager@google.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 14:26:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHwYE-0003g8-7b
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 14:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab3CSNZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 09:25:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58336 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600Ab3CSNZe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 09:25:34 -0400
Received: (qmail 29279 invoked by uid 107); 19 Mar 2013 13:27:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 09:27:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 09:25:29 -0400
Content-Disposition: inline
In-Reply-To: <1363698075-12452-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218512>

On Tue, Mar 19, 2013 at 08:01:15PM +0700, Nguyen Thai Ngoc Duy wrote:

> deepest_delta is a global variable but is updated without protection
> in resolve_delta(), a multithreaded function. Add a new mutex for it,
> but only protect and update when it's actually used (i.e. show_stat is
> non-zero).

This makes sense to me.

> Another variable that will not be updated is delta_depth in "struct
> object_entry" as it's only useful when show_stat is 1. Putting it in
> "if (show_stat)" makes it clearer.

Having just read through this code for the first time, I agree that
having the "if (show_stat)" would have made it a lot more clear under
what conditions and for what purpose the delta_depth flag was being
used.

>  builtin/index-pack.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)

Patch looks good to me. Thanks.

-Peff
