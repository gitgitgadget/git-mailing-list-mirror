Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30C81F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbfIET1t (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:27:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36525 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfIET1t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:27:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id p13so4432776wmh.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W6wjAwb+rxUhGcdF8jgaYif9/EMGNhp65dZuuFSBFAQ=;
        b=oraIXYi97wspRLSI+vkbbcoJVju2sZW1+U7/wNuDzcc8d/WvvYn13s3Onc5G35JHzI
         FossI4NN57loZ1bYSQIfPAaVxwxnsdOXJFKZxGbsv73/mTcCSBzFQHfYOXZgkMaz3DEb
         SRc4rRCrRe5gm3IvFcKLjnPF61DJtvHXEdYxfeCyj+9mfhmu08qGmmZ53U7s5WdqAMtY
         35vCdiJQBSKh3C/Upuyazo0nLB5hTEPsDM1xnq12NmqFV59LoH/reF2WbRJWQ0dwA+gm
         fMXriyDziyY40rUiFgqLyCvPC323vJH7Kbh/eMMErmzcmj+htsH/ojSOgGi7LYfonQsz
         VDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W6wjAwb+rxUhGcdF8jgaYif9/EMGNhp65dZuuFSBFAQ=;
        b=ClcxJxSkSVhRn7kbzpsOA6b7swWH3JBI74WW74h8VklyOBV0T5L/uxF17k9W8hFtUR
         sXscJE+nNnVgdWbb9l5lNV59304dM+v3KBznzonKpPGS0IXDvgGJSyHyV/m8cpLxfAxN
         M1VQUdidlRAea+RIOclmhWlcRowB/o9zmvhyWIFjLOXEptarmhwt0jS8UW0aR9ooqO6k
         dLjOiR/O3krwOToQBkrGq13J85DSoaB6875kgtIy/miLB63FYaWaxjjxrxXxTUkxdnF5
         7jwBDSwCZsKA1QUflttdcfOJZmlfugNmONX9WyNLr/Rfq7/RTHYYduHdG+EqD6h3mHe7
         cecA==
X-Gm-Message-State: APjAAAVZk6ayZ6eKIdDX/ImB/0U8D3cimtHmy49IGhOEfv3EkxaOnwtN
        W2l9wFm4wpsqVAIPPyQmmCA=
X-Google-Smtp-Source: APXvYqxcfbbxRybx+szmBJ5qKPIXdIpUUJNOEqe3Dw0pRGmQgDMwJIAja1osTsOtl36Vo49iJkrfWQ==
X-Received: by 2002:a1c:c5c3:: with SMTP id v186mr4131814wmf.125.1567711667024;
        Thu, 05 Sep 2019 12:27:47 -0700 (PDT)
Received: from szeder.dev (x4db65166.dyn.telefonica.de. [77.182.81.102])
        by smtp.gmail.com with ESMTPSA id f3sm3770036wmh.9.2019.09.05.12.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 12:27:46 -0700 (PDT)
Date:   Thu, 5 Sep 2019 21:27:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [RFC PATCH v2 12/12] clean: fix theoretical path corruption
Message-ID: <20190905192744.GB32087@szeder.dev>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
 <20190905154735.29784-13-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905154735.29784-13-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 08:47:35AM -0700, Elijah Newren wrote:
> cmd_clean() had the following code structure:
> 
>     struct strbuf abs_path = STRBUF_INIT;
>     for_each_string_list_item(item, &del_list) {
>         strbuf_addstr(&abs_path, prefix);
>         strbuf_addstr(&abs_path, item->string);
>         PROCESS(&abs_path);
>         strbuf_reset(&abs_path);
>     }
> 
> where I've elided a bunch of unnecessary details and PROCESS(&abs_path)
> represents a big chunk of code rather than an actual function call.  One
> piece of PROCESS was:
> 
>     if (lstat(abs_path.buf, &st))
>         continue;
> 
> which would cause the strbuf_reset() to be missed -- meaning that the
> next path to be handled would have two paths concatenated.  This path
> used to use die_errno() instead of continue prior to commit 396049e5fb62
> ("git-clean: refactor git-clean into two phases", 2013-06-25), but my
> understanding of how correct_untracked_entries() works is that it will
> prevent both dir/ and dir/file from being in the list to clean so this
> should be dead code and the die_errno() should be safe.  But I hesitate
> to remove it since I am not certain.  Instead, just fix it to avoid path
> corruption in case it is possible to reach this continue statement.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/clean.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 6030842f3a..ccb6e23f0b 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -1028,8 +1028,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		 * recursive directory removal, so lstat() here could
>  		 * fail with ENOENT.
>  		 */
> -		if (lstat(abs_path.buf, &st))
> +		if (lstat(abs_path.buf, &st)) {
> +			strbuf_reset(&abs_path);
>  			continue;
> +		}

I wonder whether it would be safer to call strbuf_reset() at the start
of each loop iteration instead of before 'continue'.  That way we
wouldn't have to worry about another 'continue' statements forgetting
about it.

It probably doesn't really matter in this particular case (considering
that it's potentially dead code to begin with), but have a look at
e.g. diff.c:show_stats() and its several strbuf_reset(&out) calls
preceeding continue statements.

>  		if (S_ISDIR(st.st_mode)) {
>  			if (remove_dirs(&abs_path, prefix, rm_flags, dry_run, quiet, &gone))
> -- 
> 2.22.1.11.g45a39ee867
> 
