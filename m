From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/2] Move unsigned long option parsing out of
 pack-objects.c
Date: Sun, 21 Jun 2015 19:30:26 +0100
Message-ID: <20150621183026.GA7199@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434911144-6781-1-git-send-email-charles@hashpling.org>
 <1434911144-6781-3-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 20:38:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6k89-0000GE-RE
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 20:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086AbbFUSiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 14:38:05 -0400
Received: from avasout05.plus.net ([84.93.230.250]:49798 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbbFUSiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 14:38:04 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2015 14:38:04 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id j6WT1q0012iA9hg016WUrL; Sun, 21 Jun 2015 19:30:28 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=FZvKv8K6 c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=XAFQembCKUMA:10 a=BNFp--SqAAAA:8 a=ka49Ft0f_thh0jzGDiwA:9
 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Z6k0g-0001sX-Vx; Sun, 21 Jun 2015 19:30:26 +0100
Content-Disposition: inline
In-Reply-To: <1434911144-6781-3-git-send-email-charles@hashpling.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272278>

On Sun, Jun 21, 2015 at 07:25:44PM +0100, Charles Bailey wrote:
> From: Charles Bailey <cbailey32@bloomberg.net>
> 
> diff --git a/parse-options.c b/parse-options.c
> index 80106c0..101b649 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -180,6 +180,23 @@ static int get_value(struct parse_opt_ctx_t *p,
>  			return opterror(opt, "expects a numerical value", flags);
>  		return 0;
>  
> +	case OPTION_MAGNITUDE:
> +		if (unset) {
> +			*(unsigned long *)opt->value = 0;
> +			return 0;
> +		}
> +		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
> +			*(unsigned long *)opt->value = opt->defval;
> +			return 0;
> +		}
> +		if (get_arg(p, opt, flags, &arg))
> +			return -1;
> +		if (!git_parse_ulong(arg, opt->value))
> +			return opterror(opt,
> +				"expects a integer value with an optional k/m/g suffix",
> +				flags);
> +		return 0;
> +

Spotted after sending:
s/expects a integer/expects an integer/
