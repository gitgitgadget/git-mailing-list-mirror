Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3BBC77B7E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 19:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjDZTww (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZTwt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 15:52:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E229C1707
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 12:52:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b99ef860a40so4756110276.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682538768; x=1685130768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YUKEpo6XoB91Gwvq7tdME7PgHY+8IWon7uAJMPSqeg=;
        b=d3fFQjGlGor0kritvg+e6/qpoNop5xfNqOYnRZ4OnbA+JwWBlqzsz+Vhir0HMZ5kup
         XMdmurSfbNnK2OtOnxSVYm/6ekpUorzl1eZJTP5+yCz9nca6t0/AMCRRHyThYyqQvunp
         7HXz4NdGL5uqB3T2zvbMsp5dwXXtBI7unafnWebZqnriIgSfGIoUxTYKB4oVMaGMf05X
         DJAEnjCQj2YiU4VrcODnCGVh2SxrMfO3ysIYJXZDbAycGCyNwbT2YJsDwGnU+PsNipCH
         vUDR2HAytApTh+MX0xHr018SYWo95WoS7AFoTrUSb6IEBIAbSqIhmmoAj9xPDD4K7RU7
         Q2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682538768; x=1685130768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YUKEpo6XoB91Gwvq7tdME7PgHY+8IWon7uAJMPSqeg=;
        b=CgdWUhYS7oCZN4w2UNR0zIgq7DErDR8LM8ubzsO8kfUGSs0dxbceA7yO0tCdB305fr
         HPzQAknzqvYsqhgSSM1Tqe7p8CRoxVDj8gB8+3sHoTo//RnS8ALiL648nWn9coGaOKh8
         zmHd91N2NV6y76GTeWezAwyoiC908v3HUNDq+2aTOkyOKvYRrsNHneVH1+p0D/rglH7F
         rnXDQdX8Hx9AN04hKlANU24ev06Luat7jRoNUUq0MeM3CXGV6AnI8SdbJYUUwcvIKS/l
         +Ew76UxnCzJ5gFD4ydrmAJaRul+s8VPchB8v/D3wuDR4rJ1fmaZN4D6RPoQOSDRsamUX
         Tzyg==
X-Gm-Message-State: AAQBX9dg9vsNGIfxYw/dzoNWyE4bJnq+v+Ijiktax3dTFDoHkt2SfIhb
        wGnU3BTkR23raDf7kxh4JtAWKmvxqUs30w==
X-Google-Smtp-Source: AKy350asO7mF/ZbP85nIIUcjJcpTxPIDdGlC6hKXIO2jkZvNDmBKDaoqckwa+ZSq+jWHCjCl6obrIcPimplwkQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:dac6:0:b0:b8f:485d:9fcc with SMTP id
 n189-20020a25dac6000000b00b8f485d9fccmr8504202ybf.4.1682538768218; Wed, 26
 Apr 2023 12:52:48 -0700 (PDT)
Date:   Wed, 26 Apr 2023 12:52:46 -0700
In-Reply-To: <301138da039451519c6e60d6126e7756a54d346f.1681906949.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <301138da039451519c6e60d6126e7756a54d346f.1681906949.git.ps@pks.im>
Message-ID: <kl6lzg6umne9.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 8/8] fetch: introduce machine-parseable "porcelain" output format
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> The output format is quite simple:
>
> ```
> <flag> <old-object-id> <new-object-id> <local-reference>\n
> ```

This format doesn't show the remote name or url that was fetched. That
seems okay when fetching with a single remote, but it seems necessary
with "--all". Perhaps you were planning to add that in a later series?
If so, I think it's okay to call the "porcelain" format experimental,
and forbid porcelain + --all until then.

>
> We assume two conditions which are generally true:
>
>     - The old and new object IDs have fixed known widths and cannot
>       contain spaces.
>
>     - References cannot contain newlines.

This seems like a non-issue if we add a -z CLI option to indicate that
entries should be NUL terminated instead of newline terminated, but that
can be done as a followup.

> With these assumptions, the output format becomes unambiguously
> parseable. Furthermore, given that this output is designed to be
> consumed by scripts, the machine-readable data is printed to stdout
> instead of stderr like the human-readable output is. This is mostly done
> so that other data printed to stderr, like error messages or progress
> meters, don't interfere with the parseable data.

Sending the 'main output' to stdout makes sense to me, but this (and
possibly respecting -z) sounds like a different mode of operation, not
just a matter of formats. It seems different enough that I'd prefer not
to piggyback on "fetch.output" for this (even though this adds more
surface to the interface...).

We could add --porcelain and say that "fetch.output" is ignored if
--porcelain is also given. That also eliminates the need for
--output-format, I think.

The .c changes look good to me.

> +test_expect_success 'fetch porcelain output with HEAD and --dry-run' '
> +	test_when_finished "rm -rf head" &&
> +	git clone . head &&
> +	COMMIT_ID=$(git rev-parse HEAD) &&
> +
> +	git -C head fetch --output-format=porcelain --dry-run origin HEAD >actual &&
> +	cat >expect <<-EOF &&
> +	* $ZERO_OID $COMMIT_ID FETCH_HEAD
> +	EOF
> +	test_cmp expect actual &&
> +
> +	git -C head fetch --output-format=porcelain --dry-run origin HEAD:foo >actual &&
> +	cat >expect <<-EOF &&
> +	* $ZERO_OID $COMMIT_ID refs/heads/foo
> +	EOF
> +	test_cmp expect actual
> +'

As mentioned upthread, I think this test isn't needed because
"porcelain" wouldn't run into the bug we are checking for anyway.
