Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB09C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FC32070A
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBftG8Uh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKUNqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:46:01 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41412 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUNqA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 08:46:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id m125so3029690qkd.8
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D5eAvvzBn99FXOToiqDgrKuRM2D4svuh2DcKBUHnfsQ=;
        b=tBftG8Uhm9zyJJNyZ5SnJOZxRxGSICFlj1KqIiLy4VaFkCs4lSVS0GgiQ89zuE0mEk
         Z0joTdK++9GcjtKZiARoG0qfTQReq6AdzF/ERv1lz0HM8gb0w9iStSF7z7i9IKkQ5kZ0
         w1rWSNEN65ytNDlqanU09TlzZjwY5hpq/+Gash2TL6hxlw1u0WgfvakBELftmNUbjSrD
         GN6wVikoUJqx4I3NYkFF27h949czjHnydUOMqNqIoNN4TIGIVW/1aS6zbuzvJ3V0Mh+m
         dylieZOJ7Nsf8fMhxXOsmNuM3BODHHfLMRXYi+dBDVnZY++uSrjrR0giF3hRANqQR16A
         K9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D5eAvvzBn99FXOToiqDgrKuRM2D4svuh2DcKBUHnfsQ=;
        b=jsTn6nZ9YmPZp78EGVG3oBz731dS6wFcZlrD11/ygEJDl50xgy6/XLphsPJmHUdMIJ
         N+Nw4O1PxwgDOPlkiHar3fq0psoal6qslOK21Uye3WSXAS4WhTF3+YaFSQHPkIx9dTWM
         QkBEEelHn79k/DuXZLFVcOhn76z99NXrFK0BcKDImrngFTGQJbpwEasNdZkldPSgrjpT
         zzeQjJOUu0Qb1/8sYeULBdKuvg5xwFwgsHJ4P+20p8U6liYYaQpaswKaNklbCMHe24hE
         m2wkRZNssrtahTP53jkpSl1qX9yVN7Tm7gtkCOkqB9DFjQKl86YyWnlaLa9qK0tmDxrM
         lImw==
X-Gm-Message-State: APjAAAVfOD0DCnQ40JfN55rRNDxNjmP17SGwZgxcTgV8Sd1koV/t0vll
        GDlB/i6qwWks63HIX0/krVA=
X-Google-Smtp-Source: APXvYqyTfBMYU7jShVFDK4ZjWenxljvp/zmj0bb5scUQN4DcjekyGhQqX+Steb0y7uNzCv/p8M41Cw==
X-Received: by 2002:a37:5603:: with SMTP id k3mr8008365qkb.346.1574343959478;
        Thu, 21 Nov 2019 05:45:59 -0800 (PST)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u7sm1349302qkm.127.2019.11.21.05.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 05:45:59 -0800 (PST)
Subject: Re: [PATCH v5 10/17] sparse-checkout: init and set in cone mode
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <0258ee80265f5f27a7de9b81eaf166648b4511d4.1571666187.git.gitgitgadget@gmail.com>
 <20191119175046.GK23183@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c6f641bd-8e26-b8c4-6456-65d480952ab2@gmail.com>
Date:   Thu, 21 Nov 2019 08:45:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191119175046.GK23183@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2019 12:50 PM, SZEDER Gábor wrote:
> On Mon, Oct 21, 2019 at 01:56:19PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> To make the cone pattern set easy to use, update the behavior of
>> 'git sparse-checkout [init|set]'.
>>
>> Add '--cone' flag to 'git sparse-checkout init' to set the config
>> option 'core.sparseCheckoutCone=true'.
> 
> It's not necessary to run 'git sparse-checkout init' before running
> 'git sparse-checkout set'.  The description of the latter in the
> documentation is not explicit about it, but the commit message adding
> the 'set' subcommand is, and there are several test cases that run
> 'set' without a preceeding 'init.
> 
> Therefore, I think the 'set' subcommand should get a '--cone' option
> as well.

I will take this under advisement, and revisit it in the follow-up. The
recommended usage is to run 'init --cone' first, or to set
'core.sparseCheckoutCone=true' before running the 'set' command. We can
improve this pattern to be more robust in the future.
