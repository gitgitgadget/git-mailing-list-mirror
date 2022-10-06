Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50A6C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 20:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiJFUi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiJFUiw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 16:38:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC948FF8C5
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 13:38:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so2876841pjl.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=no4/+yGnKbxWg9NemwYOk3lYAK/CIBV7pQ1fcZpZW4E=;
        b=id6oN3FIw0dAbVq3kRVORvvlxsw+bKghpJaSjWWV8LAxnEp00owQ0U6zLiD1KdwJIB
         bA7r5w9XdRAmDRBXaWjC1xYxZgNoncuFU+4iVrqqx+Oj/0AYgnc5PZZqZ2bXfCDsGhpW
         +UnK+zcDJZoEaEjNizXbQRrBMQli9pUC50c26tT5lVfrBiuiMM/s3oINQlncczkrGAhP
         hKI+1t/2mUqgXiovjvjouUur+gXdH0DsQ7p1mlFBkJlOOO+Y44fyz1AHtOk2W9i9OQI/
         WbsOSMd9XPgcNC/1C30U5A5tZQoJYAN0+4x1fPN/yJI0JMvuyCCyjl/NgUtDLeFIMYDp
         daJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=no4/+yGnKbxWg9NemwYOk3lYAK/CIBV7pQ1fcZpZW4E=;
        b=YtspN393Izir+PJCOhuoO1/D/7ljKsJOYFnjzGCJijBjeu75C16vkwZfsxaPPtgUNi
         f/3WMwypqihUL3q3jIADRko53MA/V8G3Ypn+CCy+0/YGRhSixE11fBPkehzuV2IqFzW9
         RG1Dh1v5oTu0SxdQrQRmdF06/XHEwugizR51uATEXj2fFB8N9D6NJ1V0SzYRUYkZDJ3m
         0w1EfXu5QDAMC2OiI9QUDXMFFI1xqcXmdHN4ARxQDQ3vWgGLGlz2Nus0QWQ3TWj0+KJS
         mA8o4FnpoAOEkDpWayPPq9BRv0eyjUmyMJN/OKfvoywhf2N3Q+EMY1bCgL7VtvfRKjtv
         L5mA==
X-Gm-Message-State: ACrzQf11g1066tZcyzCYL+o6B6MQZu6NhxqfPyEe483sgalpu48ZueOu
        U62DpYlZwrRyNh3ppxUmj5Q=
X-Google-Smtp-Source: AMsMyM57htbAs/EwM9AK5oUCcnZMaoGuJhhCqO8hFBmTlIB8dNSckJAvC/Oec6h980skRhuT01Uygw==
X-Received: by 2002:a17:903:1251:b0:17f:7f78:e71c with SMTP id u17-20020a170903125100b0017f7f78e71cmr1611028plh.147.1665088724413;
        Thu, 06 Oct 2022 13:38:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b00172cb8b97a8sm63908plb.5.2022.10.06.13.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:38:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 13:38:43 -0700
In-Reply-To: <pull.1375.git.1665085395.gitgitgadget@gmail.com> (Jeff Hostetler
        via GitGitGadget's message of "Thu, 06 Oct 2022 19:43:13 +0000")
Message-ID: <xmqqh70gk7qk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series fixes three syntax errors that caused compiler errors with
> clang 11.0.0 on MacOS. I've included the error/warning messages in the
> commit messages. The offending statements did compile successfully under
> clang 14.0.0 on MacOS, so I have to assume that this usage is newer than
> what clang 11 supports.

Ah, this looked familiar, and the last time we saw the one in
builtin/unpack-objects.c

https://lore.kernel.org/git/20220710081135.74964-1-sunshine@sunshineco.com/

It seems that merge-file.c was OK back then but soon after we
"broke" it with 480a0e30 (merge-file: refactor for subsequent memory
leak fix, 2022-07-01).

    $ git grep -n -e '{ *{ *0 *} *}'
    builtin/merge-index.c:15:	char oids[3][GIT_MAX_HEXSZ + 1] = {{0}};
    builtin/merge-index.c:16:	char modes[3][10] = {{0}};
    builtin/worktree.c:321:		struct config_set cs = { { 0 } };
    merge-strategies.c:93:	xmparam_t xmp = {{0}};
    oidset.h:25:#define OIDSET_INIT { { 0 } }
    worktree.c:795:	struct config_set cs = { { 0 } };

I wonder if we want to introduce some named _INIT for these specific
types?  Perhaps with something like

    /* for config_set */
    #define CONFIG_SET_INIT {{0}}
    /* for xmparam_t */
    #define XMPARAM_INIT {{0}}
    /* for mmfile_t */
    #define MMFILE_INIT {0}
    /* for git_zstream */
    #define GIT_ZSTREAM_INIT {{0}}

	Side note: between { { 0 } } and {{0}} forms that appear in
	the existing code, I picked the "unusual spacing" variant,
	i.e. without any space, hoping that it would signal the fact
	that we would prefer if we didn't have to use these to
	please older compilers to the readers.

Unless we plan to soon declare that clang 11 is too old to matter
anymore, that is.

The rule, tentatively until the compilers that need extra levels of
braces die out, can be "if there is <name>_INIT for the type, you
should use it, but otherwise you can do { 0 }", or something like
that, perhaps?

