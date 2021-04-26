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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79287C43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B686101B
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhDZOcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhDZOcT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 10:32:19 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC6C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:31:37 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id gv2so17992146qvb.8
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zP1gnbbSPgbY9ZVM0AK/Yqnx4fZ8o41TjDUBRks9CB4=;
        b=qF56owtU5GukVfQonc8DiEkid2b26khI/egHwNZCIkfdWV0m4LYsoSo5CmbXmKk54v
         j5WhwnOG9MebiqW90woQNfpzL00eM9jQn6d3T11nqT/lr8D9vRAa0Vo5OSMuPzVM604h
         rCZV1joI97BP8eukodzqYzmEF5YX9j6Whfv96sDh9HGZYzAN7C6ec3ql4sR7KvTsjEN6
         5VKdFoQvGSfI9nXdDFoGlZDQvoP9VHSKEvqLrtmnY5GizrokkWjDILLO6LQcB8jqwbV/
         qwSSkIRTNmLuA3MZA3cbMZ2/yTZ0mFhX7ntQJOzdQsvH+z5vCZJfYVWvc/KL3DxeyjKj
         bOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zP1gnbbSPgbY9ZVM0AK/Yqnx4fZ8o41TjDUBRks9CB4=;
        b=FCgIAI/aDCfVHHXgQfiembG9+PxDg4hzQJG7mfE0PHAYLXMNKG3NXrXapfFEXK69sD
         DahFo2Q9t/5SRjeYKS3KAepzOh20svWTQJ5hfeaXOzJbhoudGKuOZzbNiX8mSTEsPXPI
         oXofpyLOA9sjc2pFCyl/evsjilU1TfYXgoslq94jiAMgS9nrMbojtHFEoqY4mbLP70+e
         1I8BM+7a3hTIULS/qYZLK0C+ahvyDmadrNV+7Ui1fW1kbUvQKf8t8XFNzl2T8n/PzDts
         y2lvhmKosDfv4YF0cPkhLuVyo8WH7xevqUp2BP+2OuSVCdfSOhE8clCPvt8szz7wR4M/
         EiWA==
X-Gm-Message-State: AOAM531civTMKsS1MPqYZ7VlBScoDI2M3FLxJ2Yco2JHf+dH/7XJJt8T
        TDE4wYLXJ+aBtwC7tJzSX4+KP+UTZ0z/pw==
X-Google-Smtp-Source: ABdhPJyfrNnKVVyf+qiIONUmKc5CKEP+2Vvi3ubb20FBlucGmgQ8gj/ou+vA/uohrw/Y/k6CJVx2/w==
X-Received: by 2002:a0c:80e1:: with SMTP id 88mr17920521qvb.43.1619447497078;
        Mon, 26 Apr 2021 07:31:37 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f22sm11452852qtg.77.2021.04.26.07.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 07:31:36 -0700 (PDT)
Subject: Re: [PATCH 02/23] fsmonitor-ipc: create client routines for
 git-fsmonitor--daemon
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <3dac63eae201e6d0b949680e682238625cad59bd.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5b63eb3f-0b87-209b-3943-ced8412abb93@gmail.com>
Date:   Mon, 26 Apr 2021 10:31:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <3dac63eae201e6d0b949680e682238625cad59bd.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> +#define FSMONITOR_DAEMON_IS_SUPPORTED 1
> +#else
> +#define FSMONITOR_DAEMON_IS_SUPPORTED 0
> +#endif
> +
> +/*
> + * A trivial function so that this source file always defines at least
> + * one symbol even when the feature is not supported.  This quiets an
> + * annoying compiler error.
> + */
> +int fsmonitor_ipc__is_supported(void)
> +{
> +	return FSMONITOR_DAEMON_IS_SUPPORTED;
> +}

I don't see any other use of FSMONITOR_DAEMON_IS_SUPPORTED,
so I was thinking you could use the #ifdef/#else/#endif
construct within the implementation of this method instead
of creating a macro outside. But my suggestion might be an
anti-pattern, so feel free to ignore me.

> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> +
> +GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor")
> +
> +enum ipc_active_state fsmonitor_ipc__get_state(void)
> +{
> +	return ipc_get_active_state(fsmonitor_ipc__get_path());
> +}
> +
> +static int spawn_daemon(void)
> +{
> +	const char *args[] = { "fsmonitor--daemon", "--start", NULL };
> +
> +	return run_command_v_opt_tr2(args, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
> +				    "fsmonitor");
> +}
> +
> +int fsmonitor_ipc__send_query(const char *since_token,
> +			      struct strbuf *answer)
> +{
> +	int ret = -1;
> +	int tried_to_spawn = 0;
> +	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
> +	struct ipc_client_connection *connection = NULL;
> +	struct ipc_client_connect_options options
> +		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
> +
> +	options.wait_if_busy = 1;
> +	options.wait_if_not_found = 0;
> +
> +	trace2_region_enter("fsm_client", "query", NULL);
> +
> +	trace2_data_string("fsm_client", NULL, "query/command",
> +			   since_token);
> +
> +try_again:
> +	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
> +				       &connection);
> +
> +	switch (state) {
> +	case IPC_STATE__LISTENING:
> +		ret = ipc_client_send_command_to_connection(
> +			connection, since_token, answer);
> +		ipc_client_close_connection(connection);
> +
> +		trace2_data_intmax("fsm_client", NULL,
> +				   "query/response-length", answer->len);
> +
> +		if (fsmonitor_is_trivial_response(answer))
> +			trace2_data_intmax("fsm_client", NULL,
> +					   "query/trivial-response", 1);
> +
> +		goto done;
> +
> +	case IPC_STATE__NOT_LISTENING:
> +		ret = error(_("fsmonitor_ipc__send_query: daemon not available"));
> +		goto done;

I'll need to read up on the IPC layer a bit to find out the difference
between IPC_STATE__NOT_LISTENING and IPC_STATE__PATH_NOT_FOUND. When
testing on my macOS machine, I got this error. I was expecting the
daemon to be spawned. After spawning it myself, it started working.

I expect that there are some cases where the process can fail and the
named pipe is not cleaned up. Let's investigate that soon. I should
make it clear that I had tested the builtin FS Monitor on this machine
a few weeks ago, but hadn't been using it much since. We should auto-
recover from this situation.

But also: what is the cost of treating these two cases the same? Could
we attempt to "restart" the daemon by spawning a new one? Will the new
one find a way to kill a stale one?

(Reading on.)

> +	case IPC_STATE__PATH_NOT_FOUND:
> +		if (tried_to_spawn)
> +			goto done;
> +
> +		tried_to_spawn++;
> +		if (spawn_daemon())
> +			goto done;

This should return zero on success, OK.

> +		/*
> +		 * Try again, but this time give the daemon a chance to
> +		 * actually create the pipe/socket.
> +		 *
> +		 * Granted, the daemon just started so it can't possibly have
> +		 * any FS cached yet, so we'll always get a trivial answer.
> +		 * BUT the answer should include a new token that can serve
> +		 * as the basis for subsequent requests.
> +		 */
> +		options.wait_if_not_found = 1;
> +		goto try_again;

Because of the tried_to_spawn check, we will re-run the request over
IPC but will not retry the spawn_daemon() request. I'm unsure how
this could be helpful: is it possible that spawn_daemon() returns a
non-zero error code after starting the daemon and somehow that
daemon starts working? Or, is this a race-condition thing with parallel
processes also starting up the daemon? It could be good to use this
comment to describe why a retry might be helpful.

> +
> +	case IPC_STATE__INVALID_PATH:
> +		ret = error(_("fsmonitor_ipc__send_query: invalid path '%s'"),
> +			    fsmonitor_ipc__get_path());
> +		goto done;
> +
> +	case IPC_STATE__OTHER_ERROR:
> +	default:
> +		ret = error(_("fsmonitor_ipc__send_query: unspecified error on '%s'"),
> +			    fsmonitor_ipc__get_path());
> +		goto done;
> +	}
> +
> +done:
> +	trace2_region_leave("fsm_client", "query", NULL);
> +
> +	return ret;
> +}
> +
> +int fsmonitor_ipc__send_command(const char *command,
> +				struct strbuf *answer)
> +{
> +	struct ipc_client_connection *connection = NULL;
> +	struct ipc_client_connect_options options
> +		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
> +	int ret;
> +	enum ipc_active_state state;
> +
> +	strbuf_reset(answer);
> +
> +	options.wait_if_busy = 1;
> +	options.wait_if_not_found = 0;
> +
> +	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
> +				       &connection);
> +	if (state != IPC_STATE__LISTENING) {
> +		die("fsmonitor--daemon is not running");
> +		return -1;
> +	}
> +
> +	ret = ipc_client_send_command_to_connection(connection, command, answer);
> +	ipc_client_close_connection(connection);
> +
> +	if (ret == -1) {
> +		die("could not send '%s' command to fsmonitor--daemon",
> +		    command);
> +		return -1;
> +	}
> +
> +	return 0;
> +}

I wondier if this ...send_command() method is too generic. It might
be nice to have more structure to its inputs and outputs to lessen
the cognitive load when plugging into other portions of the code.
However, I'll wait to see what those consumers look like in case the
generality is merited.
>  struct category_description {
>  	uint32_t category;
> @@ -664,6 +665,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
>  		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
>  		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
>  		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
> +
> +		if (fsmonitor_ipc__is_supported())
> +			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");

This change might deserve its own patch, including some documentation
about how users can use 'git version --build-options' to determine if
the builtin FS Monitor feature is available on their platform.

Thanks,
-Stolee
