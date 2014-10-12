From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] receive-pack: plug minor memory leak in unpack()
Date: Sat, 11 Oct 2014 21:53:21 -0400
Message-ID: <20141012015321.GA15272@peff.net>
References: <54390DC0.8060302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 12 03:53:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xd8Ls-0004FV-CY
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 03:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbaJLBx0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Oct 2014 21:53:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:57585 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751631AbaJLBxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 21:53:25 -0400
Received: (qmail 8472 invoked by uid 102); 12 Oct 2014 01:53:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 11 Oct 2014 20:53:25 -0500
Received: (qmail 12950 invoked by uid 107); 12 Oct 2014 01:53:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 11 Oct 2014 21:53:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Oct 2014 21:53:21 -0400
Content-Disposition: inline
In-Reply-To: <54390DC0.8060302@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 11, 2014 at 01:00:16PM +0200, Ren=C3=A9 Scharfe wrote:

> The argv_array used in unpack() is never freed.  Instead of adding
> explicit calls to argv_array_clear() use the args member of struct
> child_process and let run_command() and friends clean up for us.

Looks good. I notice that the recently added prepare_push_cert_sha1 use=
s
an argv_array to create the child_process.env, and we leak the result. =
I
wonder if run-command should provide a managed env array similar to the
"args" array.

-Peff
