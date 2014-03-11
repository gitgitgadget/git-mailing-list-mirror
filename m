From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Mon, 10 Mar 2014 21:56:03 -0400
Message-ID: <20140311015603.GA12180@sigill.intra.peff.net>
References: <20140308183501.GH18371@serenity.lan>
 <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Guillaume Gelin <contact@ramnes.eu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 02:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNBvP-0004eC-Cx
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 02:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbaCKB4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 21:56:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:36995 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753305AbaCKB4G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 21:56:06 -0400
Received: (qmail 4355 invoked by uid 102); 11 Mar 2014 01:56:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Mar 2014 20:56:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Mar 2014 21:56:03 -0400
Content-Disposition: inline
In-Reply-To: <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243833>

On Sat, Mar 08, 2014 at 07:21:39PM +0000, brian m. carlson wrote:

> We shrink the source and destination arrays, but not the modes or
> submodule_gitfile arrays, resulting in potentially mismatched data.  Shrink
> all the arrays at the same time to prevent this.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/mv.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index f99c91e..b20cd95 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -230,6 +230,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  					memmove(destination + i,
>  						destination + i + 1,
>  						(argc - i) * sizeof(char *));
> +					memmove(modes + i, modes + i + 1,
> +						(argc - i) * sizeof(char *));
> +					memmove(submodule_gitfile + i,
> +						submodule_gitfile + i + 1,
> +						(argc - i) * sizeof(char *));

I haven't looked that closely, but would it be crazy to suggest that
these arrays all be squashed into one array-of-struct? It would be less
error prone and perhaps more readable.

-Peff
