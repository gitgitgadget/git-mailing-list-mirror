Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E90C4D2D6
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9646F24784
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C18M52fE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfLMT7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:59:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38750 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfLMT7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:59:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id k6so215751qki.5
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/K3UnTF21+MZMLvRfjHvwtHgurHc4e0HAMOCJ1okq8Y=;
        b=C18M52fEOghTYYB4qstV3u1T5Uqh2BEVPsataCFFv9NQwNKtK/66iKq6wlbX1fHI+C
         ftg4XXnpPAL6/WxCw+HqucZuzFdew7CqQa+MsyW3MN05l3xscLJIbipbWHK4sbIMwfMC
         1h9YN2p925WZiD3ITcSi7eP1mjmLKC64KBH2Kkpr7OWwbmo+ndolEcJb5PaPt9DtPvJN
         Uo+Sofn1G61PrD3lzSv16NWmGwYMmB5yFe99ZDVhMF4bFnf6BsSBSNUqmV04sbU11Lb+
         GpaIzmcbwGb2RIU23Jpm6rKRYMGCFWtm3bWsCCF7XMZgS4eHJHcNLqBS1tawUcZLpajE
         BGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/K3UnTF21+MZMLvRfjHvwtHgurHc4e0HAMOCJ1okq8Y=;
        b=iC+Yh6/HUGPuLL15jRGjWTEIWXEVyVOqxv8jz4T2FxIx5qZG+wx57qmyetFYmf2oiJ
         CD88UdCmjGBq2WQ8orYxv93wDl+HbR/95QoDXa7H+gKG8VSvTABiOBZ3n4hdt9xkl0jk
         EDVGcajbLkp0ALtEgtocRZSq/aibOI0LumWTPChO70xIH48OmhtGGuy5nnr8qHiZEm1r
         jYEtskkfpb+4KOiBEYUFabODKATM3kQwGVjzsOecnYORir/YC+zLXsaGJYejPZF/aqZB
         ufUZBY63SxwKSr0NSmRWOyZdUKmNPxWm6nYCIC629Pm9npdhz2HpjM93jmVSRqc/E+SM
         wEPQ==
X-Gm-Message-State: APjAAAXQEdVF/GV/hwbhRPI3Xa7qeB3IYL8xC6bv88mF2S7TqhBmwXsf
        DoeDLQori/Onx9Qm3PaXrF6jdejiNPg=
X-Google-Smtp-Source: APXvYqz5SmpuqSuwy0jIeHzSfa9b/Z+94+4P3PXgAQ1mSbEOpeBTtFVVjPmQuVCTONCt1DSLvO8KLg==
X-Received: by 2002:a37:a642:: with SMTP id p63mr15641868qke.85.1576267138281;
        Fri, 13 Dec 2019 11:58:58 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:1414:e94c:6df7:afb8? ([2001:4898:a800:1012:c547:e94c:6df7:afb8])
        by smtp.gmail.com with ESMTPSA id i4sm3117634qki.45.2019.12.13.11.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 11:58:57 -0800 (PST)
Subject: Re: Parallel fetch and commit graph writing results in locking
 failure (even on linux)
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@vger.kernel.org
References: <492636883.190386.1576264842701@ox.hosteurope.de>
 <bdb9201f-b77f-ab3c-251f-d902c76fa9bc@gmail.com>
 <20191213195215.GA862734@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b7d5a758-9753-bb8b-f66e-6435fb19046b@gmail.com>
Date:   Fri, 13 Dec 2019 14:58:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191213195215.GA862734@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13/2019 2:52 PM, Jeff King wrote:
> On Fri, Dec 13, 2019 at 02:35:47PM -0500, Derrick Stolee wrote:
> 
>> I don't think so. I think you just found a bug where the
>> fetch.writeCommitGraph logic doesn't work with parallel fetch
>> jobs (only one can write at a time).
>>
>> I believe the fix would be to write the commit-graph after
>> all of the jobs have completed, which should mean we need to
>> move the call to write_commit_graph_reachable() somewhere else
>> inside builtin/fetch.c.
> 
> This should be fixed in master by bcb06e204c (Merge branch
> 'js/fetch-multi-lockfix', 2019-12-01), I think.

Thanks, Peff. That exactly looks like the right fix. The
actual commit is 7d8e72b9 ("fetch: avoid locking issues between
fetch.jobs/fetch.writeCommitGraph" 2019-11-03). I had forgotten
that this was already fixed.

Here is the diff, for reference:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8d27f8abb7..20bcda09c4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1602,7 +1602,8 @@ static int fetch_multiple(struct string_list *list, int max_children)
                        return errcode;
        }
 
-       argv_array_pushl(&argv, "fetch", "--append", "--no-auto-gc", NULL);
+       argv_array_pushl(&argv, "fetch", "--append", "--no-auto-gc",
+                       "--no-write-commit-graph", NULL);
        add_options_to_argv(&argv);
 
        if (max_children != 1 && list->nr != 1) {

-Stolee
