Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D3CC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 09:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC9D6120D
	for <git@archiver.kernel.org>; Mon,  3 May 2021 09:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhECJx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 05:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhECJx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 05:53:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0DC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 02:53:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e7so5546789edu.10
        for <git@vger.kernel.org>; Mon, 03 May 2021 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=4mc5NCSvTPhC/VjVG5oeqV32mXo9kh/o+QMopXGz0sQ=;
        b=S/PEOv5jpJJZYNyglZKZEKv4gdqOKROqrwSI5XErHwGy8ZkNdzoGtFxEpDrmH99phN
         4D4Jv0fAwOD5oX/PKcb6XXvoo+uoLk7f6DjZXVanYh5R19BEmDGP3HEZVuoeSYvF4zD/
         G627pQseonoMuJsmzJ7wy/nfSh0tlNdqq7vHjF1SnHjrAmPVhoVHhfMK8ju5MpFSFvw5
         zfeM455u6+L61LWD9zdaqvAF+KZ4q7BEFDOP6hr9+vYXoSfB9TTvi+7tV6gygnHLyto7
         TkQqFUrguhIyJtpHLCsxDOAFQIXvHaJJ1j7EX0vWDxk6fN1QtIC7syA4svxB5Lz3bpWX
         ZpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=4mc5NCSvTPhC/VjVG5oeqV32mXo9kh/o+QMopXGz0sQ=;
        b=BQJnwwcQOfXmJWNLL8dIF+s2Z4CAm6ob8g1PvgpsA/wmx7ZfAhrP1myGx62KJ2nxDM
         00za+11taKKGB45O2ti6Cm9RjycBLaO9ERWEXzixtCmIvP3l6NRF8EhoaKwiXNW4V1Zl
         5Q2I7dw1vP1JgDfMmqb73qSH5OYdTk61bVVgFDt/2gjV51lZqQn9UWIMBZHvDINGkA2B
         pnhGCUm0mKzDNQTmEjqN/HY9bbZVLuKBxvY2lb0ylnAxHcFiQcCwXenh/8atgT3Jb88S
         tsYtXkKXFot4L0naBNtpOj9IhDoqeV24D/QMuPyVF6PRqtvFo1Z6XbOiWOR2JCIzJwY6
         EWBA==
X-Gm-Message-State: AOAM532x9LgAjtvUnIl+oZ6PYWK1GGY29iMjJBVwDp9u5+htyQlHV+Nk
        mrMZGJNOqoUtpNThinZLWP8=
X-Google-Smtp-Source: ABdhPJxQLmwXglkNZcXUCOzH7K85XZYohAMAldq8TAbuYasaTakQTnVRuWJb6Nrlvn6PW3EBDMQhLg==
X-Received: by 2002:a50:8a99:: with SMTP id j25mr18817701edj.253.1620035582115;
        Mon, 03 May 2021 02:53:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g17sm11959983edv.47.2021.05.03.02.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 02:53:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] t7415: remove out-dated comment about translation
Date:   Mon, 03 May 2021 11:46:52 +0200
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
 <YI12n+1rbedpwyfW@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YI12n+1rbedpwyfW@coredump.intra.peff.net>
Message-ID: <874kfkxhxe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 01 2021, Jeff King wrote:

> Since GETTEXT_POISON does not exist anymore, there is no point warning
> people about whether we should use test_i18ngrep. This is doubly
> confusing because the comment was describing why it was OK to use grep,
> but it got caught up in the mass conversion of 674ba34038 (fsck: mark
> strings for translation, 2018-11-10).
>
> Note there are other uses of test_i18ngrep in this script which are now
> obsolete; I'll save those for a mass-cleanup. My goal here was just to
> fix the confusing comment in code I'm about to refactor.

For what it's worth between [1] and [2] I'm not sure what to do about
the test_i18ngrep cleanup. I think your patch below is fine, but the
"test_i18ngrep" has mutated into a "grep with debugging", not just
something needed for GETTEXT_POISON.

So that part of your patch right now is making it less friendly for
debugging. I don't care, and think if we want that we'd be better of
scraping the trace ouput for such common cases and/or use "verbose grep
[...]" and teach the "verbose" wrapper about these common cases, but
knowing of that objection + having other outstanding things has been why
I haven't sent s/test_i18ngrep/grep/g patches.

1. https://lore.kernel.org/git/20210120152132.GC8396@szeder.dev/
2. https://lore.kernel.org/git/20210120182759.31102-1-avarab@gmail.com/

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t7415-submodule-names.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
> index f70368bc2e..fef6561d80 100755
> --- a/t/t7415-submodule-names.sh
> +++ b/t/t7415-submodule-names.sh
> @@ -151,10 +151,9 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
>  		} | git mktree &&
>  
>  		# Check not only that we fail, but that it is due to the
> -		# symlink detector; this grep string comes from the config
> -		# variable name and will not be translated.
> +		# symlink detector
>  		test_must_fail git fsck 2>output &&
> -		test_i18ngrep gitmodulesSymlink output
> +		grep gitmodulesSymlink output
>  	)
>  '

