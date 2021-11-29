Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B8BC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 07:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhK2HKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 02:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhK2HIK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 02:08:10 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6F7C061785
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 23:02:00 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f18so41920636lfv.6
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 23:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iKKHpncn0tzGshnEHaR7Ecx7KqAwXEBWX70v5OfdYA0=;
        b=UgNnWKDLSIVFTW6WaY8CY+1HFghXtqxMLYHFh5hPFyv7IpyPctJma0wGvgYEjNENgQ
         fsKU52P/pWDcE3M5AMOt8QP2+ug+cTUU0/iCMukJHIgxygEMqxbRu9ewTnhYHL6uz06w
         4sQg9SSuSOc8+Zv577vq8AxY4jUrFPmKH/QGs0NXibo7hfkpTR/MPobIDK8epyIkAYTf
         +Ca7CLi3NTIb9bthzLnIkT7LnWvSCWj4hfri2ETaVMtr8O1l/1Pu15hM0S+l+tPNR2rc
         WHnMsyM1P18j87r0geiDfPIJz5bnYSUX5Z90b08POPp12bmMJUTATeMz2racU1Vipz38
         A5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iKKHpncn0tzGshnEHaR7Ecx7KqAwXEBWX70v5OfdYA0=;
        b=nN9iYCrVgoDCxoTXfosBtoaeYFlYL1pbK7aMmvxgTpwkw9OzkoiM+Nh2390Ri5UEBq
         VItX8m9qzGRpAXhFzcXq0dspTERIsgQFIZC6sqZ7sGRXhpoOs+Yvunw4pCw9bF3L9Sl2
         60HdPi3Qk70douKeNntEGZwnQdvJbcbBymbPxroaEogSatYfj/XRpGkvojZD7K+/7Xdh
         WkjCLtywNhsiL/gHrRA+RW0zQAW65k//kySFnkehgeg5Rqdv/BM55HDV0JQ/6mwsmn6d
         8PHf2dDJdBhppSzyk6zC6rDAS8he1owLyzvJaM9GgZLYhNuUkxsVZNBxybEsB/m7r94F
         2yrg==
X-Gm-Message-State: AOAM530Em6ulNwxVuz8XIj6BCKLqKy1HXchyVJcdKUcfnL8e/bdt52TZ
        0qlSsBJdr9UhCO42SU9rrDTwIfRZBSyDk66U0ofKOhfReg6FQJ7B
X-Google-Smtp-Source: ABdhPJy1A4WSD3NuW06fsiJNTgnzqfJPlRgEwoYZmYQ8q1rliCcQAPM/KI0ho6i33Jj8qCqNxAc2ZQBuAjZaP6mqgmI=
X-Received: by 2002:a05:6512:168b:: with SMTP id bu11mr7463840lfb.401.1638169318500;
 Sun, 28 Nov 2021 23:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <20211122033220.32883-1-chiyutianyi@gmail.com>
In-Reply-To: <20211122033220.32883-1-chiyutianyi@gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Mon, 29 Nov 2021 15:01:47 +0800
Message-ID: <CAO0brD3VPtUrpCE2kCJDram=bLMN=89++=bgf1TddriTYo-nsA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] unpack large objects in stream
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:
>
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> Although we do not recommend users push large binary files to the git rep=
ositories,
> it's difficult to prevent them from doing so. Once, we found a problem wi=
th a surge
> in memory usage on the server. The source of the problem is that a user s=
ubmitted
> a single object with a size of 15GB. Once someone initiates a git push, t=
he git
> process will immediately allocate 15G of memory, resulting in an OOM risk=
.
>
> Through further analysis, we found that when we execute git unpack-object=
s, in
> unpack_non_delta_entry(), "void *buf =3D get_data(size);" will directly a=
llocate
> memory equal to the size of the object. This is quite a scary thing, beca=
use the
> pre-receive hook has not been executed at this time, and we cannot avoid =
this by hooks.
>
> I got inspiration from the deflate process of zlib, maybe it would be a g=
ood idea
> to change unpack-objects to stream deflate.
>

Hi, Jeff.

I hope you can share with me how Github solves this problem.

As you said in your reply at=EF=BC=9A
https://lore.kernel.org/git/YVaw6agcPNclhws8@coredump.intra.peff.net/
"we don't have a match in unpack-objects, but we always run index-pack
on incoming packs".

In the original implementation of "index-pack", for objects larger than
big_file_threshold, "fixed_buf" with a size of 8192 will be used to
complete the calculation of "oid".

I tried the implementation in jk/no-more-unpack-objects, as you noted:
  /* XXX This will expand too-large objects! */
  if (!data)
  data =3D new_data =3D get_data_from_pack(obj_entry);
If the conditions of --unpack are given, there will be risks here.
When I create an object larger than 1GB and execute index-pack, the
result is as follows:
  $GIT_ALLOC_LIMIT=3D1024m git index-pack --unpack --stdin <large.pack
  fatal: attempting to allocate 1228800001 over limit 1073741824

Looking forward to your reply.
