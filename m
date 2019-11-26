Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41838C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18C420727
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="magQ6rR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfKZPjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:39:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46392 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfKZPjT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 10:39:19 -0500
Received: by mail-qt1-f194.google.com with SMTP id r20so21805886qtp.13
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 07:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Co5qL60VqtlL71ZSQJKqABpeamm2WBXW2jhCC7EjvG4=;
        b=magQ6rR0q107ExPzMxSeTxMdhgkkjE161dM90cZok76JTFzqBFRCbFHmXZtnHy55Po
         tSvN90gW9Lt9mrmejo+O9SYNCMN+QTwCse9bV/yAhyenxUnR2CdgpKYK3S7pusTPsQ0j
         SkG1bVvWGitlZwf8JK4BsIVzE5cfMoetDOK23tP7/nJU2qkM1whmsu6C9wrQb7E72eYg
         wyBLPDK1dKHJWl1fM9dr95EhVB2d+vEXhJzzu09Gra2/s/m82WU+jvIL3Fd6ikYqSwZf
         CajU3JHMhawshHtINbRFXR2z1FGjeK50Iwo7b/e+8RLNAnTxCcbSiyK2pB/5kjEN96jU
         erGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Co5qL60VqtlL71ZSQJKqABpeamm2WBXW2jhCC7EjvG4=;
        b=lk85zU4oWJ1oBDr8yMSk/XyQh9e4pON18r6Od/QmKgQrra8ygaN6zjNVWyKWZn15KV
         TiG9ysLjN55f4v5sTIzO+CRvLDUuyXI/eaI17qRkTwYseLKVVD8aaW3J09BXXpqkBofa
         KlfteQA9V7B59jn7O2DffSDRzNkmNuroY0BgXyRhiKVFl7SroLkgA3jhuPMN9dpwTj6E
         w1Y0uSlGQPEId4xpX4DhYkKE4z14C+Ia96LvM6teU36c70W3eJpXizPZkdAMxFrdJ20g
         p12osqFgfdqJhXG4wRvVeY8XkiaHvyfemi0sACeIDdUKHuxFagcHFNB37os0If8WN2PN
         lWLA==
X-Gm-Message-State: APjAAAWzLQgCQKuRpKO9LctT/c2QVz6Gn4FCZw38PrHCFAielQooTxF1
        KoYHJOLaz6za6Vaw4PAZEzo=
X-Google-Smtp-Source: APXvYqzH9i9eNP2Ou+cag2TnBHY6vszT8cHJUwSjgumKiBi95+LdlMlmBbpyQumXiBR10umQjXArjA==
X-Received: by 2002:ac8:2fba:: with SMTP id l55mr36281304qta.167.1574782758486;
        Tue, 26 Nov 2019 07:39:18 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:2c81:2de5:cc0c:502? ([2001:4898:a800:1012:ddb4:2de5:cc0c:502])
        by smtp.gmail.com with ESMTPSA id k196sm5253468qke.97.2019.11.26.07.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 07:39:14 -0800 (PST)
Subject: Re: [PATCH v5 0/2] commit-graph: use start_delayed_progress()
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ryenus@gmail.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
 <pull.450.v5.git.1574717303.gitgitgadget@gmail.com>
 <20191126122022.GB10290@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fe7c0e41-8379-4933-4ff1-026d3f1f8472@gmail.com>
Date:   Tue, 26 Nov 2019 10:39:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191126122022.GB10290@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26/2019 7:20 AM, Jeff King wrote:
> On Mon, Nov 25, 2019 at 09:28:21PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> Update in V5:
>>
>> I took Peff's advice for using "env" to use this delay in the GC test.
> 
> Thanks. No further complaints from me. :)
> 
> There's an open issue to investigate unpack-trees sending progress to a
> non-stderr tty (which you can see in the test suite by setting
> GIT_PROGRESS_DELAY=0), but I think that should be handled separately.
> My limited digging suggests that it goes back to 2007 or earlier.

This is on my personal to-do list. Thanks!

-Stolee

