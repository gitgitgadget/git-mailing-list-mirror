From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v4 2/2] builtin/grep: add grep.fallbackToNoIndex config
Date: Tue, 12 Jan 2016 16:50:05 +0100
Message-ID: <20160112155005.GG10612@hank>
References: <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
 <1452595226-14616-1-git-send-email-t.gummerer@gmail.com>
 <1452595226-14616-3-git-send-email-t.gummerer@gmail.com>
 <20160112121106.GA18512@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 12 16:49:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ1Cc-000239-68
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 16:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058AbcALPtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 10:49:42 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35175 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbcALPtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 10:49:41 -0500
Received: by mail-wm0-f65.google.com with SMTP id f206so32039167wmf.2
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 07:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IWdFslB/w3wql4MfEAuHfXHy4T6Qq/xugItm7P8TyBo=;
        b=F6l7IrTd7xYnbBnl3QKouo2y79nvCfFWc3PY2WrPyNpICYRJxHUNGWF76MLGPlXjI0
         nOIBOxa2mtsJZ4GM87W8eI42ZLPGI0ne+zZ4C1MINXG3EGoWxfeLNRplqtGZoBJYh8Cb
         f0GbpFSWzdruJ+rZC3sIx9A+avz2lB76n6tTPiEdb6bsm6oQ2QauIdl3xi3+T+hgqoUu
         rT50vLiN3Cik7Ke1t0i5P/VaSQnrdjABqW8dj6V3mL55A1SIcdiW1wamvwU3SMPE+3t1
         4g0b8sjqtsxMdU7fp6by7QAFizd2Cs4f4/n2UixN/arUUGMcCw7F7PoBHSZmaN7VkVo4
         jAMA==
X-Received: by 10.28.57.214 with SMTP id g205mr10087346wma.20.1452613780395;
        Tue, 12 Jan 2016 07:49:40 -0800 (PST)
Received: from localhost (host214-63-dynamic.48-82-r.retail.telecomitalia.it. [82.48.63.214])
        by smtp.gmail.com with ESMTPSA id bg10sm124752276wjb.46.2016.01.12.07.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2016 07:49:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160112121106.GA18512@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283824>

On 01/12, Jeff King wrote:
> On Tue, Jan 12, 2016 at 11:40:26AM +0100, Thomas Gummerer wrote:
>
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 4229cae..6b7add6 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -755,9 +755,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >  			     PARSE_OPT_STOP_AT_NON_OPTION);
> >  	grep_commit_pattern_type(pattern_type_arg, &opt);
> >
> > -	if (use_index && !startup_info->have_repository)
> > -		/* die the same way as if we did it at the beginning */
> > -		setup_git_directory();
> > +	if (use_index && !startup_info->have_repository) {
> > +		int fallback = 0;
> > +		git_config_get_bool("grep.fallbacktonoindex", &fallback);
> > +		if (fallback)
> > +			use_index = 0;
> > +		else
> > +			/* die the same way as if we did it at the beginning */
> > +			setup_git_directory();
> > +	}
> >
> >  	/*
> >  	 * skip a -- separator; we know it cannot be
>
> Nice. This turned out delightfully simple.

Indeed, much simpler than I expected.  Thanks for the help getting it there.

> -Peff
