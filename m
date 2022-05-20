Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF02C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348329AbiETTFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345410AbiETTFv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:05:51 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F10325E
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:05:44 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m1so7828949qkn.10
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=teVOLAXohJr5f+D3rgdGHNSzYOIvUfv5haN4gTse/no=;
        b=fnUo7Meyuvl+cxrb3/QiXNrczdlvgbk1wdPnN7eHeTLxrSE1oy8buVM4J6J1GIo84d
         GUVhedNTyf5C5QaftSQi3RheOnKwlMQHX+8z4S/Le3L8fxLJNJP08G2mPbQtWRtRcC4Y
         BeACxrfEGdllbjlhI+26+bVlTJKPG3vefMcfCbD5vTsGEzxIrylqbVbkF6FZ3mF7KoZw
         cD5wdxq52AeF2ladFJygVmrQ/JVhDxCdG9oj8NC0gIMdQIF0UKE2nJcxB71mZHZwkTkT
         zCi0yM/LKo8cxFCZe/rXhjEqS1yPycyMkVr1IBgSpgN/I8CCcVMlgQzLoaYGnrdfEtoD
         lmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=teVOLAXohJr5f+D3rgdGHNSzYOIvUfv5haN4gTse/no=;
        b=Kq8S3xwyQGziU6AxSQzUO6nhTuOAaRSgmS845ZoESs9zM21VWjJYSVfXTPKzQu1vr+
         nDge/I6W7sNT4OHq/I/B8qaF4z6iBiKKuRrI47C3JexpDZNuyOMQZPB4h+z7IVL3w20i
         Hak7MFmEjWAImVvUSo2rv6pG6S3Fp2ZBhm8iiH73ntS+gOoFqmXkBsVvVJVrLtOYBQJZ
         pSKG33Z1aLkJmtVMeq2ndMr6A61H5iZFvuwLZU/FBFEbQ1T+Hb4K0Ys6hRCjtTr6tZu8
         fCFAFphGA/QsDmkiguhFWgzp7ovhoNX0dXGbQSm4uDWwrCpq5JkOC9+sjbA5/eqz+C0U
         DLxg==
X-Gm-Message-State: AOAM530C0RItmB1xwFDYuFZgkluqJY8C4kwLnO9o/O1N22dzg283SE6W
        RQ8Wr9GWv8eq2ZoLDJxzgbg9BZQWyGRN8gRN
X-Google-Smtp-Source: ABdhPJxpfusIKDlSDwbgVDbZrMTu2Hw7zzJJ7+JoMU77fzQWMy0Aj+HYlNHWhYNjiMef3+aTHn95iw==
X-Received: by 2002:a05:620a:29cb:b0:6a0:847e:fc74 with SMTP id s11-20020a05620a29cb00b006a0847efc74mr7057984qkp.2.1653073542886;
        Fri, 20 May 2022 12:05:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b3-20020a378003000000b0069fcf7678besm140014qkd.105.2022.05.20.12.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:05:42 -0700 (PDT)
Date:   Fri, 20 May 2022 15:05:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] repack: respect --keep-pack with geometric repack
Message-ID: <YofmhcBLrni0kY/s@nand.local>
References: <pull.1235.git.1653064572170.gitgitgadget@gmail.com>
 <YofJLv8+x5J7yPmf@nand.local>
 <bb19159b-6d0c-a683-a58e-95ebdc128627@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb19159b-6d0c-a683-a58e-95ebdc128627@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2022 at 10:27:21AM -0700, Victoria Dye wrote:
> > I left a couple of small notes on the patch below, but since I have some
> > patches that deal with a separate issue in the `git repack --geometric`
> > code coming, do you want to combine forces (and I can send a
> > lightly-reworked version of this patch as a part of my series)?
>
> Works for me! I'm happy with all the suggested changes you noted below
> (moving the 'string_list_sort' and cleaning up the test), so feel free to
> include them in your series.
>
> Thanks!

No problem; I (re-)sent this patch as 1/3 in my series which should be
available via the archive at:

    https://lore.kernel.org/git/cover.1653073280.git.me@ttaylorr.com/T/#t

It looks like we're on the same page with respect to my suggestions, but
feel free to take a look at the reworked version of this patch (and the
new ones on top, too) and let me know what you think.

> >> @@ -332,17 +332,34 @@ static int geometry_cmp(const void *va, const void *vb)
> >>  	return 0;
> >>  }
> >>
> >> -static void init_pack_geometry(struct pack_geometry **geometry_p)
> >> +static void init_pack_geometry(struct pack_geometry **geometry_p,
> >> +			       struct string_list *existing_kept_packs)
> >>  {
> >>  	struct packed_git *p;
> >>  	struct pack_geometry *geometry;
> >> +	struct strbuf buf = STRBUF_INIT;
> >>
> >>  	*geometry_p = xcalloc(1, sizeof(struct pack_geometry));
> >>  	geometry = *geometry_p;
> >>
> >> +	string_list_sort(existing_kept_packs);
> >
> > Would it be worth sorting this as early as in collect_pack_filenames()?
> > For our purposes in this patch, this works as-is, but it may be
> > defensive to try and minimize the time that list has unsorted contents.
>
> I went back and forth on this, eventually settling on this to keep the
> 'string_list_sort' as close as possible to where the sorted list is needed.
> I'm still pretty indifferent, though, so moving it to the end of
> 'collect_pack_filenames()' is fine with me.

I'm fine with it either way. I opted to sorting the list in
collect_pack_filenames() since I think it's slightly more fool-proof,
but I also don't have strong feelings about its placement.

Thanks,
Taylor
