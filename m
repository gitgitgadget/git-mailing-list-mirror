Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD771F404
	for <e@80x24.org>; Fri, 20 Apr 2018 15:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755734AbeDTPXl (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 11:23:41 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45920 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755643AbeDTPXk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 11:23:40 -0400
Received: by mail-ua0-f196.google.com with SMTP id j18so5935890uae.12
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BQ6YL9Snb64059zUU3uru6KpSqiSNpd2eCU4EvlGC18=;
        b=lRQ8Oz/iJgms1lpInMOh48B9EWaY5fQwEd7npLB2LO5FTU2EV7xgc76SWGgIMOh51q
         WKiR2t114FW2AlNsrYdhY+zlXRf2IDdeqIhxXixHzBCTLq1nKOKIfwyJ1sV2WRSCgshp
         bSAs8eKNKdxf1qPXm62TTUfjKtiyund3t0TocUO93sdwbI7397jgzOVPmsTvDMY/+II8
         FKpDFs54kgFBBv13Dn1fk0eGdrjJ51iCreT+ypvG51GQNhjT0SMF2J+Xcbg4eFqyW7nV
         8JZEWHLfqJJGEu5nE9PBUutqqczWaM3CRPQEn/IJbfi5XwHrnclQzwEcLk9i5ydn0VU9
         iv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BQ6YL9Snb64059zUU3uru6KpSqiSNpd2eCU4EvlGC18=;
        b=T38QvVPI3Szn9Mrsl/HRdUAxmbQf4QlEDIFXrluFZnbybVlS7sEMKQFqbhcD0kBEcC
         0NFB9/XuVJHdNI4LoaOw9bFX2UDfPJ/w1ZMgmb9s3NlgYXjmZJcwhNpphgE/R6QNGZvf
         Eqf+uwWxteVJl4Ez7Yup9AURMFN9TzoYo9IcuP7Dk+XY/iDcliYDO+ziMbCccC9P7F+2
         JjJfoTa2Qc3cDjrUwFqojWwPxHuSMtkBoAiVjst2+1xZt1EGl82V8rWjDYrrANe2jRej
         M+1HQpuxeux9AptJvTx5lgDoBkG3LJ/V8LyyoLzTzf2GbCHxEC7Vnc02CCB2M+JIqG5s
         8O1w==
X-Gm-Message-State: ALQs6tB0FnjfOhOQKrLijbg3BRSGvMEa2P/Ze1lsoMDHcw6uQSb2ZTci
        qn+Rq2oSLK68zUzu3FzPewSm96daymtrPGKqXmM=
X-Google-Smtp-Source: AIpwx4/1qprtONx3iCyQfKxZguwjoYvsdGdgL3KPKhiTZFOn9s0n+N3QnK/Pn+g90pk3dYlmxtl7VzpDuDR+SkK9hxM=
X-Received: by 10.176.83.38 with SMTP id x35mr7588430uax.29.1524237819576;
 Fri, 20 Apr 2018 08:23:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 20 Apr 2018 08:23:39 -0700 (PDT)
In-Reply-To: <20180420122355.21416-1-szeder.dev@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-34-newren@gmail.com>
 <20180420122355.21416-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Apr 2018 08:23:39 -0700
Message-ID: <CABPp-BHZ-agTY77iqe9BxLC2ijrcKO+UPk83Bn+0cckA3fJFYg@mail.gmail.com>
Subject: Re: [PATCH v10 33/36] merge-recursive: fix was_tracked() to quit
 lying with some renamed paths
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 5:23 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> This patch causes memory corruption when the split index feature is in
> use, making several tests fail.  Now, while the split index feature
> sure has its own set of problems, AFAIK those are not that bad to
> cause memory corruption, they "only" tend to cause transient test
> failures due to a variant of the classic racy git issue [1].
>
> Here is a test failure:
>
>   $ GIT_TEST_SPLIT_INDEX=3DDareISayYes ./t3030-merge-recursive.sh

Running under valgrind shows that merge-recursive.c's add_cacheinfo
(which calls add_cache_entry()) results in data used by o->orig_index
getting free()'d.  That means that anything trying to use that memory
(whether a later call to discard_index, or just a call to was_dirty()
or was_tracked()) will be access'ing free'd memory.  (The exact same
tests run valgrind clean when GIT_TEST_SPLIT_INDEX is not turned on.)

The fact that add_cacheinfo() frees data used by o->orig_index
surprises me.  add_cacheinfo is only supposed to modify the_index.
Are o->orig_index and the_index sharing data somehow?  Did I do
something wrong or incomplete for the split index case when swapping
indexes?  My swapping logic, as shown in this patch was:

    /*
     * Update the_index to match the new results, AFTER saving a copy
     * in o->orig_index.  Update src_index to point to the saved copy.
     * (verify_uptodate() checks src_index, and the original index is
     * the one that had the necessary modification timestamps.)
     */
    o->orig_index =3D the_index;
    the_index =3D tmp_index;
    o->unpack_opts.src_index =3D &o->orig_index;

Do I need to do more?
