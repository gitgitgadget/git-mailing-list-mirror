Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D27A1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 14:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbdBNOwq (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 09:52:46 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36786 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbdBNOwn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 09:52:43 -0500
Received: by mail-lf0-f49.google.com with SMTP id z134so67459112lff.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 06:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qM/2miixGC32EtpPMMPhwP44lEtQrCX7L9EPuhi1TG8=;
        b=JfZksv7lfwFuQfvDAk6n4tSUyEPI0jh5uORx9y6pLG8kFgNyO4nSFf+kScFFpncxi/
         4KvkuqCqw7a4tD7sF/qvInj0An4VusKFz4PmDoSy5Ax+4Tu6AWlH90vyLPwiIj7lVI/o
         dAhSCv82tdFNib/k/+C3DMHcmXfVCw9dwTN+uER11oeBZLtg8uT4nE2vfStXF9qfVEy6
         MZHKq45jI1sE8ln/lJji40nLNp6GJniQdyGIp/Jo9wXVck8NPrydxmxpAiNSdZXMdL5b
         uXnqn3Q4Qx+gyCij+ml6zXjtc5VsDSxmpdqQY3w6oo6seZCw8sK52n554LcHXP4y3NPj
         svVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qM/2miixGC32EtpPMMPhwP44lEtQrCX7L9EPuhi1TG8=;
        b=h8EMO4sou2ytt/vq+XFqY4jc3GvZKsEYScSZVt3FJ1jYHFNRmofdRH3jpUF3/Z8xkM
         I72Nr907nKXXlpMoFoc6X53KwfbyPc8yTBwXOSOdj5gqgNdy9Gma7vgu4MXQUK2qi2ea
         +37IzJk0nMDtZaylbQfXTM9lhyWhTSMXzl1GPSxqZSTY8OkNjU7dn5Ub56C5Ijc2li4l
         YBXf/Rqqv41UyClYFw3FXXsszTDbOb9/9bM9QRvHEUaq/aUYdUzNL1zEi+bPsPDxiul+
         yLKV5Sptji/rLa+jm2mgcsCJ/8pigBwLQk0GrC6DFWI3IzuN3Bf2GSv2B8f7z+m2ctcv
         tcRQ==
X-Gm-Message-State: AMke39nkjO9n0iTm1z2ogRkYgOABkt82IRfKZWyMrwOwCLMc1qI4mvZPsYoLX1GUwwRcqW68aTGia64bLIV7Zw==
X-Received: by 10.25.225.141 with SMTP id l13mr6474907lfk.129.1487083961217;
 Tue, 14 Feb 2017 06:52:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Tue, 14 Feb 2017 06:52:40 -0800 (PST)
In-Reply-To: <A7AEC719-6E15-4622-8E21-3E11BAF74A3C@linaro.org>
References: <A7AEC719-6E15-4622-8E21-3E11BAF74A3C@linaro.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 14 Feb 2017 15:52:40 +0100
Message-ID: <CAP8UFD12tQmWRV29BLO+KJGcGHXOqPaOLbovL7kTBHPWdyMM3g@mail.gmail.com>
Subject: Re: [BUG] Memory corruption crash with "git bisect start"
To:     Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 12:56 PM, Maxim Kuvyrkov
<maxim.kuvyrkov@linaro.org> wrote:
> I'm seeing the following memory corruption crash on a script-constructed repo when starting git bisect.  I'm seeing this crash both with system git of Ubuntu Xenial and with freshly-compiled git master from the official repo.
>
> The log of the crash is attached.

Yeah, thanks for the report.

I took a look and it looks like git bisect crashes when it runs git
show-branch and it can be reproduced with just `git show-branch
bottom` instead of `git bisect start bottom top`.

> It is possible that the bug is in Xenial glibc, in which case -- please let me know and I will take it up with the glibc developers.

I have Ubuntu GLIBC 2.23-0ubuntu5 and I get a crash too.
