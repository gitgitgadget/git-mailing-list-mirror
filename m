From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] improve symbolic-ref robustness
Date: Sun, 20 Dec 2015 02:26:38 -0500
Message-ID: <20151220072637.GA22102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 08:26:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAYOD-0007bh-P8
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 08:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbbLTH0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 02:26:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:44639 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753780AbbLTH0l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 02:26:41 -0500
Received: (qmail 20076 invoked by uid 102); 20 Dec 2015 07:26:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Dec 2015 01:26:41 -0600
Received: (qmail 11116 invoked by uid 107); 20 Dec 2015 07:26:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Dec 2015 02:26:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Dec 2015 02:26:38 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282757>

I noticed that an interrupt "git symbolic-ref" will not clean up
"HEAD.lock". So I started this series as an attempt to convert
create_symref() to "struct lock_file" to get the usual tempfile cleanup.

But I found a few other points of interest. The biggest is that
git-symbolic-ref does not actually propagate errors in its exit code.
Whoops. That's fixed in the first patch, which could go separately to
"maint".

The rest of it is fairly dependent on master because of the
refs/files-backend.c code movement. I can backport it if we really want
it for maint.

  [1/4]: symbolic-ref: propagate error code from create_symref()
  [2/4]: t1401: test reflog creation for git-symbolic-ref
  [3/4]: create_symref: modernize variable names
  [4/4]: create_symref: use existing ref-lock code

-Peff
