Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D1C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54867208D5
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0ZWPiTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMNEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 08:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMNEn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 08:04:43 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25621C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 05:04:43 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id e18so10631594edy.6
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 05:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=WUaP+6Ott5tTajD1tzCYaalXCae1e5ihxDCDMy7NRM4=;
        b=T0ZWPiTCxP7ORvUu1lkDhx0n5LMpNLVOQWLCCu6IDgDaRtpNdXuHoGcDUxAxcGnbtJ
         zXlUf/kHYolnYI+G1Sd7WyZq02n+wms4buzrlUJVjVqvp/8pGRD7fkZqdTphFPGHHxkW
         va6GfhfItfCex3rul7wCwX2rq+moPDFyQyEQIp/nhwJUG31EQ1VT9mmg4/Ii3smWEu+R
         boS180FslIM4I4Mbf5CM4LfnkZp8qNqLm64M60B19ZIJz8BhmCy9Y8I9Sr20KDx0vnL1
         99TWDVm1uqKbhzwrli47pZvZwo3IXUDhtQ8ufqXjd7r03hL13LB7yfVpzzEPnPCp4pp1
         b9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=WUaP+6Ott5tTajD1tzCYaalXCae1e5ihxDCDMy7NRM4=;
        b=g1hF/CQ7YcMjO+Ed06KWOJxiQ1hFxBuYBa1py74y4fpRxCCwRxJysx0WY8rO3QjbZ9
         8amLWmZuGV9YHaoxFgLRhyfT0f7wFMa/X4HwC+6wGY9aCGhD/ydsuTOpUdONHTChPaj8
         jLrqeCT8kalMNi77We5uaenRS3TWFNt68kmq8V4nLxZtGE1KzLuhmcCj4s4/etJllCPm
         oTOH3Ex65chhFOkKnD6qF2fgz5/nzH6dPNh6YjjyLpUTo2CHdDANmUfOPabkKWPIEDlM
         PcSwhiTt/n4y1CsjSHjR4V46p5A5hsE2cKbMGTSP8LJlk1rBQi9jR8NdjHCQrO3Pfx64
         qVIQ==
X-Gm-Message-State: AOAM531n0YCu1/984NsTSJn4jzBEJIyfNb75Ko03+UFBCEb0oOBPq5Re
        vcT0PlrQ9tAW5Y7zc03t+DXWXrmx+OQ=
X-Google-Smtp-Source: ABdhPJwF0tMQ+2fFSz60tj4NlGKLwjJFxX7Ko/H5lcbdfJuASLRWRkSCI0H6yfzmtd5maKUW5p1Qug==
X-Received: by 2002:a50:e705:: with SMTP id a5mr2483576edn.29.1605272681709;
        Fri, 13 Nov 2020 05:04:41 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id c5sm4005942edx.58.2020.11.13.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:04:40 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar pairs
References: <cover.1605269465.git.ps@pks.im> <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
Date:   Fri, 13 Nov 2020 14:04:40 +0100
Message-ID: <87mtzlflw7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 13 2020, Patrick Steinhardt wrote:

> While not document, it is currently possible to specify config entries

"While not documented..."

> +		strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
> +		if ((key = getenv(envvar.buf)) == NULL)
> +			break;

The convention in git.git is to avoid explicit NULL checks. So maybe
something like this, which also avoids the assignment inside an "if"

    key = getenv(envvar.buf);
    if (!key)
        break;

> +test_expect_success 'git config handles environment config pairs' '
> +	GIT_CONFIG_KEY_1="pair.one" GIT_CONFIG_VALUE_1="foo" \
> +		GIT_CONFIG_KEY_2="pair.two" GIT_CONFIG_VALUE_2="bar" \
> +		GIT_CONFIG_KEY_4="pair.four" GIT_CONFIG_VALUE_4="not-parsed" \
> +		git config --get-regexp "pair.*" >actual &&
> +	cat >expect <<-EOF &&
> +	pair.one foo
> +	pair.two bar
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git config copes with missing config pair value' '
> +	GIT_CONFIG_KEY_1="pair.one" git config --get-regexp "pair.*" >actual &&
> +	echo pair.one >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git config fails with invalid config pair key' '
> +	test_must_fail env GIT_CONFIG_KEY_1= git config --list &&
> +	test_must_fail env GIT_CONFIG_KEY_1=missing-section git config --list
> +'
> +
>  test_expect_success 'git config --edit works' '
>  	git config -f tmp test.value no &&
>  	echo test.value=yes >expect &&

I think we should have a bit more complete tests of what happens if you
clobber existing config keys, and testing that this is set last after
system/global/local config.
