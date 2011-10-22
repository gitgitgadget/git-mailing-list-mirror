From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] credential-cache--daemon.c: unlink() a potentially
 stale unix socket
Date: Sat, 22 Oct 2011 15:19:06 -0400
Message-ID: <20111022191905.GD1785@sigill.intra.peff.net>
References: <4EA2FCA0.70002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:19:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHh6C-0004Se-5v
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab1JVTTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:19:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39605
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583Ab1JVTTL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:19:11 -0400
Received: (qmail 30379 invoked by uid 107); 22 Oct 2011 19:19:19 -0000
Received: from mc64036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.64.198)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Oct 2011 15:19:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Oct 2011 15:19:06 -0400
Content-Disposition: inline
In-Reply-To: <4EA2FCA0.70002@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184119>

On Sat, Oct 22, 2011 at 06:25:52PM +0100, Ramsay Jones wrote:

> diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
> index ee2c15a..c5fb1b2 100644
> --- a/credential-cache--daemon.c
> +++ b/credential-cache--daemon.c
> @@ -230,6 +230,7 @@ static void serve_cache(const char *socket_path)
>  {
>  	int fd;
>  
> +	unlink(socket_path);
>  	fd = unix_stream_listen(socket_path);
>  	if (fd < 0)
>  		die_errno("unable to bind to '%s'", socket_path);

I think this is a sane thing to do, if it's more portable. We can just
get rid of the double-bind attempt in unix_stream_listen, now. I suspect
this unlink should probably just go directly into unix_stream_listen,
too.

-Peff
