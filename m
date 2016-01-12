From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/2] builtin/grep: add grep.fallbackToNoIndex config
Date: Tue, 12 Jan 2016 07:11:07 -0500
Message-ID: <20160112121106.GA18512@sigill.intra.peff.net>
References: <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
 <1452595226-14616-1-git-send-email-t.gummerer@gmail.com>
 <1452595226-14616-3-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	gitster@pobox.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 13:11:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIxnL-0001tO-NU
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 13:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbcALMLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 07:11:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:52147 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752003AbcALMLM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 07:11:12 -0500
Received: (qmail 26881 invoked by uid 102); 12 Jan 2016 12:11:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 07:11:12 -0500
Received: (qmail 13417 invoked by uid 107); 12 Jan 2016 12:11:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 07:11:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 07:11:07 -0500
Content-Disposition: inline
In-Reply-To: <1452595226-14616-3-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283813>

On Tue, Jan 12, 2016 at 11:40:26AM +0100, Thomas Gummerer wrote:

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 4229cae..6b7add6 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -755,9 +755,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  	grep_commit_pattern_type(pattern_type_arg, &opt);
>  
> -	if (use_index && !startup_info->have_repository)
> -		/* die the same way as if we did it at the beginning */
> -		setup_git_directory();
> +	if (use_index && !startup_info->have_repository) {
> +		int fallback = 0;
> +		git_config_get_bool("grep.fallbacktonoindex", &fallback);
> +		if (fallback)
> +			use_index = 0;
> +		else
> +			/* die the same way as if we did it at the beginning */
> +			setup_git_directory();
> +	}
>  
>  	/*
>  	 * skip a -- separator; we know it cannot be

Nice. This turned out delightfully simple.

-Peff
