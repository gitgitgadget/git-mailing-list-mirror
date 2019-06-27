Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DE9B1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfF0Jbu (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:31:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:52941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0Jbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561627897;
        bh=4+zPPM9Ae+KHlP+d5Gy6A0f/FgbEAlYBpzSfIfqrJXo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bq2L7PmBDYzpc8LHZLrYDViuEQSAVjpYPkFSnBNKXqizrARIKpStq9KxYdxI7vBO1
         51tFouLRgq5uNWFmCFLvlBBPC8zNcJZq1ukNKNWBbCjZZffnOUCIAqUV+wkIDjW7Mc
         E/xXKTXpCNNZfXeBS49+tBmaHXWEvaNRWkGviDqw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXZ4Q-1i1zrj381m-00WUPe; Thu, 27
 Jun 2019 11:31:37 +0200
Date:   Thu, 27 Jun 2019 11:31:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 7/7] grep: use PCRE v2 for optimized fixed-string
 search
In-Reply-To: <xmqqo92kchjm.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906271129370.44@tvgsbejvaqbjf.bet>
References: <87r27u8pie.fsf@evledraar.gmail.com> <20190626000329.32475-8-avarab@gmail.com> <nycvar.QRO.7.76.6.1906261610310.44@tvgsbejvaqbjf.bet> <xmqqo92kchjm.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TlqL8rAdjF8O2JXHpGhVHBqDlW+6iUkBM+D+WBhCP8ANQmAzIai
 ZtAdbf7XPe8mQTzyZAPvFJznSKlyy7+fdpp6f7pm+YRgQLb3VkOc+eWBoodaQ3HJ/GcwBER
 cDSqnUq5xwvlY1SfjRK1nFPYJ4R0kpaWTs1qPjqjq1qI0sOWC+025XdW0g8tYU85NUzOHqG
 JCA8Wta7jZfyHlp96TTIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ImqtUK1jarY=:2n5uqEwJ1H0ME7GwZttyPi
 PTehieyVQuF5uxKdEpZi+Duop+lJv7PzH2o5hjb0WyFvRd7aAiDVZACWwLHE9aQlVYQn1up4/
 cEg3nGgJ0sOa1rBqFk0YCF6ba7IbQqp3xqiGf4xJah9aopAz0clGacQPkUfGqSswA5QR+djHm
 YzZDnp5OrcuBEntyxwuNGh+e45t+HVwd+fornCSB8IxPdVlBLbJOJcMrJhaHx/hlx613eicV8
 TetdSkrTRv1ywAkEyvQeuZB4xwjhMx4X0AaoiW8x2+YlAZfWFX4uG7ulHnSPx4XHA8bpITacW
 6WMO0kX3RoVmpfHLTr3dUUKob3nydA++7hbatcwzY7OEJb82qIRMIf7oMoi8RB2sjtWf/Rjud
 E8QYVxoE5ifnpZ25Ju8qVDu9opplWGAWqm9ZNpnzJaCvSd/y5cx0l6Dac9NY8UMncOPjyxiug
 zRogkHwHvWtGvhJXj5+XpFraJ1gZQDtexnt1dBNyP7bj4T0mWPKAj+J5r6/VPQqM+iJ81eq6l
 D6/y0KBkhvOU60hb742nQ5XxysMaKw8DwXhlqzgmI0rK//u80n7ZkXqQ6PIqyUZAen/TUMX/+
 rMIO1a16CkIa5kOH/HsSeFeY8Cdnwt6lQYqUFvjW+aSMscCo1CFEFcMjmaOq00JVE5Be6++5/
 hFzhmUutlP5UPvg57HK6Ky5kjmlvzzTbcbyPXFeu4qemPAY1XPoz1Hql7U3vhBveMdYxdVEd6
 sPf8yv34LsuotYyJ1lgSNKdRDRW2CjqG42FkInL8i1lQ044HkieK3JswnCdER6stFVy4ytue7
 c4OonhSlHCWDZAt3IKH3OEEO8aItVW/v7rvu0Qr8Qai7K/+b0i7YVq+psEtopLvvTboEX63jd
 nZZ2oruQHYfzotv54/KxE38WznTa8h65hRqxFhLcWfuVksbOsC2PJLrooPC81mC1NtOXVRquv
 qv7JsbxBIJD8GSFfIf7JJZYTwoOa/XlcRET+HdzPJwIJFBL39hAhJ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Jun 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > ...
> > Ah hah!
> >
> > If we would not have plenty of exercise for the PCRE2 build options, I
> > would be worried. But AFAICT the CI build includes this all the time, =
so
> > we're fine.
>
> Well, I'd feel safer if it were not "all the time", i.e. we know we
> are testing both sides of the coin.

AFAIR at least the Linux32 job is built without PCRE2 by default. I might
be wrong on that, though...

In any case, the upcoming MSVC support for our Azure Pipeline _will_ build
without PCRE2, then we will have that axis covered.

Ciao,
Dscho
