Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42A11FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdBMXNa (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:13:30 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:37799 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbdBMXN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:13:29 -0500
Received: by mail-it0-f49.google.com with SMTP id x75so8129648itb.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 15:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bb0ZC+3wO5KZKfWXAFuRPMi8yxbuVMAnuRPx0SL3Wio=;
        b=iLtMV46XUavn6SCa/BsbHvV8p2TsohutslyzWkrsZgaNsDgQkX2Zlik2It8eUKaMf1
         JO493KkMimYupXPbnw0hnHeLUCC0PDAAdLJN5lh+1OyxzqP5QP2gD70GLt3P1AttY3PJ
         Fpz3M5flGKbUnyqIeYnzDcYqyN0zBs6M/xjZC6lpMsQtKB61dfTBoRgLu08jusghIr8s
         9YMRSvBmJr66S9umoeGgpy5q7Edg7Kz2cqQqeC415XPyvKr3KcgQXih/QXEYfUjyZ7t9
         5KN5C7rqvauldBrwc/hQPDlhEJggyMoNN+SQZP5puE4r4t3x7nFEDnDpAi+3cFpwni5s
         3i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bb0ZC+3wO5KZKfWXAFuRPMi8yxbuVMAnuRPx0SL3Wio=;
        b=V31V4+wkrO9AeXF403EG5xskCASJL+qhW428+ur3A7/bAQfECtqcPeCoaQO6WqmMLJ
         nksUIpg3ISpYBeTuz2WXCxV6HYK6DZgd1vwesKIzU2Yz76P3Xeii0touLWZM8fqO/xt6
         sztvpOOqphbGJR7VD4qax1Oocsfw898MvxCZY/oFQ6GnH/o4nfWmxX2ATy2dk2pL7uZ8
         nKNoVTdClgMZd0EtxsyoBTzPNM9R7zhfb8BbkZSobNhWEm38F0tjCxdp7YDYvjD/eR6D
         rkRWPyI/kFbLAmcffgZpkCXLimr4VMdMrSSHP7xPycdIu4XTE3CJRKu7I2c/2BeOPvGu
         C5Vw==
X-Gm-Message-State: AMke39kNzIR1bn8GrpjwRakQc7uRhnKI2S4vfIJgfh2d5PaBbzKvguOIPLkiKNxhlSJYYrPcH0yVt6eLmsVtP7b1
X-Received: by 10.36.34.79 with SMTP id o76mr822848ito.116.1487027608213; Mon,
 13 Feb 2017 15:13:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Mon, 13 Feb 2017 15:13:27 -0800 (PST)
In-Reply-To: <20170213152011.12050-9-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-9-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Feb 2017 15:13:27 -0800
Message-ID: <CAGZ79kb+upRpmzjwKkUCBad4JvVsjQGRt_uRsd6XhdizMGkqtg@mail.gmail.com>
Subject: Re: [PATCH 08/11] refs.c: factor submodule code out of get_ref_store()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 7:20 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This code is going to be expanded a bit soon. Keep it out for
> better readability later.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---

Looks good,
Thanks,
Stefan
