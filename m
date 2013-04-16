From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 16/33] t3210: test for spurious error messages for
 dangling packed refs
Date: Tue, 16 Apr 2013 19:57:12 -0400
Message-ID: <20130416235712.GA20585@sigill.intra.peff.net>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-17-git-send-email-mhagger@alum.mit.edu>
 <7vobdfvglf.fsf@alter.siamese.dyndns.org>
 <516D5CC6.10505@alum.mit.edu>
 <7vip3mhxhq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 01:57:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USFkW-0002Be-6n
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 01:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359Ab3DPX5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 19:57:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48600 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140Ab3DPX5P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 19:57:15 -0400
Received: (qmail 25946 invoked by uid 107); 16 Apr 2013 23:59:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Apr 2013 19:59:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Apr 2013 19:57:12 -0400
Content-Disposition: inline
In-Reply-To: <7vip3mhxhq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221491>

On Tue, Apr 16, 2013 at 04:22:25PM -0700, Junio C Hamano wrote:

> +static void parse_expire_value(const char *value, unsigned long *expire)
> +{
> +	if (!strcmp(value, "never") || !strcmp(value, "false"))
> +		*expire = 0;
> +	else if (!strcmp(value, "all") || !strcmp(value, "now"))
> +		/*
> +		 * We take over "now" here, which usually translates
> +		 * to the current timestamp, because the user really
> +		 * means everything she has done in the past, and by
> +		 * definition reflogs are the record of the past,
> +		 * there is nothing from the future to be kept.
> +		 */
> +		*expire = ULONG_MAX;
> +	else
> +		*expire = approxidate(value);
> +}

Do we want to use approxidate_careful here to catch other junk?

-Peff
