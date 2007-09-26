From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add a --dateformat= option to git-for-each-ref
Date: Wed, 26 Sep 2007 08:58:11 -0400
Message-ID: <20070926125811.GC13739@coredump.intra.peff.net>
References: <200709261009.18777.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 14:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaWT7-0003rz-7I
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 14:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbXIZM6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 08:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbXIZM6O
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 08:58:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1822 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969AbXIZM6N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 08:58:13 -0400
Received: (qmail 26749 invoked by uid 111); 26 Sep 2007 12:58:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Sep 2007 08:58:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2007 08:58:11 -0400
Content-Disposition: inline
In-Reply-To: <200709261009.18777.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59229>

On Wed, Sep 26, 2007 at 10:09:18AM +0100, Andy Parkins wrote:

> For example (I'm in BST, +0100 at present):
> 
>  $ git-for-each-ref --dateformat=normal --format='%(taggerdate)' refs/tags/v1.5.2
>  Sun May 20 00:30:42 2007 -0700
>  $ git-for-each-ref --dateformat=relative --format='%(taggerdate)' refs/tags/v1.5.2
>  4 months ago

What if you want a format that contains two dates in different formats?
Something like:

 $ git-for-each-ref --format='%(committerdate:relative) %(authordate:normal)'

would be more flexible. Although perhaps that is a bit too unlikely to
be concerned with implementing, giving options to substitutions seems
like a sane way to implement these sorts of things (e.g.,
"%(objectsize:human)", "%(parent:1)", etc).

> +		if (!prefixcmp(arg, "--dateformat=")) {
> +			arg += 13;
> +			if (!prefixcmp(arg,"relative")) {
> +				date_mode = DATE_RELATIVE;
> +			} else if (!prefixcmp(arg,"short")) {
> +				date_mode = DATE_SHORT;
> +			} else if (!prefixcmp(arg,"local")) {
> +				date_mode = DATE_LOCAL;
> +			} else if (!prefixcmp(arg,"iso8601")) {
> +				date_mode = DATE_ISO8601;
> +			} else if (!prefixcmp(arg,"rfc2822")) {
> +				date_mode = DATE_RFC2822;
> +			}
> +			continue;
> +		}

Surely this same code exists elsewhere, and could be easily factored out
into a parse_date_type function.

-Peff
