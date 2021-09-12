Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F68BC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0540261039
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhILWZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhILWZs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:25:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFBEC061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 15:24:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o20so6074938ejd.7
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=v6z5dIFuUxNie51/gjtwd0d3yH7tMVd35E3jyFhZ5iw=;
        b=ah7ar5Iq+jXE7nDlJc698is6RKRJS070KbaZz97iCJmqmE+YtD9vC+g81ZIVarHVkR
         cIjqasNbOZjCNr5VjoFQ/9DKj64FJgVrj8QqYGTq7dpi11DjuNdFQSWHEV9CZmPznHoJ
         euC5FYprCfOy+hCCU1eVcPcjX8LZDG00dtwYHNXAvvcwqs4vXRkg3mLwVLra52Xz/jYZ
         OCJHPYGpTbK8aTVpD2hiEQNTo9V+6CFc1O3NtZ+jBF9qBUJubq0Kk8+E7zrS7Wp3qgZw
         HCmCLnDaMS/IEXLBIhpBTBVncdHiiIalbx3OFrfiVoqWTiPtJQ9f2NiDUJM2cX4ipAim
         o9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=v6z5dIFuUxNie51/gjtwd0d3yH7tMVd35E3jyFhZ5iw=;
        b=1w88FNuEDacx6CqmjYiGvQckSa63mOLYWjJWUb/k+7GZ4dwYPD8DJeJEXwV+JvkMaR
         4ObW2hyZxZdN9bYfV1sVH5b1Gxiu9Ox6W1+bQAbjYBIuosiEcBARjzLrXyrKrz0VU7u0
         a1GLXALxuQ6aosgCPWq6ghcN6ZbD64vydUs+WrDMJdyAjjyFdUpfOV3Vhqob8vpF1qjc
         G09pcMPBOO5+aPSYfA2TK2zy3EbmZMSNeBYsUl9sVa23FJryysb2+NmIrpwOKXuXHkvT
         hu1XYuPaT2hxMgZi+oer6xCVpwrnSDVM5nU3Xw9ZGl9lwt+Zm0vXOT4BXXtFnkHQWjSG
         maSA==
X-Gm-Message-State: AOAM533A9avb3bTAlA96VHIb7JUCkIV6heTwHu2TrlcUM59IULZcp0YM
        g1yedAdJMPhXQ7TU6K9WjafShvSd4MZVEA==
X-Google-Smtp-Source: ABdhPJysLdv2FRF9xP3V8XdwxdsrDwh83TC+PFcvzo/STneL1laZUKv/rzDPuc/H26yg42Q4DO1rVw==
X-Received: by 2002:a17:907:76ee:: with SMTP id kg14mr9346265ejc.90.1631485471749;
        Sun, 12 Sep 2021 15:24:31 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i13sm2836408edc.48.2021.09.12.15.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 15:24:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        matheus.bernardino@usp.br, stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 04/14] dir: select directories correctly
Date:   Mon, 13 Sep 2021 00:21:42 +0200
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <723de4e42582afbe841ed96470fc02db44b24b5e.1631453010.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <723de4e42582afbe841ed96470fc02db44b24b5e.1631453010.git.gitgitgadget@gmail.com>
Message-ID: <87h7ep5t5t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 12 2021, Derrick Stolee via GitGitGadget wrote:

> +	/*
> +	 * Use 'alloc' as an indicator that the string has not been
> +	 * initialized, in case the parent is the root directory.
> +	 */
> +	if (!path_parent->alloc) {

This isn't wrong, but seems to be way too cozy with the internal
implementation details of strbuf. For what it's worth I renamed it to
"alloc2" and found that this would be only the 3rd bit of code out of
strbuf.[ch] that cares about that member.

> +		char *slash;
> +		strbuf_addstr(path_parent, pathname);

So is "pathname" ever the empty string? If not we could check the
length?

Or probably better: ...

> @@ -1331,6 +1359,7 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
>  {
>  	struct path_pattern *res = NULL; /* undecided */
>  	int i;
> +	struct strbuf path_parent = STRBUF_INIT;

Just malloc + strbuf_init() this in the above function and have a
"struct strbuf *" initialized to NULL here? Then we can use a much more
idiomatic "is it NULL?" to check if it's initialized.
