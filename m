Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B06FC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 22:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiKVWUo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 22 Nov 2022 17:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiKVWUl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 17:20:41 -0500
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA017A376
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:20:39 -0800 (PST)
Received: by mail-pg1-f181.google.com with SMTP id q1so15206901pgl.11
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVOpwt2H4kMo7vhRoyoezYgcSfKxvioKSpNR77U9EO8=;
        b=s+xwTw6McHpLBMRjEpZifP16n7oV9Gc05hwbWlB5QIBuvm53F1+c1kQLBGz64pYSJQ
         bNWHRyISLKsjjlogiKgJVIA1f5ybppK5Q198qa7k+07qfnj9gV9Z+IZqaVQx64aNiYML
         Ll/YHaad40xsqGESlHHZWlCDDxpweOVDBKGzaF/k+BMpNVVDnJL3UcGrxNDEFxVvNlbP
         UlictL0Cb+WPe8hz7vdlx5Y72GEEBwqMq6pdyFrja5gZb/vVrW0hOw/MjljoH6GFAzcM
         mHMjVpqO4Pc4lZCswuQG4+cC84moivbz8s924vwMBfpbn74Xw7l1dtBlmJAJTXyi3egC
         +kZQ==
X-Gm-Message-State: ANoB5pn6ZirHI+qqtfRw1sxbVCvV+MIXWjVDUk0kXcLCuDmdnDA08+DK
        o0o+GsoMZwNVfLpQs7FaP9YQT2Luks98U1r7+PE=
X-Google-Smtp-Source: AA0mqf7dTE33w9Hx2fjS+MF/+uDcW01NDfe1KAN0LLJLfMsusixHFOaR0Zh2paB3U9On5gy8kQgCxpGBd+n2yfukDQc=
X-Received: by 2002:a63:5049:0:b0:470:a47:996b with SMTP id
 q9-20020a635049000000b004700a47996bmr5974570pgl.514.1669155638749; Tue, 22
 Nov 2022 14:20:38 -0800 (PST)
MIME-Version: 1.0
References: <4657a19c-89c3-2237-9e6b-db897a492072@opensuse.org>
 <CAPig+cT92EokWeVA_Ou1P6kkaq90wneRrgPqnKLbkHnc=U56Vg@mail.gmail.com>
 <221122.86zgcj9hmc.gmgdl@evledraar.gmail.com> <CAPig+cTniT+_7MxMm3Kc2C_oEtQGg-WA3870baL8990Av6HmJQ@mail.gmail.com>
 <221122.86v8n6abeh.gmgdl@evledraar.gmail.com>
In-Reply-To: <221122.86v8n6abeh.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 17:20:27 -0500
Message-ID: <CAPig+cRfheaDMuQ501dABZnW0xW0+YbicoPL4665GtdjtR1fSQ@mail.gmail.com>
Subject: Re: git can not be built for s390x since update to git-2.38.0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 5:10 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On that platform, this also works:
>         diff --git a/t/chainlint.pl b/t/chainlint.pl
>         @@ -656,7 +656,7 @@ sub ncores {
>                 # Windows
>                 return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
>                 # Linux / MSYS2 / Cygwin / WSL
>         -       do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor\s*:/, <>)); } if -r '/proc/cpuinfo';
>         +       do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^(?:CPU\d+|processor\s*):/, <>)); } if -r '/proc/cpuinfo';
>                 # macOS & BSD
>                 return qx/sysctl -n hw.ncpu/ if $^O =~ /(?:^darwin$|bsd)/;
>                 return 1;

Thanks for digging into this. Your diagnosis matches the diagnosis in [1].

> Anyway, the "fix" here can also be:
>
>          $jobs = ncores() if $jobs < 1;
>         +$jobs = 1 if $jobs < 1;
>
> I.e. it's another case of bad /proc/cpuinfo parsing.

Yup, I suggested the same in [2] as a would-be-nice-to-have-eventually
patch, although only as a fallback, not as a proper fix for the
reported problem since a real fix (as you have above and as in [1])
would return the correct core count.

[1]: https://lore.kernel.org/git/CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cQ6_7wf6C280Rqi7mcTCiQp-n5GiLWTPazfcUcGFeZi0g@mail.gmail.com/
