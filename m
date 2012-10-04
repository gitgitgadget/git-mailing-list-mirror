From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] log --grep: use the same helper to set -E/-F options
 as "git grep"
Date: Thu, 4 Oct 2012 04:09:47 -0400
Message-ID: <20121004080947.GB31305@sigill.intra.peff.net>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
 <1349314419-8397-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:08:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUo-0001w8-92
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab2JDIJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 04:09:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40498 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446Ab2JDIJu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 04:09:50 -0400
Received: (qmail 17916 invoked by uid 107); 4 Oct 2012 08:10:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 04:10:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 04:09:47 -0400
Content-Disposition: inline
In-Reply-To: <1349314419-8397-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206969>

On Wed, Oct 03, 2012 at 06:33:36PM -0700, Junio C Hamano wrote:

> diff --git a/revision.c b/revision.c
> index a09e60b..7f5e53b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1604,12 +1604,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--grep-debug")) {
>  		revs->grep_filter.debug = 1;
>  	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
> -		revs->grep_filter.regflags |= REG_EXTENDED;
> +		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, &revs->grep_filter);
>  	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
>  		revs->grep_filter.regflags |= REG_ICASE;
>  		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
>  	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
> -		revs->grep_filter.fixed = 1;
> +		grep_set_pattern_type_option(GREP_PATTERN_TYPE_FIXED, &revs->grep_filter);

Very nice. After seeing the discussion on regexp types in your G+ feed,
I took a 5-minute look at this code last night and noticed the same
oddity. At which point I gave up looking at it for the evening, thinking
to come back to it later. And here my procrastination is rewarded. :)

-Peff
