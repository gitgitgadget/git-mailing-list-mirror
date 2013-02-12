From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 4/6] Git.pm: allow pipes to be closed prior to calling
 command_close_bidi_pipe
Date: Tue, 12 Feb 2013 15:51:41 -0500
Message-ID: <20130212205141.GC25330@sigill.intra.peff.net>
References: <cover.1360677646.git.mina86@mina86.com>
 <3bb6b7736eb4b0a958469be13d8c646faec1208a.1360677646.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 21:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Mq3-0003xk-GU
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759053Ab3BLUv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:51:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45480 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758289Ab3BLUvn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:51:43 -0500
Received: (qmail 5536 invoked by uid 107); 12 Feb 2013 20:53:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Feb 2013 15:53:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Feb 2013 15:51:41 -0500
Content-Disposition: inline
In-Reply-To: <3bb6b7736eb4b0a958469be13d8c646faec1208a.1360677646.git.mina86@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216196>

On Tue, Feb 12, 2013 at 03:02:31PM +0100, Michal Nazarewicz wrote:

>  sub command_close_bidi_pipe {
>  	local $?;
>  	my ($self, $pid, $in, $out, $ctx) = _maybe_self(@_);
> -	_cmd_close($ctx, $in, $out);
> +	_cmd_close($ctx, grep defined, $in, $out);

Maybe it is just me, but I find the "grep EXPR" form a little subtle
inside an argument list. Either:

  _cmd_close($ctx, grep { defined } $in, $out);

or

  _cmd_close($ctx, grep(defined, $in, $out));

is a little more obvious to me.

-Peff
