Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDD3C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 23:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBGXDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBGXDo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 18:03:44 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6907D3FF0D
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 15:03:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lu11so46869294ejb.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 15:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=04UMFyYuG8+uqsHYZz4wOH6f7xdZGB3dfisiXEGue/Q=;
        b=O0Iy2hVvBwMg9YMfGdimbTDcScz+v6ho12Nse26qEIwQSHy23MHkG4mbOTRY+kwMGe
         f6FPTHMCSc87bLJMiK1H6EEc8IN7oTNb8p9CbZ3udBCWZA5uWvoH7ySExwXlvS0yrw8p
         Yk+MGE59tXCGlbpd4mgr7PXUlmwLCvSLfzuN+PKkKmR95DE3LLE1338btQeBTA2s9OK/
         78jrDmn/fOFdua46dPTMTTT/DSNR3KROVqo2gYpK/3xAx6WjgnSaA7zpGMrKRMqaC6GX
         cAeyQbWD30/vn0v+0oSzBCZFiMuWteVlYnReWGWZW8usVHvEwGa4eIXA0sQoA2zDuOuh
         fAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04UMFyYuG8+uqsHYZz4wOH6f7xdZGB3dfisiXEGue/Q=;
        b=zzlJvTv9Zo96snaV8PPw+nvXsN9mMshm00G28d+1Pbyt9LkINL/7hzqWhoaekUIDyp
         LVUBcdWMTqJsmnbV+n6fgXokaGvXvu2TVJVnxNzN6mbpJdxWAUzZi7Mg/qX+n1DYzsEu
         dTojpQc/xU0aeufFM19zvpL6fmNXk89fVgGAdz7Hvtq70b/IyubizXQBxOy7IZ2t7JTb
         z18SRDZ7AJQCEjSecmLvoJnm698roHpFPwiR9iFpii82OjboGRiXrN5GH1Hv0AFBAeZZ
         m615tj5ssvxU1mHZPjM3WRDTIf6vEKyYKPHFU4ci/yd+63VC5wB28WJzAvpzMfHbxput
         1w7w==
X-Gm-Message-State: AO0yUKVrcDVdLwOhHfbC40JQ8Vd1N1dlqzOjyeFsEdUU7/aM7VNoxvvh
        HvWhEzwolum8qsNCWU+ktKDPXWMspL/dmRwg
X-Google-Smtp-Source: AK7set8IFBKGfGEnrvGpA/uTQudeo4n6XMbNc5iw/ISlvficmRn3Ix751qSfop8KpGRAFlqGm9ncig==
X-Received: by 2002:a17:907:3f11:b0:8aa:991:3923 with SMTP id hq17-20020a1709073f1100b008aa09913923mr4594037ejc.7.1675811020741;
        Tue, 07 Feb 2023 15:03:40 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id bu23-20020a170906a15700b0084ce5d5d21bsm7402097ejb.22.2023.02.07.15.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:03:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPWzz-0014Td-2R;
        Wed, 08 Feb 2023 00:03:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v7 4/7] submodule: refactor is_submodule_modified()
Date:   Tue, 07 Feb 2023 23:59:05 +0100
References: <20230117193041.708692-1-calvinwan@google.com>
 <20230207181706.363453-5-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230207181706.363453-5-calvinwan@google.com>
Message-ID: <230208.86pmal13jo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Calvin Wan wrote:

> diff --git a/submodule.c b/submodule.c
> index 768d4b4cd7..d88aa2c573 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -28,6 +28,10 @@ static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
>  static int initialized_fetch_ref_tips;
>  static struct oid_array ref_tips_before_fetch;
>  static struct oid_array ref_tips_after_fetch;
> +static const char *status_porcelain_start_error =
> +	N_("could not run 'git status --porcelain=2' in submodule %s");
> +static const char *status_porcelain_fail_error =
> +	N_("'git status --porcelain=2' failed in submodule %s");

Let's instead do:

	#define STATUS_PORCELAIN_START_ERROR \
        	N_("could not run 'git status --porcelain=2' in submodule %s")
	#define STATUS_PORCELAIN_FAIL_ERROR \
        	N_("'git status --porcelain=2' failed in submodule %s")

Because a thing you're not discussing in the commit message is that the
disadvantage of doing this sort of thing is that we lose the checking
that -Wformat gives us (try to add an extra "%s" to these in your
version, then the macro version, with gcc and/or clang).

Personally I'd prefer just copy/pasting over losing that, but using a
macro instead of a variable allows us to have our cake and eat it too.
