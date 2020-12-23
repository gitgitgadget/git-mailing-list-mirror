Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ED9C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 22:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B793B2225E
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 22:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgLWWKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 17:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLWWKG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 17:10:06 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4F7C061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 14:09:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id w1so1044565ejf.11
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 14:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tjuzM+6MUprWZeWYiAyot+Yv/IEStBJ5nZJmIhnSJu0=;
        b=srdvzsaSdkeShFgb6EWXsI6FlMgoqrZXCGRfoQqQUzmREGX8EKbsy5r9HU1q3S+kW3
         MLQyWxPoUDEV/PHmguK0SRI718D86Nc4/MbeE/bttNTz0IikyyrTkNXvuwVZwYefX1Qj
         O065am01AEu4g3xS5U4AV+vSywxwOD3u1SuB/kcBeG0c3+tpDiJ0HCIemd7MppHHyKL0
         AioQ6DThF6+Uv3naszr8kQz6xXh/S0DvWJxPN2TQtQO9JTqto1KGxPOlIdvH3XIEFokM
         PBQG5FqIl8/6MOD8M1EgXIujhHBEaFFvk266N5tdi7H4iGgniElBhC1CNi+adwTbFyt6
         aQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tjuzM+6MUprWZeWYiAyot+Yv/IEStBJ5nZJmIhnSJu0=;
        b=Wamdg7pPFVjQyJwYbom28nQalTjIPKdwarDep8L0dDDfzjFE+Oiz2+4DAqmu9yIAHC
         500uhTbcK/QY0mw/Vq+5qdmGjUDyGMbwY7RmpOISmS0V+d+L88c8knJZOYy0/OzxmAND
         mwj5ow5pPHun3c+bVxfN2BFI8D/ynnRkOFbhMZQ3yErC5LvLsiyfU1RyvN0DHgUy04K8
         +NSneVtBSgMJ2WP2EesHBsbTO91OHcUUAP9h1WYm3WC/y7HJHBCnzzB+5koLu75idJWH
         QPM9MkzWVP+Sq7t1KfhoLettWXhwcCi8WTH8fQMFLMsgGdf4n0bdX7kvyJqpQEZdtn/h
         D3OQ==
X-Gm-Message-State: AOAM531S+EAYJzU/7v1PRWQd+KUNpTVCHX+Vb9qupJoec6vIn8XI6+ds
        Qyx+qdDv1wJ/FDhwrXz94vMIoZWuNZc=
X-Google-Smtp-Source: ABdhPJyTOOM/fVXqpUnt1NTcqYWZn3ZK3m4N20omq2Hpc63LtBsj2Kyj0XcmpY+Kl6A4Vn2zHShcqA==
X-Received: by 2002:a17:907:444f:: with SMTP id on23mr26514757ejb.300.1608761365113;
        Wed, 23 Dec 2020 14:09:25 -0800 (PST)
Received: from szeder.dev (94-21-146-153.pool.digikabel.hu. [94.21.146.153])
        by smtp.gmail.com with ESMTPSA id qn4sm11893489ejb.50.2020.12.23.14.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2020 14:09:24 -0800 (PST)
Date:   Wed, 23 Dec 2020 23:09:22 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 16/20] mktag: allow turning off fsck.extraHeaderEntry
Message-ID: <20201223220922.GJ8396@szeder.dev>
References: <20201209200140.29425-1-avarab@gmail.com>
 <20201223013606.7972-17-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201223013606.7972-17-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 23, 2020 at 02:36:01AM +0100, Ævar Arnfjörð Bjarmason wrote:
> In earlier commits mktag learned to use the fsck machinery, at which
> point we needed to add fsck.extraHeaderEntry so it could be as strict
> about extra headers as it's been ever since it was implemented.
> 
> But it's not nice to need to switch away from "mktag" to "hash-object"
> + manual "fsck" just because you'd like to have an extra header. So
> let's support turning it off by getting "fsck.*" variables from the
> config.
> 
> Pedantically speaking it's still not possible to make "mktag" behave
> just like "hash-object -t tag" does, since we're unconditionally going
> to check the referenced object in verify_object_in_tag(), which is our
> own check, and not one that exists in fsck.c.
> 
> But the spirit of "this works like fsck" is preserved, in that if you
> created such a tag with "hash-object" and did a full "fsck" on the
> repository it would also error out about that invalid object, it just
> wouldn't emit the same message as fsck does.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index d20adf0544..1019b42378 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -377,6 +377,20 @@ EOF
>  check_verify_failure 'detect invalid header entry' \
>  	'^error:.* extraHeaderEntry:'
>  
> +test_expect_success 'invalid header entry config & fsck' '
> +	test_must_fail git mktag <tag.sig &&
> +	test_must_fail git -c fsck.extraHeaderEntry=error mktag <tag.sig &&
> +	test_must_fail git -c fsck.extraHeaderEntry=warn mktag <tag.sig &&
> +	git -c fsck.extraHeaderEntry=ignore mktag <tag.sig &&
> +	git fsck &&
> +	env GIT_TEST_GETTEXT_POISON=false \

Why this 'env GIT_TEST_GETTEXT_POISON=false' here...

> +		git -c fsck.extraHeaderEntry=warn fsck 2>err &&
> +	grep "warning .*extraHeaderEntry:" err &&

... instead of test_i18ngrep here?

> +	test_must_fail env GIT_TEST_GETTEXT_POISON=false \
> +		git -c fsck.extraHeaderEntry=error 2>err fsck &&
> +	grep "error .* extraHeaderEntry:" err
> +'
> +
>  cat >tag.sig <<EOF
>  object $head
>  type commit
> -- 
> 2.29.2.222.g5d2a92d10f8
> 
