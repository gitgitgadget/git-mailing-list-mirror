Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADABC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 00:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB7E64E6B
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 00:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhBQA7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 19:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBQA7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 19:59:12 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F53FC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 16:58:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id p2so551972edm.12
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 16:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=47V3l25Yl/PzL1lgQWtDHInE8+AVLUadW01xaxs9H34=;
        b=LDdZcEye/2x+AAloLjA6/51n9/xwLf5T1AH+e6hix6CtUBukOvkZOLZBfyydWaJwgz
         td5NK7/T5d6umDxEIjlKPbDW3txh+ECjJkYGzBhMMzpOVtshNsKb6Jz7HSyV2WKl4UNj
         O6pBl+qW7qq4ja+E5WRTXa0hnm1fq71a++YiSbBiI10y/a+JDA4G/YpM7ECIceSmy8kJ
         eLBk8IRUcTXII2aN85HDEW0fs0o454QlPAc149wsJzub3P/EX98oliJ7G0FdBTturNr2
         qTlr8cUVzltdMqm20TbfhaQzNIZTqcSzrB7C98vvE0LX4UhP6mbNyxzgfAPtakvJ31CI
         lb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=47V3l25Yl/PzL1lgQWtDHInE8+AVLUadW01xaxs9H34=;
        b=kiHcF9+DEqSReQwtAhsc38oqsAgPmcyKQOMLaUo7RC3nKbmPOCKp9SCwkZXm48oNBi
         ge9ejC673bkTZ+llgr3Pmuepx7eU3T4kbskm3kFmErXPR/keqJoQely9t/Y41JSrVhDx
         daMn4iP4FLUcy+GYziwbZ7B/T8JwngDge9hmap+P4vn4NU9riL5zZBivtGmze/lvOTuJ
         +LcziZKax9KpZacxGKN80oYvru2tFjyVXzJ9VaBa4yat3USixGfdZHUs+reRj4zKdWaR
         InEa1Ms5yZ1UtUcuAC6GTN+VmlLcq9qEEGXvTSq9Be2say7yCAKZH8OSzGwxIx6NtqWa
         TfNQ==
X-Gm-Message-State: AOAM533eQPn3FpqAMyTXk0O+NX+Rd/MKwiIhO+mK8FNwydLSH2rjWUEB
        PMCFizOhN8EC9gkr7Gj2o76rolZLg5AbkQ==
X-Google-Smtp-Source: ABdhPJzAAC1pWdh0fFQRJE6nhDGBhfC7+Ku0cMH3Ght25pobyLAV6IP0N8LqBw8it9m44bAYxpYktg==
X-Received: by 2002:aa7:ce99:: with SMTP id y25mr4081530edv.167.1613523509741;
        Tue, 16 Feb 2021 16:58:29 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id lt22sm246430ejb.80.2021.02.16.16.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:58:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] pretty: add %(describe)
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
Date:   Wed, 17 Feb 2021 01:58:28 +0100
Message-ID: <87k0r7a4sr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 14 2021, Ren=C3=A9 Scharfe wrote:

> +'%(describe)':: human-readable name, like linkgit:git-describe[1];
> +		empty string for undescribable commits

In the case of undescribable we've got the subcommand exiting non-zero
and we ignore it. The right thing in this case given how the rest of
format arguments work, but maybe something to explicitly test for?
>
> +	if (skip_prefix(placeholder, "(describe)", &arg)) {
> +		struct child_process cmd =3D CHILD_PROCESS_INIT;
> +		struct strbuf out =3D STRBUF_INIT;
> +		struct strbuf err =3D STRBUF_INIT;
> +
> +		cmd.git_cmd =3D 1;
> +		strvec_push(&cmd.args, "describe");
> +		strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
> +		pipe_command(&cmd, NULL, 0, &out, 0, &err, 0);
> +		strbuf_rtrim(&out);
> +		strbuf_addbuf(sb, &out);
> +		strbuf_release(&out);
> +		strbuf_release(&err);
> +		return arg - placeholder;
> +	}

There's another edge case in this: if you do "%(describe)%(describe)"
it'll be run twice for the rev, 3 times if you add another "%(describe)"
etc. I don't know if pretty.c has an easy way to cache/avoid that.
