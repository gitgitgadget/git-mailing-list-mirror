Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31911F42D
	for <e@80x24.org>; Mon, 28 May 2018 13:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163409AbeE1NZe (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 09:25:34 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:43125 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033122AbeE1NZa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 09:25:30 -0400
Received: by mail-wr0-f177.google.com with SMTP id d2-v6so4827320wrm.10
        for <git@vger.kernel.org>; Mon, 28 May 2018 06:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qzjH5HaY+CtqATTa5aCRogTlXZUNEJ5VrN58CJ1yR9Y=;
        b=NPNt9cpeGMZKJnm2iDRPcrncK6G4uWpaVfqeCiHBWcr15chPnubGTFniEP93p9nXje
         WAsIY+PHLPPla5LY3VlE0xDH9HnP/NinTNURRuQ4n7lm6JPpdqyOddeA0he+f3J8uhIj
         4L9dkdnEAh4L2xn5/5ns3ufXD57mD3tESFWpNQ1TBjyVVM0/s16KEME9GZbt9tYzKfiE
         9d8KeENkVplEx6RJv0vrMUXG7JMVmoHRWmIMiVBAX+VUnRycJo1E28hO86WplkrFUSzT
         IiDm/KxtzrvTM+cjxh43S8nUQmWiCdq8UyfNlAeFPdbkCVeUd5FX9prkoC4yYFJya6ow
         VeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qzjH5HaY+CtqATTa5aCRogTlXZUNEJ5VrN58CJ1yR9Y=;
        b=uFz1bkAMG4xvPNYcPKdYVh3YAPPpyb3jAa5/uWD8TLai+ksbmu5rm5gistEkjzr2CZ
         Bz6fu89GOFmcXg7ihKEkQrxsYzAh8OK435CypLIEaRpwkEhFxzAH4Vwboi3Kijxltxbi
         rm+j+Ijr0hamNiad7coHYK94ImTgL9jOO3Bi3IjFj7NtpSgaLcNoh7lt+4zoiDJIh3DW
         Axei3pClQE6o0sRnfYy6p/yHy4AzHTDWt2JPhxCFHEe9ZKDzE6N5anPi9DQD/Y0czxsc
         hn0G8DZ3JDyquP4CJpNxGFbu/OjYrRIcn8yTf97QJVZw2b0sJk33MUL+vS21LKm/tZgh
         kR9A==
X-Gm-Message-State: ALKqPwcQ8z2sAnb5ZnKx0Ub8aj9LLPvdg4z/A7TBFv70CgtKZhT35FzI
        BWkXPIQfwX4QqWoPW0Rbo258uNWw
X-Google-Smtp-Source: AB8JxZqR5EhCr0lzCKT5kZp7Zr3LxXOYmzs4XX587dwLimj0LXO3nNHpqlvOq+oOQEGKMRTdeDpxeA==
X-Received: by 2002:adf:88b2:: with SMTP id f47-v6mr9296894wrf.55.1527513928363;
        Mon, 28 May 2018 06:25:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e7-v6sm30556566wrn.88.2018.05.28.06.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 06:25:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tiago Botelho <tiagonbotelho@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, haraldnordgren@gmail.com,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v4] Implement --first-parent for git rev-list --bisect
References: <20180528092017.19022-1-tiagonbotelho@hotmail.com>
Date:   Mon, 28 May 2018 22:25:27 +0900
In-Reply-To: <20180528092017.19022-1-tiagonbotelho@hotmail.com> (Tiago
        Botelho's message of "Mon, 28 May 2018 10:20:17 +0100")
Message-ID: <xmqqzi0jj4jc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tiago Botelho <tiagonbotelho@gmail.com> writes:

> diff --git a/bisect.c b/bisect.c
> index 4eafc8262..e58cb8d62 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -33,6 +33,8 @@ static const char *term_good;
>   *
>   * We care just barely enough to avoid recursing for
>   * non-merge entries.
> + *
> + * Note: This function does not support the usage --first-parent.
>   */

Hmph, is this because we know --first-parent codepath currently does
not call this function, so we do not bother to prepare this function
to be called from --first-parent codepath?

I am not saying that we must prepare this function to be callable
with --first-parent; if I have to wonder why the above comment is
there and what it is trying to say, I suspect most other readers
would, too, so...

> diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> index a66140803..774d9a4fd 100755
> --- a/t/t6002-rev-list-bisect.sh
> +++ b/t/t6002-rev-list-bisect.sh
> @@ -263,4 +263,41 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
>  	test_cmp expect.sorted actual.sorted
>  '
>  
> +# We generate the following commit graph:
> +#
> +#   B - C
> +#  /      \
> +# A        FX
> +#  \      /
> +#   D - EX
> +
> +test_expect_success 'setup' '
> +  test_commit A &&
> +  test_commit B &&
> +  test_commit C &&
> +  git reset --hard A &&
> +  test_commit D &&
> +  test_commit EX &&
> +  test_merge FX C
> +'
> +
> +test_output_expect_success "--bisect --first-parent" 'git rev-list --bisect --first-parent FX ^A' <<EOF
> +$(git rev-parse EX)
> +EOF
> +
> +test_output_expect_success "--bisect-vars --first-parent" 'git rev-list --bisect-vars --first-parent FX ^A' <<EOF
> +bisect_rev='$(git rev-parse EX)'
> +bisect_nr=1
> +bisect_good=0
> +bisect_bad=1
> +bisect_all=3
> +bisect_steps=1
> +EOF
> +
> +test_output_expect_success "--bisect-all --first-parent" 'git rev-list --bisect-all --first-parent FX ^A' <<EOF
> +$(git rev-parse EX) (dist=1)
> +$(git rev-parse D) (dist=1)
> +$(git rev-parse FX) (dist=0)
> +EOF
> +

These are all good basic tests, but can you come up with a test that
demonstrates breakage in the previous round that has been fixed in
this version of the patch?

Thanks.

