From: Jeff King <peff@peff.net>
Subject: Re: your mail
Date: Mon, 11 Apr 2016 15:13:12 -0400
Message-ID: <20160411191311.GA9057@sigill.intra.peff.net>
References: <001a11492f107354a305303a369a@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: miwilliams@google.com
X-From: git-owner@vger.kernel.org Mon Apr 11 21:13:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aphGy-0006Pr-99
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 21:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbcDKTNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 15:13:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:47651 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754403AbcDKTNP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 15:13:15 -0400
Received: (qmail 13534 invoked by uid 102); 11 Apr 2016 19:13:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Apr 2016 15:13:14 -0400
Received: (qmail 28833 invoked by uid 107); 11 Apr 2016 19:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Apr 2016 15:13:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Apr 2016 15:13:12 -0400
Content-Disposition: inline
In-Reply-To: <001a11492f107354a305303a369a@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291227>

On Mon, Apr 11, 2016 at 07:04:23PM +0000, miwilliams@google.com wrote:

> From 7201fe08ede76e502211a781250c9a0b702a78b2 Mon Sep 17 00:00:00 2001
> From: Mike Williams <miwilliams@google.com>
> Date: Mon, 11 Apr 2016 14:18:39 -0400
> Subject: [PATCH 1/1] wt-status: Remove '!!' from
> wt_status_collect_changed_cb

These bits (minus the initial "From ..." line) should go into your
actual email headers. As it is, your email has no subject line.

> The wt_status_collect_changed_cb function uses an extraneous double
> negation (!!) when determining whether or not a submodule has new
> commits.
> [...]
> -			d->new_submodule_commits = !!hashcmp(p->one->sha1, p->two->sha1);
> +			d->new_submodule_commits = hashcmp(p->one->sha1, p->two->sha1);

It's not extraneous. hashcmp() returns 0 for equality, but an arbitrary
positive or negative value depending on how the two arguments differ.
The assigned "new_submodule_commits" is a bitfield of size 1. So the
"!!" is normalizing the value into "0" or "1".

-Peff
