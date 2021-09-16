Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45E7C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837D161207
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhIPFwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhIPFwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:52:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED7FC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:51:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c22so12291151edn.12
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kvMx7zLa3K4Qx5E2kKXZ59Ml29D9/MhRwmXAquAeLpM=;
        b=Ys/bh8oa9NFZvZZfA/wsbGjEODjc3ICpyAT8DSYYC2otq9TJ5dVHufhxP8vFkUnU/m
         0o0ro/fDD5YPLs74B5j3MPx+qX6Qlng+uTptNSRu1MvRD0A0rpCS/vZteOzp6G3aEOhd
         DLSGzCN63/29VHAqrg2erya2qVRupp3v0IfSeZ9//srWzCs9DKAQQfsrnUe9ia4C9gw5
         wUjAoPPCga/80CqhMFyfL4airNTkdb0yLLUK00wPAIrjA/QSZSRs2qp3OLEIvTml+XF/
         sbv6+NL3z4moHFDsfa6eLlKbBZgoGwaR2TD4RCEd1o9oBBJ0fsdM3ITnJ24papllhOn5
         Fh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kvMx7zLa3K4Qx5E2kKXZ59Ml29D9/MhRwmXAquAeLpM=;
        b=qtpEeZaxF+4M6+XWmz7dymB/VxNWium09VGhxNlGcymEtKzTyJJ6Wvhn7wrUGKkI7v
         6GWF22XstWpq+eygaExBhD+XNKZ1OZeITAm7fyE1+FGzlYk9DXRfG4o7adSMZaIo8adQ
         V8gRlehySuhFjGxj00b6zh4X50b3X0lvlGD/w/sY/7WAh40TX7j5WxRUl6vgcf15siqy
         Uz4fFlyrSdvJ2Mg9LkxlpptDccDk/2hajhdZAr8OcajZ6anOmV4fxSjxELau/psoKAgE
         UHWUWGcJ0JHwoFwSUlTEs/mRtKYwaZ9s6IJTlLcXPnMF2bw+KTYTkKzut0iLFwU+C8YB
         Q3ZA==
X-Gm-Message-State: AOAM532w1MGOjwMGeKdXeRpAX4P+qjpjl1SPbRoqnGGeUHa9KcXjxIe4
        /zFvVdqeT5vCPJTT0EvKTRo=
X-Google-Smtp-Source: ABdhPJymygGH04ENHrv4SQ89gHLvKaZhsvC6w0WOTAVK5viAhIrW1KSRg8a/K6gAAOmZflqGMHvrTQ==
X-Received: by 2002:a17:907:dab:: with SMTP id go43mr4453622ejc.96.1631771470395;
        Wed, 15 Sep 2021 22:51:10 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a4sm145644edb.79.2021.09.15.22.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:51:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 5/7] simple-ipc/ipc-win32: add Windows ACL to named pipe
Date:   Thu, 16 Sep 2021 07:47:27 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <5eadf71929559968cafa18d03c3a623b1adff926.1631738177.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <5eadf71929559968cafa18d03c3a623b1adff926.1631738177.git.gitgitgadget@gmail.com>
Message-ID: <877dfhm5ki.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 15 2021, Jeff Hostetler via GitGitGadget wrote:

> +struct my_sa_data
> +{
> +	PSID pEveryoneSID;
> +	PACL pACL;
> +	PSECURITY_DESCRIPTOR pSD;
> +	LPSECURITY_ATTRIBUTES lpSA;
> +};
> +
> +static void init_sa(struct my_sa_data *d)
> +{
> +	memset(d, 0, sizeof(*d));
> +}
> +
> +static void release_sa(struct my_sa_data *d)
> +{
> +	if (d->pEveryoneSID)
> +		FreeSid(d->pEveryoneSID);
> +	if (d->pACL)
> +		LocalFree(d->pACL);
> +	if (d->pSD)
> +		LocalFree(d->pSD);
> +	if (d->lpSA)
> +		LocalFree(d->lpSA);
> +
> +	memset(d, 0, sizeof(*d));
> +}

[...]

> +fail:
> +	release_sa(d);
> +	return NULL;
> +}
> +
>  static HANDLE create_new_pipe(wchar_t *wpath, int is_first)
>  {
>  	HANDLE hPipe;
>  	DWORD dwOpenMode, dwPipeMode;
> -	LPSECURITY_ATTRIBUTES lpsa = NULL;
> +	struct my_sa_data my_sa_data;
> +
> +	init_sa(&my_sa_data);
>  

[...]

>  	hPipe = CreateNamedPipeW(wpath, dwOpenMode, dwPipeMode,
> -				 PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, lpsa);
> +				 PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0,
> +				 my_sa_data.lpSA);
> +
> +	release_sa(&my_sa_data);
>  
>  	return hPipe;
>  }

Just a nit on the init pattern, since we always allocate this on the
stack (this as all the relevant "struct my_sa_data") I'd have thought to
see:

    #define INIT_MY_SA_DATA { 0 }
    [...]
    struct my_sa_data my_sa_data = INIT_MY_SA_DATA;

Which gets rid of the need for an init_sa() function.

Also having the release_sa() do a memset() is a bit odd, usually we have
a reset*() function do that if the intent is to re-use, but it doesn't
appear to be in this case, and we don't return this data anywhere, do
we?

