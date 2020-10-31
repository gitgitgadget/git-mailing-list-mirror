Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E5C388F9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 17:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E93208A9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 17:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tODiMiCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgJaRUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 13:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgJaRUr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 13:20:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C7AC0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 10:20:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z6so7938546qkz.4
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zdda3fh0o1kQHAmx+r4WPJiw5Dg24uU18C4VpFWqab0=;
        b=tODiMiCYgKPFWASdlCOMZAdK/Aw8gJ+tplB9sPwO2MWjhlFGuBbjg+1cfl2CCWWDdV
         +2hkkdd2ITPqYshBD1OkKbDATiD5WVeODXYRWFi+INnuvwz+U4Xx337RJP8ahC+DBe4b
         wXBVnBnqJzyT7qrXXlnqwELTKpYdfr3WwS4VteVL07q1Z9nshrtJ36Z89Q8x7F/F0Noa
         fQuJZsWOrZ7RbvOtmrvAUCokpRO6BSSCg8boRNDpJrSWGQd26juPImQimYpqXj+J/+od
         JwyeV7X1RKm1EpnJ/NZ/hvXWKCemJTTUoymlina+2sAxtHFcSDgdf+hkWlcx0NdOLovK
         SJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zdda3fh0o1kQHAmx+r4WPJiw5Dg24uU18C4VpFWqab0=;
        b=crVXEhM83egKPiwH8jOY9CWW67nQCobMWB9Ulq9Y5XcgbLUDg2BbzojU9HJYHRA/0b
         Ttg4CZTLzvedVMhT0OwTuevYVt5JbSMPDomisdtd9NjS6yHXFQ0+JZc5dykcEfcY0sNt
         07nrtftENj1umYjZ1SCpwk57VQf2h8MWjz3fdjXgf61MvGR8g65vZWEZh+/Crf8SAyp8
         HRjwIFu9JNK7u8kfsF+qSwhSR1yrI5sToakHxIQ6HZVW/X6XOm5W2IfquStm+vds339+
         XyJNhIN64+fvch8/GKdy4R3tQ6MaXA27noP3Ubyakovz+zAuUXa8JlW3ULC3IgQyNID6
         NhIw==
X-Gm-Message-State: AOAM532gvlh+yqKk0PKBxB+xiK5ufkqb+2iIzE5gi8gf7Qn4hM1DqRTe
        h2ROXQWvgBXRHwbvUiesGlsG1Ml4GjNFtA==
X-Google-Smtp-Source: ABdhPJy8I48iLHrzTOvqefBwPNBFa56F9LU8rKLf5m+Pt4H5p44a4tL8vq/tMCbV0KGjTc+zYx0rxA==
X-Received: by 2002:a37:65d1:: with SMTP id z200mr7255265qkb.103.1604164846261;
        Sat, 31 Oct 2020 10:20:46 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id w45sm4809092qtw.96.2020.10.31.10.20.45
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 31 Oct 2020 10:20:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/6] doc: line-range: improve formatting
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqblgk7pjv.fsf@gitster.c.googlers.com>
Date:   Sat, 31 Oct 2020 13:20:44 -0400
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1EAEFFE7-F690-43F7-83C7-BD07A42C91D7@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com> <7d3fc0a503b160ea15363a4465af4647bce6a30b.1603889270.git.gitgitgadget@gmail.com> <CAPig+cQcjjj3x_iTDX=yBUai6xHrShsGO5J3sdpX-2UhM7_OJQ@mail.gmail.com> <xmqqblgk7pjv.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 29 oct. 2020 =C3=A0 16:19, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
>> On Wed, Oct 28, 2020 at 8:48 AM Philippe Blain via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> Improve the formatting of the description of the line-range option =
'-L'
>>> for `git log`, `gitk` and `git blame`:
>>>=20
>>> - Use bold for <start>, <end> and <funcname>
>>=20
>> My impression is that it is more common in Git documentation for =
these
>> placeholders to be formatted with backticks rather than as bold (or,
>> if not more common currently, at least is trending that way). That's
>> not to say that my impression is necessarily accurate.
>=20
> I think the impression is fairly in line with the reality. =20

Yes, I compared using=20

   git grep '`<' | wc -l=20

and=20

   git grep "'<" | wc -l

and the same for their closing  counterparts and the backticks win.

> That is
> not to say that it is a good future to aim for.
>=20
> My personal preference is
>=20
>    - use `as-is` for things that must be typed as-is (e.g. `-L`)
>=20
>    - use 'emph' for things that are placeholder (e.g. '<start>'').

Thanks for clarifying. It is indeed what I tried to do.

