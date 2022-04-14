Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FF2C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 08:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbiDNJAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbiDNJAA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 05:00:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92078692B6
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 01:57:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t11so8696471eju.13
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gYO+CTwuaKfnfrBWRCzAfRNv0muueW9uSIgCvWozEYw=;
        b=M5waxxE4TJMHIwHZPNUDaOMB7Kf/MXNnQ2ub2ELbvRJYv5AexPKST5ju77Q8Qp+gcW
         ht6Juo811z4/CRvL7+qsCTAiyn8FVEyZNfkAVqSWA3WRpXw5K9vo3ImZiqc9QBK3Zvhy
         MqGNY+rvIxscTe2flAzh9LLBgRwsp8Sbus5oc7XhrscQUN0jrxxdlQ1YUji0h+AZVjgI
         AB+0Drq/T+hrM8/3Hg1h8NFq5sNQkCjY6hutOayt36bSmfa8P+OLBNMu2rCC1UVaewVK
         GcKBDnt8VhQU5zSMv8Xa4D0zy2anFZlfX+u4EsFtpZax68JejZ9eosKsLM1KlI3b2wdT
         cSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gYO+CTwuaKfnfrBWRCzAfRNv0muueW9uSIgCvWozEYw=;
        b=0TRjMx/S1k4h5SkTIugIIl2BWm4n1KclOpIBmtzZVbftEVPQhYGR7xTi1/gKllO48p
         PZALKkc01DtrRo70Igeya1np1QDm6cuKJUcHJGAv/A6VTqr048BWPJZQvSZjUU84oIHl
         1HMRMLeeYkTQIq08CMxvWeZNJxCY9e/MwwcXv+m8VhOHevabFEHgy92U9dtYP3u9H8s9
         mLJrgLonWisoclJY/0JoD4dA+bBPgHbh3Xqv/noDnsC0bxfdVzyKAwrM9SU/trDdV4q0
         JpOgYESSHCZQCBcgKBTFMlyMjGHB8GkvuKvdSKvPxBUfoyNr+VJfjsEOI9B22xoactrx
         xAxw==
X-Gm-Message-State: AOAM53038tUa2NQzx938khm3pH0flRYqv+0xKt2AvjDaZdaqZ638P14J
        6bvEXa1MKwUKPFYZ3zigi/ZkOahyvld+4CUPChvM9Gv6OJ4=
X-Google-Smtp-Source: ABdhPJzQ4xef60xKyk+Jm+LwMQpQcRdg16siKGVRk1bx4PmDdMip58KZvkWPgKBQsCfuHz18v2LmJYf6JwokeBCyTjQ=
X-Received: by 2002:a17:907:2cc3:b0:6da:e6cb:2efa with SMTP id
 hg3-20020a1709072cc300b006dae6cb2efamr1416469ejc.169.1649926649594; Thu, 14
 Apr 2022 01:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAA0Qn1sBF=PAduCQCXbYkeu4cphw7O+AnvwFNMWijuKYskaT8g@mail.gmail.com>
 <20220412191556.21135-1-Jonathan.bressat@etu.univ-lyon1.fr> <220412.868rsagkus.gmgdl@evledraar.gmail.com>
In-Reply-To: <220412.868rsagkus.gmgdl@evledraar.gmail.com>
From:   Jonathan Bressat <git.jonathan.bressat@gmail.com>
Date:   Thu, 14 Apr 2022 10:57:18 +0200
Message-ID: <CANteD_zkvDiMBT2M3_eL_HV5v=ckg=fJQxEGrvDx5ttMAdSdUg@mail.gmail.com>
Subject: Re: [PATCH 0/1] Be nicer to the user on tracked/untracked merge conflicts
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Cogoni Guillaume <cogoni.guillaume@gmail.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>, git@vger.kernel.org,
        guillaume.cogoni@gmail.com,
        Jonathan <Jonathan.bressat@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 12 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om> wrote:
> Do you have an example of such a non-working case? I'm not sure why it
> wouldn't work.

For exemple this test fail:

+test_expect_success 'overwrite the file when fastforward and the same
content' '
+ echo content >README.md &&
+ test_commit "init" README.md &&
+ git branch A &&
+ git checkout -b B &&
+ echo content >file &&
+ test_commit "tracked" file &&
+ git checkout A &&
+ echo content >file &&
+ git merge B
+'

but this one works:

+test_expect_success 'overwrite the file when fastforward and the same
content' '
+ echo content >README.md &&
+ test_commit "init" README.md &&
+ git branch A &&
+ git checkout -b B &&
+ echo content >file &&
+ git add file &&
+ test_commit "tracked" &&
+ git checkout A &&
+ echo content >file &&
+ git merge B
+'

will send you a new version of our patch soon.
Thanks to your reviews and help.

Jonathan BRESSAT and
Guillaume COGONI
