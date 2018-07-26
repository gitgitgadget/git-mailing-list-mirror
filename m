Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B0D1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 09:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeGZKhg (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 06:37:36 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:46775 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeGZKhg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 06:37:36 -0400
Received: by mail-yb0-f194.google.com with SMTP id c3-v6so368654ybi.13
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 02:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6WvZAIWC9pgk4Yb7mppVoFTGgjHST+P5Vb1n1E542E=;
        b=f6wZ+LK4gjSnL37sUzaqG+IomGXfRjmgN0eFUpiGAIgcdWlBP3P8GA8iWUENK+JjWj
         8DdmMlGSaxJOtymsYsUH14HgAmP6DbZIl2ztezSOgKX+nRgqbqJJA+K2vq4wV2XR1ttW
         QKLCoTFoKRjgFhyEquLw4y4tN9q+jOlOmjCkCsxmiIzqJxvFmgNNJSC66EzHlwIQlGrg
         QR4ljS9kUTEfEd3pA2PASsUfoK8etTuA7HETVX0HeEKeVAgrF5ns8fCoOiTSYDYhQqH3
         3qLyzs2DB2ozQIqBJQ+aGhCOVvgSu5N6b1TxkAoTeb4Pm1W059+k7GVBK2BupIQNFLIS
         e81w==
X-Gm-Message-State: AOUpUlHCOHq3EBu40LhESU2jD6AeglRzg4MoAwDPUkv1ytV0GS9aHqhG
        XhDLl2yLYG3L5Imj0PGKitHmZucjGUVFM8pOS0k=
X-Google-Smtp-Source: AAOMgpdTSLbSdOL2nEWTuUlxNaYAqKuKNYdSwh+OwOpFMH3+MafPFdpuEAEoVOsrreMA99+6L+LBwGzgkrkRAF1BKdo=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr513112ybq.295.1532596899439;
 Thu, 26 Jul 2018 02:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
 <20180725134345.8631-1-chenbin.sh@gmail.com> <CAPig+cR2gYEwOTVBMRde35rn9oVsixeerbm5iJV+FmnOiBWxqQ@mail.gmail.com>
 <CAAE-R+_BWJAB3zsZUZ+=Zn6SiSkzrWG0EYwBF_OcX_V+2idCww@mail.gmail.com>
In-Reply-To: <CAAE-R+_BWJAB3zsZUZ+=Zn6SiSkzrWG0EYwBF_OcX_V+2idCww@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Jul 2018 05:21:28 -0400
Message-ID: <CAPig+cQ80DrYJjYgJEvfcpeNEscgNBvj7ydwxMMVRf6kBfpaqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] add hook pre-p4-submit
To:     bin chen <chenbin.sh@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 10:08 PM chen bin <chenbin.sh@gmail.com> wrote:
> The hook does not receive any information or input from git. The
> original requirement
> comes from my colleague. He want to run unit test automatically before
> submitting code
> to remote repository. Or else CI server will send the blame mail to the manager.

Okay, that seems in line with a hook such as pre-commit. Please do
update the documentation to mention that the hook takes no arguments
and nothing on standard input, and perhaps describe in the
documentation an example use-case (as you did here).

I'm not a p4 or git-p4 user, but, out of curiosity, would there be any
information which could be supplied to the hook as arguments or
standard input (or both) which would help the hook author implement
the hook more easily? Perhaps such information would be fodder for a
future enhancement (not necessarily needed for this patch).

> The hook actually stops the submit process from start instead of abort
> submit in midway.
> So nothing is touched when hook exits with status 1.

This might be a good thing to add to the documentation, as well.

> I'm not sure whether `git-p4` should print some "hook rejection" message.
> Current implementation is same as other hooks (`pre-commit`, for example).
> Only hook itself is responsible to print error messages.
>
> Personally I don't have opinion whether we should print out hook
> related message inside
> `git-p4.py`. I just try to following existing convention of git.
>
> What you guys think?

Following existing practice makes sense. It can always be revisited
later if needed.

Thanks.
