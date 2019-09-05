Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9D31F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbfIETJ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:09:56 -0400
Received: from mout.web.de ([212.227.15.3]:41891 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731206AbfIETJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567710582;
        bh=GxhL6kgu1cl5uZ/RDXX4QPaDfnXoiq1D/7brbm266mw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PIHGapfcgCRlNNhRpiFLV4pC2Hz7dG5xG9etK/EAlExLXWUbBB7fUyTy1kLntyY+h
         O/UCGiEqkf0ebZFVfUiwWvxo5vQH5Hk4rfR4WVp/hUoSrpX8gyzyz5XsutA6zeiJtZ
         RZBoPDWe+6o1n1wGdyhPLJSyWcz7KMjoHW6IdGl4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRUC0-1hhi98151U-00SdlA; Thu, 05
 Sep 2019 21:09:42 +0200
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
To:     Jeff King <peff@peff.net>
Cc:     Stephan Beyer <s-beyer@gmx.net>, Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20190905082459.26816-1-s-beyer@gmx.net>
 <6c6c4e71-d9e5-1ad4-74db-12c323da42f7@web.de>
 <20190905175304.GA23663@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b4f53049-ff50-8143-1653-d321cce6421c@web.de>
Date:   Thu, 5 Sep 2019 21:09:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905175304.GA23663@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2nN/NGguPhahSpkm7HmO4dJrs2koVYpoWUzpjQPNHvrnOMQBfyi
 2tuBMbC2Ur57nxWNjeVoFBLbMd1zSN387tY6jZej67kbUdF2klR037lRRobNxNPpJLMcyyR
 l266NuG6mdqDppPiOJkeSIu63zzO/AT62qVOIkvvgIDsUBjMgdqN/Va8Lz66ACxrR0qQohX
 wk9hi90chFcwgfLLH8Q6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vkL6gtdE/6w=:nNgaDUJa8+/U0a31ir8xvb
 xzbktB+pxu3sMK+zjY/9qg7O9AWkV68KeviD/4aa7kXsOOSCbUuEF3ahwGKQ0NB49rDJA6h1Y
 fP6cjR6Sb0HuKNdNy3IW56vTppg+W8XPejScjGJotqB1zZPbN/1tbqO7RljU5RTbALwA6Bo6M
 JWU+kpXbSERvIdzxlKle4RrOPeB+R9yWY7q3G3FKnNPAY/XP4UIiv6tW87eZdZ/x1A6xEGv1U
 p+eqefvBvTx+oSdhLsvQn3P7x5bnwAJuDWouqDdCJD8Dm3K+RkcGh1YxEsx6T+EinauIDJ0AV
 sZofRz4NBijLCYZQu9chRv9Uc5EJhvIMgkEE7JbFRM45cC9pmKNOBQpYjtzmE8RChTmDUPZ+7
 iS5gBmcYnE8qTrmYZLvyKw9Ac+zZx14tS7+bpw3OJ6SM1cz4FQBYgjarF6ZcUAy8wGz0F6THD
 1avxWsNRj6PvhPJ2qpBncNVjh+AY6vdhjdelS8BBt+p3AT5yeO9QK8IpDTkp87pL3VwJ1knyZ
 LQ6JWpffp5LGY4OkSULghqF51+f7dJc3n7FAXgxUMFlVYGoEm0ADKtL5E6r66WMccBfE8jOQr
 zYftix0YCEsMbg7OEflQKsRf4IGjTNLhqty5izVkOG0XpA+/3iDzNw7nB30MeMK1BwaR+6uOv
 NN/Yk/S4d3KJOPzCOO/xVi8i0B8rqmyvh0PbHgNZu9DtUJ6xSareP40SpLRxleKHxfn/FEwGT
 5kBVyxItkV/Z8+T23YtSp8L1QEu0z4cs9FNzBF9dn6WtWGOabsMl0m1g9nEi7ASGJb1dxlNtl
 qkQ+Hr7pfYpORAV/eLVXqXtF3eeV+46QpIOLqgcioCrNC/oZOUpJPpO0KrhBsGvwU66P5iDWP
 aoalxKKvX+wzKmD4iwz92YvBWGKeDSMjlzAMX8RQNvNQju/rcLtbc+x/WEbyZtqk7gSOOryuW
 XvvfU9/9XxB8bOiYB6mkrquqL/QV8tVn/TVEKvT3erH0tpGO43Kv26fAjPx5fw43MIu3O8IqW
 HIdN9rvDKTd/5w7z384xBnlTrsSDnOfcACP7Il5ExAV+I8jdTUWHkXUK6HMEO3yYvuGXKg3F5
 F6XSAiqo66aat90UlN30Elxj5HyKUT2P4tXNiOHS5LZRScFeLGhWIx7lTiIK8GuKl9APIsBHs
 BnpLaxCc74hm0gAL/rZg+2Cep2vs7cCklVOyrkSKZHfPkh0e9QwdcbhRgh1Wo+QP+vgAU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.09.19 um 19:53 schrieb Jeff King:
>>> int cmd__read_cache(int argc, const char **argv)
>>> {
>>> -       int i, cnt =3D 1, namelen;
>>> +       int i, cnt =3D 1, namelen =3D 0;
>
> I actually saw this one the other day, because it triggered for me when
> compiling with SANITIZE=3Daddress. AFAICT it's a false positive. "name" =
is
> always NULL unless skip_prefix() returns true, in which case we always
> set "namelen". And we only look at "namelen" if "name" is non-NULL.
>
> This one doesn't even require LTO, because skip_prefix() is an inline
> function. I'm not sure why the compiler gets confused here.

Yes, that's curious.

> I don't mind
> initializing namelen to 0 to silence it, though (we already set name to
> NULL, so this would just match).

Pushing the strlen() call into the loop and getting rid of namelen should
work as well -- and I'd be surprised if this had a measurable performance
impact.

Ren=C3=A9
