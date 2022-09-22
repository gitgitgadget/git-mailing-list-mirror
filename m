Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6337C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 17:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiIVRYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 13:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiIVRYU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 13:24:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C39105D41
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663867456;
        bh=kxua2uLc++t8zSU1wIxvOpx4Q1C/c0TEJVlznE0vWHw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cECaG8ISnfY1L0uFTPXEQm6TKAcRz972EBab2TcqdQIe74X589kc0Xc27OSc2u5Rx
         veKwYQIK7Trb5Mg/RSRlLaQUT4rwq6N4leLhnsFMe32lO1lVgziZnZQgY5o7tAJSZA
         NW1r2T3GmDPPJVwbW8DjcmlLfaSpoCDVPAmJfoKI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.113.77] ([89.1.213.188]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1oyPQS0ebM-00lR7q; Thu, 22
 Sep 2022 19:24:16 +0200
Date:   Thu, 22 Sep 2022 19:24:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] merge-tree: fix segmentation fault in read-only
 repositories
In-Reply-To: <CABPp-BGUiDXxv8eQhKQXHcem3ke9e=Q99a_FDExZ5XZYUgir6A@mail.gmail.com>
Message-ID: <322o3q9q-4559-63n5-9o56-q16463o3q7p6@tzk.qr>
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com> <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com> <CABPp-BGUiDXxv8eQhKQXHcem3ke9e=Q99a_FDExZ5XZYUgir6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zqKGsLXZBgb76uvR0io28n3AdaHVUPVDnTu7rB9QUrbhqXDq3a3
 Lufh0jLxNSUCSaxvm4UY3rdutHAR2O46zBoxE/FEzU2Czq4XNrIeu7jWhRMpxHeSQz52Z5x
 jDnJPZRmuWDmGSvSyrRrH1t/OZSR7c1kGt+tfuYox061Yy0xpQTb2XRbJXbue6HGZHHQH1h
 iqXZLd4s1ylEWf6/jd6zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8EWJS+q+La4=:Xsr31OWdB9+85EtFJ7owov
 Y2Vff+s7GYSyJ33jmgPM8WWQ3Aq0uxCV4nh0Z1LixPUqc4Kfcu5Z13yylSfLZcCwrWXDxSmT8
 zW/22SyLjDSyqMWAHoo8gpVonM6IbI2bh69FMi18PLtpB33x4Dc/DxHDMJL0S32a6b6CYsf+s
 yqF3phic92SJ+bN6p5U0JTko5Fpb1KICp/A4sMR5MoReS2YL9cdMmDqIG3sxZfZsmsxhPTPvu
 BW1VxYizaPJWQeE7jM0SX1AfNBxDJsRiBgDkT3e1cpbgSEiem8HF2ryo6j0fMOYC5g6M8Jiht
 4knHyI9ovByqVcG9RoNptFxNliwCVCqJuVNMYMBC2b6h0/p52Kf5m/10NeCq23JrdfBjiMeRQ
 UkLhmIVZMYiAP5Ki1NA5NP9ggTUH4i+kb8KGiwYA7gCz438xVY4PwWNoqtIJrmvKIItz3fba3
 p8+om8cVAxP5+7oowWA5La5hPRPfXMcqgFpOPyUXe+Cf5b+IQoyX7IwKBZmqpHNp1D1D4AwD9
 UrOE4YSDp7z++xGTWbH66mchC/saxDDSsj8E7e1gJuVJOwVKOihdHvtBTFosBuBErodpi+eL1
 L8pOp/HKi+yMLsdJx/9s5GhjHZyCBlGyiRMK7r4d7gLEi2JtQarYqaG5Uig4q/X9QrgcsYKMp
 6CBg/NfJ2uk6ZiQsuE7oWsiLppYR9Ly0SJ+wLG+E8ZBSFRYc1xESx0Ulq7DzqpVXs2vymKqfu
 wBDc98/Lmg+KPKL9z0xz4t+CTzpuIP8B+XXIFnIxdJ4+A9MBZNPhT/pMczMfmCmkGsqWAJ2Wj
 HSXL0I87SG774zgp/3OFEcc7oT3Mo1UCssukKWUFKoGgLY9vCAZ3rdmVhB3aAfnyL7jEf1iuk
 IY7Me9o4pX21YyNCAHbYwWQjNYYAOm6ng0IM0KJzXt9OZjpQEaLmfc3PXKmeb6q/5AdgUm0eT
 ZJwMoFhqbrrT6jHPm66K33b4GW4xkFkvEmsnbeUVkSVzw7kdZHrCksTxRUEE3DE0uU04Mg0Yo
 MGId8JLQ3aWUug5p1lbyZL1y/rdGTRAj6DqQg5b/KA1nZPMz/Z2FzaeVW6jeWY5jbfl1aTN5e
 8tMZhnqOVU+a54MmtNy5JCwmSa96nh9OQHEFK5WRAxWqZaH635twFl93xFLUEiuqzY2n+Php/
 gMjhetzv9LkDw63vT/1x/5pDM2
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

just quickly...

On Wed, 21 Sep 2022, Elijah Newren wrote:

> On Wed, Sep 21, 2022 at 3:08 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > @@ -473,7 +475,7 @@ static int real_merge(struct merge_tree_options *o=
,
> >                                               &result);
> >         }
> >         merge_finalize(&opt, &result);
> > -       return !result.clean; /* result.clean < 0 handled above */
> > +       return !result.tree || !result.clean; /* result.clean < 0 hand=
led above */
>
> Thinking out loud, should this logic be at the merge-ort.c level,

You're right, of course. I have pushed up a tentative v3 that does it as
you proposed, and it looks not half bad. I'll look a bit more deeply,
still, but chances are that I'll submit this later today as v3 as-is.

And then I will reply a bit more verbosely, either ;-)

Ciao,
Dscho
