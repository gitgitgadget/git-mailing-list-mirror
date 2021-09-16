Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4346C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AE160187
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhIPFsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhIPFsB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:48:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9515C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:46:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t6so12269843edi.9
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VD8ncyGYpvmkvRmc1XWUJrnWGd25mjiupt59Ce4ktq4=;
        b=pjQc/d9X2rLvjwpyBK1ta1+55SZMayL6ZSKnayFOhEOWmzk+7LJ4Fs/Ognb0wvsAkm
         5RZGd2QES9Vbfb+9a187p9IQseHDwP99Elq2nogwc4K+2fCMx5KVOw150MzlELRVEbcm
         GWNgBtwMBLb2s6EfS4nKkRg5gmY3AucUIcJscam14+TT9/ZJjlwG+BMt12q84p1AWRtC
         ROLYwzYAvBeTJ9bsgbVs+dsG94pu2LImeI9WWXGOZwmhWXvzuFn/Ky04tQ+44ZOBCKBH
         Ly5YpMPeOZwHqtoHwxeL7dvagV9htOIB7YcYVGyfVbR3277DeSfQFD9GPVUT+bpiUw9U
         20Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VD8ncyGYpvmkvRmc1XWUJrnWGd25mjiupt59Ce4ktq4=;
        b=c7q7ukR5Ix/rVEuw++cXDrdb1jA3g+R2lqfTa3cqpq0zIu57EjtECgPIVJKe3R6TQe
         11OuSyTxzJFxu5t12R88/B3H6XIMTXTTN4nBTp6GjT8iUTCgx58Pxr03Ae3NylT0Z9jS
         AyObD2roHZ9ov/xuV/BjuVIzd7Jj+uSG06BKuB+g7PG9YY9O5k4fjE7RZiRdxtMOVCeB
         EUonITqPQ2VlEWSKOT5Hm9dAmNXYT/j7HyB9oY4SRvgEFHOonB3lyXgeU4z8cgvcA/vO
         xyuNiasPuCHRnTbNYMRGh5Iz/FB+lQGi97tmh9tRTnyASBwypxZ/YkN9WN/rJBDHArlu
         O4Og==
X-Gm-Message-State: AOAM53219ouMNeyk3qpFqs1rsIuy4qsBnVbbxkNnH7jqo1BsV4+geZru
        DpcViAl18vY6SN8SBnWmExhqhFyOUIc=
X-Google-Smtp-Source: ABdhPJzX7n4XV3cXoPeP5ilaGR4tHopXo9E8K/+2KfsfRS5r4Smp+vlbZgkXNhOa6VssEfJEQCNrgQ==
X-Received: by 2002:a17:907:784b:: with SMTP id lb11mr4466984ejc.307.1631771199325;
        Wed, 15 Sep 2021 22:46:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id la19sm755606ejc.111.2021.09.15.22.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:46:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 4/7] simple-ipc/ipc-win32: add trace2 debugging
Date:   Thu, 16 Sep 2021 07:40:58 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <30b7bb247c3c8531119f99e293d84b1836297251.1631738177.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <30b7bb247c3c8531119f99e293d84b1836297251.1631738177.git.gitgitgadget@gmail.com>
Message-ID: <87bl4tm5s1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 15 2021, Jeff Hostetler via GitGitGadget wrote:

> @@ -112,6 +115,11 @@ static enum ipc_active_state connect_to_server(
>  				if (GetLastError() == ERROR_SEM_TIMEOUT)
>  					return IPC_STATE__NOT_LISTENING;
>  
> +				gle = GetLastError();
> +				trace2_data_intmax("ipc-debug", NULL,
> +						   "connect/waitpipe/gle",
> +						   (intmax_t)gle);
> +
>  				return IPC_STATE__OTHER_ERROR;
>  			}
>  

I've never used this Win32 API (or well, any Win32 API) but I'm guessing
that GetLastError() isn't here to check an error in GetLastError() itself.

Earlier in this function added in your 59c7b88198a (simple-ipc: add
win32 implementation, 2021-03-15) we assign to "gle", I'd really expect...:

>  	if (!SetNamedPipeHandleState(hPipe, &mode, NULL, NULL)) {
> +		gle = GetLastError();
> +		trace2_data_intmax("ipc-debug", NULL,
> +				   "connect/setpipestate/gle",
> +				   (intmax_t)gle);
> +
>  		CloseHandle(hPipe);
>  		return IPC_STATE__OTHER_ERROR;
>  	}
>  
>  	*pfd = _open_osfhandle((intptr_t)hPipe, O_RDWR|O_BINARY);
>  	if (*pfd < 0) {
> +		gle = GetLastError();
> +		trace2_data_intmax("ipc-debug", NULL,
> +				   "connect/openosfhandle/gle",
> +				   (intmax_t)gle);
> +
>  		CloseHandle(hPipe);
>  		return IPC_STATE__OTHER_ERROR;
>  	}

...something that looks exactly like this. I.e. as shown by the below
hunk-at-the-end, as it is I'm either missing some subtlety that could
really use explaining. I.e. this reads like:

    int saved_errno = errno;
    if (syscall()) {
        if (errno)
            die("bad");
        saved_errno = errno;
        log_it("...%d", saved_errno);
    }

When surely we want either of:

    int saved_errno = errno;
    if (syscall()) {
        if (errno)
            die("bad");
        log_it("...%d", errno);
    }

Or better yet (and consistent with the rest of your code):

    int saved_errno = errno;
    if (syscall()) {
        saved_errno = errno;
        if (saved_errno)
            die("bad");
        log_it("...%d", saved_errno);
    }

diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 8dc7bda087d..b0c422e4867 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -109,9 +109,12 @@ static enum ipc_active_state connect_to_server(
 			t_start_ms = (DWORD)(getnanotime() / 1000000);
 
 			if (!WaitNamedPipeW(wpath, timeout_ms)) {
-				if (GetLastError() == ERROR_SEM_TIMEOUT)
+				gle = GetLastError();
+				if (gle == ERROR_SEM_TIMEOUT)
 					return IPC_STATE__NOT_LISTENING;
 
+				/* ...rest of your patch */
+
 				return IPC_STATE__OTHER_ERROR;
 			}
 
