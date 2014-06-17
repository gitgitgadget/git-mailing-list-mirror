From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] http: fix charset detection of extract_content_type()
Date: Tue, 17 Jun 2014 17:40:28 -0400
Message-ID: <20140617214025.GB18994@sigill.intra.peff.net>
References: <CAFT+Tg-d6hBact67bjnc2NFghtmBtr7tyuBvA4_QWgz71eJv_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Yi, EungJun" <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:40:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx17T-0004f5-W9
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 23:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965436AbaFQVke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 17:40:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:46393 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965147AbaFQVkd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 17:40:33 -0400
Received: (qmail 29734 invoked by uid 102); 17 Jun 2014 21:40:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jun 2014 16:40:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2014 17:40:28 -0400
Content-Disposition: inline
In-Reply-To: <CAFT+Tg-d6hBact67bjnc2NFghtmBtr7tyuBvA4_QWgz71eJv_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251958>

On Wed, Jun 18, 2014 at 12:29:59AM +0900, Yi, EungJun wrote:

> From: Yi EungJun <eungjun.yi@navercorp.com>
> 
> extract_content_type() could not extract a charset parameter if the
> parameter is not the first one and there is a whitespace and a following
> semicolon just before the parameter. For example:
> 
>     text/plain; format=fixed ;charset=utf-8
> 
> And it also could not handle correctly some other cases, such as:
> 
>     text/plain; charset=utf-8; format=fixed
>     text/plain; some-param="a long value with ;semicolons;"; charset=utf-8
> 
> Thanks-to: Jeff King <peff@peff.net>
> Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
> ---

Thanks, the patch content looks good here, but...

> diff --git a/http.c b/http.c
> index 2b4f6a3..3a28b21 100644
> --- a/http.c
> +++ b/http.c
> @@ -927,7 +927,7 @@ static int extract_param(const char *raw, const char *name,
>   return -1;
>   raw++;
> 
> - while (*raw && !isspace(*raw))
> + while (*raw && !isspace(*raw) && *raw != ';')
>   strbuf_addch(out, *raw++);
>   return 0;

It looks like your patch has been whitespace-damaged.

-Peff
