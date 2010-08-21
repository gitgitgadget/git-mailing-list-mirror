From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 3/5] fmt-merge-msg: Update command line options to
 sync with config options
Date: Fri, 20 Aug 2010 23:02:03 -0500
Message-ID: <20100821040203.GA2636@burratino>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
 <1282331702-5115-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 06:04:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfJL-0005Np-QG
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954Ab0HUEDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:03:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51906 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab0HUEDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:03:48 -0400
Received: by gwj17 with SMTP id 17so1518562gwj.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+F243VJxZGnTuUu/4Cb2zhUegy4RXcG836rZHpLRjQw=;
        b=Pt6Udng2193FI47KasKbj/8aDplY5sWWsK0Le7E/lPGHh75+1BRfRckB28AwBILSaR
         CURVrO8GsD5xv0pg4NuOht1J4dnzns1Jf88brxuwud5t9NgTLvdtouUEVV8Mgk42FO9t
         TBWv8KwGXQ1FcQp6KjtyNOyMIrdSE90TumZcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=viw3liHBRJjnyHXqw4lVHr2dtbojNfOggpscv5A9bWETFIE8j1G+wlfoDTr82+6KJh
         f4ygcbj1p4WgFs8mkPWjGz7PoAI3Btye9IHI4oLpfktFLEkWirUgXq6JWHuW9Y6AJE2V
         9JT4X2nviHxO8/kRCOTdjX1kwZNowAfTwlr5g=
Received: by 10.100.38.4 with SMTP id l4mr2621864anl.134.1282363427415;
        Fri, 20 Aug 2010 21:03:47 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id c19sm5746110ana.22.2010.08.20.21.03.46
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:03:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282331702-5115-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154096>

Ramkumar Ramachandra wrote:

> +++ b/builtin/fmt-merge-msg.c
> @@ -7,11 +7,10 @@
>  #include "string-list.h"
>  
>  static const char * const fmt_merge_msg_usage[] = {
> -	"git fmt-merge-msg [-m <message>] [--log|--no-log] [--file <file>]",
> +	"git fmt-merge-msg [-m <message>] [--log=[<n>]|--no-log] [--file <file>]",

[--log[=<n>]], no?

>  	NULL
>  };
>  
> -static int merge_summary;
>  static int log_limit = 0;

Ah, so you elminate the boolean arg here. :)

Nit: the usual style in git is to let statics and globals that should
be 0 be implicitly initialized.

> @@ -328,10 +326,12 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
>  	const char *inpath = NULL;
>  	const char *message = NULL;
>  	struct option options[] = {
> -		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
> -		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
> +		{ OPTION_INTEGER, 0, "log", &log_limit, "n",
> +		  "populate log with <n> entries from shortlog",
> +		  PARSE_OPT_NOARG, NULL, 20 },
> +		{ OPTION_INTEGER, 0, "summary", &log_limit, "n",
>  		  "alias for --log (deprecated)",
> -		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
> +		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 20 },

OPTARG, I think.
