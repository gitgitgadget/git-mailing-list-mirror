Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D60C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 08:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiIZIR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiIZIRH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 04:17:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA432ED75
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 01:16:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dv25so12315432ejb.12
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 01:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=+EoqhvxnKCqogT/VdRPLr0ScClgR7F5i6Fldto0ItM4=;
        b=fomiNLvbJs2peU7anZgr9OOB85wT+BtFQpYgUn76caTDZGgCDx/a1vBB1N9Ww6nAJd
         GyUE6OicVfeiM8+oZGzZB+jscN33uRWqfRDA8N6xD8VfBDOnkFLNqhqcNmOS0iGZudZL
         aIKnkA6DhDlZFTjvo3VhrdMNJvvG4NvzI50MRpZZXfOF9TdLKM9BIXJ7czu6G6UyR0S4
         HUzXxfslfdWIHawa1zcGxwqZMXrQy9ZAgiclL5YIJ1JGaRIEfXsp/BaABqc/E8NH37EQ
         oPJEHexupFoi9E28umjgitK4g4Yam1+IRDDSbw+jMlKRthXRc99ejpX69UoDZW86uZdy
         GAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=+EoqhvxnKCqogT/VdRPLr0ScClgR7F5i6Fldto0ItM4=;
        b=RhPrFtM+bNiKqJXGTSMSeky0Ka+3doVrQWzDnJX5T3hhATKN2kVC5jU5ZJ9kYUP4dJ
         EBR9wlXjTFMNFKntzICY6xC6RPV7Q4ad3zby8Xk2E7E8eCXeyH1/kZlNnDtseRHXBf2L
         kiJCLmz+fQSafDo9iJBlfZm2vxlZq7BUEg/vn4pN6NLCOtanq67mRcHkWwBrhBigio+b
         UN1LFoZfpDrgPf7E2C6/3RNA1CdsBkL/RJVByf/MraQbAUV64xH+R0RSA2k6iqSDSDYn
         AO0EvzNNOasaiA5pAQtvKMgy8KrK9MF5sG0K1sEHgXkpsQbZlFWkChy0023VhnWe28wV
         NXog==
X-Gm-Message-State: ACrzQf1GvpAn8R0aWQPhf8Eo3yUJHDPwSA59HW6WdiZ4IBZ1FIgvTyFO
        0MyCrmQz/F96bq7OnVR+VWS1ylo+me0=
X-Google-Smtp-Source: AMsMyM4Ijvf5VWAWjBvjqokwh7B4hz9MitU12Yjq5R+PVBuSnO94JFCE/2w7Jvf5o9sGOotOpfbLzA==
X-Received: by 2002:a17:907:320c:b0:77b:6f08:9870 with SMTP id xg12-20020a170907320c00b0077b6f089870mr17139500ejb.249.1664180212820;
        Mon, 26 Sep 2022 01:16:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k11-20020a05640212cb00b0045758a5c295sm952607edx.45.2022.09.26.01.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:16:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocjIJ-003lrU-2H;
        Mon, 26 Sep 2022 10:16:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] ref-filter.c: fix a leak in get_head_description
Date:   Mon, 26 Sep 2022 10:14:38 +0200
References: <6ff29e96-7f8d-c354-dced-b1b363e54467@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6ff29e96-7f8d-c354-dced-b1b363e54467@gmail.com>
Message-ID: <220926.86bkr24kjw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 25 2022, Rub=C3=A9n Justo wrote:

> In 2708ce62d2 (branch: sort detached HEAD based on a flag, 2021-01-07) a
> call to wt_status_state_free_buffers, responsible of freeing the
> resources that could be allocated in the local struct wt_status_state
> state, was eliminated.
>
> The call to wt_status_state_free_buffers was introduced in 962dd7ebc3
> (wt-status: introduce wt_status_state_free_buffers(), 2020-09-27).  This
> commit brings back that call in get_head_description.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
>
> ---
>  ref-filter.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index fd1cb14b0f..914908fac5 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1722,6 +1722,8 @@ char *get_head_description(void)
>  	} else
>  		strbuf_addstr(&desc, _("(no branch)"));
>=20=20
> +	wt_status_state_free_buffers(&state);
> +
>  	return strbuf_detach(&desc, NULL);
>  }

Thanks, this looks good to me. FWIW I have a local (still unsubmitted)
series of leak fixes across the tree which fixed this leak, that commit
is presented below as a "I've already been running with this for a
while" data point.

Thanks!

-- >8 --
Subject: [PATCH] wt-status API users: use wt_status_state_free_buffers(), f=
ix
 leaks

Fix a memory that was accidentally introduced in ref-filter.c in
2708ce62d21 (branch: sort detached HEAD based on a flag, 2021-01-07),
and one that's been present in builtin/checkout.c since
c45f0f525de (switch: reject if some operation is in progress,
2019-03-29).

In both cases we should be using the wt_status_state_free_buffers()
API introduced in 962dd7ebc3e (wt-status: introduce
wt_status_state_free_buffers(), 2020-09-27).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 2 ++
 ref-filter.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 54373424403..549c3d17a1a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1469,6 +1469,8 @@ static void die_if_some_operation_in_progress(void)
 		      "or \"git worktree add\"."));
 	if (state.bisect_in_progress)
 		warning(_("you are switching branch while bisecting"));
+
+	wt_status_state_free_buffers(&state);
 }
=20
 static int checkout_branch(struct checkout_opts *opts,
diff --git a/ref-filter.c b/ref-filter.c
index 45908d4bdfc..81278ec3cf7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1722,6 +1722,8 @@ char *get_head_description(void)
 	} else
 		strbuf_addstr(&desc, _("(no branch)"));
=20
+	wt_status_state_free_buffers(&state);
+
 	return strbuf_detach(&desc, NULL);
 }
