From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] do not depend on signed integer overflow
Date: Mon, 4 Oct 2010 23:43:01 -0400
Message-ID: <20101005034301.GA23357@coredump.intra.peff.net>
References: <1286232552-5244-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 05:42:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2yQF-0005GD-An
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 05:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381Ab0JEDm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 23:42:28 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46245 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728Ab0JEDm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 23:42:28 -0400
Received: (qmail 25832 invoked by uid 111); 5 Oct 2010 03:42:27 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 05 Oct 2010 03:42:27 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Oct 2010 23:43:01 -0400
Content-Disposition: inline
In-Reply-To: <1286232552-5244-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158163>

On Tue, Oct 05, 2010 at 12:49:12AM +0200, Erik Faye-Lund wrote:

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 2e680d7..e243d9d 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -161,7 +161,7 @@ static void use(int bytes)
>  	input_offset += bytes;
>  
>  	/* make sure off_t is sufficiently large not to wrap */
> -	if (consumed_bytes > consumed_bytes + bytes)
> +	if (signed_add_overflows(consumed_bytes, bytes))
>  		die("pack too large for current definition of off_t");
>  	consumed_bytes += bytes;
>  }

FWIW, I find your new version much easier to read, too (that it fixes a
bug is just a nice bonus. ;) ).

-Peff
