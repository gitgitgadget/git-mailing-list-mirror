Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EECC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 18:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F69820748
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 18:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKHTVYYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKYS5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:57:07 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46288 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfKYS5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 13:57:07 -0500
Received: by mail-qv1-f67.google.com with SMTP id w11so6177356qvu.13
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 10:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WcY1kMuDQKju5dxdLWElZJTyVId2qHeO5zkN21NrKiw=;
        b=TKHTVYYcB+pyjmIyYxvpeqYvwCucLAsiMP+lcq0sZmPhy4hq2EMIg7HjySRg30u491
         XfyU4rr0jM2YT6RQaiq6xJX+a3dSnwnx+i8/WAT4cBTg6g6KemtgPN8KeAdkgyObzSG1
         He44ivXzOF85PBjNmIncUDoDVkYVSUb4MC2o8hWeoXvI7tCaPqm4fvW2RYie0vGA4r6B
         tzekSTFQs699uVERD5vxQ5LneRhQPhEhlMqbMkUD1aCB6lK82iTEoHRycHllmJA2lxVD
         gQ52jJe7wPMAJqAZ5LRA7yq4U3qEAFsJDczgIPyR9po4+iJLbp/e2qKDNPKSfgdx61uQ
         hFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WcY1kMuDQKju5dxdLWElZJTyVId2qHeO5zkN21NrKiw=;
        b=ItdJcfegi+s7O80N1PCvLwCIMzQYgp3shzoHMjh9fuYVHpcqBUwIVF3iOCfZwKE1Go
         tT0BB4XC5o7Byj8TWdg9aArmD3/4C4u6YmNgc8lABEyLzLff7DYw8I+SVXSjem3oDHnY
         GIcbao23W90MG57Rw3nZ7VbHgxWPjtCVEJAx9REIY4SwaUWzGGKFmhVUuLol1zDlnGWP
         u+4Yutg3b1d2AGddjQrIi0QxbMeCnLAVrN8oCa7yvzu2mku+iCKPC/S2nL783U9WbO4K
         HuhNCw0kCAX0vDqOzqTr+z8vqoRk3SVpJ/16qETm1XysumPPGvJgzAsNwauIqqy6+QNI
         Zf9Q==
X-Gm-Message-State: APjAAAWV8pw4vBs8VfaTK1RMspEuQdi15+rNdYYJ0Io4raWJID2iJf1g
        MNxBPKDeTGwDR92su6oLzso=
X-Google-Smtp-Source: APXvYqwzhYUSoPs/wUCG4kc6cu6OPjQQMLQCX6+6+KtEuq97uVhEKatj/YYk6LOwMlpHSgsYEMx/dQ==
X-Received: by 2002:a0c:f987:: with SMTP id t7mr14695799qvn.133.1574708226003;
        Mon, 25 Nov 2019 10:57:06 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:b980:e052:6a66:fccd? ([2001:4898:a800:1012:6ab4:e052:6a66:fccd])
        by smtp.gmail.com with ESMTPSA id c128sm3792498qkg.124.2019.11.25.10.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 10:57:05 -0800 (PST)
Subject: Re: [PATCH v4 2/2] commit-graph: use start_delayed_progress()
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ryenus@gmail.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
 <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
 <e62dcc1ce503311c6c11452862f384492965a35f.1574351516.git.gitgitgadget@gmail.com>
 <20191122071716.GD23225@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9d298c6d-303a-eecd-e79d-b90010fdf3d0@gmail.com>
Date:   Mon, 25 Nov 2019 13:57:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191122071716.GD23225@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22/2019 2:17 AM, Jeff King wrote:
> On Thu, Nov 21, 2019 at 03:51:56PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> The tests that check for the progress output have already been updated
>> to use GIT_PROGRESS_DELAY=0 to force the expected output. However, there
>> is one test in t6500-gc.sh that uses the test_terminal method. This
>> mechanism does not preserve the GIT_PROGRESS_DELAY environment variable,
>> so we need to modify check on the output. We still watch for the
>> "Enumerating objects" progress but no longer look for "Computing
>> commit graph generation numbers".
> 
> I'm still puzzled by this paragraph. If I replace the test hunk in your
> patch with this:
> 
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 7f79eedd1c..0a69a67117 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -109,7 +109,8 @@ test_expect_success 'gc --no-quiet' '
>  '
>  
>  test_expect_success TTY 'with TTY: gc --no-quiet' '
> -	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
> +	test_terminal env GIT_PROGRESS_DELAY=0 \
> +		git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
>  	test_must_be_empty stdout &&
>  	test_i18ngrep "Enumerating objects" stderr &&
>  	test_i18ngrep "Computing commit graph generation numbers" stderr
> 
> the test works fine for me.

Thanks! I was having trouble getting that to work by only
inserting "GIT_PROCESS_DELAY=0" somewhere. The added "env"
is what I was missing.

-Stolee

