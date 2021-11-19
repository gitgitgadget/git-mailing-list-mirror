Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A547BC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A44961A89
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhKSMXi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 19 Nov 2021 07:23:38 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:42974 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhKSMXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:23:37 -0500
Received: by mail-ed1-f45.google.com with SMTP id r11so41899288edd.9
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wgaDahvolSwQI9/NnrWncU6VtyuRm8HUZjFAjlK4lWU=;
        b=IWw3faMcXPARy8e8sAjreslb7mWjDjsd5bCWG+Qd47zW0wxRQ9A7v9VaGbLxUDXy/g
         yQ1BRX6umJCAzqLWky74iazg74l8g9Fs4KdHak+itu8RHljPzx8nHfaXm5aDwE11TxiZ
         vrS2qAHYaK7DOhQQWRBUH80M+Au6Vznlrtxjx/xnxOhBS57F3nd1nLAPZj+YI+hB85CB
         IKZ0dM1CnvdJtScCS6KMNH+krXiY6E6B6sG9LWhgHJYlRg+bPNzFLkjgENAVLQeHZwqa
         LmPJL+qY21XyvrQG/q9/UG7x5czxqkl6DiOQwfW+mPsHfupPFh8pNC4blccdNr8GhUiO
         2dWw==
X-Gm-Message-State: AOAM532R0DOph8sdZ9bZwl6eapxF2euN0FO/i6o7winOjMXhTlPqVgG/
        bBnnNeW0s6CNy4SVgZRNTANKKNmaj+oWqwvFBO2mKLGxnYEAHQ==
X-Google-Smtp-Source: ABdhPJxSFKiuGuEvEGPOc3/FgdmBLEOAC19hxJnDn+1abpmfzwBqZsTYRQRCEgvuXMo+kX7ynXUb3nvPPOBZLdvGaKc=
X-Received: by 2002:a17:907:6e1c:: with SMTP id sd28mr7444789ejc.28.1637324435350;
 Fri, 19 Nov 2021 04:20:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
 <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com> <96d8573dc808bc32990842675ca32a0d1e8a8cef.1637232636.git.gitgitgadget@gmail.com>
 <877e2b84-347d-8687-d3dc-6c7ce508ac1d@gmail.com> <211119.861r3c4a4g.gmgdl@evledraar.gmail.com>
In-Reply-To: <211119.861r3c4a4g.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Nov 2021 07:20:24 -0500
Message-ID: <CAPig+cQq3Ek7RL9NKuvR5V9OVULRf7=N3QEYvy9=xqdZB3EEWg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] am: support --empty option to handle empty patches
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?QWxlZW4g5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 7:12 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Nov 19 2021, Bagas Sanjaya wrote:
> > On 18/11/21 17.50, Aleen via GitGitGadget wrote:
> >> +test_expect_success 'still output error with --empty when meeting empty files' '
> >> +    test_must_fail git am --empty=drop empty.patch 2>actual &&
> >> +    echo Patch format detection failed. >expected &&
> >> +    test_cmp expected actual
> >> +'
> >
> > Why isn't the echo string quoted?
>
> There's no need to quote the arguments given to echo in cases like
> these.
>
> It's not the same, i.e. it'll get N arguments on argv and not on, but it
> makes it easier to spot things that do need quoting, rather than
> over-quoting everything.

I recently expressed an opposing opinion in [1], stating effectively
that omitting the quotes like this is "an accident waiting to happen":

    ... the lack of quotes ... in the `echo ... >expect` statement
    gives me a moment's pause since it relies upon the fact that
    `echo` will insert exactly one space between the ... arguments
    (which happens to match the single space in the [command's output]
    ). For clarity and that extra bit of robustness, I'd probably have
    used a single double-quoted string argument with `echo`.

But, it's a fairly minor objection.

[1]: https://lore.kernel.org/git/CAPig+cQVSUg1aqry_hMydJ=Uo=-VhOog6TUTpG=0on0LUcw8Dg@mail.gmail.com/
