Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1356C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 23:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbhLUXoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 18:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbhLUXoD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 18:44:03 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE92FC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:44:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id bm14so1426465edb.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOlTTnfrRpevw6YNugH9bgryjeoTS2eQY3CezeUli4k=;
        b=X64bP0mboTytWShpvrBvBEQZCUqTx9FhjvKBPvAyy0YjP/sCOJYU5h870yoKKGnTd4
         vHCJPJqF9JdSdSnJNG3eQHnmoIvRDczfJrc5KAfLiZ7T/+EcSu2lkPxfErvEd7cyqkp2
         LUHCO72qajdXdK5pFlo9gzKmVCdbWuf8bLtEbsO+KfShM8IyusT9py1Tsd4DyYnFj9Td
         FDB0Ypy5ZhtmWIlsv3rXuE0i3ACGBN9R3Jpzpr1r3BAdUBo4u1WBix9Gzn+0PxRFS0Fs
         b8cemZAox7klsaNOGXCZEoUDzG6Yo+FpQ5Cw5Da/DCDc2OiUzFaPVOdVapxwy51woEoZ
         Ux6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOlTTnfrRpevw6YNugH9bgryjeoTS2eQY3CezeUli4k=;
        b=rFiNASz1mFRsRLBcuvMOl4EDNliR3a54GEKjtBweXN5wc+r1Hsu7YrIBxPM+C/MXHS
         4VwY0MHIT2H6ttrjWWYgOImk6CKIoXxlZsS9+hDTvbM10xg7svojxwmiN0PTD3ZdXdXW
         YReKh5aJavBuu0elxCa0hFGTwTOJaDLJHx5TBHOAZ1CFe1riBL77UuifjFNi1PrAhhIp
         99nzoxott4cQiV3qiayGsWL2mNtTOLZLEhgUZTg5Oe3Zh4afiXFvHLPxwp85vIUTBnQS
         ylk1Lev7sjQddZ4G8uPhCOF2laJmzo3KSHbNAG2XDlhMEAbooToRcHeyXTgVS62R5aCz
         or3w==
X-Gm-Message-State: AOAM530/TTXYyUGxRSJQZUIVxJWq5RMhaWPFxhlbsfqUXfu2MQSVrzvf
        59ZG/uoY7AP37IwIEgEO6w0EHmmXXfvgQwuc5l4=
X-Google-Smtp-Source: ABdhPJwaTj7bwIEyCnn+++7JbkCrr5R/XUlh2T6ELzxMeLt2cp4V2/oINwNfp22Vy56y87bGc48ZEZ042+Q5MTIMNx8=
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr500877ejc.100.1640130241475;
 Tue, 21 Dec 2021 15:44:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com> <xmqqsfulo88n.fsf@gitster.g>
In-Reply-To: <xmqqsfulo88n.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Dec 2021 15:43:50 -0800
Message-ID: <CABPp-BFoOzQ7Er4BUKUj0mqHkAO0ePCdaFhiv4i10oURZi=Rvg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add a new --remerge-diff capability to show & log
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 3:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Here are some patches to add a --remerge-diff capability to show & log,
> > which works by comparing merge commits to an automatic remerge (note that
> > the automatic remerge tree can contain files with conflict markers).
> >
> > Changes since original submission[1]:
> >
> >  * Rebased on top of the version of ns/tmp-objdir that Neeraj submitted
> >    (Neeraj's patches were based on v2.34, but ns/tmp-objdir got applied on
> >    an old commit and does not even build because of that).
>
> Oh, that's bad.  I wish people do not rebase their updates on top of
> newer 'master' only for the sake of it, once an older version is
> queued.
>
> >  * Modify ll-merge API to return a status, instead of printing "Cannot merge
> >    binary files" on stdout[2] (as suggested by Peff)
>
> I wondered if we want to do the same for other error messages to
> give callers greater control, but this change by itself already
> looks quite good.
>
> >  * Make conflict messages and other such warnings into diff headers of the
> >    subsequent remerge-diff rather than appearing in the diff as file content
> >    of some funny looking filenames (as suggested by Peff[3] and Junio[4])
>
> OK.
>
> >  * Sergey ack'ed the diff-merges.c portion of the patches, but that wasn't
> >    limited to one patch so not sure where to record that ack.
>
> On that single patch?

Yeah, the main patch near the end that changed 4 files; he acked the
changes to just one of those files in that patch.
