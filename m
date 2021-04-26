Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98AC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8CA61176
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhDZPJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDZPJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 11:09:20 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99381C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 08:08:38 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id ef17so21688064qvb.0
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pxs8BqcKKiIH5e9vyjZsnxOXPVvGyo9Vm81/Lwiijik=;
        b=BavPVkMYIQNocul+YrHGz/K8H5ZBIST2v30zhWkqWS8vzEzMLPzv+ADqlyx7ctCNYb
         JyagqAmLJd0iIw3ciG8F2nY2boknZWCLhcT21cjgd2d44xadfhpE62Cq1eAPUO/HfjOU
         q6CpjwO5gUJtAVkYz5UYUHorZaGlsd6TdJVyI/SzH8/YX/QQBr2mwcOvcSHE0Mf95TiD
         07Q10qovyUBipPBtTo/T2FHxkuUTmNljeK+oBeKEIirf3v6LH907idQAfGzrJ6REzbpF
         1kHNVlQJWNAGhU/L3dHiPqgaGog8KyFcRofuX/zTVPL7Yjo7llciGptmsnU8kbRdlOwz
         hydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pxs8BqcKKiIH5e9vyjZsnxOXPVvGyo9Vm81/Lwiijik=;
        b=EIdVsJAvHKEgiQ1FrouACfcu0gbvpiTdySHbY9LxW5wRFTNCKzh1YdANZbVqMvsAey
         Q/XI8KH28kznWdA9Qdt+8gaC+/FwqWhjAMvcP2dZY2WfPKBqTrV7535DNXgbW8/+V/Kt
         rbrXOZ1yaz2a6qvdfbmmjiFsou/DqVMip6hdiYR+hJ3+6c1rchKKhbyG84qRjW55dEbg
         tV85QNAb66oxZpivVik6Qpvf05eESC738Ux1iRDg8lyR7pyoCrGKnzJIPCzjO6+PI9eu
         /kzrYzNe1/pZdarHiAByvR4H9Fo3QkKygaz9XUCLU543U8VVLIRc7KOPFYt6bub03cGz
         0qkw==
X-Gm-Message-State: AOAM532YwQPXLDoMCTsQmg7YrCkGarEagbS3EiEOwpLpI580/LOgpgpL
        HWuQ6Y13Oq7LFX9IuuNJ0W8=
X-Google-Smtp-Source: ABdhPJySo13v8fAHg6nx2lIit90tYc8elMQPtzim/ED4ivivzFkloDk5GxMwYcw8wQdyhwVB5sglDQ==
X-Received: by 2002:a0c:b3c8:: with SMTP id b8mr18316182qvf.17.1619449717851;
        Mon, 26 Apr 2021 08:08:37 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:bc73:cea4:3f85:d407])
        by smtp.gmail.com with ESMTPSA id m4sm168450qkh.131.2021.04.26.08.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 08:08:37 -0700 (PDT)
Subject: Re: [PATCH 05/23] fsmonitor--daemon: add a built-in fsmonitor daemon
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <95d511d83b1211f24aeb17edbd4918750f406ece.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <522e10e6-f18d-9c28-7102-f5a855d4be50@gmail.com>
Date:   Mon, 26 Apr 2021 11:08:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <95d511d83b1211f24aeb17edbd4918750f406ece.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND

I think these compile-time macros should be replaced with a
method call, as I've said before. It should be simple to say

	if (!fsmonitor_ipc__is_supported())
		die(_("fsmonitor--daemon is not supported on this platform"));

and call it a day. This can be done before parsing arguments.

> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
> +{
> +	enum daemon_mode {
> +		UNDEFINED_MODE,
> +	} mode = UNDEFINED_MODE;
> +
> +	struct option options[] = {
> +		OPT_END()
> +	};

I can see where you are going here, to use the parse-opts API
to get your "--<verb>" arguments to populate an 'enum'. However,
it seems like you will run into the problem where a user enters
multiple such arguments and you lose the information as the
parser overwrites 'mode' here.

Better to use a positional argument and drop the "--" prefix,
in my opinion.

Thanks,
-Stolee
