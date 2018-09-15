Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D6351F404
	for <e@80x24.org>; Sat, 15 Sep 2018 11:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeIOQss (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 12:48:48 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50266 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIOQss (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 12:48:48 -0400
Received: by mail-it0-f67.google.com with SMTP id j81-v6so5850478ite.0
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 04:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Apbwr6x7eQ6dwssHO830OpEZAua/rWzYjj3wH4WWfjk=;
        b=HX8x1ijSTHcFoplbasPFQ+7fGXFX3cDtADbJ38WxlgV1MZFrWL4Jg9sobIHT9nng2i
         yAv+yJODJ92JCa+BEkrvmjUFHTq9z0vFla+dKYcOyT2dGyyweD/GTDnToPTvr6mh88H8
         NTBUMtwtYupAetasVSBi1RUN63MoaSR57dShM2nimuyW4MY1y3uIK8PfyJWPVYiDRtvD
         OSahXNJ+YHzg65wkij1OQ35rEfURo6A2sl9B7MxkiF/hCLVpUtN9D3RPteosagSTTWEo
         gzOEPRFrWQ5g9vur6UqCQc7pyGF6T7fj6WLr6WhQKKmUoPQLuZd7lec6VGiMIY/rF2Vw
         UWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Apbwr6x7eQ6dwssHO830OpEZAua/rWzYjj3wH4WWfjk=;
        b=sfL/KWqG5/yS9YGTzleQOeKKb9EHysrZwA5ARbr47Q+xnWw5cRdI/zi50317Lwbb4d
         SmP+wMpbNbYr2E9GwhGBhx/r1K0m8UQHjG3+mol3Ung+RqDq64urS990GprkuAf68rbv
         pMzWKEdgj9B1Mm6r7+0kvU6tqtIE00pt7PV4hbjj4Wl9y02nPqGqIiJEhsfNSkR7VqB/
         ABV3xHUYVZhjiNhkFsrrO6N7W/KuPDBJVSHD2caEIUU+LqMNgme31WBfb/hlf7rafVgI
         yRXCVvHRjwmNQPkl7mf1gZ6LTel4f+JnqzNmQr/mr9iqAizYEyTLvgaIwUjBCTeKmD0m
         SwKw==
X-Gm-Message-State: APzg51CtJwRuhAUzT3griC9ko7GZzMTntAunnhqWslnof75ClDoUKq3D
        PD6k9M3894J4+NsVFD3+USsegNxBy9pZFSsvqZM=
X-Google-Smtp-Source: ANB0VdY6eDLAzupAVwDSNP66Xi3Ub+5UeRhinhpTMP6YuyZlnQHRFliCWBRBdBj+C6VxLm61+KjxvwlVOF7SdhdYgXU=
X-Received: by 2002:a24:d583:: with SMTP id a125-v6mr5937492itg.91.1537011008046;
 Sat, 15 Sep 2018 04:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com> <20180912161832.55324-4-benpeart@microsoft.com>
In-Reply-To: <20180912161832.55324-4-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 15 Sep 2018 13:29:41 +0200
Message-ID: <CACsJy8AhNQhFa1ONsmnLOjznbZss2=L=xCPD5fa2vdHw79x0ag@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] read-cache: load cache entries on worker threads
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 6:18 PM Ben Peart <benpeart@microsoft.com> wrote:
>  #ifndef NO_PTHREADS
>         nr_threads = git_config_get_index_threads();
> -       if (!nr_threads)
> -               nr_threads = online_cpus();
> +       if (!nr_threads) {
> +               cpus = online_cpus();
> +               nr_threads = istate->cache_nr / THREAD_COST;
> +               if (nr_threads > cpus)
> +                       nr_threads = cpus;

It seems like overcommitting cpu does reduce time. With this patch
(and a 4 core system), I got

$ test-tool read-cache 100
real    0m36.270s
user    0m54.193s
sys     0m17.346s

if I force nr_threads to 9 (even though cpus is 4)

$ test-tool read-cache 100
real    0m33.592s
user    1m4.230s
sys     0m18.380s

Even though we use more cpus, real time is shorter. I guess these
threads still sleep a bit due to I/O and having more threads than
cores will utilize those idle cycles.
--
Duy
