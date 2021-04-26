Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA92CC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942136135B
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhDZPqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhDZPqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 11:46:16 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4600C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 08:45:33 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l1so2097126qtr.12
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ghFVnKGIvhvcH9nkvEgwBo7Dsf5xehS7zV96S3D2oqE=;
        b=GeJbI8Z3IkTFG2r1abecZ9EmQZH2uZCEPqrmSqY7h2S1OwSQwwIZo1jZ0juLHT+FHF
         ciU1LR28BajivrYp4l2Wi9Uy1/VliCt87tX/CCuiDh8Evu7+81RkUHK1UA1M8LZ5fXsN
         7iEcakLTRvxtYboXkigyDX9l/Q+0LiUZa1o5Us+QNt8V23sx0X1PaRoD9CFahiBh98rd
         /ZtBZO5i0p43ukR46PypUd6nsC52pyGckxzvwO2iwvs/aAxDo4NJx8m1glA8061Fkh7j
         8GJX95zBKxURvOz5nerWkljmg5tA8gasPQsDA9m4JQ+6aSNAB3CjUSj2A6+4i2Hyilqf
         zBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ghFVnKGIvhvcH9nkvEgwBo7Dsf5xehS7zV96S3D2oqE=;
        b=a0kFogtfMj+9qRijdT8oVbnTqK4lrnHZr8CG9Eyn5G+44FuwaOoIdnCmHkzIjuIKgS
         hAgQ8CLF0+WXIkx+Cjp+B+PHATi/lEzQpDo3BhZRKUvrBwgoh9bWzGoJpUEhu4QMTOxm
         v6ANzlXB78IOmsCDLM8AVss1YkNX3MVp6QKFftJ2TvbuscxbJDrFSglX/LL4ez/GpaGH
         yXDyz+nRgtZjeTKiWPtEsKz53RmWXzOo61KRiWJOb1IppjQFFiLDVjobqPUTawjbPYJ/
         Wiz/ml2Uy4fK06/A3ji4+63dnsSbTdUNP8QCz3TOHlKs/pT2YSOn771B39p5TXoFMETu
         eNcw==
X-Gm-Message-State: AOAM532wc0hm2P0OyezddvqwN9vsq5xRoIUl4ohJfhdf5jEfnHyWUX/Z
        0s3UzTzZ3k/Cv2XhCjS2MXg=
X-Google-Smtp-Source: ABdhPJw3ehglrtP3OR9OvCX806MrOzJN3g6zk2voJVP8uivAY1L9+LmiMMdY4AzfLiJqgJ2Bk6V1uA==
X-Received: by 2002:ac8:4501:: with SMTP id q1mr16973356qtn.385.1619451933090;
        Mon, 26 Apr 2021 08:45:33 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:cdf6:999f:6779:61eb])
        by smtp.gmail.com with ESMTPSA id c29sm11349276qtv.93.2021.04.26.08.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 08:45:32 -0700 (PDT)
Subject: Re: [PATCH 05/23] fsmonitor--daemon: add a built-in fsmonitor daemon
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <95d511d83b1211f24aeb17edbd4918750f406ece.1617291666.git.gitgitgadget@gmail.com>
 <522e10e6-f18d-9c28-7102-f5a855d4be50@gmail.com>
Message-ID: <1c45542a-5d80-6e51-26fe-94066987a566@gmail.com>
Date:   Mon, 26 Apr 2021 11:45:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <522e10e6-f18d-9c28-7102-f5a855d4be50@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/21 11:08 AM, Derrick Stolee wrote:
> On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> 
> I think these compile-time macros should be replaced with a
> method call, as I've said before. It should be simple to say
> 
> 	if (!fsmonitor_ipc__is_supported())
> 		die(_("fsmonitor--daemon is not supported on this platform"));
> 
> and call it a day. This can be done before parsing arguments.
> 
>> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
>> +{
>> +	enum daemon_mode {
>> +		UNDEFINED_MODE,
>> +	} mode = UNDEFINED_MODE;
>> +
>> +	struct option options[] = {
>> +		OPT_END()
>> +	};
> 
> I can see where you are going here, to use the parse-opts API
> to get your "--<verb>" arguments to populate an 'enum'. However,
> it seems like you will run into the problem where a user enters
> multiple such arguments and you lose the information as the
> parser overwrites 'mode' here.

I see that you use OPT_CMDMODE in your implementation, which
makes this concern invalid.

> Better to use a positional argument and drop the "--" prefix,
> in my opinion.

This is my personal taste, but the technical reason to do this
doesn't exist.

Thanks,
-Stolee
