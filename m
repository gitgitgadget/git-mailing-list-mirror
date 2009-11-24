From: Jeff King <peff@peff.net>
Subject: Re: git tag listing order
Date: Tue, 24 Nov 2009 14:00:23 -0500
Message-ID: <20091124185947.GA24409@coredump.intra.peff.net>
References: <20091124105609.0980e796@montecarlo.grandprix.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter van der Does <peter@ourvirtualhome.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 20:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND0cp-00017W-UL
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 20:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933920AbZKXTAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 14:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933903AbZKXTAU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 14:00:20 -0500
Received: from peff.net ([208.65.91.99]:36289 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933900AbZKXTAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 14:00:19 -0500
Received: (qmail 10428 invoked by uid 107); 24 Nov 2009 19:04:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Nov 2009 14:04:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2009 14:00:23 -0500
Content-Disposition: inline
In-Reply-To: <20091124105609.0980e796@montecarlo.grandprix.int>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133586>

On Tue, Nov 24, 2009 at 10:56:09AM -0500, Peter van der Does wrote:

> I'm using git 1.6.5.3 on Ubuntu and was wondering if there is a way to
> list tags in order of when they were added to the tree, instead of
> alphabetical?

You can use for-each-ref with its sort option:

  git for-each-ref --sort=taggerdate --format='%(refname:short)' refs/tags

Though note that unannotated tags will have no taggerdate, and will all
sort to the front of the list. To exclude them, I think you'd have to
use a special format to grep and sort yourself. Something like:

  git for-each-ref \
    --format='%(taggerdate:iso8601) %(refname:short)' refs/tags |
    grep -v '^ ' |
    sort |
    cut -d' ' -f4-

-Peff
