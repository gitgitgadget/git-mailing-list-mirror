From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Mon, 24 Aug 2009 21:57:26 -0400
Message-ID: <20090825015726.GB7655@coredump.intra.peff.net>
References: <1251146568-25248-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Tue Aug 25 03:58:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MflJI-0002ME-SJ
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 03:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbZHYB50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 21:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbZHYB50
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 21:57:26 -0400
Received: from peff.net ([208.65.91.99]:59031 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094AbZHYB5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 21:57:25 -0400
Received: (qmail 12972 invoked by uid 107); 25 Aug 2009 01:57:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 24 Aug 2009 21:57:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2009 21:57:26 -0400
Content-Disposition: inline
In-Reply-To: <1251146568-25248-1-git-send-email-catap@catap.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126988>

On Tue, Aug 25, 2009 at 12:42:48AM +0400, Kirill A. Korinskiy wrote:

> Sometimes (especially on production systems) we need to use only one
> remote branch for building software. It really annoying to clone
> origin and then swith branch by hand everytime. So this patch provide
> functionality to clone remote branch with one command without using
> checkout after clone.

If you are doing this a lot, it is probably a sign that you should
repoint the "HEAD" of the parent repository.

That being said, you may want one branch half the time, and another
branch the other half. So I think this is a good feature.

A few comments:

> ---
>  Documentation/git-clone.txt |    4 ++++
>  builtin-clone.c             |   26 +++++++++++++++++++++++---
>  2 files changed, 27 insertions(+), 3 deletions(-)

Tests?

> -	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
> -	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
> +	const struct ref *refs, *head_points_at, *remote_head = NULL, *mapped_refs;
> +	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT, branch_head = STRBUF_INIT;

Style nit: I don't know if we have a style guideline for declaring
variables, but I find these "many variables on a line" declarations
annoying for reviewing, since it is hard to see what actually changed
(and yes, you only added a declaration on one, so I am partially
complaining about the person who came before you :) ).

> +		if (option_branch)
> +			die("--bare and --branch %s options are incompatible.",
> +			    option_branch);

Hmm. Would it perhaps make sense to have "--bare --branch foo" point the
HEAD of the newly created bare repo, but not impact the (nonexistent)
working tree?

-Peff
