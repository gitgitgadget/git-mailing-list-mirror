From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] diff: Do not warn about missing EOL at EOF for
 symlinks
Date: Thu, 3 Jun 2010 13:02:44 -0400
Message-ID: <20100603170244.GA22779@coredump.intra.peff.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
 <c1e0646449aae50fb962108d16b5428fb7d73bae.1275575236.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 03 19:02:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKDoi-0003VA-DH
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 19:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756577Ab0FCRCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 13:02:47 -0400
Received: from peff.net ([208.65.91.99]:49774 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754178Ab0FCRCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 13:02:47 -0400
Received: (qmail 32063 invoked by uid 107); 3 Jun 2010 17:02:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 03 Jun 2010 13:02:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jun 2010 13:02:44 -0400
Content-Disposition: inline
In-Reply-To: <c1e0646449aae50fb962108d16b5428fb7d73bae.1275575236.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148347>

On Thu, Jun 03, 2010 at 04:35:22PM +0200, Michael J Gruber wrote:

> diff --git a/diff.c b/diff.c
> index 7950df6..cad7339 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1788,6 +1788,8 @@ static void builtin_diff(const char *name_a,
>  		ecbdata.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
>  		ecbdata.found_changesp = &o->found_changes;
>  		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
> +		if (DIFF_OPT_TST(o, ALLOW_TEXTCONV) && (S_ISLNK(one->mode) || S_ISLNK(two->mode)))
> +			ecbdata.ws_rule &= ~WS_NO_EOL_AT_EOF;

I see why you would use ALLOW_TEXTCONV to control this behavior, since
textconv by definition creates patches you can't apply. But it feels a
little hack-ish to me, as textconv is really something different. You
seem to want a "--allow-diff-which-cant-be-applied".

-Peff
