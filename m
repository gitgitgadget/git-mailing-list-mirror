Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6A8C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 07:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiBXHOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 02:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiBXHOS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 02:14:18 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1719C230E6C
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 23:13:46 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d5-20020a623605000000b004e01ccd08abso823190pfa.10
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 23:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l0g4SftYnDpMLgTL4AxVdO3SLr3hfp+59lIkf9rW5gY=;
        b=EKXFc3/lNaEFMzwrk/bhbYVwqrkRZsu7ce3s2Uzoaf45v8T/TOcW6/MJMD9DO+xNDY
         Wcl2dvLh/6rg4ypWf57NxG2sSzyH14zf2kkqKilCKgFWFZoIMMfGs7UGz23qJ01qNyOn
         Z+U9ScQHvnh5nnxy+PZ2hSEb+ltCU/BhUCUhMvmja/CuX9yxVhYc/n27P86m9HZfsUJW
         cDWMzrEbj+hkAo3kpdt1Z5RQxEOZybRmPfFgbQLy5JHZz3h1zHuyRHCN0xz6JPy87lpj
         1pa2Sdx/lkp/vdz+SGsFtOzwZTiOHtFdcpBNZR0HV7I8HqIyg5hGCgaTyFGGHYhuUP1N
         bQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l0g4SftYnDpMLgTL4AxVdO3SLr3hfp+59lIkf9rW5gY=;
        b=pHQMdagNy0UMbtbTM2E/DoAiZFVmzVP/XEGY/dtnDSvXIYZtHwwuWJ0oP6iGFxBZsi
         HDqIhE9uGk9dEPCkbdXmlh4rgQ8d3l7yL44Sku3bsDcls9Sg1PMqOWbn7cszx+9jtO5t
         2X2m0k9GqSd7Lbe5rHviBBY45ASyDfNXBQzW65TTtt/Y9SKARKs6tFkx7La1pJ//iFZh
         tWCgEjtnraFGkluSn2PvFCYcj4B+xEJxaf7aXUrxuuaxu30nlC2C4v4n/HqnLEZ7+xQx
         8riE7SA1EmbxRHD5BpUwgGVGlIowKNzFLdWFajE5FevtQm3lReRASQlgUDBf6MSQbW69
         cJ+w==
X-Gm-Message-State: AOAM533HtbfS2S5voUPC+tm+uRN5fPC0Ss1tePHF2fIBQKeYlOO/dR8A
        yfIw34dKR7oZE7omaTghqhZPfiqwdDV7dQ==
X-Google-Smtp-Source: ABdhPJyC84JrfvGWc6/d7oB4rZUynfW4GlpMq1e0Mjkg7JyTWOilTyPuPHVHbYp52yXjJ1GWuXm0YdM9px06Ew==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:d481:b0:1bc:7850:6403 with SMTP
 id s1-20020a17090ad48100b001bc78506403mr11191139pju.63.1645686825513; Wed, 23
 Feb 2022 23:13:45 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:13:29 +0800
In-Reply-To: <xmqq7dao1e5m.fsf@gitster.g>
Message-Id: <kl6lsfs84u06.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <YYwxVO7A29FcN+hN@coredump.intra.peff.net> <20220124205342.41450-1-chooglen@google.com>
 <xmqq7dao1e5m.fsf@gitster.g>
Subject: Re: [PATCH] stash: strip "refs/heads/" with skip_prefix
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kraymer <kraymer@gmail.com>,
        Daniel Hahler <git@thequod.de>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>>  	branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
>>  	if (flags & REF_ISSYMREF)
>> -		branch_name = strrchr(branch_ref, '/') + 1;
>> +		skip_prefix(branch_ref, "refs/heads/", &branch_name);
>
> The branch_name variable is initialized to a constant string "(no branch)",
> so if HEAD is poihnting elsewhere (which you could do manually),
> skip_prefix() would fail and leave branch_name intact, which would
> give us the desirable outcome, too.
>
> Looking good.

Hm, did we ever pick this up? I dug through the old "What's Cooking"
mails and didn't find any mention of this.

Admittedly, this dropped off my radar until performance review season
reminded me of this. Though now that I say this, it sounds like I want
this for the sake of performance review :p

(Which is not the case btw, I just want to scratch my own itch :))
