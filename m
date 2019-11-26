Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ECDC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 20:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85372075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 20:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulK5JlVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfKZUCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:02:43 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36744 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKZUCn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 15:02:43 -0500
Received: by mail-pj1-f67.google.com with SMTP id cq11so8798042pjb.3
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 12:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lvBgznInfRi6HA+a4xzo6Mno2nfOMogiqMlxuPkHyfw=;
        b=ulK5JlVUxT+1VlPwWA0Tc6k6bU15TWhp9eXC7jY0YLWbG7PdAhqfP60XjQ1GtjEWyY
         wL5l4wbVfo0WshPBOf4r6hqbWGEPgupLHsVkH3BppVrc5UsJjWcho/Ga0izIaVYkMadq
         p35sZV3yQrS7SE906EI8cFHJ7/mIM6CGuPABGUTTKNQ4pbtOLGJr9yu6YfCnLJfRY095
         NCcz/L5riBM+6kVcvF0JJNTT+7zSA3FZvqnEG3YESPTLm6ew1+eeQ+vufZYIfOaoTMe/
         FbvJRG99piVwRNuU4Q2gIsheu5tZ815gkwE9rthiI5Z3rGC6tM09+oPmF/93siE1ZjLr
         S8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lvBgznInfRi6HA+a4xzo6Mno2nfOMogiqMlxuPkHyfw=;
        b=kZzHltCw+9UGmuOVdLflfI/XF7jdjj8sRbTdqjFQqkJIp8+UHlnSt3wwPiNajBPPPG
         +TpPW1KxFm8A23SJh/gewCQUgqd9160QhiY4M/uC/44lXwpxiBr8IBPXeOptC1lWDlKW
         egjfsHawqx6b7yBJZd1a25zMboyaEjjo9NVv53UwBuxPjKES10pz3IQVedFaaK1nUUHv
         +TMLMegB+56zEMAbJkS4rH+wIILG/rIxWUYFFXzgZVz8djAyqVeFyg57tb/s5Va+/NX0
         UAydqD16PnZ5Xr3H1aJGdetr7g8Rs20L18ilrogbs5pfFHxIYZHLnAnFopfMszaxhlTm
         IHkA==
X-Gm-Message-State: APjAAAWineAaBhzo71M911RsiDeuUWW8yy3nzG9cbq8bFonXn5rkJQUn
        jfPdzxMb5wMi98noDE5AOEt30cU5
X-Google-Smtp-Source: APXvYqzo53H6hLzc3AbFc21yBglUn088yGSHZZsX+QGzoqeXbSezEfAav2sxOrOdfGK6hOmEWcdedg==
X-Received: by 2002:a17:90a:c01:: with SMTP id 1mr1111631pjs.37.1574798562520;
        Tue, 26 Nov 2019 12:02:42 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id k88sm2026202pjb.15.2019.11.26.12.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 12:02:41 -0800 (PST)
Date:   Tue, 26 Nov 2019 12:02:39 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: use test_must_be_empty F instead of test_cmp empty
 F
Message-ID: <20191126200239.GA36748@generichostname>
References: <52479277-b753-c3c0-7f6c-5d013016964e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52479277-b753-c3c0-7f6c-5d013016964e@web.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

On Tue, Nov 26, 2019 at 08:46:34PM +0100, René Scharfe wrote:
> Use test_must_be_empty instead of comparing it to an empty file.  That's
> more efficient, as the function only needs built-in meta-data only check
> in the usual case, and provides nicer debug output otherwise.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>

Nice, I like test cleanup :)

> ---

[...]

> diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
> index 0b20b07e68..3a3d8d3bd5 100755
> --- a/t/t9010-svn-fe.sh
> +++ b/t/t9010-svn-fe.sh
> @@ -53,9 +53,7 @@ text_no_props () {
>  	printf "%s\n" "$text"
>  }
> 
> ->empty
> -
> -test_expect_success 'empty dump' '
> +test_expect_success PIPE 'empty dump' '

How come we need the PIPE prereq here? At the top of this file, we have

	if test_have_prereq !PIPE
	then
		skip_all="svn dumpfile importer testing requires the PIPE prerequisite"
		test_done
	fi

which should guarantee PIPE at this point already.

Thanks,

Denton

>  	reinit_git &&
>  	echo "SVN-fs-dump-format-version: 2" >input &&
>  	try_dump input
> @@ -208,7 +206,7 @@ test_expect_failure 'timestamp and empty file' '
>  	test_cmp expect.date actual.date &&
>  	test_cmp expect.files actual.files &&
>  	git checkout HEAD empty-file &&
> -	test_cmp empty file
> +	test_must_be_empty file
>  '
> 
>  test_expect_success 'directory with files' '
> --
> 2.24.0
> 
