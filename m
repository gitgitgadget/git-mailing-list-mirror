Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084F6C00144
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 17:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbiGZRky (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbiGZRkf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 13:40:35 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930B183B6
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 10:40:21 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g10-20020a17090a3c8a00b001f3026313e0so315386pjc.7
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TNiDKIlVlhHmlLRPSIAX0iYQIiA98ASnUYpJxTs5tD0=;
        b=phzz/6izD3JbrKGV0ukq1VK5AgHRgB5W03bfJYENMOtT7vkAxk8osNqYlvMPhY8j/I
         iepPdOtM4T/LjWMwCK9+vBUvTsyTAxvNdfh5dQwFnvyJzwMjUa9socmeeNHxTyjpsdzg
         Cgw54s20Gzx6lEEnIDYnzUCzXa1bskEQmlwaJl1t792NOa1kJ6XbEU0K8UnH4kcBIlrS
         NyYCK28xsAvdSb6tHTOEotEKoxlGSiSZH48XtdYwriRhScAVfd49b7jC40KKtX209b7k
         1fuej2UsZfAFT9+XYSl93wfL0Ub+M80pbBbKLJu4a1S306S06MaChhul+SEgwEdQPwgs
         RmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TNiDKIlVlhHmlLRPSIAX0iYQIiA98ASnUYpJxTs5tD0=;
        b=7WHK8PrdeC4vRaB/fghb52E7Icoubk5CGkTXMRu3K6qjf3p+wCID1WdYnUomkpam1k
         bmpt3IlsFLwiuLGEoAgAUPH6hWydNNsXdPo0uuqBNVvMnXbPJbzmWa2MEhjMc5xcQPDT
         puLePK4dXjAY4OGTf3/vH9RwfvXK4B6ABzGfK7A0QyZpDveHnyM1GLRAejF0yM0cA/VI
         aDP1Jz6LtJf8WOsgLgoZoBssMENyXjr8I9bnOOLRifXaySloT0ZqkayuEL+ZF/yTOfHh
         IQPvBaXJRC4vF9dvOM7rU/5qzoITd0cfJZqYG2A2CP4qEuUjcyAbW+/iXQYwDDQHORAJ
         APQg==
X-Gm-Message-State: AJIora+b3fJ/dxbEx7S6Zi+Lg84tPegI34FvmhORhhPOezQT9MGTaGtI
        Qv50U/y7+2MdPv4bPYn6imk4LS6SEjHAzA==
X-Google-Smtp-Source: AGRyM1v7g0AjrtUxqo9TBbJ8AJ3RyWQgha7ImAUr9GhTVwxUFBW35KB6j2OYim/JioUOMpIPHHbu6oUnpR6cUQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:41d0:b0:16d:4841:214e with SMTP
 id u16-20020a17090341d000b0016d4841214emr17336337ple.13.1658857220295; Tue,
 26 Jul 2022 10:40:20 -0700 (PDT)
Date:   Tue, 26 Jul 2022 10:40:18 -0700
In-Reply-To: <YuAj+eBajf6jkJPc@nand.local>
Message-Id: <kl6llesfsrgd.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com> <YuAj+eBajf6jkJPc@nand.local>
Subject: Re: [PATCH] config.c: NULL check when reading protected config
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Jul 26, 2022 at 05:09:32PM +0000, Glen Choo via GitGitGadget wrote:
>> From: Glen Choo <chooglen@google.com>
>>
>> In read_protected_config(), check whether each file name is NULL before
>> attempting to read it. This mirrors do_git_config_sequence() (which
>> read_protected_config() is modelled after).
>
> s/modelled/modeled

Ah, thanks.

>> Without these NULL checks,
>>
>>  make SANITIZE=address test T=t0410*.sh
>
> I'm glad that t0410 was catching this for us already, though it is too
> bad we didn't see it outside of the ASan builds, or I think we could
> have potentially caught this earlier.
>
> Either way, I think the test coverage here is sufficient, so what you
> wrote makes sense.
>
>> diff --git a/config.c b/config.c
>> index 015bec360f5..b0ba7f439a4 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -2645,9 +2645,12 @@ static void read_protected_config(void)
>>  	system_config = git_system_config();
>>  	git_global_config(&user_config, &xdg_config);
>>
>> -	git_configset_add_file(&protected_config, system_config);
>> -	git_configset_add_file(&protected_config, xdg_config);
>> -	git_configset_add_file(&protected_config, user_config);
>> +	if (system_config)
>> +		git_configset_add_file(&protected_config, system_config);
>> +	if (xdg_config)
>> +		git_configset_add_file(&protected_config, xdg_config);
>> +	if (user_config)
>> +		git_configset_add_file(&protected_config, user_config);
>>  	git_configset_add_parameters(&protected_config);
>
> I wonder: should it become a BUG() to call git_configset_add_file() with
> a NULL filename? That would have elevated the test failure outside of
> just the ASAn builds, I'd think.
>
> There's certainty a risk of being too defensive, but elevating this
> error beyond just the ASan builds indicates that this would be an
> appropriate layer of defense IMHO.

Hm, if we're going in this direction, what if we made it a BUG() to call
fopen_or_warn() with a NULL filename? Then we wouldn't have to
reimplement this BUG() check in all of its callers.

>
> Thanks,
> Taylor
