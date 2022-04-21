Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35B3C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442155AbiDUVc4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Apr 2022 17:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442120AbiDUVcp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 17:32:45 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3603CE35
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:29:54 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id u15so3164526ple.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RPo9skY38g0RkO0dx494xnTOLxDwwv/5ScgRtpPRXgE=;
        b=FxpuxJiA0CZi7oXwnU2xFyKfPTMZLmIoToKjNYmmIM2TJHCzZ44rM7+2gdOL1IjAN6
         10zYMaZDVC4jXMkSd2ViMZN12/NUBqZLzgjxmfN1VatWO7b4ylpH2Tl515NXuXXBsLN7
         3OMK64oe9geoLL//6rX7MVNhShSoSdiiiy1FU8OU3DMFS4zwxGes6jessg8r9NMLo+hW
         diwHFXUbPLes6iTr0+LvItxu0NhclLfaoNR0kKy5+vVtH3JsE3LIBp2bC/AkIGhWjcIy
         WU6smH4f9WEsNRKz4QQv3Va2SGJSK4trbROlPLdF+6Rv6iTBBCARyaj/kHJvYPvMmfxP
         YrTw==
X-Gm-Message-State: AOAM531V5zb5jBLDWIMoJmjSrFIjZsu7VcokaIPih+n1lXAcBMHWf/+S
        o53onvwoLUTQocYEGCAodIG/PJ9FrhNZv8zx2Uo=
X-Google-Smtp-Source: ABdhPJz6qVOjqXYbA8iZjvfeR8nQTYjk1fL68gZnBHmIDy9hsJVRDxSK5pp6avuB8UMBMM7h5kdb7oLoYTzrSfGmtFc=
X-Received: by 2002:a17:903:2302:b0:158:cef1:79b9 with SMTP id
 d2-20020a170903230200b00158cef179b9mr1215867plh.64.1650576593648; Thu, 21 Apr
 2022 14:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
 <patch-2.2-28208bac859-20220421T124225Z-avarab@gmail.com> <xmqqo80uf9jn.fsf@gitster.g>
 <220421.86pmla5eja.gmgdl@evledraar.gmail.com>
In-Reply-To: <220421.86pmla5eja.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Apr 2022 17:29:42 -0400
Message-ID: <CAPig+cTWj2Xf4sfMJBkzLhG5oUBS+Pb5-D-K50xMt9rP0doBRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] CI: don't care about SHA256 mismatch on upstream
 "perforce" package
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 5:10 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Apr 21 2022, Junio C Hamano wrote:
> > Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> >> +            sed -i -e 's/\(sha256.\).*/\1:no_check/' "$path" &&
> >
> > "sed -i" is not POSIX and without macOS box I do not know if it
> > works there.  FreeBSD sed manual seems to indicate they have
> >
> >       sed -i <extension>
> >
> > Ah, no, I'd say we should NOT use "sed -i" here, not in the form in
> > this patch, after seeing
> >   https://unix.stackexchange.com/questions/401905/bsd-sed-vs-gnu-sed-and-i
> > but that is 4-year old information, so...
>
> It works on the OSX we use now:
> https://github.com/avar/git/runs/6092916612?check_suite_focus=true

On my end-of-life'd 10.13 macOS, `sed` (which is the FreeBSD version)
requires an argument after `-i`, thus it's taking `-e` as the
extension name for the backup file, and then uses the raw
's/\(sha256.\).*/\1:no_check/' as the `sed` command. So, it's working,
but only by accident since `-e` is optional when invoking `sed`.

> I think it's fine to keep it, but we could also use "perl -pi -e" here,
> or a rename dance...

Although it's working (by accident), it's rather misleading since it
looks like `-e` is introducing the `sed` command, even though it
really isn't (the `-e` is being consumed by the `-i` option). Any of
the following would likely be less confusing (in no particular order
of preference):

    * sed -i .bak -e '...' "$path"
    * rename dance
    * perl -pi -e ...
