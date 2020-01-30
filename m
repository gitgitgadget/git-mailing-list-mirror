Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E81AC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016F120707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbTA+vYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgA3PBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:01:19 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44190 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgA3PBT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:01:19 -0500
Received: by mail-yw1-f65.google.com with SMTP id t141so2078109ywc.11
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 07:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YU5JU40prWwOD7WyTYIExUr8gZY7BTg7hKJ2LXlgmFQ=;
        b=NbTA+vYXZYqVl4BKMsHspkS6HuLLMZrkrSHqz+/m4Nrx7bY627Y7xiEs3OswyP9tyT
         SJAweX+p7eD8kE59Q1aDaaue755IllK3K7Ci0PoOqVsljN7hl63ntCOfywSm+Pr4Ttal
         57UolxBFws2xUlZ38SilLA7Fw1w7zHhgi6IypEl8ONHZsn1xjyICK7BhzjpFwmBMfdr8
         XQtQB1sBrmFzpU7VbHRXQXoPzFtWf6RjcAP8Bzt44aybjQeNl0Ut2yDcDakBpDAuyMP3
         dQI8MqghUhtD/IQrQvCf+OmK90y9LP5MCrl3hlv4z+WFWQRG/M1+33/81vj+Wa4IbuYC
         RgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YU5JU40prWwOD7WyTYIExUr8gZY7BTg7hKJ2LXlgmFQ=;
        b=QiOIKAaqZYb+fXJWGwkob/lXKg+VhxnEq21EgCzQPy3RxkTYcR74nVOUz7XLWuF1Wu
         a4g2ipXXJK46wRUAm+E7TCaF2+Ewj90BChaOgNxcmdppUpzJOd6+jWFpBWlv0W9EtkKd
         YiEvHigcruqXrRRAErMC/4DtMLpIFzBx+Y1yDICK7w8u6cEJts7ebGd1GiB79ALWIRxh
         hoX/Gyv7AEyq6UEr2x4nox+rnOrj2npb4Km7O41YVhJ4f3N/Hg7Xw44qEuW7aJnlX4+n
         h1yVWuQEmdFF24PGXFOSmGaTgnd3pb1m0UyP/t5MVt/Q+IbNwUExoo29mw4Om28aV8Y8
         xpNA==
X-Gm-Message-State: APjAAAV1J/E9jC3PTLtM9slwlYmH/soRBSzqSmhIVhTJm6XMMLBInZK3
        8t7XOyZfRtoH6I12+1wboMY=
X-Google-Smtp-Source: APXvYqy4UXMjQY9fxSGKTKF58aHYUey4JQp3yrZSNMPlmkCimKv48XWwk/JRknIbRfFt5QtiUUMjUA==
X-Received: by 2002:a0d:f106:: with SMTP id a6mr3521462ywf.318.1580396477910;
        Thu, 30 Jan 2020 07:01:17 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d22sm2440076ywb.77.2020.01.30.07.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 07:01:17 -0800 (PST)
Subject: Re: [PATCH v3 10/12] sparse-checkout: write escaped patterns in cone
 mode
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
 <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <e2f9afc70c92c606a9d93660bce0599b7b7ddf6e.1580236003.git.gitgitgadget@gmail.com>
 <20200129101713.GB4218@coredump.intra.peff.net>
 <20200129103352.GD4218@coredump.intra.peff.net>
 <7a85cded-eccf-9f33-4056-08b2923b2861@gmail.com>
 <20200130072957.GE2189233@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <35c451a0-f06a-ada1-9614-49dae91e6e4d@gmail.com>
Date:   Thu, 30 Jan 2020 10:01:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200130072957.GE2189233@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 2:29 AM, Jeff King wrote:
> On Wed, Jan 29, 2020 at 09:16:11AM -0500, Derrick Stolee wrote:
> 
>> I've applied the smaller comments and am now investigating the right
>> thing to do with other is_glob_special() characters. There is a small
>> chance that I can replace any "c == '*' || c == '\'" with is_glob_special(),
>> but we shall see. At the very least, I'll need to expand my tests.
> 
> Yeah, that's all I'd expect to need. You mentioned earlier about how
> ls-tree would output them, but I don't think it would matter. Now that
> you're using unquote_c_style(), you'll get the literal filenames no
> matter which way ls-tree decides to quote them (and I don't think it
> would quote '?', just as it wouldn't '*', because those are not
> syntactically significant in its output).

Yes, even this case for 'git ls-tree' gets covered in the final
version of the test:

test_expect_success BSLASHPSPEC 'pattern-checks: escaped characters' '
	git clone repo escaped &&
	TREEOID=$(git -C escaped rev-parse HEAD:folder1) &&
	NEWTREE=$(git -C escaped mktree <<-EOF
	$(git -C escaped ls-tree HEAD)
	040000 tree $TREEOID	zbad\\dir
	040000 tree $TREEOID	zdoes*exist
	040000 tree $TREEOID	zglob[!a]?
	EOF
	) &&
	COMMIT=$(git -C escaped commit-tree $NEWTREE -p HEAD) &&
	git -C escaped reset --hard $COMMIT &&
	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" zglob[!a]? &&
	git -C escaped sparse-checkout init --cone &&
	git -C escaped sparse-checkout set zbad\\dir/bogus "zdoes*not*exist" "zdoes*exist" "zglob[!a]?" &&
	cat >expect <<-\EOF &&
	/*
	!/*/
	/zbad\\dir/
	!/zbad\\dir/*/
	/zbad\\dir/bogus/
	/zdoes\*exist/
	/zdoes\*not\*exist/
	/zglob\[!a]\?/
	EOF
	test_cmp expect escaped/.git/info/sparse-checkout &&
	check_read_tree_errors escaped "a zbad\\dir zdoes*exist zglob[!a]?" &&
	git -C escaped ls-tree -d --name-only HEAD >list-expect &&
	git -C escaped sparse-checkout set --stdin <list-expect &&
	cat >expect <<-\EOF &&
	/*
	!/*/
	/deep/
	/folder1/
	/folder2/
	/zbad\\dir/
	/zdoes\*exist/
	/zglob\[!a]\?/
	EOF
	test_cmp expect escaped/.git/info/sparse-checkout &&
	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" zglob[!a]? &&
	git -C escaped sparse-checkout list >list-actual &&
	test_cmp list-expect list-actual
'

Thanks,
-Stolee


