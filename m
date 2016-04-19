From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 3/6] verify-tag: change variable name for readability
Date: Tue, 19 Apr 2016 01:13:22 -0400
Message-ID: <20160419051322.GB19439@sigill.intra.peff.net>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
 <1460932021-27633-4-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Tue Apr 19 07:13:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asNyc-0004y3-5g
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 07:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbcDSFN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 01:13:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:51879 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751135AbcDSFNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 01:13:25 -0400
Received: (qmail 5830 invoked by uid 102); 19 Apr 2016 05:13:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 01:13:25 -0400
Received: (qmail 12936 invoked by uid 107); 19 Apr 2016 05:13:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 01:13:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 01:13:22 -0400
Content-Disposition: inline
In-Reply-To: <1460932021-27633-4-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291843>

On Sun, Apr 17, 2016 at 06:26:58PM -0400, santiago@nyu.edu wrote:

> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index 77f070a..010353c 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -21,20 +21,21 @@ static const char * const verify_tag_usage[] = {
>  static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
>  {
>  	struct signature_check sigc;
> -	int len;
> +	int payload_size;
>  	int ret;
>  
>  	memset(&sigc, 0, sizeof(sigc));
>  
> -	len = parse_signature(buf, size);
> +	payload_size = parse_signature(buf, size);

While we're here, can we make payload_size a "size_t"? That is the
return type of parse_signature.

> -	if (size == len) {
> +	if (size == payload_size) {

That would make this a comparison between "unsigned long" and "size_t",
but I doubt it would be the first such place in git. And it works out in
practice, because "unsigned long" is generally at least as large as
"size_t", and if our buffer is larger than "size_t" can store, we'd have
failed long before, when trying to allocate the buffer.

We could make "size" also a "size_t", but I suspect then we'd just be
bumping the mismatch out to its caller.

-Peff
