From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] shortlog: replace hand-parsing of author with
 pretty-printer
Date: Mon, 18 Jan 2016 15:13:38 -0500
Message-ID: <20160118201337.GA15943@sigill.intra.peff.net>
References: <20160118200136.GA9514@sigill.intra.peff.net>
 <20160118200248.GC15836@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 21:13:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLGBM-00007I-Jr
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 21:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215AbcARUNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 15:13:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:55672 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755979AbcARUNk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 15:13:40 -0500
Received: (qmail 324 invoked by uid 102); 18 Jan 2016 20:13:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:13:40 -0500
Received: (qmail 13611 invoked by uid 107); 18 Jan 2016 20:14:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:14:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 15:13:38 -0500
Content-Disposition: inline
In-Reply-To: <20160118200248.GC15836@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284321>

On Mon, Jan 18, 2016 at 03:02:48PM -0500, Jeff King wrote:

> +	format_commit_message(commit, "%an <%ae>", &author, &ctx);
> +	/* we can detect a total failure only by seeing " <>" in the output */
> +	if (author.len <= 3) {
>  		warning(_("Missing author: %s"),
>  		    oid_to_hex(&commit->object.oid));
> [...]
> +		goto out;
>  	}

One note on this. In the linux.git tree, this warning actually triggers,
because there is a commit with a bogus empty author:

  $ git log -1 --format=raw af25e94d4dc | grep ^author
  author  <> 1120285620 -0700

Whereas in the original code, you really do get a line with a blank
name.

I think what the new code does is quite reasonable, but I'm not sure if:

  1. People really want a syntactically valid empty name to be
     represented.

and

  2. Regardless of the output, if kernel folks will be annoyed by the
     warning whenever they run a full-repo shortlog.

-Peff
