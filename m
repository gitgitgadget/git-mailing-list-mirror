Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2764AC433E1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 01:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0193D2076C
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 01:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7G8sfZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgF3Bpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgF3Bpe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 21:45:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E3AC061755
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 18:45:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 145so14714975qke.9
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 18:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GhR+OrbdfCFW/uTObA/uIb5Wg7veLlstcNHN5ecVhDk=;
        b=S7G8sfZw6Gi+CWv+T93NseF3d92g0pyiKQ9G7aA7AyeM9JwIIl73Zf3IM+u5r/QXKT
         AIVq7cNcJkk4h69I4IR/u4c5TpUtOeeRD8pwSwAx2UluEbZgmciVA8hy3KVRIY27UbJH
         jdKAPWp0/yYS29zKQNmG0ADbjpNIjAhe6ZbeuM6XzCqFdlvNePo3gt4GeZU0J2sPUIiH
         d4gdil7FeAjN8mn8Q5WaPE/hGMXjg/QKvooWpEbh8coXxUhqCrOpjqeVY6mmX9kPRZYO
         9ZIm5kb9Vyb2S6xFP24omNjEmC6FQYeXBKCy2pfFLSABpCwW2yeN038Jp0hesEzizrmi
         6ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GhR+OrbdfCFW/uTObA/uIb5Wg7veLlstcNHN5ecVhDk=;
        b=Kq0xY8r/qn1z/sTBkDqRfbk+9hxhIYfS/z5gmhbyVN+BWrjIE0IyimXgjkyvhZW/rU
         Rgv2oX2vB7yw4XFt2RC8HHhe0darQfji4IQ3e1FkpsO2y4CDv0GZaBBNy5MErpieNBG1
         C0SrfUQ4q03zxqGgaKybXYQyDIMd/K7dI1Am5mfD1+0sHFzf4zga/wTqIWveyufEug9q
         lwJ1/U457xBMaw7vLidbCs1P9Fm2vwNzYG/C3l3PVs/q3+dijZWdtj9XWhaGGMv0nOvo
         5ulriVXaILceCkMt+U4yxB9egCND8Y10aD2+Cg163VBljN3vgT8oIphLUGP+EZfZqcdv
         cK2Q==
X-Gm-Message-State: AOAM532jR7OJD8p25SFqoVY8F8Ww5fBcEKtSNyiLP4V2S0RDBptoA+q3
        /AAuYBZGA7Y6OZOyazkSH0g=
X-Google-Smtp-Source: ABdhPJzt26CQpGoPdT1e2PO4bICDZ/fEyjrLlOkxfKx7w2EoeMtKfiO/vYCr0W0v6K8kxwTPq4x8CQ==
X-Received: by 2002:a05:620a:40c1:: with SMTP id g1mr17847431qko.391.1593481533483;
        Mon, 29 Jun 2020 18:45:33 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o5sm1936815qtb.26.2020.06.29.18.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 18:45:32 -0700 (PDT)
Subject: Re: [PATCH 1/2] commit-reach: create repo_is_descendant_of()
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, avarab@gmail.com,
        abhishekkumar8222@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.664.git.1592414670.gitgitgadget@gmail.com>
 <8f7fd8f5941426c3ed7fc28c6e4afd62bcd4bb8d.1592414670.git.gitgitgadget@gmail.com>
 <20200629134035.GA59624@syl.lan>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8dc7ae37-8587-b055-d18f-75a153129026@gmail.com>
Date:   Mon, 29 Jun 2020 21:45:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200629134035.GA59624@syl.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2020 9:40 AM, Taylor Blau wrote:
> On Wed, Jun 17, 2020 at 05:24:28PM +0000, Derrick Stolee via GitGitGadget wrote:
>> +int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
>> +{
>> +	return repo_is_descendant_of(the_repository, commit, with_commit);
>> +}
>> +
> 
> I don't think that it makes a big deal either way, but I wonder about
> moving 'repo_is_descendant_of' to the header file, and making
> 'is_descendant_of' be 'static inline int' as you defined it here.
> 
> Since this has already graduated up to master already, I don't think
> that it's worth going back just to shuffle this code around, but I was
> wondering if you had any specific reason for doing it this way.

I have good news for you. [1]

[1] https://lore.kernel.org/git/20200623184222.54201-1-carenas@gmail.com/

Thanks,
-Stolee
