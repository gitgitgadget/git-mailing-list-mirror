Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB25C3F2D3
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 21:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C578A246AF
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 21:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwuEBYGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgB1VXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:23:09 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:42816 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1VXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 16:23:09 -0500
Received: by mail-lj1-f172.google.com with SMTP id d10so4863298ljl.9
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 13:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=/M5RjQPzp+mwl5AtYvNUPyxqYUGuTmswSH9ScOWmzO8=;
        b=qwuEBYGmxmfKWrMNqfZYdjX4j/UyOM4uyeSUryU8x2YpdQ53zpdz5t/H54KvKEEPWC
         H17MqQTdcPy3UB8vacerLUGxddNONPley+dp+jaD7MwOoeYC3+z5VfpAYmxdl30rB+fN
         GKVpp28W4YWVniafkG7PABRzEaxBG4wFoeuyFAfiHAIqt2UWMtnr+v6lR48zSPIuJou9
         Kf8lAOhQO9mUpMPkINCaV01RE4amjlaUPRCauXs4XuiSiJyeFjaECdU3ykJfs/zc2Ju5
         yTqFMG4kr/5ikYW/EDp98vTDP+otCSOdwabcSFZvAiid68+yaYsooyyoUn161DSerwmR
         PGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=/M5RjQPzp+mwl5AtYvNUPyxqYUGuTmswSH9ScOWmzO8=;
        b=LAaj6kMygooRIt7RFgNpKZDKJY4T8l8490ys6v60rgD+71Qi6NIgO6mYz29DzxlfIL
         YPyZIa145f01ZQFvH/Eb6XIlPqj9jaeQgSgLQvnfG0IXJQ/86g+kE7sQtxUEZqourUQ4
         PrjH+hbNNBze90/Wi7xABy2pMGHOgbxWgyNhZx5JnmwsKaqrkAYX3R2lUjKlKL4BtYYW
         Gvx8317mVdANaqyexbydJ+DyBPH4TJZ8nfnkLYseMkofWww+trdTvnQ7SeBmJGD13oy9
         yDN50RM3eTRey/yzEj43UyQ2Jje/27Heo8k8EPBn6eNC1eKadyYIS/vFQIHWcKlcFYq3
         YXQg==
X-Gm-Message-State: ANhLgQ1/Kd2oB6Uk0jaWlZXJ+zYgfdNwbC3LPGDFDT1bFpHGzACh+o9r
        w3XkjWC46KddcPENIjmwpIsNR8xWai7T6Wt2gNs=
X-Google-Smtp-Source: ADFU+vsK7ktOfRDfIfpYU6VNd3XfPfE+kWXfyR/qxAKjS6AI2BIDOWTqzXoxtOUH91ol2VTCCV8v8tM1cDqhNRQo4+M=
X-Received: by 2002:a2e:80d1:: with SMTP id r17mr4122053ljg.292.1582924985750;
 Fri, 28 Feb 2020 13:23:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHd499DC7pOB3kD7nAG79GrufKrV-8p4vSZ5ZEPQb5gdXrNakg@mail.gmail.com>
 <CABPp-BGrwNf9p6Ayu=A4CF9ydww8tQfvzFqFO1rNm-QG55yG6w@mail.gmail.com>
 <xmqq8skmeabd.fsf@gitster-ct.c.googlers.com> <1320071582924243@iva6-ab1cb434301d.qloud-c.yandex.net>
In-Reply-To: <1320071582924243@iva6-ab1cb434301d.qloud-c.yandex.net>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 28 Feb 2020 15:22:54 -0600
X-Google-Sender-Auth: os0XfWMuUpothbnjHylmjj9-JN0
Message-ID: <CAHd499B3HbXPo+O3u3qA-SfJ_dV=z2k5v09mVHtbjXGkAaNBvQ@mail.gmail.com>
Subject: Re: Why does `pull.rebase` default to `false`?
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 3:10 PM Konstantin Tokarev <annulen@yandex.ru> wrote:
> In reality, newbies often end up doing chaotic merges caused by pull
> instead of learning about rebase and branches. IMO, it would be better
> to have pull.ff=only as a default.

You and Junio make a really good point. After reading the responses, I
definitely could reword my problem statement. The problem is that, for
newbie git users (the majority of people I work with), they just do
`git pull` which always does a merge. Myself (and many others) in
simple workflows don't like it when newbies do merges on a pull.

So the problem statement is: Prevent newbies from doing a merge commit
on pull. Whether its a rebase or not is beside the point. I think
making it --ff-only would solve the issue nicely. It forces them to
make their intention explicit: Ether do a merge pull, or a rebase
pull. But you are forcing them to pick (and ultimately get educated).
