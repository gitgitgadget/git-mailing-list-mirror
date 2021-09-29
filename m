Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B530BC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 17:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859346135E
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 17:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbhI2RaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244721AbhI2RaH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 13:30:07 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2907EC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 10:28:26 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a11so3701098ilk.9
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LERYnFsAtVjCnFT7uuJIkhnKInkZQwNgAnizuxGxvRM=;
        b=QjMuToWJhyer5WqWWw57t5zwWHDqtrQxiWxOvlhXXvmPeTQ3JEFbeM/fytjd0BGnrn
         tjzc0IDkoNOJPqAllpqMoNK24hg4QL5ywkY08bdOBAbkBVOsgf5L0EqKfM3h4WnZBUiY
         tyvGs673d8NOwsk+JIIn4hLyOmAh1ko29fYo1sgpHZIOQAm/GiYcM1QqpP0TfT+ak+u/
         JJmWrI6Iw7T24LkxeITWgGMv3kbkPuT3wM7fZ6B5oewUwpVMTqP/zklmGdwJnY/iWcTW
         N5GFvkpnzmadYwBF6/XXRwNjAeuNj5xqLzbW77XvOYkhUn5XaMNWX6yfHI91OuLsnNJo
         6p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LERYnFsAtVjCnFT7uuJIkhnKInkZQwNgAnizuxGxvRM=;
        b=xgw1Kwk+UyhIHlYAOrMzQ9upd79vbtcHkA7Po2WjiNVB54QS59KgjvQywmO3HxpKTE
         PiC28iyoz+HvJ0OxWi+Ec30/kcl8kO9nvY7M4EUgNuIG1YvEoNSm+VCTr4VXuv1GTFhk
         belq4/hei06bkR9PF0SJ3VY9dghn5sTgMK6e80jk834SZB0DxbISaCV30SpepNp+TcdB
         Tr1PhLX9ffGQxlDj+dYSo66JDbcZnKCfPi4lOnfIp9mxp2/BrVksgzaPdLTy4fjV3/x0
         KL5Ymj58wegLwHEQnwmJLaVqRWXjNJM7gOra2srxNkcInSLh/I92Kg3aia+LUIw4FM7t
         mQ0w==
X-Gm-Message-State: AOAM533Fd2jdxeaQ057yoaAmLiVtgp6NEiNVf71iVdh+9w+nvAfJNBaS
        3cCJd19YG3PJjrJfiUThLRLRbQ==
X-Google-Smtp-Source: ABdhPJwta78H12gBtduNo45X3dX6gTX3wnQvnRPu+uRW5hQhfYRlMqxc9Yt8sFY+Xm7ShZzv4os80w==
X-Received: by 2002:a05:6e02:1bad:: with SMTP id n13mr664379ili.142.1632936505521;
        Wed, 29 Sep 2021 10:28:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i8sm220484ioi.29.2021.09.29.10.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 10:28:25 -0700 (PDT)
Date:   Wed, 29 Sep 2021 13:28:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 07/10] commit-graph: stop using optname()
Message-ID: <YVSiOMaKNoDZ3SlO@nand.local>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
 <patch-07.10-b0b313795c7-20210928T130905Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-07.10-b0b313795c7-20210928T130905Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 03:14:28PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Stop using optname() in builtin/commit-graph.c to emit an error with
> the --max-new-filters option. This changes code added in 809e0327f57
> (builtin/commit-graph.c: introduce '--max-new-filters=<n>',
> 2020-09-18).
>
> See 9440b831ad5 (parse-options: replace opterror() with optname(),
> 2018-11-10) for why using optname() like this is considered bad,
> i.e. it's assembling human-readable output piecemeal, and the "option
> `X'" at the start can't be translated.

In fact, using optname there (which blames to me) was a mistake for an
even simpler reason: there is no abbreviated form of
`--max-new-filters`, and we know that by the time this error is emitted
that we got the positive form instead of `--no-max-new-filters`.

So we could have just written the option's name verbatim, and given
translators something easier to work with.

> It didn't matter in this case, but this code was also buggy in its use
> of "opt->flags" to optname(), that function expects flags, but not
> *those* flags.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/commit-graph.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 0386f5c7755..36552db89fe 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -172,8 +172,7 @@ static int write_option_max_new_filters(const struct option *opt,
>  		const char *s;
>  		*to = strtol(arg, (char **)&s, 10);
>  		if (*s)
> -			return error(_("%s expects a numerical value"),
> -				     optname(opt, opt->flags));
> +			return error(_("option `max-new-filters' expects a numerical value"));

Makes sense. The `'-style quoting is still weird to me. It is consistent
with some of the conversions in 9440b831ad5, but most importantly with
how parse-options.c:get_value() behaves (because it calls optname
underneath).

(This has nothing to do with your patch, but I thought the custom
write_option_max_new_filters callback was weird when I wrote it. It's
working around trying to make the negated form set a value to `-1`
instead of `0`. But it's an annoying hack, because we have to call
strtol() ourselves when we're not negated. *sigh*).

Looks good to me.

Thanks,
Taylor
