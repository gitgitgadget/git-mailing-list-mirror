From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] blame.c: Properly initialize strbuf after calling
 textconv_object(), again
Date: Mon, 7 Nov 2011 12:41:36 -0500
Message-ID: <20111107174136.GA4047@sigill.intra.peff.net>
References: <4EB7FEE6.9000609@gmail.com>
 <20111107164946.GD27055@sigill.intra.peff.net>
 <4EB8166E.9000703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 18:41:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNTCY-0000qJ-Se
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 18:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701Ab1KGRli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 12:41:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35845
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755839Ab1KGRli (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 12:41:38 -0500
Received: (qmail 28246 invoked by uid 107); 7 Nov 2011 17:41:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 12:41:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 12:41:36 -0500
Content-Disposition: inline
In-Reply-To: <4EB8166E.9000703@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185006>

On Mon, Nov 07, 2011 at 06:33:34PM +0100, Sebastian Schuberth wrote:

> 2564aa4 started to initialize buf.alloc, but that should actually be one
> more byte than the string length due to the trailing \0. Also, do not
> modify buf.alloc out of the strbuf code. Use the existing strbuf_attach
> instead.

Heh. When I wrote the previous email I just made up the name
"strbuf_attach" as the opposite of "strbuf_detach". I didn't know it
actually already existed.

> -			    textconv_object(read_from, mode, null_sha1, &buf.buf, &buf_len)) {
> -				buf.alloc = buf_len;
> -				buf.len = buf_len;
> -			}
> +			    textconv_object(read_from, mode, null_sha1, &buf_ptr, &buf_len))
> +				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);

Looks OK to me.

-Peff
