Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0126EC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A9864F16
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhBXRg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbhBXRg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 12:36:26 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53033C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 09:35:46 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d9so2885380ote.12
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 09:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=zE3A16C3YBEEB84Ivb9vQA+isw1D7EJneGacOn5+4jE=;
        b=NOi93h4z3MYM5BPA8SU3AQ19AFKIGY/gb2gv68YWosjIfJB3+ayR1BeAj6TIF2qMxQ
         LkNCwGoCyYJjnkCbDpLM9Uu1ZZxWvEUaAzlYLTmg6CaXnkFJSapHVYdHW7abKW0SCjO+
         N9fn/uMLse5TVFasxeijwltHVGl94xr2lfrZUc2PUle1877ebDzaIOi/FAhWWC0uuqDE
         3raANAaQsN0tMotYPFlgFQUS9/lebDGU+Xuy/eBOxk+hTJJQ1uVqtcCRAiDoWegCfyL9
         K3HYKKht3esMbIlXFq1IUb2a1fGGYYqcxlc0ZjfJxjZ+F9LOK71Pa5z7kaF2a9KN/e8b
         u8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=zE3A16C3YBEEB84Ivb9vQA+isw1D7EJneGacOn5+4jE=;
        b=LWWvC7CMe78wGltWdUVJCWXHiyQT4gUiPgtq5fl6qaPwdl2b6DqsR5AKc2B4vQBsS3
         8vJBL7E/Wx58nl1Xe19rGrF0S/ocFaYoZTuJWfEaT5o3aVdvz4UPOGpBZ9mgd0BL3ATo
         a0vPNKswIB6CfgZdN3tYeWU0dLeEM9jPRymBy3vBfHhuf8CzSi9lqA6onscx6QMXL81+
         ZaQKQaL/7qU+2qOKfszf/a53gPXVozCWm08bRlln5fbs1tbVDh0oX86VJRkmYgu2ot+d
         +LlFiTsZpITwK9SPsZlBuVfAEdEa4LH1sCVApi5jnF2rjzNsydJoHKKEzpUwc/nlr4tw
         jTxA==
X-Gm-Message-State: AOAM53211BMC+xEuFNBI7BaITfulhcHd68VjvqNE7XocRWZT7ii+SCmA
        0lTad12Fa0G5friU+2YFFtnwv8rpAXd6sw==
X-Google-Smtp-Source: ABdhPJxmXcQ1QxufONuu5+fZQYd+/51yM0h15jJqQxLlgzPVYyfl5aGNhyrLrI279lIXC/ICtn12Rg==
X-Received: by 2002:a9d:261:: with SMTP id 88mr24529285otb.310.1614188145673;
        Wed, 24 Feb 2021 09:35:45 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:d50a:c289:effe:68e4? ([2600:1700:e72:80a0:d50a:c289:effe:68e4])
        by smtp.gmail.com with UTF8SMTPSA id 43sm494205otv.69.2021.02.24.09.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 09:35:44 -0800 (PST)
Message-ID: <aaf7c657-ef16-7612-166f-01560918d82d@gmail.com>
Date:   Wed, 24 Feb 2021 12:35:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
From:   Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 08/10] diffcore-rename: add a new idx_possible_rename
 function
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
 <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
 <cbd055ab33998962cb7712906cdad5dff3390660.1614123848.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <cbd055ab33998962cb7712906cdad5dff3390660.1614123848.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2021 6:44 PM, Elijah Newren via GitGitGadget wrote:> +static char *get_dirname(const char *filename)
> +{
> +	char *slash = strrchr(filename, '/');
> +	return slash ? xstrndup(filename, slash-filename) : xstrdup("");

My brain interpreted "slash-filename" as a single token on first
read, which confused me briefly. Inserting spaces would help
readers like me.

> +	 *   (4) Check if applying that directory rename to the original file
> +	 *       would result in a destination filename that is in the
> +	 *       potential rename set.  If so, return the index of the
> +	 *       destination file (the index within rename_dst).

> +	 * This function, idx_possible_rename(), is only responsible for (4).

This helps isolate the important step to care about for the implementation,
while the rest of the context is important, too.

> +	char *old_dir, *new_dir, *new_path;
> +	int idx;
> +
> +	if (!info->setup)
> +		return -1;
> +
> +	old_dir = get_dirname(filename);
> +	new_dir = strmap_get(&info->dir_rename_guess, old_dir);
> +	free(old_dir);
> +	if (!new_dir)
> +		return -1;
> +
> +	new_path = xstrfmt("%s/%s", new_dir, get_basename(filename));

This is running in a loop, so `xstrfmt()` might be overkill compared
to something like

	strbuf_addstr(&new_path, new_dir);
	strbuf_addch(&new_path, '/');
	strbuf_addstr(&new_path, get_basename(filename));

but maybe the difference is too small to notice. (notice the type
change to "struct strbuf new_path = STRBUF_INIT;")

> +
> +	idx = strintmap_get(&info->idx_map, new_path);
> +	free(new_path);
> +	return idx;
> +}

Does what it says it does.

Thanks,
-Stolee
