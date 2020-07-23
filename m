Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF015C433DF
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 05:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1C320768
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 05:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgGWFb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:31:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43298 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgGWFb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 01:31:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id a15so3881555wrh.10
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 22:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keD5StT0aoTovIlk9D76ztHQ2eB0SJ9p5SkwBwFVGzY=;
        b=F8jnojNQLa+guuWu/jQQY4U1xYSNvotLbQdoxL5+G/eL6CTQR6EVJY/2nTkRTqyXNz
         W+8cIENKJBlu1PIANC32o0wIktshg4s5OyNSfDZC9n6QfiQQKb2AVxI5wSBovlTJPk85
         2lwj89vGK6tZwBqKReyNKkwFenHMXB3bkVPSRpX86zhqbPAzycXUu1XTD6MxCEsUbbpC
         jBlqD6B2xaTf7Ii0n0pRADjyOgvG/2rqutrXn28ojhpm6Uw+HgCuq8Q0xi0WUVl3bTzL
         s80hFFc7dkodLREUdJWDHcuxpA1v60BTHq/oh14JY/bqRUxlxYOljuMQj1RHcfNKFQQa
         ZsmQ==
X-Gm-Message-State: AOAM532H/8YVPSx+NSBGvwx8nkMh7VM+pkbZRQW2k3UV8k/CvvtcIC7K
        GNxv3YUwMXyhRFrcLC9Xwyzmcd+1eJkyzLvmbE+VgT3s6sA=
X-Google-Smtp-Source: ABdhPJxAC88rccuhZb+4R6faw2GM0bdE1xqc7oDyTqNPLhx9+esA45dpuIn40/R9ZN9StCQU4IlgepOk8ZGVH8E+vwA=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr2583066wrs.226.1595482286541;
 Wed, 22 Jul 2020 22:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net> <20200723010943.2329634-32-sandals@crustytoothpaste.net>
In-Reply-To: <20200723010943.2329634-32-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Jul 2020 01:31:15 -0400
Message-ID: <CAPig+cRWptYRJUpT71jW6_O9UZ1RK=FCbZj-+OkR_5kGqSWScg@mail.gmail.com>
Subject: Re: [PATCH v3 31/39] bundle: add new version for use with SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 22, 2020 at 9:10 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> [...]
> Since we cannot extend the v2 format in a backward-compatible way, let's
> add a v3 format, which is identical, except for the addition of
> capabilities, which are prefixed by an at sign.  We add "object-format"
> as the only capability and reject unknown capabilities, since we do not
> have a network connection and therefore cannot negotiate with the other
> side.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/Documentation/technical/bundle-format.txt b/Documentation/technical/bundle-format.txt
> @@ -7,6 +7,8 @@ The Git bundle format is a format that represents both refs and Git objects.
>  == Semantics
>
> -A Git bundle consists of three parts.
> +A Git bundle consists of four parts.

Rather than having to worry about updating this each time the format
changes, perhaps just say:

    A Git bundle consists of several parts.

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> @@ -281,15 +281,16 @@ test_expect_success 'create bundle 1' '
>  test_expect_success 'header of bundle looks right' '
>         head -n 4 "$D"/bundle1 &&
> -       head -n 1 "$D"/bundle1 | grep "^#" &&
> -       head -n 2 "$D"/bundle1 | grep "^-$OID_REGEX " &&
> -       head -n 3 "$D"/bundle1 | grep "^$OID_REGEX " &&
> -       head -n 4 "$D"/bundle1 | grep "^$"
> +       sed -n -e 1p "$D"/bundle1 | grep "^#" &&
> +       sed -n -e 2p "$D"/bundle1 | grep "^@object-format=" &&
> +       sed -n -e 3p "$D"/bundle1 | grep "^-$OID_REGEX " &&
> +       sed -n -e 4p "$D"/bundle1 | grep "^$OID_REGEX " &&
> +       sed -n -e 5p "$D"/bundle1 | grep "^$"
>  '

I wonder if it would be simpler and cleaner to do something like this instead:

    cat >expect <<\-EOF &&
    # v3 git bundle
    @object-format=sha256
    -[OID] message
    [OID] refs/head/master

    EOF
    head -n 5 "$D"/bundle1 | sanitize_oid >actual &&
    test_cmp expect actual

where sanitize_oid() is a function which converts a hex OID into the
literal string "[OID]" (or whatever). I believe I've seen you employ
such sanitization functions already in these series in cases when you
want to verify that an OID is present in some output but don't care
about the actual value.

Or perhaps this approach is overkill?

Reading further in this patch, I see that you actually do employ this
technique in a new test you add to t5607, though you don't bother with
OID sanitation in that test.

> diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
> @@ -94,4 +98,29 @@ test_expect_success 'fetch SHA-1 from bundle' '
> +test_expect_success 'git bundle v3 has expected contents' '
> +       git branch side HEAD &&
> +       git bundle create --version=3 bundle HEAD^..side &&
> +       head -n2 bundle >actual &&
> +       cat >expect <<-EOF &&
> +       # v3 git bundle
> +       @object-format=$(test_oid algo)
> +       EOF
> +       test_cmp actual expect &&

I think you want to swap the 'actual' and 'expect' arguments.

> +       git bundle verify bundle
> +'
> +
> +test_expect_success 'git bundle v3 rejects unknown extensions' '
> +       head -n2 bundle >new &&
> +       echo "@unknown=silly" >>new &&
> +       sed "1,2d" bundle >>new &&
> +       test_must_fail git bundle verify new 2>output &&
> +       test_i18ngrep "unknown capability .unknown=silly." output
> +'

I worry about passing binary bundle data through 'sed' like this.
Historically, some 'sed' implementations would drop the last part of a
file if it didn't end with a newline. Even today, not all 'sed'
implementations necessarily pass the binary data through unmolested.
For instance, on Mac OS, 'sed' adds a newline at the end of the file
if the binary bundle blob didn't end with a newline. Perhaps a more
reliable approach would be to use Perl to read the entire bundle in as
a blob, use s/// to munge the @object-format= line into the @unknown=
line, and write it out.
