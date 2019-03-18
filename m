Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3493020248
	for <e@80x24.org>; Mon, 18 Mar 2019 15:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfCRPk5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 11:40:57 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44458 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfCRPk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 11:40:57 -0400
Received: by mail-vs1-f65.google.com with SMTP id b8so9730306vsq.11
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ae57Xom0BqPstoNnallqvQWtTVmBQf5L0BiZsaphI8E=;
        b=DqaihTfHkNxw1CJ/hHeh7qFG6y9DO95mY763N13NdC+qLRFqDPvV2fQrXwwIfpkG5Z
         P9BlTl+/5TBmxbGIQvmq4+DzCAbrJDlbyVit19/VsV4tE1ecl64YOuuPoKk0qDVEVDPa
         NKW27nHV0R3alB3AEoOP8E7F1yuAgsJ0vK01fnxs51rbzNSGi/IJLm2ynsP2JNA+f8Io
         ydm7hL5b94D9803g4LNs+JHiVCeCZklKyp1qPApmtpSdHCkuBvm01e7mXgjFDm8cR6+C
         DoyVoZ877/3lqaq9Z3v2/F/xkYtnSWgj4oYR34Ufls+W/zwGcS4ypIwv5t1PxRGjbcr2
         /khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ae57Xom0BqPstoNnallqvQWtTVmBQf5L0BiZsaphI8E=;
        b=Dg+U4AEeavY/qt/BpWEDjgsQm34MPkAPXp90qcgYSmyy+CCEJE/ELStkqDcIALVPnO
         Yf2d8OTBfk1+4Y+8nFmr6jD2gEDhOrhH98VhpGhTvkHZBUxljJ5/4rOvs3hKZNALRgOh
         6aB2WA1NcPO6n8VMpWkJUadA0XxQckPbFkdpnt+V54XwUJCUgLLkTN9ZXaGLt2mgDO7E
         vW8kRNGczfygKNhyyZcil7pLPBS4sA98AZWTlR8xaMAuzjr0jvz640AfL7p4jWWa1Mgl
         feTk3vlziZ8aUYP4M7YW9xWPMYbhmNDWoPQnkaes6qLeMR0jonIzEXfrszIanqHFawdf
         FzJA==
X-Gm-Message-State: APjAAAUHkzit357ZtHyRozFq3Pet1UP/2fiuBt05HVj+2RSw+xDMPtti
        TeBRkibWg/pHUTi5ZSea4MbJ3FDwMe4AJconbok=
X-Google-Smtp-Source: APXvYqxUYi/2TxPTZYIGr3Sd8DqOgxRv+syyfdj0yj5ywRcVj/jarSWDsYMi/120PHiFeykvvBsOhRgn0qzPFBByhsY=
X-Received: by 2002:a67:f8cc:: with SMTP id c12mr9192674vsp.136.1552923655612;
 Mon, 18 Mar 2019 08:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190317060023.3651-1-pclouds@gmail.com> <20190318113822.6195-1-pclouds@gmail.com>
In-Reply-To: <20190318113822.6195-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Mar 2019 08:40:43 -0700
Message-ID: <CABPp-BFDy4ppUqmC_J_hx4kFWaC+otBZ=mbuaJK13Wxzcz_urQ@mail.gmail.com>
Subject: Re: [PATCH v2] unpack-trees: fix oneway_merge accidentally carry over
 stage index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 4:38 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> Phillip found out that 'git checkout -f <branch>' does not restore
> conflict/unmerged files correctly. All tracked files should be taken
> from <branch> and all non-zero stages removed. Most of this is true,
> except that the final file could be in stage one instead of zero.
>
> "checkout -f" (among other commands) does this with one-way merge, which
> is supposed to take stat info from the index and everything else from
> the given tree. The add_entry(.., old, ...) call in oneway_merge()
> though will keep stage index from the index.
>
> This is normally not a problem if the entry from the index is
> normal (stage #0). But if there is a conflict, stage #0 does not exist
> and we'll get stage #1 entry as "old" variable, which gets recorded in
> the final index. Fix it by clearing stage mask.
>
> This bug probably comes from b5b425074e (git-read-tree: make one-way
> merge also honor the "update" flag, 2005-06-07). Before this commit, we
> may create the final ("dst") index entry from the one in index, but we
> do clear CE_STAGEMASK.
>
> I briefly checked two- and three-way merge functions. I think we don't
> have the same problem in those.
>
> Reported-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

This is awesome; thanks for tracking it down and fixing.
