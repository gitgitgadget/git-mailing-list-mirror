From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] config.mak.uname: Darwin: define HAVE_GETDELIM for
 modern OS X releases
Date: Tue, 2 Jun 2015 14:44:13 -0400
Message-ID: <20150602184413.GA11437@peff.net>
References: <1433269138-10890-1-git-send-email-sunshine@sunshineco.com>
 <1433269138-10890-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 20:44:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzrAk-0006nS-25
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbbFBSoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:44:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:39808 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753624AbbFBSoR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:44:17 -0400
Received: (qmail 16812 invoked by uid 102); 2 Jun 2015 18:44:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Jun 2015 13:44:16 -0500
Received: (qmail 10240 invoked by uid 107); 2 Jun 2015 18:44:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Jun 2015 14:44:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jun 2015 14:44:13 -0400
Content-Disposition: inline
In-Reply-To: <1433269138-10890-2-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270580>

On Tue, Jun 02, 2015 at 02:18:57PM -0400, Eric Sunshine wrote:

> The use of 'expr' in this new test is decidedly different from existing
> instances which merely check if `uname -R` matches a particular single
> digit and a period. If the new test took the same approach, it would
> have to match either one digit (in a particular range) plus a period, or
> two digits with the first being "1", plus a period. The resulting 'expr'
> expression quickly becomes ugly and quite difficult to decipher. Hence,
> the new test instead takes advantage of expr's relational operator '>='
> to keep things simple and make the test easy to understand at a glance
> ("if version >= 11" where 11 is the Darwin major version number of OS X
> 10.7).

I think that is OK with respect to portability; we are already inside a
$(uname_S) check, so we know we are on some form of Mac OS. But...

> +	ifeq ($(shell expr $(shell expr "$(uname_R)" : '\([0-9][0-9]*\)\.') '>=' 11),1)

Do you need to spawn two shells? It seems like:

  $(shell expr `expr "$(uname_R)" : '\([0-9][0-9]*\)'` '>=' 11),1)

should do the same thing.

-Peff
