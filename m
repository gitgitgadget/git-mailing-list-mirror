From: Jeff King <peff@peff.net>
Subject: Re: diff --stat
Date: Tue, 14 Feb 2012 16:53:18 -0500
Message-ID: <20120214215318.GA24802@sigill.intra.peff.net>
References: <7v4nuub7el.fsf@alter.siamese.dyndns.org>
 <20120214195036.GD12072@sigill.intra.peff.net>
 <7vfwed6uws.fsf@alter.siamese.dyndns.org>
 <20120214202934.GA23291@sigill.intra.peff.net>
 <7vty2t5bmw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:53:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQJT-0008DH-DZ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760478Ab2BNVxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 16:53:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35947
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757303Ab2BNVxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:53:22 -0500
Received: (qmail 12362 invoked by uid 107); 14 Feb 2012 22:00:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 17:00:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 16:53:18 -0500
Content-Disposition: inline
In-Reply-To: <7vty2t5bmw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190769>

On Tue, Feb 14, 2012 at 01:49:11PM -0800, Junio C Hamano wrote:

>  static int scale_linear(int it, int width, int max_change)
>  {
> +	if (!it)
> +		return 0;
>  	/*
> -	 * make sure that at least one '-' is printed if there were deletions,
> -	 * and likewise for '+'.
> +	 * make sure that at least one '-' or '+' is printed if
> +	 * there is any change to this path. The easiest way is to
> +	 * scale linearly as if all the quantities were one smaller
> +	 * than they actually are, and then add one to the result.
>  	 */
>  	if (max_change < 2)
> -		return it;
> -	return ((it - 1) * (width - 1) + max_change - 1) / (max_change - 1);
> +		return 1;
> +	return 1 + ((it - 1) * (width - 1) / (max_change - 1));

I'm not sure I understand why the "it - 1" and "max_change - 1" bits are
still there, or what they are doing in the first place. I.e., why is it
not simply "scale linearly to width-1, then add 1" as I posted earlier?

-Peff
