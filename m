Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D7C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 22:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B1F22285
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 22:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgLWWVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 17:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgLWWVP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 17:21:15 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2CAC061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 14:20:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r5so569085eda.12
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 14:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qVZJAVBgcmoVXzZMdA1ixPC2sjXhRSrPzTIEmpl0ImA=;
        b=kr9Q9Indof0CYuXWPdQvfuADhLF4kIhzmf8KApdJBkbcmq4Tv/vfjPuRm5pgF7d/lv
         QDZTKMm4361/wQGfGR5BmFi5I+J6vqUkgu1qG9ir+Xe3Ar4DBBOXF9oeFAHC/Hi4saIN
         c6Dn8P+LxINztPKQ4wt+2UZaqZz/PDJVUYey2rlFNrU1EFyPQ66EPq75GOG2bO+mi6rj
         wv5/QqXT4KYllNUYbeu9SAT+iDoINEzKv8STJVmN+C6OPTlGjnLlQjCsMl2Y+joU5/0F
         Hn4eeWXPqvNqofLW0MIl5/tWX4RmHviBu978ebgPeNI289td3kEG6Rk/d5SSDvD+UHiV
         GjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qVZJAVBgcmoVXzZMdA1ixPC2sjXhRSrPzTIEmpl0ImA=;
        b=gAoShEZcWY+dPatl+PAeyn9kpcYTEij7qq1TMgIYjWfypQeSKzq0dVxe3tBPcOJ3pe
         fTx2VA9s/PomMjBClDSfUr7Gu/lzexOv6WsVLkFepZvwYHC1yutF9qYByPse99c5asIf
         JPZHb4NYCSmyoetIZlimbhCib6SUMaUSGJK1ssnEsCu75hQpCIv4mrpcB3AAGhkeeqLs
         BuQU+tGx7ukWVNSgtnD2xoabSe04P6T5qG/NIFs5SOFcli9Aaf2W+Kx7sqmDIBkOEBdT
         YqEYIU60OIKA+g9/DldbAqvFUtur5SNcpot0tA1C3BXd/L5M2sdUUrHCQi05NViOB/AI
         nv8A==
X-Gm-Message-State: AOAM531R/JzIt/tjHUsWaqn9la9cab67hUmf04SCVBZX6sIDBZZ+xGMx
        TNjsPu6kwGHG1DzdwP/QMfQ=
X-Google-Smtp-Source: ABdhPJxQf2hXHtltlA6HoEh/ZIq7DKOPD6/uvlpRBtJWewMqQ2X4P2PsYMQ0EeGxqX5CdKnGgS/Ifw==
X-Received: by 2002:a50:bacb:: with SMTP id x69mr26309743ede.39.1608762033672;
        Wed, 23 Dec 2020 14:20:33 -0800 (PST)
Received: from szeder.dev (94-21-146-153.pool.digikabel.hu. [94.21.146.153])
        by smtp.gmail.com with ESMTPSA id d18sm31633234edz.14.2020.12.23.14.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2020 14:20:33 -0800 (PST)
Date:   Wed, 23 Dec 2020 23:20:31 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 20/20] mktag: add a --no-strict option
Message-ID: <20201223222031.GK8396@szeder.dev>
References: <20201209200140.29425-1-avarab@gmail.com>
 <20201223013606.7972-21-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201223013606.7972-21-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 23, 2020 at 02:36:05AM +0100, Ævar Arnfjörð Bjarmason wrote:
> Now that mktag has been migrated to use the fsck machinery to check
> its input, it makes sense to teach it to run in the equivalent of "git
> fsck"'s default mode, instead of hardcoding "git fsck --strict". Let's
> do that and support the "--no-strict" option.
> 
> Since this is a new option we don't need to cater to parse-option.c's
> default of automatically supporting --strict. So let's use
> PARSE_OPT_NONEG, using a new trivial helper macro.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index 2e8b718379..b436ae1e44 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -12,12 +12,16 @@ test_description='git mktag: tag object verify test'
>  # given in the expect.pat file.
>  
>  check_verify_failure () {
> -	expect="$2"
> -	test_expect_success "$1" '
> +	test_expect_success "$1" "
>  		test_must_fail env GIT_TEST_GETTEXT_POISON=false \
>  			git mktag <tag.sig 2>message &&

So this 'git mktag' is always invoked with
GIT_TEST_GETTEXT_POISON=false (instead of, for some reason, using
test_i18ngrep on the next line)...

> -		grep "$expect" message
> -	'
> +		grep '$2' message &&
> +		if test '$3' != '--no-strict'
> +		then
> +			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&

Wouldn't a GIT_TEST_GETTEXT_POISON=false be necessary for this 'git
mktag' as well?  Or, alternatively (preferably?), a test_i18ngrep
below.

> +			grep '$2' message.no-strict
> +		fi
> +	"
>  }
>  
>  test_expect_mktag_success() {
