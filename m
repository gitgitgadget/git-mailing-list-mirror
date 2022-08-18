Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA524C32773
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 15:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbiHRPDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343980AbiHRPC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 11:02:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33558BD14C
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:02:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n4so2032720wrp.10
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=a0mqdGJkVIbClbEDQ3A7jE8PByzi4/2uRKTuMAhPETo=;
        b=B8UiakRA7KRvs8RDWaFvmsg2RDJMp2utVpe4yP4qEGyuU1dKocbgQ3ZUKCmjwV/rE7
         T0UtlpAvD8n1Hk1NwA7xzE8VrGEbN8SS1eHMFsipAgVLBjj3Jxs3W77IabsuTlLOjw3n
         7bIqXD61qMwP1zvAeAqDjNO1DDAPhNkZpJPKgQ5B0K/lu8UbTUwQGKA7HpksDelVjUjo
         L0AOKzwC5D0UZZVEtveGWh4B/KEJZz/izmOZKvOAOzXi8JWNiFYV3alepETbSCqtNeP/
         AGChFUtH4b1TLRqSNJY4VNw8ocZ1feaLuWaN8rSMnaNeZo5oyblMOEyb/OFU5Mms9dNf
         ku7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a0mqdGJkVIbClbEDQ3A7jE8PByzi4/2uRKTuMAhPETo=;
        b=ARw/dRrnu3cP7bLg/hXsBE0W4lnZOWJdScjfv0F12RkXtv0Bi54wFtymjla5lm5GyT
         4XRISJviqgbBIHhS6FtPA4gpiCj/BhZe8qxbB5EfUn1rQWL1Z/uaT8NKvwMDiak6sZzZ
         kbPbXri9Nis1iKJ+6ioBioWwE2QtDBwtFd4UbGP3oOQe5nfuSk9yvp3IzCAwqCHEFk58
         7ko/b6qCgmWxUVVLYUv9swvkk4Fd8bzNHspVddEFTO5CG65eOq7dKhAWu+7Zj31t0VEL
         d3YFYEDait4LvRsim6CmvLxNfz5Tmx1q3ycZhoeY88Adk8b09Si0dfMwNIL7Q7hah7/c
         q53Q==
X-Gm-Message-State: ACgBeo2EJV5yGAD36/63rYxl0s9EVJgL4UHjSsZ3kua3BDSmNXsCgQ+T
        Eso52ohNS+t4d/FuWhi22rw=
X-Google-Smtp-Source: AA6agR6WCYMNA9Jln3yQ23B1gqyvV8uRtc98UrC02hI4V4ujZ6lcOwtXRYZk6JRWVTKHqwBTjI929g==
X-Received: by 2002:adf:e199:0:b0:225:2f90:9178 with SMTP id az25-20020adfe199000000b002252f909178mr1715057wrb.318.1660834976761;
        Thu, 18 Aug 2022 08:02:56 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b003a5bd5ea215sm2329740wmj.37.2022.08.18.08.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:02:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oOh2Y-000HKV-30;
        Thu, 18 Aug 2022 17:02:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/4] sequencer: do not translate parameters to
 error_resolve_conflict()
Date:   Thu, 18 Aug 2022 17:01:09 +0200
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
 <cover.1660828108.git.git@grubix.eu>
 <4684d54aeb3e00c96ba581c824a04e47b7236db7.1660828108.git.git@grubix.eu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <4684d54aeb3e00c96ba581c824a04e47b7236db7.1660828108.git.git@grubix.eu>
Message-ID: <220818.86v8qp8uid.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 18 2022, Michael J Gruber wrote:

> `error_resolve_conflict()` checks the untranslated action_name
> parameter, so pass it as is.
>
> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  sequencer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 51d75dfbe1..8b32b239b9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -537,7 +537,7 @@ static struct tree *empty_tree(struct repository *r)
>  static int error_dirty_index(struct repository *repo, struct replay_opts *opts)
>  {
>  	if (repo_read_index_unmerged(repo))
> -		return error_resolve_conflict(_(action_name(opts)));
> +		return error_resolve_conflict(action_name(opts));
>  
>  	error(_("your local changes would be overwritten by %s."),
>  		_(action_name(opts)));
> @@ -3753,7 +3753,7 @@ static int do_reset(struct repository *r,
>  	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
>  
>  	if (repo_read_index_unmerged(r)) {
> -		ret = error_resolve_conflict(_(action_name(opts)));
> +		ret = error_resolve_conflict(action_name(opts));
>  		goto cleanup;
>  	}

Perhaps we should have the error_resolve_conflict() function take a
"enum replay_action" instead? We could just do this more isolated
change, but perhaps that "while-we're-at-it" would be acceptable to
reduce the risk of running with this particular set of scissors.

Then we could note in a comment in that function that we do not want to
translate the string we'd get from action_name()...
