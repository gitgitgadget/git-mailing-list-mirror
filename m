Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EC9C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 19:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC1860C3D
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 19:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbhDZTuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 15:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241644AbhDZTuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 15:50:01 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989A8C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 12:49:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u80so23961697oia.0
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cG90ta7+/0ROeHkhT1M6mr3z+YEd9irmVowseoWTxRs=;
        b=BbZeE2Cieb0VFz+6UrGLu5utKhu+UnyMO5IAZgwi4pI7aom+RqB/sSbjm8C+qSKSAM
         ZHtS7bTZQ1LM8T0rv3F/8vP+FgP6mF8kbpt9ZVlvH1r6nZx4uvmi7qhWs6Ld0OIfBOIc
         yOuisSTKcuwV483vd0ljzY4E462P29lyhXr6q2iDYfjzJdBvnAFYtRo0JC0l2eASFASv
         RiRZ0kz7zFNe0qOAP4ZimN4kusOymYs38KpXYfpA7E6wegt5HJ2lSFXyKAOzSDmj8BLL
         YodEZV9G+Z63uJnpv4VM0uUh+oMsSS6M/4qV4gpieBSkoXktsxT3lDQxx4OuA+rzvXMa
         F7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cG90ta7+/0ROeHkhT1M6mr3z+YEd9irmVowseoWTxRs=;
        b=kUzj3aXebkJWM7nE9p3A0tt9QnRPvbFQ07MHj68bRdw/tpi+R7snuboeVmkaUtr8kO
         +nbwkzmLAdlQiUnOZnUw8NNEKVMdGfDrzpecKM8GqQ/aNPFD8sEedXzfu15whzo8B8Rs
         3MliLTMSmWDoE+D29+0nC/2aqsSt60an3HCbEKXyRbhhly2DNG2heWrqNTewyzOCzHMh
         C3CG0yIbvWXXM1UcpGStQQQ8s/1fsqJwPYTvqwPXuBufFUiCjys6yaGSPu60cD6LJ3zh
         KmlH+R0WA8/38qac7AKwfoPJ2QhawOe5dvFiihiq8JS8OTuYodSV/nnJUAGvBhRg5txc
         3WNg==
X-Gm-Message-State: AOAM532E+3viv7WslYsx6og3OfP13cAFlxBFlmyU2oGYT1QJkKrVFi8j
        AJM6UjkqMXPbT4z8MzMDuKU=
X-Google-Smtp-Source: ABdhPJz7sp1s63LI5MAkvn4QV3IpOHvxXLpiTszitqCKxuTy+TJK5l/T/L94YGAt/Q6rk//ECHHx4Q==
X-Received: by 2002:aca:90b:: with SMTP id 11mr478939oij.77.1619466558893;
        Mon, 26 Apr 2021 12:49:18 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:65f6:360e:4aa8:3d0f? ([2600:1700:e72:80a0:65f6:360e:4aa8:3d0f])
        by smtp.gmail.com with ESMTPSA id e12sm337379otq.46.2021.04.26.12.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 12:49:18 -0700 (PDT)
Subject: Re: [PATCH 11/23] fsmonitor--daemon: define token-ids
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <304fe03034f8622aa8728d8872cc9bc539bab861.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3f0c5c7d-8448-15ec-9e12-b2745d7bbf2b@gmail.com>
Date:   Mon, 26 Apr 2021 15:49:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <304fe03034f8622aa8728d8872cc9bc539bab861.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach fsmonitor--daemon to create token-ids and define the
> overall token naming scheme.
...
> +/*
> + * Requests to and from a FSMonitor Protocol V2 provider use an opaque
> + * "token" as a virtual timestamp.  Clients can request a summary of all
> + * created/deleted/modified files relative to a token.  In the response,
> + * clients receive a new token for the next (relative) request.
> + *
> + *
> + * Token Format
> + * ============
> + *
> + * The contents of the token are private and provider-specific.
> + *
> + * For the built-in fsmonitor--daemon, we define a token as follows:
> + *
> + *     "builtin" ":" <token_id> ":" <sequence_nr>
> + *
> + * The <token_id> is an arbitrary OPAQUE string, such as a GUID,
> + * UUID, or {timestamp,pid}.  It is used to group all filesystem
> + * events that happened while the daemon was monitoring (and in-sync
> + * with the filesystem).
> + *
> + *     Unlike FSMonitor Protocol V1, it is not defined as a timestamp
> + *     and does not define less-than/greater-than relationships.
> + *     (There are too many race conditions to rely on file system
> + *     event timestamps.)
> + *
> + * The <sequence_nr> is a simple integer incremented for each event
> + * received.  When a new <token_id> is created, the <sequence_nr> is
> + * reset to zero.
> + *
> + *
> + * About Token Ids
> + * ===============
> + *
> + * A new token_id is created:
> + *
> + * [1] each time the daemon is started.
> + *
> + * [2] any time that the daemon must re-sync with the filesystem
> + *     (such as when the kernel drops or we miss events on a very
> + *     active volume).
> + *
> + * [3] in response to a client "flush" command (for dropped event
> + *     testing).
> + *
> + * [4] MAYBE We might want to change the token_id after very complex
> + *     filesystem operations are performed, such as a directory move
> + *     sequence that affects many files within.  It might be simpler
> + *     to just give up and fake a re-sync (and let the client do a
> + *     full scan) than try to enumerate the effects of such a change.
> + *
> + * When a new token_id is created, the daemon is free to discard all
> + * cached filesystem events associated with any previous token_ids.
> + * Events associated with a non-current token_id will never be sent
> + * to a client.  A token_id change implicitly means that the daemon
> + * has gap in its event history.
> + *
> + * Therefore, clients that present a token with a stale (non-current)
> + * token_id will always be given a trivial response.

From this comment, it seems to be the case that concurrent Git
commands will race to advance the FS Monitor token and one of them
will lose, causing a full working directory scan. There is no list
of "recent" tokens.

I could see this changing in the future, but for now it is a
reasonable simplification.

> + */
> +struct fsmonitor_token_data {
> +	struct strbuf token_id;
> +	struct fsmonitor_batch *batch_head;
> +	struct fsmonitor_batch *batch_tail;
> +	uint64_t client_ref_count;
> +};
> +
> +static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
> +{
> +	static int test_env_value = -1;
> +	static uint64_t flush_count = 0;
> +	struct fsmonitor_token_data *token;
> +
> +	token = (struct fsmonitor_token_data *)xcalloc(1, sizeof(*token));

I think the best practice here is "CALLOC_ARRAY(token, 1);"

> +
> +	strbuf_init(&token->token_id, 0);

This is likely overkill since you used calloc() above.

> +	token->batch_head = NULL;
> +	token->batch_tail = NULL;
> +	token->client_ref_count = 0;
> +
> +	if (test_env_value < 0)
> +		test_env_value = git_env_bool("GIT_TEST_FSMONITOR_TOKEN", 0);
> +
> +	if (!test_env_value) {
> +		struct timeval tv;
> +		struct tm tm;
> +		time_t secs;
> +
> +		gettimeofday(&tv, NULL);
> +		secs = tv.tv_sec;
> +		gmtime_r(&secs, &tm);
> +
> +		strbuf_addf(&token->token_id,
> +			    "%"PRIu64".%d.%4d%02d%02dT%02d%02d%02d.%06ldZ",
> +			    flush_count++,
> +			    getpid(),
> +			    tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +			    tm.tm_hour, tm.tm_min, tm.tm_sec,
> +			    (long)tv.tv_usec);

Between the PID, the flush count, and how deep you go in the
timestamp, this seems to be specific enough.

> +	} else {
> +		strbuf_addf(&token->token_id, "test_%08x", test_env_value++);

And this will be nice for testing.

> +	}
> +
> +	return token;
> +}
> +
>  static ipc_server_application_cb handle_client;
>  
>  static int handle_client(void *data, const char *command,
> @@ -330,7 +436,7 @@ static int fsmonitor_run_daemon(void)
>  
>  	pthread_mutex_init(&state.main_lock, NULL);
>  	state.error_code = 0;
> -	state.current_token_data = NULL;
> +	state.current_token_data = fsmonitor_new_token_data();
>  	state.test_client_delay_ms = 0;
>  
>  	/* Prepare to (recursively) watch the <worktree-root> directory. */
> 

Thanks,
-Stolee
