From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v2] grep: correctly initialize help-all option
Date: Fri, 10 Apr 2015 18:35:31 +0200
Message-ID: <5527FBD3.4000103@web.de>
References: <1428586916-22679-1-git-send-email-ps@pks.im> <1428609546-3535-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 18:35:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ygbu9-0003N1-Gu
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 18:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbbDJQfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2015 12:35:37 -0400
Received: from mout.web.de ([212.227.15.3]:58790 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754539AbbDJQfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2015 12:35:36 -0400
Received: from [192.168.178.27] ([79.250.171.213]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LfiZ8-1ZCrG903NS-00pJDr; Fri, 10 Apr 2015 18:35:35
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1428609546-3535-1-git-send-email-ps@pks.im>
X-Provags-ID: V03:K0:kLXfUBG/3yBv6NKylb89j/LW6LsFNMZ9HuIEXsk41kZ8YacgYFf
 81RYgIv5N8YVCoBrVyEl232VBoJqJytsomwjLxd+Ieyln8jxqJoDh8g8NS0dobnLJ9u+sHE
 xKcsCAulDistPpxPL6FWZflOwbAb+5eWWl1bpmKOqo/bHFQgHiSBW5uAouLajD9H2wGo4In
 4qp3+K3bpasXzm8sZNGdQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267015>

Am 09.04.2015 um 21:59 schrieb Patrick Steinhardt:
> The "help-all" option is being initialized with a wrong value.
> While being semantically wrong this can also cause a segmentation
> fault in gcc on ARMv7 hardfloat platforms with a hardened
> toolchain. Fix this by initializing with a NULL value.

Because the pointer is not used it can't exactly be "wrong".  The 
callback function could call usage_with_options itself using that 
pointer, for example.  I suspect that's what an earlier version did (I 
don't remember).

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>
> Added missing sign-off and changed initialization with &opts to
> initialization with NULL according to Eric's comment as the value
> is not being used anyway.

Thanks, it looks good.

>
>   builtin/grep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index abc4400..d04f440 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -738,7 +738,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>   			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
>   		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
>   			 N_("allow calling of grep(1) (ignored by this build)")),
> -		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, N_("show usage"),
> +		{ OPTION_CALLBACK, 0, "help-all", NULL, NULL, N_("show usage"),
>   		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
>   		OPT_END()
>   	};
>
