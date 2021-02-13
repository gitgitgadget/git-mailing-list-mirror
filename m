Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18421C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 09:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87F064DDF
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 09:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhBMJbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 04:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhBMJbg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 04:31:36 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564D5C061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 01:30:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id w1so3270310ejf.11
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PLSD+x0rsfALv8piwWm5a95b62Sctmh9J2xu8O2l9tg=;
        b=UKQ1b7/NVn9jNtEL9Kxeaq+OLUPDNPJ9ZhP3EV6ssxUygmf36IaOqPKxQmo4Fj7rl/
         npjkpqJbECh1Lihtyt1aHSsMbnVtFFFOHQ4jcm/iHVrXm87QUNSo9MV/ORv0FF9pWf4R
         AYyzLilLNKaFVuBg5kAy4gt1NcadrR6zgr9F1b3prAvqdM3O58KpLJPXq6IruQ6OITdJ
         qawWkbmVf+VmcXfV0/RO5H/m6RHWSm7P3xzHg5H19C8CDbACYej2nx/DJRaMm+8QhY6k
         pFB1WFXyGX4tShWchIfRlxUjacNdriRXrS/xJPopMjYzdqGFvD7s/kLnvu2ozuRztETk
         H9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PLSD+x0rsfALv8piwWm5a95b62Sctmh9J2xu8O2l9tg=;
        b=XGJ02VsHVNQjRbxLKFr/IqjirgxhNGstBfqLLMGKwyn570usebM9iO1mpdunDay1hS
         H2FGaopK2LJdMODuQSoEqmT9Yoo+MrjTClqfYA8WYzHG8SBrxA3gKT00i5StRVm24Ysn
         QlnNHevVHeB4NYwRfDZebIQyoC0h/Jm5XLayuOObGhLpyos7lBh8vy+9dnN+Zz8SEghU
         5hkwvmPCV+AkpaHitRSi/tSVBP+n9Pr1x0zZ6lPS3kcN96c7R2Nc636JoomWcMOoNFrC
         ZcTAdj08Q1xUNCiRCcsB0gJRCJ3dnk7DccuLU85fdJEQLcuk+JbJSSBQIfBNmuABcENk
         bK5A==
X-Gm-Message-State: AOAM532LUaC0PAkJSkUam1rfHIhr79DaVvuB5lU4O+/6NrHBQo7Z+vtV
        fLeAfJif8LAHZTcIu6E1MHA=
X-Google-Smtp-Source: ABdhPJxII+LGAOoqDLcbmCGZaNfEuTGEbmvLlhLXVf5aqPzmmxu5s/Zt1rfVspkqpB53KFqsUTrj4w==
X-Received: by 2002:a17:907:98cd:: with SMTP id kd13mr6597352ejc.152.1613208654985;
        Sat, 13 Feb 2021 01:30:54 -0800 (PST)
Received: from szeder.dev (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id hb24sm7604363ejb.16.2021.02.13.01.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 01:30:54 -0800 (PST)
Date:   Sat, 13 Feb 2021 10:30:52 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 12/12] t0052: add simple-ipc tests and
 t/helper/test-simple-ipc tool
Message-ID: <20210213093052.GJ1015009@szeder.dev>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <1e5c856ade8557d7514d9bee1c58bf978aba062c.1613174954.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e5c856ade8557d7514d9bee1c58bf978aba062c.1613174954.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 13, 2021 at 12:09:13AM +0000, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create t0052-simple-ipc.sh with unit tests for the "simple-ipc" mechanism.
> 
> Create t/helper/test-simple-ipc test tool to exercise the "simple-ipc"
> functions.
> 
> When the tool is invoked with "run-daemon", it runs a server to listen
> for "simple-ipc" connections on a test socket or named pipe and
> responds to a set of commands to exercise/stress the communication
> setup.
> 
> When the tool is invoked with "start-daemon", it spawns a "run-daemon"
> command in the background and waits for the server to become ready
> before exiting.  (This helps make unit tests in t0052 more predictable
> and avoids the need for arbitrary sleeps in the test script.)
> 
> The tool also has a series of client "send" commands to send commands
> and data to a server instance.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---

> diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
> new file mode 100644
> index 000000000000..92aa7f843cfa
> --- /dev/null
> +++ b/t/helper/test-simple-ipc.c

[...]

> +/*
> + * This is "application callback" that sits on top of the "ipc-server".
> + * It completely defines the set of command verbs supported by this

Please avoid the noiseword "verbs" and just call them commands; a few
of these commands are not even verbs.

> + * application.
> + */
> +static int test_app_cb(void *application_data,
> +		       const char *command,
> +		       ipc_server_reply_cb *reply_cb,
> +		       struct ipc_server_reply_data *reply_data)
> +{
> +	/*
> +	 * Verify that we received the application-data that we passed
> +	 * when we started the ipc-server.  (We have several layers of
> +	 * callbacks calling callbacks and it's easy to get things mixed
> +	 * up (especially when some are "void*").)
> +	 */
> +	if (application_data != (void*)&my_app_data)
> +		BUG("application_cb: application_data pointer wrong");
> +
> +	if (!strcmp(command, "quit")) {
> +		/*
> +		 * The client sent a "quit" command.  This is an async
> +		 * request for the server to shutdown.
> +		 *
> +		 * We DO NOT send the client a response message
> +		 * (because we have nothing to say and the other
> +		 * server threads have not yet stopped).
> +		 *
> +		 * Tell the ipc-server layer to start shutting down.
> +		 * This includes: stop listening for new connections
> +		 * on the socket/pipe and telling all worker threads
> +		 * to finish/drain their outgoing responses to other
> +		 * clients.
> +		 *
> +		 * This DOES NOT force an immediate sync shutdown.
> +		 */
> +		return SIMPLE_IPC_QUIT;
> +	}
> +
> +	if (!strcmp(command, "ping")) {
> +		const char *answer = "pong";
> +		return reply_cb(reply_data, answer, strlen(answer));
> +	}
> +
> +	if (!strcmp(command, "big"))
> +		return app__big_command(reply_cb, reply_data);
> +
> +	if (!strcmp(command, "chunk"))
> +		return app__chunk_command(reply_cb, reply_data);
> +
> +	if (!strcmp(command, "slow"))
> +		return app__slow_command(reply_cb, reply_data);
> +
> +	if (starts_with(command, "sendbytes "))
> +		return app__sendbytes_command(command, reply_cb, reply_data);
> +
> +	return app__unhandled_command(command, reply_cb, reply_data);
> +}

[...]

> +int cmd__simple_ipc(int argc, const char **argv)
> +{
> +	const char *path = "ipc-test";

Since the path of the socket used in the tests is hardcoded, we could
use it in the tests as well to check its presence/absence.

[...]

> diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
> new file mode 100755
> index 000000000000..e36b786709ec
> --- /dev/null
> +++ b/t/t0052-simple-ipc.sh
> @@ -0,0 +1,134 @@

[...]

> +# Sending a "quit" message to the server causes it to start an "async
> +# shutdown" -- queuing shutdown events to all socket/pipe thread-pool
> +# threads.  Each thread will process that event after finishing
> +# (draining) any in-progress IO with other clients.  So when the "send
> +# quit" client command exits, the ipc-server may still be running (but
> +# it should be cleaning up).
> +#
> +# So, insert a generous sleep here to give the server time to shutdown.
> +#
> +test_expect_success '`quit` works' '
> +	test-tool simple-ipc send quit &&
> +
> +	sleep 5 &&

The server process is responsible for removing the socket, so instead
of a hard-coded 5 seconds delay the test could (semi-)busy wait in a
loop until the socket disappears like this:

diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
index 6958835454..609d8d4283 100755
--- a/t/t0052-simple-ipc.sh
+++ b/t/t0052-simple-ipc.sh
@@ -122,6 +122,13 @@ test_expect_success 'stress test threads' '
 
 test_expect_success '`quit` works' '
 	test-tool simple-ipc send quit &&
+	nr_tries_left=10 &&
+	while test -S ipc-test &&
+	      test $nr_tries_left -gt 0
+	do
+		sleep 1
+		nr_tries_left=$(($nr_tries_left - 1))
+	done &&
 	test_must_fail test-tool simple-ipc is-active &&
 	test_must_fail test-tool simple-ipc send ping
 '

This way we might get away without any delay or with only a single
one-second sleep in most cases, while we could bump the timeout a bit
higher for the sake of a CI system in a particularly bad mood.

Would this work on Windows, or at least could it be tweaked to work
there?

I think this is conceptually the same as what you did at startup,
except in this example the test script waits instead of the test-tool
subcommand.  Perhaps it would be worth incorporating this wait into
the test-tool as well; or perhaps it would be simpler to do the
waiting in the test script at startup as well.

> +	test_must_fail test-tool simple-ipc is-active &&
> +	test_must_fail test-tool simple-ipc send ping
> +'
> +
> +test_done
> -- 
> gitgitgadget
