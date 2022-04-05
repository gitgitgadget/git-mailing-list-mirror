Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4837CC433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 02:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiDECz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 22:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiDECzh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 22:55:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469A723E3D7
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 19:04:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w18so6963990edi.13
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 19:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=psadB/oStke7BugqRCJJFXfFPlTINiytnb6IQFJn2ho=;
        b=mZuJMbowuj8Ea8KKZHLeUA/Xrrq5r/7l1dvYmh68JeCiTm7fl7b2DOa+NoNtd1JoIm
         RWxbrbhV2PV5FGzspVglvybYxwx4F5wi0IiSG6ZRGwIQHH3D1LS7PKQpVm1fDXp2vTID
         wBGOlmhs7f5A1c7qzJtTWd3QlPJsVmH7ojnKq4AfcBhowSgeN2MqRGZT76hFwCN/j6bh
         1XvMm+wN1FUjaa4VDcVIO8BxV6RsGrm3R3yLotWu7Rd+pR+ZXVIukOLQqG/dDraZyvH+
         8i8OcXCHnMnf73bQkyK0+zlGV76CYwD/1LffdMex8rMyUIgumg9qpteCDi0GJGDAi562
         oV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=psadB/oStke7BugqRCJJFXfFPlTINiytnb6IQFJn2ho=;
        b=QCIDeYrxpwWQx+dahPv/9EKuq1bDTJtK225rLAtpRa6lzSvAHo3T/YIrbUPNoM7CSW
         HdtPXYUrqz7LsjmhjctyXdBIC06CRjykNF4BEPo1On9Q86NEfil2JpX3B2XWOBRSrlzQ
         n0U4e4oumZ+r8EJPCA5SlLDBDd4HRTW297AHwg+3g+jWS5FR5QpOg+oQb/oYZvbQx7wW
         kgcp4H48y4d+egfzMKRzqPqI9+xMY0y+Ua14yTSTHJXyPK+VQNVyKDjnxjmUT2RQVRE4
         zFSEpGSXCFWJidq6fvL4uA/rYLG//0Hwddi7YHHrBFpKUZqT5IT2ZV9QIA99IBsEtW2H
         aSjw==
X-Gm-Message-State: AOAM531E3ZMSB9SVhNGnpsjfDSz0LsMrimHYAi0T9aB3t6+NGpEAHcQz
        7m9XQHcZbcYKFqQU4k1/wRATXaie7Woeeg==
X-Google-Smtp-Source: ABdhPJz9PisN1qP29eddDzycd+qV//LHCznjb8+xX1aL0JtK/24WA2JBNoquNaiiEyAUtTMt9dPitw==
X-Received: by 2002:a05:6402:1811:b0:41c:d21a:4096 with SMTP id g17-20020a056402181100b0041cd21a4096mr1099537edy.389.1649124256673;
        Mon, 04 Apr 2022 19:04:16 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nd31-20020a170907629f00b006dff863d41asm5025364ejc.156.2022.04.04.19.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 19:04:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbYYJ-002mR2-8B;
        Tue, 05 Apr 2022 04:04:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Laurent Lyaudet <laurent.lyaudet@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?Eckhard_S=2E?= =?utf-8?Q?_Maa=C3=9F?= 
        <eckhard.s.maass@googlemail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: Git has two ways to count modified lines
Date:   Tue, 05 Apr 2022 03:58:13 +0200
References: <CAB1LBmvX4kv3yqSZ+X4Ozkb9esUem3U1JY48kWVi_Eef78Sk=Q@mail.gmail.com>
 <CAB1LBms3F1EGswxF9mO=JrmWmj4XFncv4ZrkAy-dvOHdVrkwLQ@mail.gmail.com>
 <d650bb90-df94-eeab-0684-ee447e080ad6@web.de> <xmqqh779u72a.fsf@gitster.g>
 <c35bd0aa-2e46-e710-2b39-89f18bad0097@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <c35bd0aa-2e46-e710-2b39-89f18bad0097@web.de>
Message-ID: <220405.865ynomgkg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 04 2022, Ren=C3=A9 Scharfe wrote:

> diff --git a/sequencer.c b/sequencer.c
> index a1bb39383d..85a17d45bd 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1327,7 +1327,6 @@ void print_commit_summary(struct repository *r,
>  	get_commit_format(format.buf, &rev);
>  	rev.always_show_header =3D 0;
>  	rev.diffopt.detect_rename =3D DIFF_DETECT_RENAME;
> -	rev.diffopt.break_opt =3D 0;
>  	diff_setup_done(&rev.diffopt);
>
>  	refs =3D get_main_ref_store(the_repository);
> diff --git a/t/t7524-commit-summary.sh b/t/t7524-commit-summary.sh
> new file mode 100755
> index 0000000000..47b2f1dc22
> --- /dev/null
> +++ b/t/t7524-commit-summary.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +
> +test_description=3D'git commit summary'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_seq 101 200 >file &&
> +	git add file &&
> +	git commit -m initial &&
> +	git tag initial
> +'
> +
> +test_expect_success 'commit summary ignores rewrites' '
> +	git reset --hard initial &&

A leftover debugging aid? You can also use test_commit earlier:
=09
	diff --git a/t/t7524-commit-summary.sh b/t/t7524-commit-summary.sh
	index 47b2f1dc22a..60027e86ccd 100755
	--- a/t/t7524-commit-summary.sh
	+++ b/t/t7524-commit-summary.sh
	@@ -4,14 +4,10 @@ test_description=3D'git commit summary'
	 . ./test-lib.sh
=09=20
	 test_expect_success 'setup' '
	-	test_seq 101 200 >file &&
	-	git add file &&
	-	git commit -m initial &&
	-	git tag initial
	+	test_commit initial file "$(test_seq 101 200)"
	 '
=09=20
	 test_expect_success 'commit summary ignores rewrites' '
	-	git reset --hard initial &&
	 	test_seq 200 300 >file &&
=09=20
	 	git diff --stat >diffstat &&


> +	test_seq 200 300 >file &&
> +
> +	git diff --stat >diffstat &&
> +	git diff --stat --break-rewrites >diffstatrewrite &&
> +
> +	# make sure this scenario is a detectable rewrite
> +	! test_cmp_bin diffstat diffstatrewrite &&

Is this really binary? I removed the ! and tried test_cmp, and it's just
a diffstat.

Elsewhere in the test suite we test_cmp this output, would be
clearer/easier to read to do the same here if possible.

> +
> +	git add file &&
> +	git commit -m second >actual &&
> +
> +	grep "1 file" <actual >actual.total &&
> +	grep "1 file" <diffstat >diffstat.total &&
> +	test_cmp diffstat.total actual.total
> +'
> +
> +test_done

