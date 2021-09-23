Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F25C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794A061107
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbhIWPN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbhIWPN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 11:13:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB06C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 08:12:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y89so14214147ede.2
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qOVUVOCfydUTdeuB/P+JbL1s+HV/4VckWDRloHW5XRM=;
        b=Mi7hWdf1TC0gefsxbYOg3B3vKMD46fvKG6hl1BZQMOGsqrydC/3DBb6hS9HWBtiH48
         BYVzUio7LkKpiVcEeAPLE7QouXYg9UPE4qBNU3g6ZPjf7u14PFODFgSA1hy915IgYIj4
         tTXqcPlTBigyYXVqaEWytbLMw0uSQ5cNvd5BmVFmjknoC6lvlsXN6fDKl7H3UpTT2MDO
         uYoEWMmTUv3gsC/1QSiyehX35L9lECGirOQVhNs3cGOTv6XhAPSzsDG7EJ0fUc6ux30l
         PkYnFOIP2UHU8bixJqsRdN0Sq1DEVTDmIBo2xhzpWsErw73f2gLbp8fjZMWIi7diC3nh
         XnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qOVUVOCfydUTdeuB/P+JbL1s+HV/4VckWDRloHW5XRM=;
        b=u+IHnLMRl7cTmcKmKEoP9OICwFQkDyv5bQG8hJ4i61MRf8SxE26JAHRQb/4ug5th/e
         KarivXsGM05L/eWqTcDDfgUTmK0JLdHlMw/mgYQ5t7FtnmZEdbQRzJo165BiLEPgN2He
         R2dCW7VP7fiEDEb4ku5ri0nABclzulTgljv78jC9Q585C2r6vSAMId6xbTC1HVGNuKe1
         aZoC80TOje4TJT13/z32h14UpPahTBbo2uTh5KEqGisL1hY+v/JMm/+C/MVSPPMyl/JG
         ZzWa+AIwQjBtEuLSLRamKrr2LU8V76N/aNHb6f5CH4qUoyp4CbW1Ie+DT+lqiYHn0YMo
         78ew==
X-Gm-Message-State: AOAM531nUu6wpfvJ0lBh9rbLrr6q/8A0h1GXlmbkY0I+DzT3Wo29JhR3
        EpvTBQI957VD8C3PsjD1h4tVmzzCWbC6vg==
X-Google-Smtp-Source: ABdhPJyMFROH/dVmX4/905Lh6xqDu0rPvqOa/rrs5NhpYags547McBtjrVRt0BBN2rFkqYWiWBC7Ag==
X-Received: by 2002:a50:d5c1:: with SMTP id g1mr5965953edj.296.1632409945203;
        Thu, 23 Sep 2021 08:12:25 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j5sm3186579ejb.96.2021.09.23.08.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:12:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
Date:   Thu, 23 Sep 2021 17:03:56 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
Message-ID: <87r1df497s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Jeff Hostetler via GitGitGadget wrote:

> +	switch (sbgr) {
> +	case SBGR_READY:
> +		return 0;
>  
> -		else if (pid_seen == pid_child) {
> -			/*
> -			 * The new child daemon process shutdown while
> -			 * it was starting up, so it is not listening
> -			 * on the socket.
> -			 *
> -			 * Try to ping the socket in the odd chance
> -			 * that another daemon started (or was already
> -			 * running) while our child was starting.
> -			 *
> -			 * Again, we don't care who services the socket.
> -			 */
> -			s = ipc_get_active_state(cl_args.path);
> -			if (s == IPC_STATE__LISTENING)
> -				return 0;
> +	default:
> +	case SBGR_ERROR:
> +	case SBGR_CB_ERROR:
> +		return error("daemon failed to start");

There was a discussion on v1 about the "default" being redundant here
and hiding future compiler checks, this is another "not sure what you
thought of that" case (per [1]).

Interestingly in this case if I drop the "default" my local gcc
uncharacteristically complains about a missing "return" in this
function, but clang doesn't. I needed to add a BUG() to shut up the
former. Maybe I'm wrong, but perhaps it's a sign of some deeper
trouble. This is with gcc/clang 10.2.1-6/11.0.1-2.

1. https://lore.kernel.org/git/87v92r49mt.fsf@evledraar.gmail.com/

I played with the diff below on top of this, I can't remember if it was
noted already, but the way you declare function ptrs and use them isn't
the usual style:

-- >8 --
diff --git a/run-command.c b/run-command.c
index 76bbef9d96d..5c831545201 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1903,7 +1903,7 @@ void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir)
 }
 
 enum start_bg_result start_bg_command(struct child_process *cmd,
-				      start_bg_wait_cb *wait_cb,
+				      start_bg_wait_cb wait_cb,
 				      void *cb_data,
 				      unsigned int timeout_sec)
 {
diff --git a/run-command.h b/run-command.h
index 17b1b80c3d7..e8a637d1967 100644
--- a/run-command.h
+++ b/run-command.h
@@ -527,7 +527,7 @@ enum start_bg_result {
  * Returns 0 if child is "ready".
  * Returns -1 on any error and cause start_bg_command() to also error out.
  */
-typedef int(start_bg_wait_cb)(const struct child_process *cmd, void *cb_data);
+typedef int (*start_bg_wait_cb)(const struct child_process *cmd, void *cb_data);
 
 /**
  * Start a command in the background.  Wait long enough for the child
@@ -549,7 +549,7 @@ typedef int(start_bg_wait_cb)(const struct child_process *cmd, void *cb_data);
  * any instance data that it might require.  This may be NULL.
  */
 enum start_bg_result start_bg_command(struct child_process *cmd,
-				      start_bg_wait_cb *wait_cb,
+				      start_bg_wait_cb wait_cb,
 				      void *cb_data,
 				      unsigned int timeout_sec);
 
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 28365ff85b6..82dc2906a2a 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -275,9 +275,7 @@ static int daemon__run_server(void)
 	return ret;
 }
 
-static start_bg_wait_cb bg_wait_cb;
-
-static int bg_wait_cb(const struct child_process *cp, void *cb_data)
+static int bg_wait_cb(const struct child_process *cp, void *cb_data, int foo)
 {
 	int s = ipc_get_active_state(cl_args.path);
 
@@ -319,9 +317,8 @@ static int daemon__start_server(void)
 	switch (sbgr) {
 	case SBGR_READY:
 		return 0;
-
-	default:
 	case SBGR_ERROR:
+		return 0;
 	case SBGR_CB_ERROR:
 		return error("daemon failed to start");
 
@@ -331,6 +328,7 @@ static int daemon__start_server(void)
 	case SBGR_DIED:
 		return error("daemon terminated");
 	}
+	BUG("unreachable");
 }
 
 /*

