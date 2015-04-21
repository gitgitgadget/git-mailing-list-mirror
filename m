From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Tue, 21 Apr 2015 19:21:13 -0400
Message-ID: <20150421232112.GA28316@peff.net>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
 <xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
 <xmqqsibyo141.fsf@gitster.dls.corp.google.com>
 <CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
 <CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>
 <CAGZ79kZWm=Mi6o4jMNthiDRcR9irs_5MyRuEmHdDSrn-JFpQ=g@mail.gmail.com>
 <xmqqzj62ifc9.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYk_3E1RMdNvA_OrCj6EdaJ2Xdps9pUxEkWwvDNazb6Gg@mail.gmail.com>
 <CAGZ79kY842JXB37++nwYjkX1WK9ja5m-G1aDj=QgLN-qKLo9Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 01:21:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkhTk-0000nK-4r
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 01:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbbDUXVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 19:21:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:48373 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964880AbbDUXVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 19:21:15 -0400
Received: (qmail 11691 invoked by uid 102); 21 Apr 2015 23:21:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 18:21:15 -0500
Received: (qmail 5982 invoked by uid 107); 21 Apr 2015 23:21:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 19:21:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2015 19:21:13 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kY842JXB37++nwYjkX1WK9ja5m-G1aDj=QgLN-qKLo9Lg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267573>

On Mon, Apr 20, 2015 at 05:31:11PM -0700, Stefan Beller wrote:

> When running the test locally, i.e. not in the test suite, but typing
> the commands
> myself into the shell, Git is fine with having just 5 file descriptors left.
> The additional 4 required fds come from beign run inside the test suite.
> 
> When strace-ing git, I cannot see any possible other fds which would require
> having some left over space required. So I'd propose we'd just take a reasonable
> number not too small for various test setups like 32 and then go with the
> proposed patches.

FWIW, we already use a magic value of "25 extra" in open_packed_git_1. I
don't know if that means the number has been proven in practice, or if
it is simply that nobody actually exercises the pack_max_fds code. I
suspect it is the latter, especially since d131b7a (sha1_file.c: Don't
retain open fds on small packs, 2011-03-02).

-Peff
