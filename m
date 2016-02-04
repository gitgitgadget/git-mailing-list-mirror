From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 13/20] refs: resolve symbolic refs first
Date: Thu, 4 Feb 2016 02:37:42 -0500
Message-ID: <20160204073742.GA20162@sigill.intra.peff.net>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
 <1452788777-24954-14-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 08:37:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aREUB-0006t2-0Y
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 08:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080AbcBDHhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 02:37:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:37233 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754873AbcBDHhp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 02:37:45 -0500
Received: (qmail 14592 invoked by uid 102); 4 Feb 2016 07:37:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 02:37:45 -0500
Received: (qmail 32408 invoked by uid 107); 4 Feb 2016 07:37:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 02:37:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Feb 2016 02:37:42 -0500
Content-Disposition: inline
In-Reply-To: <1452788777-24954-14-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285401>

On Thu, Jan 14, 2016 at 11:26:10AM -0500, David Turner wrote:

> +static int dereference_symrefs(struct ref_transaction *transaction,
> +			       struct strbuf *err)
> +{
> +	int i;
> +	int nr = transaction->nr;
> +
> +	for (i = 0; i < nr; i++) {
> +		struct ref_update *update = transaction->updates[i];
> +		const char *resolved;
> +		unsigned char sha1[20];
> +		int resolve_flags = 0;
> +		int mustexist = (update->old_sha1 &&
> +				 !is_null_sha1(update->old_sha1));

Coverity complains about this last line, as "update->old_sha1" is an
array. I think you want to check "update->flags & REF_HAVE_OLD" instead?

-Peff
