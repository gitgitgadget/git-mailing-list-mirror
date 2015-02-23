From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/4] parse-options: introduce OPT_PATH
Date: Mon, 23 Feb 2015 20:06:57 -0000
Organization: OPDS
Message-ID: <6D98922D49BD42139185BE6A94DDD5DA@PhilipOakley>
References: <20150223144214.GA31624@peff.net> <cccf3d14e5582996e5be1467849121a262f9c9f1.1424707497.git.git@drmicha.warpmail.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, "Junio C Hamano" <gitster@pobox.com>
To: "Michael J Gruber" <git@drmicha.warpmail.net>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 21:06:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPzGZ-0006zh-CC
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 21:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbbBWUGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 15:06:01 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:23781 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751748AbbBWUGA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 15:06:00 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AIHQAih+tUPAj2EFxbgwaBLIMIgy5twWEEAoEoRAEBAQEBAQUBAQEBOCAbhAoGAQUIAQEZFR4BASELAgMFAgEDFQUCBSECAhQBBBoGBwMUBgESCAIBAgMBiAoDFbpvhlOMNCGFPIEhiXKEboJvL4EUBY9SWpNXiEWEED4xgkMBAQE
X-IPAS-Result: A2AIHQAih+tUPAj2EFxbgwaBLIMIgy5twWEEAoEoRAEBAQEBAQUBAQEBOCAbhAoGAQUIAQEZFR4BASELAgMFAgEDFQUCBSECAhQBBBoGBwMUBgESCAIBAgMBiAoDFbpvhlOMNCGFPIEhiXKEboJvL4EUBY9SWpNXiEWEED4xgkMBAQE
X-IronPort-AV: E=Sophos;i="5.09,632,1418083200"; 
   d="scan'208";a="584164897"
Received: from host-92-16-246-8.as13285.net (HELO PhilipOakley) ([92.16.246.8])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 23 Feb 2015 20:05:57 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264292>

From: "Michael J Gruber" <git@drmicha.warpmail.net>
> Many options are paths, but not files. Introduce OPT_PATH which does
> the same path processing as OPT_FILENAME but allows to name the 
> argument.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Documentation/technical/api-parse-options.txt | 5 +++++
> parse-options.h                               | 2 ++
> 2 files changed, 7 insertions(+)
>
> diff --git a/Documentation/technical/api-parse-options.txt 
> b/Documentation/technical/api-parse-options.txt
> index 1f2db31..109903c 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -187,6 +187,11 @@ There are some macros to easily define options:
>  The filename will be prefixed by passing the filename along with
>  the prefix argument of `parse_options()` to `prefix_filename()`.
>
> +`OPT_PATH(short, long, &var, arg_str, description)`::
> + Introduce an option with a path argument named arg_str.
> + The filename will be prefixed by passing the filename along with

I couldn't understand this. Should it be s/filename/pathname/ ? Or am I 
way off topic.

> + the prefix argument of `parse_options()` to `prefix_filename()`.
> +
> `OPT_ARGUMENT(long, description)`::
>  Introduce a long-option argument that will be kept in `argv[]`.
>
> diff --git a/parse-options.h b/parse-options.h
> index 7940bc7..5127a5d 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -149,6 +149,8 @@ struct option {
>    PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
> #define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), 
> \
>         N_("file"), (h) }
> +#define OPT_PATH(s, l, v, a, h)    { OPTION_FILENAME, (s), (l), (v), 
> \
> +        (a), (h) }
> #define OPT_COLOR_FLAG(s, l, v, h) \
>  { OPTION_CALLBACK, (s), (l), (v), N_("when"), (h), PARSE_OPT_OPTARG, 
> \
>  parse_opt_color_flag_cb, (intptr_t)"always" }
> -- 
> 2.3.0.296.g32c87e1
>
> --
Philip 
