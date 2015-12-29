From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/3] improve symbolic-ref robustness
Date: Tue, 29 Dec 2015 00:55:58 -0500
Message-ID: <20151229055558.GA12848@sigill.intra.peff.net>
References: <20151220072637.GA22102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 06:56:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDnGV-00067s-6W
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 06:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbbL2F4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 00:56:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:46492 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750916AbbL2F4B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 00:56:01 -0500
Received: (qmail 13927 invoked by uid 102); 29 Dec 2015 05:56:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Dec 2015 23:56:01 -0600
Received: (qmail 18348 invoked by uid 107); 29 Dec 2015 05:56:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:56:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 00:55:58 -0500
Content-Disposition: inline
In-Reply-To: <20151220072637.GA22102@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283067>

On Sun, Dec 20, 2015 at 02:26:37AM -0500, Jeff King wrote:

> I noticed that an interrupt "git symbolic-ref" will not clean up
> "HEAD.lock". So I started this series as an attempt to convert
> create_symref() to "struct lock_file" to get the usual tempfile cleanup.

Here's version 2, based on comments from Michael. The first two patches
were picked out separately for jk/symbolic-ref-maint, so I've dropped
them here (so 1+2 here are the original 3+4).

The other differences from v1 are:

  - use "refname" instead of "ref" to match surrounding code

  - drop adjust_shared_perm, as lockfile does it for us

  - adjust reflog writing order (done in a new patch)

The patches are:

  [1/3]: create_symref: modernize variable names
  [2/3]: create_symref: use existing ref-lock code
  [3/3]: create_symref: write reflog while holding lock

-Peff
