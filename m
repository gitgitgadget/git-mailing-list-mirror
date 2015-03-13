From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/4] git-credential-store: support multiple credential
 files
Date: Fri, 13 Mar 2015 02:15:30 -0400
Message-ID: <20150313061530.GA24588@peff.net>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
 <1426056553-9364-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 07:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWIsl-0006PQ-1J
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 07:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbbCMGPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 02:15:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:60851 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751247AbbCMGPd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 02:15:33 -0400
Received: (qmail 1987 invoked by uid 102); 13 Mar 2015 06:15:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Mar 2015 01:15:33 -0500
Received: (qmail 10210 invoked by uid 107); 13 Mar 2015 06:15:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Mar 2015 02:15:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2015 02:15:31 -0400
Content-Disposition: inline
In-Reply-To: <1426056553-9364-2-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265402>

On Wed, Mar 11, 2015 at 02:49:10PM +0800, Paul Tan wrote:

> Previously, git-credential-store only supported storing credentials in a
> single file: ~/.git-credentials. In order to support the XDG base
> directory specification[1], git-credential-store needs to be able to
> lookup and erase credentials from multiple files, as well as to pick the
> appropriate file to write to so that the credentials can be found on
> subsequent lookups.

I looked over the code here and in the second patch, and I didn't see
any real problems. Thanks for iterating on this.

Two minor nits, that might not even be worth addressing:

> +static void store_credential(const struct string_list *fns, struct credential *c,
> +			     const char *default_fn)

I think you could even get away without passing default_fn here, and
just use the rule "the first file in the list is the default". Unless
you are anticipating ever passing something else, but I couldn't think
of a case where that would be useful.

> +	struct string_list fns = STRING_LIST_INIT_NODUP;

This is declared NODUP...

> -	if (!file)
> +	if (file)
> +		string_list_append_nodup(&fns, file);

So you can just call the regular string_list_append here (the idea of
declaring the list as DUP or NODUP is that the callers do not have to
care; string_list_append does the right thing).

-Peff
