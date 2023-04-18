Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23004C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjDRTjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDRTju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:39:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD97EFA
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:39:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b620188aeso2701318b3a.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681846789; x=1684438789;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DjxixWHbC4kPi03ND/3tL3X/lrLMgtxWjrrhusmIQo=;
        b=a9SYRzGF5TPRzaFz9lizHw30ZuZvGETFuB/iMNwcDWBBq3WIYdXRpR/YVyXJBBnXAD
         LZU1U0AioKhc6I9mOUiTrCj2XAlroHx4nkolRmhDfbK74Z+MGuDgQUvgP5Qz+SH/bnHd
         uoKVQj8VeudxmftPUK2JtnkRXam7Q2Wb78/x4kfhFc4uXgTh8HrGh+p/fOUle1U7hqzP
         SS6lj2MMfcZcguCNURMP9e8FwHnDHhTIAo/foVJcyZOfvRWzKhnJpMnACsQxVXXKjIj9
         S874od0FDgo46Nxr3v6wPo1t1ZFnK3AWCDYbGE9AaM2SWx2hB/zbg6cBnSEKtC3xWG1u
         Co8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681846789; x=1684438789;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6DjxixWHbC4kPi03ND/3tL3X/lrLMgtxWjrrhusmIQo=;
        b=NRgiW/jrv0AT2hnse8/XL51AMYvvohBm6TpQqbprVtFHg0pPI+KJENYuMk3QGzjH5B
         uC3ekZL907+V2hAre0YERSqkDWMdOAinONDL6EnmPbp1HBEriduG1JpbBxVa5Ud/6vvq
         QHhqEDqOgNdgGwQ4abHkh9ZJC6yMVc4VWB/MI7jO7ldqlqEXfFXYO2C0fym7H30espDR
         HEryV9kVOV31lFeVxjvWyDtse1aLMNCbjUMgLEcx7UdYXLmyxxAV4B5eUp92GzgM3RYs
         oeDphkGIMhlS1Mxx0o6KkNytjZlcnL4Tffv7SUdEpFEmc23FvRWb0XCdaWTeZHaNinv+
         WGTw==
X-Gm-Message-State: AAQBX9c5rG9waeGsX/eAzxCVEAznA9RiLvnQFLrRAAvcLFdBafdu+/0T
        K66Nq0r6ZClFJKpvpPvkNq0=
X-Google-Smtp-Source: AKy350bV7bfmfkPKujkU3jxPtBzdyvpUYyyi1bPpB+6pQAPB0MnSC24zK9p3R72KuUsYsvMJVXJtqw==
X-Received: by 2002:a05:6a00:2491:b0:63d:4752:4db6 with SMTP id c17-20020a056a00249100b0063d47524db6mr401436pfv.8.1681846788691;
        Tue, 18 Apr 2023 12:39:48 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b005810c4286d6sm9707809pfn.0.2023.04.18.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:39:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 1/6] string-list: introduce
 `string_list_split_in_place_multi()`
References: <cover.1681428696.git.me@ttaylorr.com>
        <cover.1681845518.git.me@ttaylorr.com>
        <6658b231a906dde6acbe7ce156da693ef7dc40e6.1681845518.git.me@ttaylorr.com>
Date:   Tue, 18 Apr 2023 12:39:48 -0700
In-Reply-To: <6658b231a906dde6acbe7ce156da693ef7dc40e6.1681845518.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 18 Apr 2023 15:18:43 -0400")
Message-ID: <xmqqleipc73v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Introduce a variant of the `string_list_split_in_place()` function that
> takes a string of accepted delimiters.
>
> By contrast to its cousin `string_list_split_in_place()` which splits
> the given string at every instance of the single character `delim`, the
> `_multi` variant splits the given string any any character appearing in
> the string `delim`.
>
> Like `strtok()`, the `_multi` variant skips past sequential delimiting
> characters. For example:
>
>     string_list_split_in_place(&xs, xstrdup("foo::bar::baz"), ":", -1);
>
> would place in `xs` the elements "foo", "bar", and "baz".

strtok() also skips leading and trailing delimiters, i.e. the above
will give you identical result for ":foo:bar:baz:".

It would be useful to test that here in addition to the existing ones.

> +for test_fn in test_split test_split_in_place_multi
> +do
> +	$test_fn "foo:bar:baz" ":" "-1" <<-\EOF
> +	3
> +	[0]: "foo"
> +	[1]: "bar"
> +	[2]: "baz"
> +	EOF
>  
> +	$test_fn "foo:bar:baz" ":" "0" <<-\EOF
> +	1
> +	[0]: "foo:bar:baz"
> +	EOF
>  
> +	$test_fn "foo:bar:baz" ":" "1" <<-\EOF
> +	2
> +	[0]: "foo"
> +	[1]: "bar:baz"
> +	EOF
>  
> +	$test_fn "foo:bar:baz" ":" "2" <<-\EOF
> +	3
> +	[0]: "foo"
> +	[1]: "bar"
> +	[2]: "baz"
> +	EOF
