From: Jeff King <peff@peff.net>
Subject: Re: bug: git submodule add fails when .git is a symlink
Date: Wed, 2 Mar 2016 03:49:04 -0500
Message-ID: <20160302084904.GA30295@sigill.intra.peff.net>
References: <20160301204218.GA4083@kitenet.net>
 <CAGZ79kY6Lf6u0=s8J_cqRNFsry4nu2SdL0GZ2gkFsu6gBrB65Q@mail.gmail.com>
 <xmqq8u217tqa.fsf@gitster.mtv.corp.google.com>
 <20160301231720.GB3731@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:49:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab2T2-0006kK-C5
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 09:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbcCBItI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 03:49:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:53076 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751167AbcCBItH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 03:49:07 -0500
Received: (qmail 11541 invoked by uid 102); 2 Mar 2016 08:49:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 03:49:07 -0500
Received: (qmail 21794 invoked by uid 107); 2 Mar 2016 08:49:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 03:49:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2016 03:49:04 -0500
Content-Disposition: inline
In-Reply-To: <20160301231720.GB3731@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288109>

On Tue, Mar 01, 2016 at 07:17:20PM -0400, Joey Hess wrote:

> Junio C Hamano wrote:
> > A more pertinent question may be which version of Git did the above
> > ever work, I guess.  We fairly liberally chdir around and I do not
> > think we deliberately avoid assuming that "cd .git && cd .." might
> > not come back to the original directory, for example, so I wouldn't
> > be surprised if it never worked.
> 
> IIRC git used symlinks for .git in submodules before version 1.7.8, so I
> guess that older versions supported that pretty well.
> 
> This one case is the only time I've seen a symlink for .git present a
> problem so far.

Fortunately you provided a simple reproduction case, so it is easy to
bisect. It did work in v1.7.8, and broke in d75219b (submodules: always
use a relative path from gitdir to work tree, 2012-03-04). Not
surprising, I guess. It presumably worked before only because we were
using absolute paths.

-Peff
