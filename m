From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] '%S' option for pretty printing to support --source
Date: Thu, 5 Mar 2009 04:17:58 -0500
Message-ID: <20090305091758.GC30445@coredump.intra.peff.net>
References: <200903050918.29051.petri.hodju@yumesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org,
	gitster@pobox.com
To: Petri Hodju <petri.hodju@yumesystems.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 10:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9jv-0008G0-8M
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 10:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbZCEJSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 04:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbZCEJSK
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 04:18:10 -0500
Received: from peff.net ([208.65.91.99]:42064 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbZCEJSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 04:18:08 -0500
Received: (qmail 29339 invoked by uid 107); 5 Mar 2009 09:18:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 04:18:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 04:17:58 -0500
Content-Disposition: inline
In-Reply-To: <200903050918.29051.petri.hodju@yumesystems.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112277>

On Thu, Mar 05, 2009 at 09:18:28AM +0200, Petri Hodju wrote:

> +static void format_source(struct strbuf *sb, const struct commit *commit)
> +{
> +    if (commit->util)
> +	strbuf_addstr(sb, (char *) commit->util);
> +}
> +

Hmm. This is the second patch in the last few weeks to use commit->util
to carry information for --pretty=format: (I am cc'ing Deskin Miller,
who wrote the first).

They cannot both work, obviously. So we need to do one of:

  - refactor the information out of commit->util to somewhere else

  - allow multiple commit->util users somehow (which I think is a
    potential performance problem -- the simplistic design is meant to
    avoid things like allocation overhead)

  - gracefully block concurrent use of conflicting features

-Peff
