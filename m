From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2 jk/war-on-sprintf] read_branches_file: plug a FILE*
 leak
Date: Fri, 23 Oct 2015 07:19:03 -0400
Message-ID: <20151023111903.GA14996@sigill.intra.peff.net>
References: <2c89c60e470def8f85941933c9fafe4db314628a.1445579874.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-for-windows@googlegroups.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Oct 23 13:19:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpaNM-0002jh-Sy
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 13:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbbJWLTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 07:19:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:46933 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751896AbbJWLTH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 07:19:07 -0400
Received: (qmail 27589 invoked by uid 102); 23 Oct 2015 11:19:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Oct 2015 06:19:06 -0500
Received: (qmail 26548 invoked by uid 107); 23 Oct 2015 11:19:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Oct 2015 07:19:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Oct 2015 07:19:03 -0400
Content-Disposition: inline
In-Reply-To: <2c89c60e470def8f85941933c9fafe4db314628a.1445579874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280091>

On Fri, Oct 23, 2015 at 08:02:51AM +0200, Johannes Sixt wrote:

> The earlier rewrite f28e3ab2 (read_branches_file: simplify string handling)
> of read_branches_file() lost an fclose() call. Put it back.
> 
> As on Windows files that are open cannot be removed, the leak manifests in
> a failure of 'git remote rename origin origin' when the remote's URL is
> specified in .git/branches/origin, because by the time that the command
> attempts to remove this file, it is still open.

Thanks for catching. This was due to my last-minute rewrite of
strbuf_read_file into fopen/strbuf_getline. Your patch looks good to me.

-Peff
