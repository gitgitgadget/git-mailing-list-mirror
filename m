Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D671C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2779D2065C
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5HOwTEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEPLPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726206AbgEPLPh (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:15:37 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB41C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:15:37 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id k4so1753064uaq.10
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+pkwki9XKqdLKa6JrYGjUEDWR/PRagR/tuucA2fapk=;
        b=B5HOwTEcnHB5E2HHPSdxjgFH+29fER7J8vxdmXrVDvWYc348QmDYASIFNrLvh22G09
         t9rIs55N+XQExcTenFQuHBVouDxDwTMy/Ij5ElvcQeYJ7+3vqirRCxk41oeHHaPbcSGb
         Te/Yvef0wJMlXQtoHN9wg950lubHmogp4AUS+gBJl/ubCBiVxFf4x3oRqWQQujHyLLiG
         xoXIhGDuo3kI1fIx3Wg8dOL5re1bzfFmmacbXEAGYOePBBeU4jjpws+Ad/tNCeKZ64Sq
         dmSIVdGWmCD9M0uKlUh8GZfHoscb85a3atudd+A9rhR7UJlYUs9iA2SjSfTYjQBJLMzj
         Gspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+pkwki9XKqdLKa6JrYGjUEDWR/PRagR/tuucA2fapk=;
        b=Vj3sbqOUzIyJ4U4+RlmRQAmLAy3q1keAOj5t+gUVM5k816ZqNysi3ST7oXvIGLFbfk
         nk24+Ux3i7EiNZq6XcoN3Xu95dXlLkrmteZGD1QKxQl358XNEqQ1c2nJeD+vD6r5NoD5
         cYqomIGUdnaW+Kgr5labFQTA0/Hf1objNTOp9zP1eh0s/OjVH74ac8FVZ3EFiVPJ7eca
         ODc+aLR+xSblLiV5JxP1fxR4MRT6L5rSHtmm/PM3Z/PMqPSywio0ykYB1nYg1mzQMVuO
         TfuUmCbFWv3yYfFBCBubjYlsl9owMo6rQ+onwclppgEDAo2f6puSKfVL0KtlF96GtSE3
         ydvg==
X-Gm-Message-State: AOAM5332lT6uyTqFI1ldVZfaJ249sy9YsHcPnX4SRh1gmfkJ2oQwBd+3
        Y8yJ1zu+60sVqDdAeJ1O+QzGFG29vSee6ODsb6Q=
X-Google-Smtp-Source: ABdhPJxgxFnz11Cf1nZQtL9ge1ZR0c3p3OIpeSjDrRV8nc0hM8gY+dTDhnDbElwD3X/0YFY5xlQXygqoDQJeroDb0mU=
X-Received: by 2002:ab0:6ed0:: with SMTP id c16mr2455410uav.62.1589627736868;
 Sat, 16 May 2020 04:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-33-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-33-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 13:15:25 +0200
Message-ID: <CAN0heSpNp1f=3p_ef-13547Sf6qkDXG1-i+0tDDX3VBhP72dgQ@mail.gmail.com>
Subject: Re: [PATCH 32/44] serve: advertise object-format capability for
 protocol v2
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> In order to communicate the protocol supported by the server side, add
> support for advertising the object-format capability.  We check that the
> client side sends us an identical algorithm if it sends us its own
> object-format capability, and assume it speaks SHA-1 if not.
>
> In the test, when we're using an algorithm other than SHA-1, we need to
> specify the algorithm in use so we don't get a failure with an "unknown
> format" message. Add a wrapper function that specifies this header if
> required.  Skip specifying this header for SHA-1 to test that it works
> both with and without this header.

This last sentence sort of answers an earlier question I made: should we
stop special-casing in the test and just always write the capability? I
can see your point here, but it only applies if you actually go to the
trouble of running the tests both with SHA-1 and SHA-256, right?

That is, I wonder if we shouldn't always pass the "object-format"
capability in the tests and, if we have the SHA-1 prereq, execute a
dedicated test where we do not pass it and verify that we default
correctly. Hmm?

> +write_command () {
> +       echo "command=$1"
> +
> +       if test "$(test_oid algo)" != sha1
> +       then
> +               echo "object-format=$(test_oid algo)"
> +       fi
> +}
> +
>  test_expect_success 'test capability advertisement' '
> +       test_oid_init &&
>         cat >expect <<-EOF &&
>         version 2
>         agent=git/$(git version | cut -d" " -f3)
>         ls-refs
>         fetch=shallow
>         server-option
> +       object-format=$(test_oid algo)
>         0000
>         EOF
>
> @@ -45,6 +56,7 @@ test_expect_success 'request invalid capability' '
>  test_expect_success 'request with no command' '
>         test-tool pkt-line pack >in <<-EOF &&
>         agent=git/test
> +       object-format=$(test_oid algo)
>         0000
>         EOF
>         test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&

In these two tests, we give "object-format" unconditionally, meaning
that in a SHA-1 run, we don't *always* skip passing in the capability.
So that's good. Should we verify that the implementation acts on the
"object-format=sha1" capability? Can we? The server should behave as
if it wasn't passed in at all, so I'm not sure how we could do that.

But that brings me to another point: Shouldn't we try to test the whole
"mismatched object format" detection by passing in "sha1" in a SHA-256
build and "sha256" with SHA-1. I suppose a `test_oid wrong_algo` could
come in handy in lots of negative tests that we'll want to add
throughout. Or maybe that doesn't quite fit the long-term goal.


Martin
