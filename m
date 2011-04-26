From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] t0081-*.sh: Fix failure of the 'long read' tests
Date: Tue, 26 Apr 2011 19:48:51 -0400
Message-ID: <20110426234850.GC32491@sigill.intra.peff.net>
References: <4DB70972.20308@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 27 01:49:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEs03-0004U1-1d
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 01:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab1DZXsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 19:48:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57626
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909Ab1DZXsy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 19:48:54 -0400
Received: (qmail 21169 invoked by uid 107); 26 Apr 2011 23:50:34 -0000
Received: from c-67-172-212-47.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.212.47)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Apr 2011 19:50:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Apr 2011 19:48:51 -0400
Content-Disposition: inline
In-Reply-To: <4DB70972.20308@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172137>

On Tue, Apr 26, 2011 at 07:05:38PM +0100, Ramsay Jones wrote:

> The infinite loop is caused by the loop variable increment
> expression, which looks something like this:
> 
>     : $((i = $i + 1)) || return
>
> [...]
>
> The reason for the RFC is that I don't understand why (apparently)
> I'm the only person seeing this failure; I suspect that a newer
> version of bash than I have does not have this problem (ie the
> original arithmetic expansion actually works). dunno :-(

Yeah, that syntax is handled just fine by my bash and dash:

  $ cat >foo.sh <<'EOF'
  i=1
  : $((i = $i + 1))
  echo $i
  EOF

  $ bash foo.sh
  2
  $ bash --version | head -n 1
  GNU bash, version 4.1.5(1)-release (x86_64-pc-linux-gnu)

  $ dash foo.sh
  2

But I think your i=$(($i + 1)) is the right solution.

-Peff
