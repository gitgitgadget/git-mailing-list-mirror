From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] reflog_expire(): ignore --updateref for symbolic
 references
Date: Thu, 12 Feb 2015 16:54:21 -0500
Message-ID: <20150212215421.GA19618@peff.net>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
 <1423473164-6011-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:54:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM1iO-0004pm-Up
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 22:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbbBLVyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 16:54:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:48394 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750959AbbBLVyY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 16:54:24 -0500
Received: (qmail 4747 invoked by uid 102); 12 Feb 2015 21:54:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Feb 2015 15:54:24 -0600
Received: (qmail 28141 invoked by uid 107); 12 Feb 2015 21:54:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Feb 2015 16:54:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Feb 2015 16:54:21 -0500
Content-Disposition: inline
In-Reply-To: <1423473164-6011-7-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263772>

On Mon, Feb 09, 2015 at 10:12:42AM +0100, Michael Haggerty wrote:

>  	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
> +		/*
> +		 * It doesn't make sense to adjust a reference pointed
> +		 * to by a symbolic ref based on expiring entries in
> +		 * the symbolic reference's reflog.
> +		 */
> +		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
> +			~(type & REF_ISSYMREF);
> +

Isn't this second clause tautological? Unless REF_ISSYMREF covers all
bits in "type", then "type & REF_ISSYMREF" must always have at least one
bit 0, and negating it becomes non-zero. Did you mean:

   !(type & REF_ISSYMREF)

?

-Peff
