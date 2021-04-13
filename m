Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A5AC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC68F6052B
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345027AbhDMOp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344897AbhDMOpX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:45:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A2C061756
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:45:02 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r20so19637094ljk.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TVKRC4sc2wsUumCqxP2yPF46A8N+02ybVvWNamdLFJ0=;
        b=YbS1FWu3sE5P6RrRey7TINGaL7mETirDjvpy9G4bcRDiyQIPD38IVWjTtcaBzzkGkr
         iZqvh0AXcRIQ3oPDp5tFkj/He2pBEl16L42DDcqM3fXqdLGWUhBq8K61Tv8aDyRlb6qd
         6VPliLaEOO5M0PRVydT0t7HFR2mKz03j7pFDDPVWywoSZVvHmKBeknQDfH/NoOK1LeqZ
         A5k0eUMWmlYS9aDqzA5DMu3OUigUQWeGlZn5PHQW4Pz7BU5ZnSNadsDi7a64EpeDbNt+
         CqAjjomWpmcEAHXGJQiw4BLbHygDwbNvw6r3cjxZ4hZUyng0BTcMWkgSkUZ5CFJEkpmJ
         1YPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TVKRC4sc2wsUumCqxP2yPF46A8N+02ybVvWNamdLFJ0=;
        b=Nh4YeLxl46QynjqZJPi+abb7CKwkhznYcviiRSNn+rXhEiG/aZUXLetvElTYs1BqDk
         kOhh1k0yeSBec/idm3LLyVuLSBEkGIv6w8Z+Z4Lq2a4yUg5YsofFPUxYh3uxKatKXuo2
         o3Xywp30akbcSxSU9l1X9hcglyl18ofhQkPuvr/3W+8JnAatM0EaV3wfTe83O5ffsQGD
         4nFJneHED08LDCdvgNlx++FrFU1ijmqqAQhsaQMyvpNMixlfLv4lmd8tqPm67eE7ULF7
         6nwwV5xTx4oXLVtoCZlEgVLe52e+8QICeblOX8IR/phYpURDGBNzKmga5u8VbvC5No3v
         jl9Q==
X-Gm-Message-State: AOAM532txPPpwTnCd7KjHD6ZJxzu+5rkEssrCcjMqFTPuVxbMIkgVzVE
        kky5VSkD195wbStCtVuxBf4wnHuThKAKXRq5fU9atqskTxU=
X-Google-Smtp-Source: ABdhPJyPf5C/AlbBikpBrJWzQTGDwLMk4kNqNQPp2+xXcp38PSm6sS7VZyPTGnF332zOlXLE0D9nDSO5PrKNu4lDsuI=
X-Received: by 2002:a05:651c:513:: with SMTP id o19mr5524865ljp.291.1618325101420;
 Tue, 13 Apr 2021 07:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com> <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
In-Reply-To: <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 13 Apr 2021 11:44:50 -0300
Message-ID: <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 9:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> If a new test is added to this "while read magic cmd" test facility
> added in 3c2f75b590c (t4013: add tests for diff/log family output
> options., 2006-06-26) but no test file is added it'll fail the first
> time, but then succeed on subsequent runs as a new file has been added
> in t4013.
>
> Let's accomplish the same aim in way that doesn't cause subsequent

s/in way/in a way/ ?

> test runs to succeed. If we can't find the file we'll BUG out, and
> suggest to the developer that they copy our "expect.new" file over,
> unlike the previous "expect" file this won't be picked up on
> subsequent runs.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t4013-diff-various.sh | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 67f6411aff9..228ff100c61 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -200,10 +200,12 @@ do
>         esac
>         test=3D$(echo "$label" | sed -e 's|[/ ][/ ]*|_|g')
>         pfx=3D$(printf "%04d" $test_count)
> -       expect=3D"$TEST_DIRECTORY/t4013/diff.$test"
> +       expect_relative=3D"t4013/diff.$test"
> +       expect=3D"$TEST_DIRECTORY/$expect_relative"
>         actual=3D"$pfx-diff.$test"
>
>         test_expect_$status "git $cmd # magic is ${magic:-(not used)}" '
> +               test_when_finished "rm $actual" &&

Nit: before these two patches, "$actual" was only removed when the
test succeeded. So, in case of failure, the failed output files would
still be there for debugging. It might be interesting to keep this
behavior and only remove "$actual" at the end of the test.

>                 {
>                         echo "$ git $cmd"
>                         case "$magic" in
> @@ -216,16 +218,19 @@ do
>                             -e "s/^\\(.*mixed; boundary=3D\"-*\\)$V\\(-*\=
\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
>                         echo "\$"
>                 } >"$actual" &&
> -               if test -f "$expect"
> +
> +               if ! test -f "$expect"
>                 then
> -                       process_diffs "$actual" >actual &&
> -                       process_diffs "$expect" >expect &&
> -                       test_cmp expect actual
> -               else
> -                       # this is to help developing new tests.
> -                       cp "$actual" "$expect"
> -                       false
> -               fi
> +                       expect_new=3D"$expect.new" &&
> +                       cp "$actual" "$expect_new" &&
> +                       BUG "Have no \"$expect_relative\", new test? The =
output is in \"$expect_new\", maybe use that?"
> +               fi &&
> +
> +               test_when_finished "rm actual" &&
> +               process_diffs "$actual" >actual &&
> +               test_when_finished "rm expect" &&
> +               process_diffs "$expect" >expect &&
> +               test_cmp expect actual
>         '
>  done <<\EOF
>  diff-tree initial

The rest LGTM, thanks.
