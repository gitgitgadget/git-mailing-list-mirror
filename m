Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E52CC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617E861CDA
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhF2CFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhF2CFE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:05:04 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D54C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:02:36 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y76so14069263iof.6
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E1+KqMmeJhPXEaJ2cHkYN16nyn3mahIOYF3NtNd2RZk=;
        b=usMR4bzPKxD4lKoN3YSe7kadDVNJ6mukHzvIcwTCNrY+VSzujhHgCIgW1Lg+GNghbC
         7/G5H9tjetyINOiqr6nDfiIsuashH3+765HqFOObILDSfA0RD3XMiRJfxcrcy1cfx3wf
         VB5QtuID6LBQq/mlcfetTmcjJJkqb1i4ivwmiPHRJGqKReraGWtLZiHn2vcXQwC6Vp9V
         iaoqQyNffzzucove8hRNt7gbDQWbrQ9383YWh2QMNYVHUqg8ohATu2W9IYAb7Jyj57KN
         NtL9YwsIURmFsJGVDF+gAadNtlufK6DXVi5hUuKu0qNlTU71MrcTBb8LyH3Mcf3D2/8R
         eFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E1+KqMmeJhPXEaJ2cHkYN16nyn3mahIOYF3NtNd2RZk=;
        b=HpoE44Oi5eveNN+ldKQDQmI7ftZDLcxOlaBGHcoauh4LoTh6xRTQAH0qwJgZnGD4d/
         QdQop8XhpM2a1ghEDnGfGi2cSSHmWaDLt2ZkYCYOnCj2thaoAHnW42rsiGHkFylK+R2W
         xNsttpnLzAaa37XQEMlxVyt7AQDZJc9tT8NAGiQQvC7D/M/m/ccsP6pLwCBjDJkOkm9P
         +FbTF1gCdLjNG7Hxz2zJaOqJrlWdAWMbdHGqVwNd0xfUgAuKZ2fXJI1IjDyPcuX1I4MX
         Hg6kE5SaXR8FtIh+xc9cSjnf30z4tAtiMADXWAy4omakRTqwHzMdFOhzukI4pBRObdSn
         fhVw==
X-Gm-Message-State: AOAM532JxkV6MVamkY72i45ZfuIrtj3zVBvDGIcUK15L9OKEsEbVZEOE
        VhjVl1ZT0VWGyKslUSwe634=
X-Google-Smtp-Source: ABdhPJwouOmzbt6KyI5IWcKedYDYNEEs3GGvIEZeNIOphDpqJ0xAwKM34MwWanG6k504DJImrb0L0A==
X-Received: by 2002:a5d:8154:: with SMTP id f20mr1945409ioo.89.1624932156186;
        Mon, 28 Jun 2021 19:02:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:707c:50a9:e7e5:baa? ([2600:1700:e72:80a0:707c:50a9:e7e5:baa])
        by smtp.gmail.com with ESMTPSA id k4sm10014100ior.55.2021.06.28.19.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 19:02:35 -0700 (PDT)
Subject: Re: [PATCH v6 00/14] Sparse-index: integrate with status
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git@jeffhostetler.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
 <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dec05200-75a9-fd60-8ab3-1c0b51d2c946@gmail.com>
Date:   Mon, 28 Jun 2021 22:02:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2021 9:51 PM, Derrick Stolee via GitGitGadget wrote:
...
> Update in V6
> ============

I'm very sorry for the noise. I was working on my cover letter and
adjusting the patches relative to some nits I discovered, including
the ordering of some patches in my larger topic on this subject,
and forgot to push those before submitting the v6. Please ignore
this version. A correct v7 is coming soon.

Again, sorry for the noise.

-Stolee
