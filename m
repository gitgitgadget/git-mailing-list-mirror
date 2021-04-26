Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5176C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DAD61139
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhDZQNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhDZQNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:13:30 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDADC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:12:48 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i81so56938749oif.6
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DFaWkF8m+jJI4mm0LDxY4migly7qECNVz/iuUIBsoUc=;
        b=Zk6QBVRFdL/JLrlX0YsJh2GjOVLvLNdu2jDHlHVrFW+/8sYbRV6z+GL0hvyqdrITOR
         eXxGNmzCzmxrAKtS2ssT7KPs8hckS5qoGHqEm7sVBfIZIU3TGMvnkyA43acdBw7UitTk
         WpETbBHrfa09qX2K4aGz5PWWy223VFtO8uMCs0SXrOeGBLSQvYqevPn5GomHC20dL0Ck
         7WpozPYZaSEgGXreTNOnzqH+OFK+VuQSoH5EPC1TZexF+4AYiQQ0LlouPtY3x1qYYy/j
         IEwFgSEnEjmiGY9VYpcVknRKmdpF2cozICM2kNhel71D8zJpVZGp6WvDvNGsDH9R0yzF
         okdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DFaWkF8m+jJI4mm0LDxY4migly7qECNVz/iuUIBsoUc=;
        b=fudFQse3GdSaXPXncijHio4kJ5syxVcPbyosvd+gBw9ks3crClVEIauvihyf2MOHok
         L7ZsoYWhk36TMRLAOMH2k8mvCL9c6f3QwtdVJ0yUNYh7d8NkqxTHUf+2XJkAx8o47tW5
         e6w4168LQFNZOtXWcc03/PvavcA05M+HZoPo8pznYUTdaP9ZmtEMxVeDEadSH3iVYx0U
         NC0BjrDUfrddkmyXEaKKH+7YgZBNizt3YcSRooPeBYWNE8q/wo7aXwS+iM9csfZXYB9R
         tOydhS1qzc1THKB6dqB+rmBCZXHTqx6cHOmYb6RuXtzNwHyhj91BrD4bEJfPJTyXQhxg
         LT7g==
X-Gm-Message-State: AOAM530ozmlDjEXpaod7NjyWyyLQYfx4lw3hL3Bt0xwg5bGQ9Pq8sXUz
        6xnXe3cuS0EM3NQ7eBQPe8E=
X-Google-Smtp-Source: ABdhPJyEmEnBMCiE1XeM+ou6tz0HHq0qbVV8BckwlVYSRAcbnQ+iDacMSlzzCUs+ZBymXh951trUow==
X-Received: by 2002:aca:2316:: with SMTP id e22mr1846721oie.53.1619453567997;
        Mon, 26 Apr 2021 09:12:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:65f6:360e:4aa8:3d0f? ([2600:1700:e72:80a0:65f6:360e:4aa8:3d0f])
        by smtp.gmail.com with ESMTPSA id d62sm3112703oia.37.2021.04.26.09.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 09:12:47 -0700 (PDT)
Subject: Re: [PATCH 09/23] fsmonitor--daemon: implement daemon command options
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <2b291d805d59b54203d939e048bb568782d5e17b.1617291666.git.gitgitgadget@gmail.com>
 <91a0fc4b-505a-fa2b-c797-5e420e836642@gmail.com>
Message-ID: <3aa3c802-0ad1-0a65-d646-0cd574cb8036@gmail.com>
Date:   Mon, 26 Apr 2021 12:12:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <91a0fc4b-505a-fa2b-c797-5e420e836642@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2021 11:47 AM, Derrick Stolee wrote:
> On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
> ...
>> +	/* Prepare to (recursively) watch the <worktree-root> directory. */
>> +	strbuf_init(&state.path_worktree_watch, 0);
>> +	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
>> +	state.nr_paths_watching = 1;
> 
> Yes, let's watch the working directory.
> 
>> +	/*
>> +	 * If ".git" is not a directory, then <gitdir> is not inside the
>> +	 * cone of <worktree-root>, so set up a second watch for it.
>> +	 */
>> +	strbuf_init(&state.path_gitdir_watch, 0);
>> +	strbuf_addbuf(&state.path_gitdir_watch, &state.path_worktree_watch);
>> +	strbuf_addstr(&state.path_gitdir_watch, "/.git");
>> +	if (!is_directory(state.path_gitdir_watch.buf)) {
>> +		strbuf_reset(&state.path_gitdir_watch);
>> +		strbuf_addstr(&state.path_gitdir_watch, absolute_path(get_git_dir()));
>> +		state.nr_paths_watching = 2;
>> +	}
> 
> But why watch the .git directory, especially for a worktree (or
> submodule I guess)? What benefit do we get from events within the
> .git directory? I'm expecting any event within the .git directory
> should be silently ignored.

I see in a following patch that we place a cookie file within the
.git directory. I'm reminded that this is done for a reason: other
filesystem watchers can get into a loop if we place the cookie
file outside of the .git directory. The classic example is VS Code
running 'git status' in a loop because Watchman writes a cookie
into the root of the working directory.

Thanks,
-Stolee
