From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/1] http: Fix crash when passing malformed URL
Date: Wed, 16 Mar 2016 17:29:38 -0400
Message-ID: <20160316212938.GA4441@sigill.intra.peff.net>
References: <1458125647-32707-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip@i4.informatik.uni-erlangen.de, i4passt@cs.fau.de,
	git@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:29:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agJ0j-0000nx-TL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493AbcCPV3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:29:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:32820 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751510AbcCPV3l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:29:41 -0400
Received: (qmail 26915 invoked by uid 102); 16 Mar 2016 21:29:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:29:40 -0400
Received: (qmail 20342 invoked by uid 107); 16 Mar 2016 21:29:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:29:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 17:29:38 -0400
Content-Disposition: inline
In-Reply-To: <1458125647-32707-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289043>

On Wed, Mar 16, 2016 at 11:54:06AM +0100, Anton Wuerfel wrote:

> When passing a malformed URL to http_init() in http.c, git dies from a null
> pointer dereference. An example for a malformed URL is http:/git-scm.com (note
> the single slash after the protocol).
> 
> I could not reproduce this error within any functions of git - I just noticed it
> during development of a git extension together with Phillip Raffeck.

You can reproduce it with:

  git clone https::bogus

Normally we recognize "https://" as the signal to send the URL to the
git-remote-https helper, but you can override the helper by specifying
"whatever::", and then the rest of the string will be passed to it.

-Peff
