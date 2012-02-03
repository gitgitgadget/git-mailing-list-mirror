From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Fri, 3 Feb 2012 16:55:07 -0500
Message-ID: <20120203215507.GB3472@sigill.intra.peff.net>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120202200240.GC9246@sigill.intra.peff.net>
 <7vr4ycu3ty.fsf@alter.siamese.dyndns.org>
 <20120203120657.GB31441@sigill.intra.peff.net>
 <7v7h03odyo.fsf@alter.siamese.dyndns.org>
 <20120203212604.GA1890@sigill.intra.peff.net>
 <7vr4ybmvrq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 22:55:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtR6D-0005kK-9B
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 22:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757984Ab2BCVzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 16:55:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56044
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754987Ab2BCVzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 16:55:09 -0500
Received: (qmail 2617 invoked by uid 107); 3 Feb 2012 22:02:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 17:02:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 16:55:07 -0500
Content-Disposition: inline
In-Reply-To: <7vr4ybmvrq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189812>

On Fri, Feb 03, 2012 at 01:50:33PM -0800, Junio C Hamano wrote:

> >   write_script foo.sh "$SHELL_PATH" <<-\EOF
> >     echo my arguments are "$@"
> >   EOF
> 
> I first thought that the order of parameters were unusual, but with that
> order, you could even go something fancier like:
> 
> 	write_script () {
> 		case "$#" in
> 		1)	case "$1" in
> 			*.perl | *.pl) echo "#!$PERL_PATH" ;;
> 			*) echo "#!$SHELL_PATH" ;;
> 			esac
>                 2)	echo "#!$2" ;;
> 		*)	BUG ;;
>                 esac >"$1" &&
>                 cat >>"$1" &&
>                 chmod +x "$1"
> 	}
> 

Nice. I was going to suggest a wrapper like "write_sh_script" so you
didn't have to spell out $SHELL_PATH, but I think the auto-detection
makes sense (and falling back to shell makes even more sense, as that
covers 99% of the cases anyway).

-Peff
