Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F3C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjDRTbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjDRTbO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:31:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637BB8694
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:31:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a667067275so20259175ad.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681846273; x=1684438273;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf5rGknleFd5E2S8V/t1S+gyIHBUF371PeHVh5mPjzU=;
        b=gmcthZs41ZluMpKy6Mn3Kj1QeJ2ndGFkFKugB07+sgSJ/3cjGAJUIz4ztnnR9AR5yZ
         kZdFVDu463uT+Capj0LmCUzZCgTGKXMLO2Vrx+0Mbialda2byG/F62K46gPOiichTT+c
         qt62k14BuQM0sl04qbaXiWiQ38NwPApKOWhOzSe3dnXj5eAYPo8bHBpGUyhWVDRMv8yE
         NUFRQInQattVyCfSeiotPAexFpG0Ufj6bDcFGr4RaNV0xnAlgtF+JtPuTTxP59XUQq54
         /EDUhglL1kDIVhGdaJ5SFl4NEe7WDxcaqtDgEvoYpWKmHdJv6oCzGaj3L/ByxbVtM6E5
         I5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681846273; x=1684438273;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uf5rGknleFd5E2S8V/t1S+gyIHBUF371PeHVh5mPjzU=;
        b=lqA7/0m9BgSldgOYH/CgbGXf71c05AtfucKIToa89VmEIDeq5SwRsaDgUdyAG1M+Ew
         8XXZcGorUhhfs5F6FTYnB1xxWTpTDKqvJc5/rspiZSJGNvhQIF5LRHG9uVaSZf3760Os
         cGJbUwb64EonPGGL6pWwJi/5wn/4V52shFAkf9ovUQRsmSmhMTzvZEQ4fdT0G9ci0cME
         W5ZAOsp3pT2MRQ38Xyw3a/f4V7aInMsrskMZGC7U/2pN/f/qSte7D+NNWc5F4jI0Yd4Z
         A7Uuk+wmJDeLiKoxiYJk8QJstNVcrQdXktl5/JTEejrwuYraN7caSlDnfsKPDt8PPSVs
         boXw==
X-Gm-Message-State: AAQBX9cl1UxKkhJEXJRm5oVCUgWLYXLEPlkBiQMLMGVwW3vkQuGzeLUk
        eO3SRiaEvHNhG3B4eV2RVQs=
X-Google-Smtp-Source: AKy350YbYr9xlC/mI82bRxvBUkgB9GVBXLAj++VNRNosoVjyhc2umlqazN+TX7j5Zuu8zvMQEYDKxg==
X-Received: by 2002:a17:902:b688:b0:1a6:b2e3:5dc4 with SMTP id c8-20020a170902b68800b001a6b2e35dc4mr2174873pls.14.1681846272739;
        Tue, 18 Apr 2023 12:31:12 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id co16-20020a17090afe9000b00246be20e216sm10980536pjb.34.2023.04.18.12.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:31:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [RFC PATCH v2 3/3] t1300: add tests for missing keys
References: <20230414081352.810296-1-rybak.a.v@gmail.com>
        <20230418175034.982433-1-rybak.a.v@gmail.com>
        <20230418175034.982433-4-rybak.a.v@gmail.com>
Date:   Tue, 18 Apr 2023 12:31:12 -0700
Message-ID: <xmqqr0shc7i7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> +test_missing_key () {
> +	local key=$1
> +	local title=$2
> +	test_expect_success "value for $title is not printed" "
> +		test_must_fail git config $key >out 2>err &&
> +		test_must_be_empty out &&
> +		test_must_be_empty err
> +	"
> +}

In this case it would not make any difference only because no caller
will feed $key that can be split at $IFS, but it is a good practice
to enclose the executed body of test_expect_* script inside a single
quote *and* let variable substitution to happen inside eval; in
other words, you should write the above like so:

(GOOD)	test_expect_success "value for $title is not printed" '
		test_must_fail git config "$key" >out 2>err &&
		test_must_be_empty out &&
		test_must_be_empty err
	'

The difference is a bit subtle.  In the original version, the string
fed to "eval" when "test_expect_success" runs has $key already
substituted.  So if $key has $IFS whitespace in it, the command line
arguments of the "git config" would not be what you think your callers
are feeding.  An attempt to keep it together by enclosing inside a
double quote, still trying to salvage the pattern to enclose the
executed body inside a pair of double quotes, i.e.

(BAD)	test_expect_success "value for $title is not printed" "
		test_must_fail git config \"$key\" >out 2>err &&
		test_must_be_empty out &&
		test_must_be_empty err
	"

would fail when $key has an unbalanced double quotes and cause a
syntax error.

Again, in this case it would be OK due to the limited callers, but
it is a good discipline to follow, as others less familiar with our
tests scripts than you would copy from what you write in your
patches.

The title string (e.g. "value for $title is not printed") does not
go through eval, and it needs to be quoted with double quotes for
the $title to be substituted, by the way.

> +test_missing_key 'missingsection.missingkey' 'missing section and missing key'
> +test_missing_key 'missingsection.penguin' 'missing section and existing key'
> +test_missing_key 'section.missingkey' 'existing section and missing key'

