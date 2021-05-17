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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F0C43461
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2AB4611BF
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbhEQQwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbhEQQwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:52:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D2C06134F
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:44:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id et19so3117275ejc.4
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=O/rc2PwrEhnt8Oj1H4/vK2mbpvkQypYBvBqAvC3Cz0Y=;
        b=X8LeHnQRbBpbwotVl8mlfj/Qn8BqBY65hPJAGPuKyJ2A3VPTpbIGV8nAQv5DHhwRBV
         FaQ0MyOQTUHkkCCcxeOFCnFa8Wpgm57ihjt1hddwB/RcLT+/ddtZ/iRqdzPARZEFPsFE
         0hfAvisaECy+Nyym+p9hF8P+bdi6zufv0TFaI1KqOi5LzgYok6KgjH4thiZiHW+69EF8
         xpd1zuOvjWfxxpWKmVUL93VlyKtXjJ7YVWR+GKQoMTvoaPFpBaqbCf6GT93oBaKxNTiP
         G9WTtkwl/HJzK5pkJ+bpihstITV9l5J+fjsdu2VuH1KpREtndu9WO8O79FA8eEP9Yfbs
         6bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=O/rc2PwrEhnt8Oj1H4/vK2mbpvkQypYBvBqAvC3Cz0Y=;
        b=feMh70LU+Enoj+wAY4U14HYJCdQVrnRa9NhdgLmUmH/V5CQBKrBPbRqQOfClq6hiU2
         VahBUuj3m6CGr7EWKGfZGiUdnyM/Z7xjC9jdmDJ5Bc7oeoAkhUT/crBOMD6Wc30t7mQW
         WcQgTTSxb9KdlKE1prKCl2p/QOVxf/qSLrWdewFRd7Uh3llnHffFH5eCAr1HyZj8Exk+
         l6rrPP1Vq8GelGWwIeev7mtUyi0PITSRTJqSP7oJJ0O3f9kxsZdYhjAkWf0F5Db2lzYp
         fesxvmL54qF2dY+Aztwel3EQPYslmFUnKA0WBOIqxXQ1XFQ/bZQkq4yu9FiwWPbFljQg
         POfw==
X-Gm-Message-State: AOAM5325FKvcFotiwbnHQ8tZp/LbjWJoyVnBWPqUKayj2jFkjppWFU4D
        BZrJIa4xP6JGDhDFFlYtuhDWeraXLzc=
X-Google-Smtp-Source: ABdhPJxfnX/6gEbze+Xh8SrNi1nhYjclCAWxXXJ12/ORnh0f84XEf/tji+4DbgAabWZsN/ugZWtYQA==
X-Received: by 2002:a17:906:d1d2:: with SMTP id bs18mr876250ejb.56.1621269868617;
        Mon, 17 May 2021 09:44:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id di7sm11480134edb.34.2021.05.17.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 09:44:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7500: remove non-existant C_LOCALE_OUTPUT prereq
Date:   Mon, 17 May 2021 18:42:34 +0200
References: <20210517151222.2865093-1-tmz@pobox.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210517151222.2865093-1-tmz@pobox.com>
Message-ID: <87wnrxqphw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 17 2021, Todd Zullinger wrote:

> The C_LOCALE_OUTPUT prerequisite was removed in b1e079807b (tests:
> remove last uses of C_LOCALE_OUTPUT, 2021-02-11), where =C3=86var noted:
>
>     I'm not leaving the prerequisite itself in place for in-flight changes
>     as there currently are none that introduce new tests that rely on it,
>     and because C_LOCALE_OUTPUT is currently a noop on the master branch
>     we likely won't have any new submissions that use it.
>
> One more use of C_LOCALE_OUTPUT did creep in with 3d1bda6b5b (t7500: add
> tests for --fixup=3D[amend|reword] options, 2021-03-15).  This causes a
> number of the tests to be skipped by default:
>
>     ok 35 # SKIP --fixup=3Dreword: incompatible with --all (missing C_LOC=
ALE_OUTPUT)
>     ok 36 # SKIP --fixup=3Dreword: incompatible with --include (missing C=
_LOCALE_OUTPUT)
>     ok 37 # SKIP --fixup=3Dreword: incompatible with --only (missing C_LO=
CALE_OUTPUT)
>     ok 38 # SKIP --fixup=3Dreword: incompatible with --interactive (missi=
ng C_LOCALE_OUTPUT)
>     ok 39 # SKIP --fixup=3Dreword: incompatible with --patch (missing C_L=
OCALE_OUTPUT)
>
> Remove the C_LOCALE_OUTPUT prerequisite from these tests so they are
> not skipped.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> I noticed this while testing 2.32.0-rc0.  I grep for skipped tests to hel=
p me
> catch missing requirements in the Fedora packages.
>
>  t/t7500-commit-template-squash-signoff.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-t=
emplate-squash-signoff.sh
> index 9092db5fdc..7d02f79c0d 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -413,7 +413,7 @@ test_expect_success 'amend! commit allows empty commi=
t msg body with --allow-emp
>  '
>=20=20
>  test_fixup_reword_opt () {
> -	test_expect_success C_LOCALE_OUTPUT "--fixup=3Dreword: incompatible wit=
h $1" "
> +	test_expect_success "--fixup=3Dreword: incompatible with $1" "
>  		echo 'fatal: reword option of --fixup is mutually exclusive with'\
>  			'--patch/--interactive/--all/--include/--only' >expect &&
>  		test_must_fail git commit --fixup=3Dreword:HEAD~ $1 2>actual &&

Thanks. This is obviously correct.

Junio (added to CC): I also think it makes sense to pull this into rc1,
since we have 3d1bda6b5b new in 2.32.0, and will be skipping this part
of its tests everywhere without this patc.h
