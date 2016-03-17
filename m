From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2/GSoC 4/4] t0301: test credential-cache support of
 XDG_RUNTIME_DIR
Date: Thu, 17 Mar 2016 14:08:12 -0400
Message-ID: <20160317180811.GA23669@sigill.intra.peff.net>
References: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
 <1458233326-7735-4-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, pickfire@riseup.net
To: Hui Yiqun <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:08:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcLM-0003DO-LK
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936295AbcCQSIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 14:08:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:33518 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934165AbcCQSIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 14:08:14 -0400
Received: (qmail 16794 invoked by uid 102); 17 Mar 2016 18:08:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Mar 2016 14:08:14 -0400
Received: (qmail 2841 invoked by uid 107); 17 Mar 2016 18:08:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Mar 2016 14:08:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2016 14:08:12 -0400
Content-Disposition: inline
In-Reply-To: <1458233326-7735-4-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289134>

On Fri, Mar 18, 2016 at 12:48:46AM +0800, Hui Yiqun wrote:

> t0301 now tests git-credential-cache support for XDG user-specific
> runtime file $XDG_RUNTIME_DIR/git/credential.sock. Specifically:
> 
> * if $XDG_RUNTIME_DIR exists, use socket at
>   `$XDG_RUNTIME_DIR/git/credential-cache.sock`.
> 
> * otherwise, `/tmp/git-$uid/credential-cache.sock` is taken.
> 
> Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
> ---
>  t/t0301-credential-cache.sh | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
> index 82c8411..892d1ba 100755
> --- a/t/t0301-credential-cache.sh
> +++ b/t/t0301-credential-cache.sh
> @@ -12,7 +12,34 @@ test -z "$NO_UNIX_SOCKETS" || {
>  # don't leave a stale daemon running
>  trap 'code=$?; git credential-cache exit; (exit $code); die' EXIT
>  
> +test_expect_success 'set $XDG_RUNTIME_DIR' '
> +	XDG_RUNTIME_DIR=$HOME/xdg_runtime/
> +'
> +
> +helper_test cache
> +
> +test_expect_success 'when $XDG_RUNTIME_DIR is set, `$XDG_RUNTIME_DIR/git` are used' '
> +	test_path_is_missing "/tmp/git-$(id -u)/git/credential-cache.sock" &&
> +	test -S "$HOME/xdg_runtime/git/credential-cache.sock"
> +'

This test fails for me, probably because XDG_RUNTIME_DIR is not
exported.

-Peff
