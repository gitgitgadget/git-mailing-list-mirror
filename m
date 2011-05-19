From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] notes remove: --stdin reads from the standard input
Date: Thu, 19 May 2011 06:50:09 -0400
Message-ID: <20110519105009.GA11107@sigill.intra.peff.net>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com>
 <1305764061-21303-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 12:50:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN0oA-0007Qu-2O
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 12:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab1ESKuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 06:50:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37003
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907Ab1ESKuO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 06:50:14 -0400
Received: (qmail 14695 invoked by uid 107); 19 May 2011 10:52:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 06:52:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 06:50:09 -0400
Content-Disposition: inline
In-Reply-To: <1305764061-21303-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173948>

On Wed, May 18, 2011 at 05:14:21PM -0700, Junio C Hamano wrote:

> +	if (from_stdin) {
> +		struct strbuf sb = STRBUF_INIT;
> +		while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
> +			int len = sb.len;
> +			if (len && sb.buf[len - 1] == '\n')
> +				sb.buf[--len] = '\0';
> +			retval |= remove_one_note(t, sb.buf, flag);
> +		}
> +	}

Wouldn't strbuf_rtrim (or even strbuf_trim) be useful here?

Manipulating only a copy of the len parameter while changing the strbuf
itself raised warning flags, though it is correct as-is because you
never actually use sb.len.

Using strbuf_trim is shorter, easier to read, and will helpfully eat any
extraneous whitespace, too.

-Peff
