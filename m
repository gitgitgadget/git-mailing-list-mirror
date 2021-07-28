Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A757DC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 22:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3F86101B
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 22:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhG1Wsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 18:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhG1Wsh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 18:48:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117E8C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 15:48:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o3-20020a2541030000b0290557cf3415f8so4770730yba.1
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kYQZpHASDX0+tz5r0s9lEyAGwz/XRgYNhdtvt/otYnY=;
        b=m6UX7iu4DIoJoE6pLf5Wf21dxHQLIosxeQg28CgcPAJJmmnopSvbDdtjsWUPJTEt/0
         Zgouc8ZSNSrvBqRP87BmblRgA78NNaCK7nUrT4o6AwJFrT0SRtIfhmKjx+m7m477QiIN
         jV2hjwaCwU59fESYLoy6+ZEbtOd//EIiHRwX81kgLSj/RJQVzNNFlzOHOCGjNHJMoUJC
         1zlz0khnNrACIg5ZvtPoD6Fofxx68XOyJdp69k6x9Hf5bw8cNUfmtTn/NnIV9IfK5zdK
         k40Jrt/gUm2To5aThrHMp6pjtqiaiXb1B4T6iLdQHVeYVGNQVSj0vJsKDJzlaOUDPtYR
         0KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kYQZpHASDX0+tz5r0s9lEyAGwz/XRgYNhdtvt/otYnY=;
        b=ScjCL9m6l7RkHUUXZE7sD9FVBCYY/eAZYXYlmpxP/IXX6ghvghHBa/wAL0CvWEPRmN
         anT9ZXDNSje7yQPK5tSrLtujXE4Tqa8Lg8acavieg0u8cwrWxGvOnM1gShIK1mcyo5vH
         1IMX0sSemE809P/une4/0PI2sILsYGdIxTSeF2QkSU3qeqTfiqZTMHIrpOfKfFt4M1/Y
         0C/apMyombG4Ascva2Zp4Fn8WEVz8LgWJ+qH0dhReDHhVtMybC4ZxUcSM4DzGWigF2Ij
         0ArzTgUeKaT7hfPXLU2Mj0KlLz8Lmz3liWzRbCH/2EugOMFYgadi4nGulk6p793liVQT
         klaw==
X-Gm-Message-State: AOAM530KSQPcM7NKfFtgQVBdKs/EJkFrkyqNzyDEgi7YPnCm3benTv0u
        G0E6MXA+Hr1cqHW2bDMpyUOvTDv0LNtox/nwBMh4
X-Google-Smtp-Source: ABdhPJwzPZtjMe6VPZL2nGqAmqSbNLmTT1riAemz+Dk8NUxkeQ7DCzR/+6TGCmqk5fot4wji1RZa7+j0zmX1VjEJP1bl
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8b8b:: with SMTP id
 j11mr2639278ybl.138.1627512514066; Wed, 28 Jul 2021 15:48:34 -0700 (PDT)
Date:   Wed, 28 Jul 2021 15:48:32 -0700
In-Reply-To: <071e6173d8e418349d94fea97624e8cee9f1dde5.1627501009.git.gitgitgadget@gmail.com>
Message-Id: <20210728224832.2717826-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <071e6173d8e418349d94fea97624e8cee9f1dde5.1627501009.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: Re: [PATCH v6 3/9] ssh signing: retrieve a default key from ssh-agent
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com, fs@gigacodes.de,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> if user.signingkey is not set and a ssh signature is requested we call
> ssh-add -L and use the first key we get

[snip]

> +/* Returns the first public key from an ssh-agent to use for signing */
> +static char *get_default_ssh_signing_key(void)
> +{
> +	struct child_process ssh_add = CHILD_PROCESS_INIT;
> +	int ret = -1;
> +	struct strbuf key_stdout = STRBUF_INIT;
> +	struct strbuf **keys;
> +
> +	strvec_pushl(&ssh_add.args, "ssh-add", "-L", NULL);
> +	ret = pipe_command(&ssh_add, NULL, 0, &key_stdout, 0, NULL, 0);
> +	if (!ret) {
> +		keys = strbuf_split_max(&key_stdout, '\n', 2);
> +		if (keys[0])
> +			return strbuf_detach(keys[0], NULL);
> +	}
> +
> +	strbuf_release(&key_stdout);
> +	return "";
> +}

Could the commit message have a better explanation of why we need this?
(Also, I would think that the command being run needs to be configurable
instead of being just the first "ssh-add" in $PATH, and the parsing of
the output should be more rigorous. But this is moot if we don't need
this feature in the first place.)
