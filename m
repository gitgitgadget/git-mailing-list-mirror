From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin/push.c: make push_default a static variable
Date: Wed, 18 Feb 2015 13:50:08 -0500
Message-ID: <20150218185007.GA7257@peff.net>
References: <20150216054550.GA24611@peff.net>
 <20150216054754.GB25088@peff.net>
 <20150217104628.GA25978@peff.net>
 <xmqqsie4300s.fsf@gitster.dls.corp.google.com>
 <20150217182324.GA12816@peff.net>
 <xmqqzj8cyyip.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 19:50:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9hQ-0006Cd-I3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 19:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152AbbBRSuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 13:50:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:50599 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752586AbbBRSuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 13:50:10 -0500
Received: (qmail 3515 invoked by uid 102); 18 Feb 2015 18:50:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 12:50:09 -0600
Received: (qmail 19722 invoked by uid 107); 18 Feb 2015 18:50:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 13:50:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2015 13:50:08 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzj8cyyip.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264041>

On Tue, Feb 17, 2015 at 02:16:30PM -0800, Junio C Hamano wrote:

> Do you want to resurrect that @{publish} stuff?  I think it had
> sensible semantics, and I do not think we mind keeping the
> push_default configuration to be read from the default_config
> codepath.

I'll take a look at it and see if it's in good enough shape to apply
as-is, or with minor tweaking. But regardless, let's...

> If we decide to go that route, then the series would become
> something like this:
> 
> $gmane/263871 [1/4] git_push_config: drop cargo-culted wt_status pointer
> $gmane/263878 [2/4] cmd_push: set "atomic" bit directly
> $gmane/263879 [3/4] cmd_push: pass "flags" pointer to config callback
> $gmane/263880 [4/4] push: allow --follow-tags to be set by config push.followTags
> 
> omitting the original 2/2 patch we are discussing.  I am inclined to
> replace what I queued with the above four.

...do this. Even if we don't apply other patches to make use of
push_default immediately, it's a plausible area for us to touch later,
and the cleanup from the dropped patch was not so important.

> +	if (!strcmp(k, "push.followtags")) {
> +		if (git_config_bool(k, v))
> +			*flags |= TRANSPORT_PUSH_FOLLOW_TAGS;
> +		else
> +			*flags &= ~TRANSPORT_PUSH_FOLLOW_TAGS;
> +		return 0;
> +	}

Did you have an opinion on sticking this behind a helper function?

It feels like a lot of repeating of the same variables and flags, but I
worried that "munge_bit" ends up being even more confusing.

-Peff
