Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2411B2047F
	for <e@80x24.org>; Thu, 27 Jul 2017 00:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbdG0APn (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 20:15:43 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35831 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdG0APm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 20:15:42 -0400
Received: by mail-pf0-f171.google.com with SMTP id h29so41655691pfd.2
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 17:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=isdQDCwM42wDBSvaya2NtOivH40Wr/mAIEiCKArX6iU=;
        b=X5KUHsI7x8SqpCQE2/VtGGnGA8Lq1m88HF7fIB4V7m9QIn8UhMZKlx7tBdgRfSRC+r
         EZati8JXlRxthT4KsT0AhlM9xyVoJETyrGoRyTyTZfxXLmrsJdjKefQv2BywOzdLHHDz
         hQhWr/p6tfJqEPSKOUo/c2//tOQpnzYSzhXTU9M5GS7i4Rsm5vb+8q8mvkz5e9x60i4U
         Y/oquW/z32JPgJiBU7Am/QlG832xLDLiNK+xGPMiDiPi0d/uJccpk1fdBB/if7T4kLgv
         FAchnwJQ44iiy8mf/21EEMIae4PvNm1Nad/RpYHQwKNhdRzBoKoCk4OqmHQDnebetcD+
         41Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=isdQDCwM42wDBSvaya2NtOivH40Wr/mAIEiCKArX6iU=;
        b=RaqHWxkhC7pnuCnTQsmSNDUL0Dxl+jiqxaC7KYrh3mZWogK0s7X4rFQz4kyliBWXue
         htrdLLIIS36eeMmZCoINz0mKRdBS87Xx9sroVUyKP27D1BXFl2NFPzSjY2oXUqw10Uhy
         SjI/6W9L97LkLDugh2xQpHCmpi1jnZgZymCVczt/1k9BGTbJ4JDhtpvaoUbQe+ejZvcK
         eBw6IAPRYK90IEIcIdF03D/Vp+9T9auuQFvCtMg3QcHkEfuKfnVCJ6QPmDC3eddYxuLP
         64EIODwMk+i86fjAx5PDWDyGWI+GwnmgwE2FMEx41hkLJHfi1VMePDGBpkS8HPc5DTrL
         Pvww==
X-Gm-Message-State: AIVw1135OIns+eP1lKS6Tp/hp8w4/6UAsKVBx0dKkd9ezWKpb4iu2dbe
        pSztfbeSWk6nUgkBfW6mg1C5wXY6mEpu
X-Received: by 10.99.184.2 with SMTP id p2mr2493283pge.194.1501114541660; Wed,
 26 Jul 2017 17:15:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Wed, 26 Jul 2017 17:15:41 -0700 (PDT)
In-Reply-To: <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
References: <20170720232040.GA159617@aiede.mtv.corp.google.com> <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Jul 2017 17:15:41 -0700
Message-ID: <CAGZ79ka+BDqSpQtMPhFjuJrGb+eT=oPNeMEhFavg43TbPVerbw@mail.gmail.com>
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a symlink
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2017 at 4:39 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> One of the tricks that `contrib/workdir/git-new-workdir` plays is to
> making `packed-refs` in the new workdir a symlink to the `packed-refs`
> file in the original repository. Before
> 42dfa7ecef ("commit_packed_refs(): use a staging file separate from
> the lockfile", 2017-06-23), a lockfile was used as the staging file,
> and because the `LOCK_NO_DEREF` was not used, the pointed-to file was
> locked and modified.
>
> But after that commit, the staging file was created using a tempfile,
> with the end result that rewriting the `packed-refs` file in the
> workdir overwrote the symlink rather than the original `packed-refs`
> file.
>
> Change `commit_packed_refs()` to use `get_locked_file_path()` to find
> the path of the file that it should overwrite. Since that path was
> properly resolved when the lockfile was created, this restores the
> pre-42dfa7ecef behavior.
>
> Also add a test case to document this use case and prevent a
> regression like this from recurring.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> Sorry for the slow response; I've been traveling and very busy.
>
> I didn't even know that a symlinked `packed-refs` file is a thing. The
> attached patch should fix the problem. It applies on top of v3 of
> mh/packed-ref-store [1] (which is already in next).

Thanks for providing a fix.
Code looks good to me, I wonder if the test needs SYMLINKS
special treatment though?

Stefan
