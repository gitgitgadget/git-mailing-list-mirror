Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FCEC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2471C610F8
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhEMSxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 14:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEMSxd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 14:53:33 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F70EC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:52:23 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c10so10704701qtx.10
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yQ99EwEL7b4SJHhAx8BjWc8vC2n5ZUWI3Tp7oeFwX0Q=;
        b=LvvCHVMZZyIhaefmGX0LN69TMdvK1SdOLoC9Kq9y+Bbk+QznQBkCQo+ioELrPV3av/
         EuFQte/hcY8YuWIUc4Lf5djnZ4PdzLTRySH3BreMZrFI7oAAgQzKqqPuygk+os+MrhrX
         MgKXxEfBXU0cMCwskEXfHGoWziC6rLoIE7JDwsMvANR6J3PjPY7m3TbRm8/bTbi3mitQ
         AF9YGnOC2B7NRFA9vObYt7CWCKr15UXzM5oG2deEGdkHek+W0V7b17wz5qguhhU2NHB5
         1hLOP5HkPrRwQuIefrJ5VylCf/DvqeBMqzuJXPKmnl87UlxMr9+rEnCGlA5e5KN7BGfE
         xFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yQ99EwEL7b4SJHhAx8BjWc8vC2n5ZUWI3Tp7oeFwX0Q=;
        b=cCyvVP4FMR1yyR8++ms0SH3HNomzEl7zwjJ1v3NPb7q9Jgn88YY8CZKfOVtCUVZChq
         hmgIZ8nsHT2HdgxiTef9WlpjsHXNgW3Xtk6fxnO8s+fmTTAluOPWmLoySFp2hxgsUJwo
         o1cVUCPHxsE+r/uLZnfbfvrAbvYssd0ZQLHIG0L7pJgsPFS8SA5p6WG4C9NjdNt2dixt
         UmaERNubhfPIxP4/PfSEIr81KEloKA5Ev5k262/dS7UotRZCJUZVIqku/Bo9kXoymAjB
         2Wz6YGZM5Ac5K9sutwbwqQjKY0jsGI3njzxSmN82gToMSXoAqdzjXmU93zyISImLMIgf
         KZ5g==
X-Gm-Message-State: AOAM530BVimEwdZKHbfl1Y4hchcFhGH6BJGGsdJuYFze10l9696DlJH/
        79HFGA9Pv7lRf3ckIBHAB/s=
X-Google-Smtp-Source: ABdhPJx6W9T1JH3UrgpVNoYs+0bVbxNTVOmTYXeqsaiqR+M/RnwGLRhkeAAjk8GLviZduIQv5o00ug==
X-Received: by 2002:ac8:5a82:: with SMTP id c2mr26971194qtc.345.1620931942137;
        Thu, 13 May 2021 11:52:22 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:2995:520e:db1f:80e7])
        by smtp.gmail.com with ESMTPSA id k29sm2158432qtu.83.2021.05.13.11.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 11:52:21 -0700 (PDT)
Subject: Re: [PATCH 16/23] fsmonitor--daemon: implement handle_client callback
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <2b4ae4fc3d622f0fee8eb5e527a51467e13acfc5.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0b9e54ba-ac27-e537-7bef-1b4448f92352@gmail.com>
Date:   Thu, 13 May 2021 14:52:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2b4ae4fc3d622f0fee8eb5e527a51467e13acfc5.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:

Here is a rather important bug that I found on a whim while working
with sparse-index integrations. The sparse-index isn't important
except that it caused a different pattern of batch creation and
responses from the daemon.

> +/*
> + * Format an opaque token string to send to the client.
> + */
> +static void fsmonitor_format_response_token(
> +	struct strbuf *response_token,
> +	const struct strbuf *response_token_id,
> +	const struct fsmonitor_batch *batch)
> +{
> +	uint64_t seq_nr = (batch) ? batch->batch_seq_nr + 1 : 0;

Here, you add one to the batch value to indicate a difference
between "zero" and "positive" values.

> +
> +	strbuf_reset(response_token);
> +	strbuf_addf(response_token, "builtin:%s:%"PRIu64,
> +		    response_token_id->buf, seq_nr);
> +}
> +
> +/*
> + * Parse an opaque token from the client.
> + */
> +static int fsmonitor_parse_client_token(const char *buf_token,
> +					struct strbuf *requested_token_id,
> +					uint64_t *seq_nr)
> +{
> +	const char *p;
> +	char *p_end;
> +
> +	strbuf_reset(requested_token_id);
> +	*seq_nr = 0;
> +
> +	if (!skip_prefix(buf_token, "builtin:", &p))
> +		return 1;
> +
> +	while (*p && *p != ':')
> +		strbuf_addch(requested_token_id, *p++);
> +	if (!*p++)
> +		return 1;
> +
> +	*seq_nr = (uint64_t)strtoumax(p, &p_end, 10);

Which means here you should decrement one from the value, possibly,
(except if it is zero).

> +	if (*p_end)
> +		return 1;
> +
> +	return 0;
> +}

...

> +	shown = kh_init_str();
> +	for (batch = batch_head;
> +	     batch && batch->batch_seq_nr >= requested_oldest_seq_nr;
> +	     batch = batch->next) {

And without either decrementing one from requested_oldest_seq_nr or
adding one to the batch_seq_nr here, this loop could terminate
immediately.

In my testing, I added one to the left-hand side of the inequality.

Thanks,
-Stolee
