Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074ECEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 23:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbjFOXck (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 19:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFOXci (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 19:32:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565EB10F6
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 16:32:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6668c030ec9so219337b3a.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686871957; x=1689463957;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVCg2szd6FG9mSVAdQvOcyfYI1EikWjQr7snyJTm17w=;
        b=G3ZhkVspWdUI0sATFcIPY6GdqWAM/FoejQSaHBijiDh2B8fDY0hUd/pTnu4/ZvrSG4
         658mOvUsJHuERH4TD0wFGmvogpHqJpsp60PZxfiWR+yMvjGkoDE69DXfny0G14Z9czQm
         IoG18c/sboCniLovE6FmJ96sTaGsLaeFK/Fv1/dMxNOc8Rq7jrh+Tl/VAI07AdtNNzfj
         g4q4lJilqB19eUpI5qhelQ8dsz24D09drFNobWVYw63Gv+0Iy8haOYKyh5rfgBiK+VBh
         fGDwxB7zkZgxB97AJ9hQHGOdFDEPSEEvu+unQ5MGYoGW6XmjNkryJZUWKl5KhQIgBlrC
         3G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871957; x=1689463957;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oVCg2szd6FG9mSVAdQvOcyfYI1EikWjQr7snyJTm17w=;
        b=TYaMLW/vWgzClQdNUxhB/F0nO5VDbz5ceRFgfXBMirrBT0v/kRFaQP6wU1EcPmfDag
         GOuyrDNRa85a95FLKNlwRPIdrYx2VMSlFTgquuV1ivGMi+S6srasG0NzZlq21CYHf7xp
         r8FyjutMLgk65vjrsHh8nfdZP8kjqObfSsyAcj2Yiosc4zqjJpuMfuDw2KfTrrB35Lgg
         c19h7KYu+1NI1zGUtwYkABh89vY7225Nd9QBEmNdqjQWhBN9kgTa455DnYxmFwEQlE2Y
         ZGBZpBbzkHEIHngNEq3zaInl9C95eVizRo76SpKwZhM84J/gKp4GDrv6OnyCMtyzfWyj
         XMfA==
X-Gm-Message-State: AC+VfDzl2GNa7pvtRFu7nHvwBXeK05QoGGRzOrkt00uRhS/AJJtYpFxb
        MOkZDjD9IaL2vJqeeeAA08k=
X-Google-Smtp-Source: ACHHUZ5uleBHDu73z0+AqcxPsXtUbmkq75Ho2tqreD9zVIAUT1bT91qO8KiHlIHf2096/Y3aIAeq1g==
X-Received: by 2002:a05:6a00:1a0e:b0:656:8e21:bd37 with SMTP id g14-20020a056a001a0e00b006568e21bd37mr602718pfv.21.1686871956644;
        Thu, 15 Jun 2023 16:32:36 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id q23-20020a62ae17000000b0065992d334f4sm12849835pff.177.2023.06.15.16.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:32:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/9] t/helper: add 'find-pack' test-tool
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230614192541.1599256-4-christian.couder@gmail.com>
Date:   Thu, 15 Jun 2023 16:32:35 -0700
In-Reply-To: <20230614192541.1599256-4-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 14 Jun 2023 21:25:35 +0200")
Message-ID: <xmqq1qicuwrw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> In a following commit, we will make it possible to separate objects in
> different packfiles depending on a filter.
>
> To make sure that the right objects are in the right packs, let's add a
> new test-tool that can display which packfile(s) a given object is in.

This tool would be serviceable if we only are interested in checking
just a few objects, but if we were to check many objects, I have to
wonder if it would be more efficient to use show-index to dump the
list of objects per pack, which should be sorted by object name, so
it should be trivial to run "comm" with the list of objects you want
to check.

Or if you only are checking about a dozen or so, taking one or more
arguments from the command line and looping over them may also be
OK.  The output format of course may have to be changed, if we were
to go that route, though.

It really depends on the granularity at which this test helper wants
to work at, I think.

Anyway...

> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index abe8a785eb..41da40c296 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -31,6 +31,7 @@ static struct test_cmd cmds[] = {
>  	{ "env-helper", cmd__env_helper },
>  	{ "example-decorate", cmd__example_decorate },
>  	{ "fast-rebase", cmd__fast_rebase },
> +	{ "find-pack", cmd__find_pack },
>  	{ "fsmonitor-client", cmd__fsmonitor_client },
>  	{ "genrandom", cmd__genrandom },
>  	{ "genzeros", cmd__genzeros },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index ea2672436c..411dbf2db4 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -25,6 +25,7 @@ int cmd__dump_reftable(int argc, const char **argv);
>  int cmd__env_helper(int argc, const char **argv);
>  int cmd__example_decorate(int argc, const char **argv);
>  int cmd__fast_rebase(int argc, const char **argv);
> +int cmd__find_pack(int argc, const char **argv);
>  int cmd__fsmonitor_client(int argc, const char **argv);
>  int cmd__genrandom(int argc, const char **argv);
>  int cmd__genzeros(int argc, const char **argv);
