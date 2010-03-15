From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon.c: avoid accessing ss_family member of struct
 sockaddr_storage
Date: Mon, 15 Mar 2010 17:29:15 -0400
Message-ID: <20100315212915.GB25342@coredump.intra.peff.net>
References: <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st>
 <XI3O9HirgFwPkEqC3RdYR4j56mg_uuJQZk1YFST6ukqbKXjgxaqJdNDHwlLXg5R_FVXWmWQSGmg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git@mlists.thewrittenword.com,
	kusmabite@gmail.com, martin@martin.st,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Mar 15 22:29:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrHqw-0002r2-4d
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936846Ab0COV33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 17:29:29 -0400
Received: from peff.net ([208.65.91.99]:49031 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936835Ab0COV32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:29:28 -0400
Received: (qmail 30952 invoked by uid 107); 15 Mar 2010 21:29:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Mar 2010 17:29:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Mar 2010 17:29:15 -0400
Content-Disposition: inline
In-Reply-To: <XI3O9HirgFwPkEqC3RdYR4j56mg_uuJQZk1YFST6ukqbKXjgxaqJdNDHwlLXg5R_FVXWmWQSGmg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142253>

On Mon, Mar 15, 2010 at 04:03:00PM -0500, Brandon Casey wrote:

> When NO_SOCKADDR_STORAGE is set for a platform, either sockaddr_in or
> sockaddr_in6 is used intead.  Neither of which has an ss_family member.
> They have an sin_family and sin6_family member respectively.  Since the
> addrcmp() function accesses the ss_family member of a sockaddr_storage
> struct, compilation fails on platforms which define NO_SOCKADDR_STORGAGE.
> 
> Since any sockaddr_* structure can be cast to a struct sockaddr and
> have its sa_family member read, do so here to workaround this issue.

Didn't Gary say that AIX 5.2 sticks sa_len at the front of their
sockaddr?

We know that whatever we actually have (an actual sockaddr_storage, or a
sockaddr_in, or a sockaddr_in6) will have the family at the front, so
can you just cast it to sa_family_t?

Or am I wrong in assuming that, and on AIX sockaddr_in actually has
sa_len at the front, so casting to sockaddr does the right thing (and my
recommendation above would actually be broken)? The AIX boxen I have
access to are all down at the moment.

-Peff
