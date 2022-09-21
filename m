Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3982ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 20:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiIUUNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiIUUNN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 16:13:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51316A405B
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663791184;
        bh=/k5/RWcJE8aPnqsrHsGqaW6TBKY4fB7EMQ5pE3gaAJ0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fAfaAwwTFsIXvurNKPd0/W1v2GtQopTAzaF6wENGVQI4p+3opNVmxRkY76ImOvTnt
         P3bwQ05qdOHq+Hro3VKVZ7Wc7h6G3B7zBUJehizM2NPC4npIMKRZBc4+TN+5MWyYlR
         C6nlkaD4NAATjg0OUAHolAvzvPZgbZMqOr9XgP6Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.115.55] ([89.1.213.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRRZ-1olAAF2Agt-00XtlU; Wed, 21
 Sep 2022 22:13:04 +0200
Date:   Wed, 21 Sep 2022 22:13:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-tree: fix segmentation fault in read-only
 repositories
In-Reply-To: <xmqqedw438bq.fsf@gitster.g>
Message-ID: <p25141n2-p277-21o4-r8s3-4396491s41n8@tzk.qr>
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com> <xmqqedw438bq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jvsNViAKlaxgmHUu/OnmZBnlcpOvin6RJadq/diwnDktSjRJrpt
 uatv+zoyTXBUNtqk1u+PKiMjTSdV1dRNmD+9ZdnuzeC57M0ouCyXu/iRjih6Z1oiKGvT6dt
 5Ue9zmwjKZceewq+uMPinvsbO4+itogJCCmwdp6tQ2SBXOtid6XDkXTnZgL6Gd3kG+0pp8q
 sojgju5IbXAv2oFobS3nQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2tFHyPiUChY=:nGK1ERlkPnh0isgLwemxpJ
 KWl66swJ1ujVqcOkxKIfm2JSUD3exMMVAHYu1v6HOCqVwcIaiYdQQFtybPYKz8I4ditSdvc1Q
 f8o9XG7mGKGsViSytd6/iw1hI21w0rJRRMCx3aClIKYK7CZfEy4/9QD44mpcQdkiQbvWPdXDA
 Q8JxF54ufw3gVuM86L8Q/c1iska5sFUrQY3VkTcm+7Tg/wbjxPyYiWyUxM7h8L4oE84Q6VGkx
 LmoX0VbvR1TWjcU1yBNmSfskue6Vi9BtgBAqIVufIE6WCsoHKjgaoRWeBK4hWVwfI5Uz5tMF2
 lD4RNLQKqDbCvqIBx7nWnLFBDx7x6i8fG9UXavy3mxicUGC8069xMlLfMlp8XIe2P3bO85UEK
 eAepOEI6yGprzJi0vo9uYWyyS25Eq9IC5kgY4KOGau6Yh68PwtmQNO2YaIbLB7gmDdyhwURJP
 OC6UIhiqNHJUtNz0Au/UN4LYNYoqkJjcK4liDGledn5Il5qY3jMraAP7yW0IcFZm9W7snSEt0
 RWhNFQZ3D/uU4gfX40lqHzO09e5K5yhSLki+XXRDPVbQxSQIhpBdDWep9hzd3GnNSZqv/mzm8
 bLyrO+Vtapl+QFuL+hU9l7DNVBKo55U7SUevO4YrJOOVDGvaDz6JgkPYMjufZGDdkPjCrdhd3
 YgsaEDMlpl1cNQ8E65BqHfWHXhlxi26uDnVu1ZDIj85OsWl3QWhDRrMJpKPQCyBaWVSJSXBsO
 37IeS5e7rAzyUYCEVDsgWcgIGyc4n8KPAGPzAyVeS1dG7/qFxtSSCtttJUZIliw+EaSn0mLlb
 j7xWwmtyMHBmw9f6P/2NAAsFJeCV8Z3lR1UZc+9yTzIRVAqloh1/jXQrplaBS9ldbtBgcVR/j
 6S5KUYxLOXX0K/vjr3HELBVHJWVbz0LiwLLeRoIrY6HE8EjxWMRtBisbnT1/6p1Ld32du07af
 +A1qbAeiHBmC7S5BO0I9Zke45vQLlkvjyJWUKeNMApZQg9Ziyd7unSJ5BdwmR/jEwk+9/RaHz
 m+dAr0YaKsjQnisU2cMGujCqBDs12xbf0PTYasua4UkSPwhJC3q1mlMZOy6hugRsMM6N2Fs5T
 oXY8V/ZhQtwGKLCanWuX7FSqa6bzKtkyFGJGAEx28tAaK+L42AJZ1bRtfCPqx557fcJj+s97z
 VgoGuKlMAfiiCmJKX0LoHsgXlT
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Sep 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +test_expect_success 'merge-ort fails gracefully in a read-only reposi=
tory' '
> > +	git init --bare read-only &&
> > +	git push read-only side1 side2 &&
> > +	test_when_finished "chmod -R u+w read-only" &&
> > +	chmod -R a-w read-only &&
> > +	test_must_fail git -C read-only merge-tree side1 side2
> > +'
>
> Doesn't this test need a prerequisite to guard against those whose
> filesystem lacks SANITY?

Yes, of course!

Thank you for the sanity check (pun intended!),
Dscho
