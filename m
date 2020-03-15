Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE0C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5EB206B1
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3OROmKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgCOSfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:35:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40220 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgCOSfn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 14:35:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id z12so6435442wmf.5
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3fkYHtGJForEqEKk9sYj4UYZ0yAKLy78WBgCsk2K5a0=;
        b=o3OROmKZzbGOS2E3zs/rqb4g8UVTG2QgorbiJqmX+prWH9RMJDWmD9wf83ftycenwW
         Jl0RGgPnda8p8Mvlag2heJH289cEShDzwzvW3tsQ2UUStbkXEjiHEfcI3JcG0qtMu1xz
         oBFJ+vrlkvMY4jGYjqXtTVEoUCLpQft7c5Wkl6jdtpr0gVwYih39itH83yPi0ziEO2iO
         ZIoBikUlE4NZOk/IS7/cg4pwKUPPdkoZz6fTLs7IHFTn/w/4bVvJgO+5yIs39uYGdVXe
         sY5pIPK7FoKvcVpXL8iSVvuqDpSp88bBQdpJA3arEWpPu4CvfzF4XqBr+9tow2i8X3Hd
         YZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3fkYHtGJForEqEKk9sYj4UYZ0yAKLy78WBgCsk2K5a0=;
        b=bKVarwlhIdQi3wWkZUuoPu/A0xPxEpDyFZKCuH/dTCbkiKjMTRJQEdKXFe2ftcd72X
         xcPTep8JQUKVLE2WzkyEiMc/t2CpcrMisG5GfKY9O3u3YAGKvt6LJnI6E9CEKGMQ6oI/
         PRGbBNC2fROrt1PQVGejbGTA0+oiWleeTrFVRo8z9PZq02lAPqZ3vqBjovdNz+sfH6hE
         4X/9U1O1nH6CkUNtmZjgjmgtObYA6A1inodNAZ+z6QUikU5CLTKDrMfRSd+5UCkZdIJl
         Mcp7yrSItgtmgU2WI30lrjCOF78ryiKREQDPZqNOGqXvZNMbB4g59WwQoMrrcu/5bpuY
         b7jg==
X-Gm-Message-State: ANhLgQ2bj03IaVJIRfO08/P51F+bEsdaCI6B9Lc6vIfnMWd4sKY9lXBy
        MTHXNE/QgyDBoO/doWC5P04FN6rYbps=
X-Google-Smtp-Source: ADFU+vs0iQBeD/d1Ah8bC6+W+ppyObYR2hlhvhXWq3p2zCkoDx5JkCm2fVVYAJQXBjnA2MKMIKKaBA==
X-Received: by 2002:a1c:b743:: with SMTP id h64mr23050713wmf.88.1584297340602;
        Sun, 15 Mar 2020 11:35:40 -0700 (PDT)
Received: from ?IPv6:2001:a61:2532:a301:b98a:7e2b:46fb:d046? ([2001:a61:2532:a301:b98a:7e2b:46fb:d046])
        by smtp.gmail.com with ESMTPSA id y5sm2512172wmi.34.2020.03.15.11.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 11:35:39 -0700 (PDT)
Subject: Re: [PATCH] t: fix whitespace around &&
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20200315180902.13750-1-rybak.a.v@gmail.com>
 <CAPig+cTGqEdr+rjRCfKmcm=ab3vKnUokd6KyrsoBiy=AO9nnOQ@mail.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <0ad0600c-d1fc-0f44-dae1-7bd0fc22b3e8@gmail.com>
Date:   Sun, 15 Mar 2020 19:35:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cTGqEdr+rjRCfKmcm=ab3vKnUokd6KyrsoBiy=AO9nnOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-15 19:20, Eric Sunshine wrote:
> On Sun, Mar 15, 2020 at 2:09 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>> Add missing spaces before '&&' and switch tabs to spaces.  Also fix the
>> space after redirection operator in t3701-add-interactive.sh while we're
>> here.  These issues were found using `git grep '[^ ]&&$'`.
>>
>> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
>> ---
>> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
>> @@ -348,7 +348,7 @@ test_expect_success \
>> -        echo "To be changed and have mode changed" > 07-change-mode-change     &&
>> +        echo "To be changed and have mode changed" > 07-change-mode-change &&
> 
> The commit message talks about dropping whitespace after the '>'
> redirection operator (and some of the changes in this patch do so),
> however, this change neglects that cleanup.

Good catch. t9500-gitweb-standalone-no-errors.sh has 35 of these vs 19
redirects with correct formatting, so it might be better to fix those redirects
in a separate patch. What do you think?

>> @@ -361,7 +361,7 @@ test_expect_success \
>> -        echo "Changed and have mode changed" > 07-change-mode-change   &&
>> +        echo "Changed and have mode changed" > 07-change-mode-change &&
> 
> Ditto.
> 

Thanks for review.
