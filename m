Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1CF5202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbdB1Vez (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:34:55 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33384 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbdB1Vex (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:34:53 -0500
Received: by mail-pg0-f65.google.com with SMTP id x17so3052542pgi.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 13:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PmcTMHFpZjJSVDUuF/AP5VZ60kSGXLFFlbvH/gA6bDo=;
        b=OYIMKKzhiBEBm0ap+xUZMzorLLfhFzsbcv++KO4KNLs5yAzgadG/EITzLz6G3+BfVA
         nOL4/MbXivD7CFXwzAChgKBw1TiPKnNkQ5eU+REax76zkmU64kDsxbVwhATyqw3INx29
         sRlAfLPDPgi4tUdZITdyOfeMc6CVnpWmLzHdN+8z95tLgch2dRsV8rhgAUJj2rgUZ/P0
         C0q9nPAlf7m2KxuI1NUBJublkDsWAmyyD2n8IRjdftJ5uVKCjOjauZ5QfybctziI2m5X
         XVTfjAijiADy14Di7eCbt1o5tOf2BDcYUz5ZuqnNR6ZvKQPCXPHOT4ImgserOArCsDGy
         sgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PmcTMHFpZjJSVDUuF/AP5VZ60kSGXLFFlbvH/gA6bDo=;
        b=INAhwkLb021LM7+H+SlAPe3hT3Cf9K2o2sq+cFtW1pyS5U6UVi0F5TiMFAGkNpDcfm
         IQkZstxrg2lfz5fosH2mEnwZ+ojn55TIFhfwVuWKup2PiPka0QOawthU0AQbB1bJh6Rs
         2ZZ0SYhpRiZ4aIcekv1vt7ZWrreny1dCCG8GEGyqL01DczxU2kDz715DcaMdut0Ol24D
         b9ZCECh94fR8iEuAuU4SDE2yd49Ap09Cji1pFmIomSLjODi/lPyOU/le0RLCTBlT83/b
         POanKcc0ROlR54XQ4C5F+wntfhEGsKqqOsH6/aKGDNtkUIR1i4wAm75dMjd4MmbxpOD6
         yfkA==
X-Gm-Message-State: AMke39l/cjSwQCaNkaY0wuBleKZu1Vbw0N19FgqNzitYUQZBV1t8+E9l0tRB/r48I6RnwA==
X-Received: by 10.84.218.1 with SMTP id q1mr5613592pli.104.1488315870189;
        Tue, 28 Feb 2017 13:04:30 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id s5sm5975685pgc.57.2017.02.28.13.04.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 13:04:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH 3/5] grep: fix bug when recuring with relative pathspec
References: <20170224235100.52627-1-bmwill@google.com>
        <20170224235100.52627-4-bmwill@google.com>
Date:   Tue, 28 Feb 2017 13:04:28 -0800
In-Reply-To: <20170224235100.52627-4-bmwill@google.com> (Brandon Williams's
        message of "Fri, 24 Feb 2017 15:50:58 -0800")
Message-ID: <xmqqefyijacj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>  	/* Add super prefix */
> +	quote_path_relative(name, opt->prefix, &buf);

Hmph, do you want a quoted version here, not just relative_path()?

Perhaps add a test with an "unusual" byte (e.g. a double-quote) in
the path?

>  	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
>  			 super_prefix ? super_prefix : "",
> -			 name);
> +			 buf.buf);
> +	strbuf_release(&buf);
>  	argv_array_push(&cp.args, "grep");
>  
>  	/*
> @@ -1199,7 +1202,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  
>  	parse_pathspec(&pathspec, 0,
>  		       PATHSPEC_PREFER_CWD |
> -		       (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
> +		       (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0) |
> +		       (super_prefix ? PATHSPEC_FROMROOT : 0),
>  		       prefix, argv + i);
>  	pathspec.max_depth = opt.max_depth;
>  	pathspec.recursive = 1;
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> index 418ba68fe..e0932b2b7 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -227,7 +227,7 @@ test_expect_success 'grep history with moved submoules' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'grep using relative path' '
> +test_expect_success 'grep using relative path' '
>  	test_when_finished "rm -rf parent sub" &&
>  	git init sub &&
>  	echo "foobar" >sub/file &&
