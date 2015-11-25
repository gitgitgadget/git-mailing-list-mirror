From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] git rev-list doesn't complain when repo is empty
Date: Wed, 25 Nov 2015 04:10:11 -0500
Message-ID: <20151125091010.GD4696@sigill.intra.peff.net>
References: <CA+izobv6OuAAjnKH5A=vcmJh3yDhWi41WAD-OmVSN2d7P_5SGA@mail.gmail.com>
 <1448434853-7527-1-git-send-email-apahlevan@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: atousa.p@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 25 10:10:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1W5r-0001eG-F8
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 10:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101AbbKYJKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 04:10:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:33761 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754721AbbKYJKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 04:10:13 -0500
Received: (qmail 28254 invoked by uid 102); 25 Nov 2015 09:10:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 03:10:13 -0600
Received: (qmail 24381 invoked by uid 107); 25 Nov 2015 09:10:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 04:10:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2015 04:10:11 -0500
Content-Disposition: inline
In-Reply-To: <1448434853-7527-1-git-send-email-apahlevan@ieee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281689>

On Tue, Nov 24, 2015 at 11:00:53PM -0800, atousa.p@gmail.com wrote:

> From: Atousa Pahlevan Duprat <apahlevan@ieee.org>
> 
> Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
> ---
>  builtin/rev-list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index d80d1ed..f71b87f 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -348,7 +348,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
>  	      !revs.pending.nr)) ||
>  	    revs.diff)
> -		usage(rev_list_usage);
> +               return 0; // empty repo

Even if we were to agree that rev-list should exit with code 0 for "git
rev-list --all" in an empty repo, I do not think this patch is the right
way to do it. It also catches:

  git rev-list

with no arguments in a non-empty repository, which should produce a
usage() message.

-Peff
