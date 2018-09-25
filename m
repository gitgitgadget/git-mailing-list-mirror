Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642F41F453
	for <e@80x24.org>; Tue, 25 Sep 2018 05:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeIYLXK (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 07:23:10 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:35957 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeIYLXK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 07:23:10 -0400
Received: by mail-qk1-f171.google.com with SMTP id a85-v6so861722qkg.3
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 22:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJ2lQMbgy1C46bQWvN+n+1GZXLkz5E5fgg9mSAPeQK4=;
        b=jeDQcmCj5YcrZYUZbg1D6EcmG4xLPxxmSsZwEC4N4GZWyuZvB+jCopzydWgh0lnd4f
         shuoJjWrCONWY8qwR3a314zxu10nqCI+xiS/fZQ1NGJw1GIcGqJDB/wx+bR61aN7x23d
         BC1G7bR8RBovAhIHkcRIGQKH9HrvVFLuIDzsWt97poDsTYvzoVQ06VD2jb09glc/em1/
         CynfBuivCVe5T1CQkuy1cR0PmwzphJ8uZkCLJdYfgDFwYgrt1ytQGCUioUfJ0XnlMIRa
         U5dAmBKfoRovJmRP5RyVrsJOvP8ycyDrzOMROw6crdftC0iCOL03XbEFip7n9rQ4oEl3
         r21A==
X-Gm-Message-State: ABuFfojkm/ISDJZlB/NIaG/2oDbxjBFFI3hITxr+rxgNJDvnFHXu9fkG
        rRc/4HzUfMowXgwtJ4QcIDyhtcozyRLlm8yHRbM=
X-Google-Smtp-Source: ACcGV6380C6u+cG6P7jUKwwYIrQuOy9wcwMWoIwFyfAQhap2j13g705u+Fj33+FEfIaFagLCvSsEK3e+NfJMd0+WIiU=
X-Received: by 2002:a37:d78e:: with SMTP id t14-v6mr1370035qkt.220.1537852644079;
 Mon, 24 Sep 2018 22:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.39.v3.git.gitgitgadget@gmail.com> <pull.39.v4.git.gitgitgadget@gmail.com>
 <a0a3cf01343381281554d0e175b2f4ec5fbe0abb.1537822669.git.gitgitgadget@gmail.com>
In-Reply-To: <a0a3cf01343381281554d0e175b2f4ec5fbe0abb.1537822669.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 25 Sep 2018 01:17:12 -0400
Message-ID: <CAPig+cTT9cpDPyWugg8WNmCdA7OhEOxVxTxD3FRhpf7Sgdg-zA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] commit-reach: properly peel tags and clear flags
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 4:58 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/commit-reach.c b/commit-reach.c
> @@ -544,20 +544,42 @@ int can_all_from_reach_with_flag(struct object_array *from,
>  {
> +               from_one = deref_tag(the_repository, from_one,
> +                                    "a from object", 0);
> +               if (!from_one || from_one->type != OBJ_COMMIT) {
> +                       /* no way to tell if this is reachable by
> +                        * looking at the ancestry chain alone, so
> +                        * leave a note to ourselves not to worry about
> +                        * this object anymore.
> +                        */

Style nit:

    /*
     * Multi-line comment
     * formatting.
     */
