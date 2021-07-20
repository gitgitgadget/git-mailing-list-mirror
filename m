Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC9EC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 13:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E073761165
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 13:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhGTMUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 08:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGTMUN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 08:20:13 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34907C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 06:00:51 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id a7so19043045iln.6
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jDLKWPhNpnVgBie0SP2U3MapzPS7Fk1ZvmAQtYcygks=;
        b=CARpn3h2km1txHm4yCBLBsXMa6NeuFwNCJL15Ma6FvdmlSK+GYOlQB0sCLld876xTB
         5qN4ghfVWyn5JJ+0q7IDY4rzPkmRXJuLKeYROkpaM5yC5MY7VR84+gpa/a15d9uTwNuY
         sPNamIWwRFZIk/k2UBjiZd1y2hlxtCq3TpD9/UAOluL4HdhX8jPAcSu0fm9lBAWzgWzy
         4a2XtaFwEtOTuqItIZzm1Zief3Eucl96XQsqO8rrh6ibM/8LoxVBs8iCOyQ5tNWkxO+j
         jQYyzS62opxDFmNnk54qS0X70/GS4OD5QaGy4+OnewdixOd6wyvcL2/dzhcyj736gx11
         cHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jDLKWPhNpnVgBie0SP2U3MapzPS7Fk1ZvmAQtYcygks=;
        b=QsBL+Zb1DnUIubGyasOkcubvngGLHZUbU96N/PG+/meC3TyTtTLRiEJlN5TcchA+3L
         Etb92tppDZJd6s8Mf+HBZRWv1eG+sLL4U4EExtjnRo+1yhlDbWQ+4gSsLJbryREjffJC
         yuXZP0XEzuGCjSir/N+7O5lf7RDF/URE+FE/G+x7sdSa0TlEvqBOeMioyO7iQXq/wRUO
         z29EHAlquYqO+3B3kwjayDLrhj758d31HmkbG0S4zljczJcNFLWiKpaMRy711pEe/GNK
         zXgM3M3uDF+BQxHILmmv/hY+v2/EVtv8b2VXw1ce+76KttOU1T2rdQlyYQi1hTQr/EqH
         CRqQ==
X-Gm-Message-State: AOAM530PvnGsfrgXQFwGsBJ/r42DDutvE4xLXgMIg/PPJr8L923NHmAf
        sqdcNrnPimAOmKh3q9aI3tQ=
X-Google-Smtp-Source: ABdhPJzssVR4/VSEjE5H21egtO7y02jJZ7GJ/TPF9CVztAhbKOUsohDLtiRbIcHf3RrxtRRN1rIXGg==
X-Received: by 2002:a92:d80c:: with SMTP id y12mr21013010ilm.30.1626786050542;
        Tue, 20 Jul 2021 06:00:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:edd1:69f6:c801:b756? ([2600:1700:e72:80a0:edd1:69f6:c801:b756])
        by smtp.gmail.com with ESMTPSA id z12sm12439110iom.6.2021.07.20.06.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 06:00:49 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] Optimization batch 14: trivial directory
 resolution
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
 <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1eeec718-a315-c038-d54a-4503a5ca88d1@gmail.com>
Date:   Tue, 20 Jul 2021 09:00:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/16/2021 1:22 AM, Elijah Newren via GitGitGadget wrote:
> This series depends textually on ort-perf-batch-12, but is semantically
> independent. (It is both semantically and textually independent of
> ort-perf-batch-13.)
...
> Range-diff vs v2:

Thank you for making these edits.

>      ++struct deferred_traversal_data {

In particular, I think this new struct works rather well.

This version LGTM.

Thanks,
-Stolee
