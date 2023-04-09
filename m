Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B7FC7619A
	for <git@archiver.kernel.org>; Sun,  9 Apr 2023 01:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjDIB0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 21:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIB0F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 21:26:05 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C987D99
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 18:26:05 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5491fa028adso366644057b3.10
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 18:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681003564; x=1683595564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYUzjQTNYHZKy/w1b8ChnPtXJPZBt22jUySxriDd8J4=;
        b=xJfszoqETmSQmV7M98wwF0BhQNYUf8WQop4mSPn+6i6FWWIvM+adOrYMkHJxCmnl3g
         Mye68Z9/sjgfStVjRi8B3bsxRZ2EAg8g+sFGigW9mPi+7Yhr0bLoAUlw8q9xv1xJUqfs
         jjybLARFZ2ZmheaINGccNUxx/wwHdfqqz5fUZRomVdYDJ8afSgeiV9o6j2VqkoZtvcQD
         UI1X+RPdWzcZy800fa1RD4ZzW2oJ1pm3ft2cW3XmIRiSenFtNQW9dlrPhswsr5RGn3ap
         BdF1FqS05mtCxWE/kzGPNHwSNeYgC4skGxsZahHwnhij1hk1LpH4o22cXOeUx386Rp+I
         ILDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681003564; x=1683595564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYUzjQTNYHZKy/w1b8ChnPtXJPZBt22jUySxriDd8J4=;
        b=BQByF2xltVJaUNn+6kunXKWZGJhO0H6xfXmAF4o685qF79FC2zz14KgWlZMGikToa/
         +LCYuIBS3FfqDrhg7ykp9DCvHry/1jiqBhEInEruXWAdtxEsgcDPW4YLENzzC5/zwE+J
         o2WUB89DQeb7M7GE4qq4a7cyt2Nl1Cppxc7CoNvwBfoN+POnhV0EBQ0RhoiThAaxiyg6
         oKS1HhzwK1MPadetNCdQsOa13+/gpiCfq8r90VGUC80aUNZXmHCDkpanHFq3u27NMiUQ
         pju7RCBKccuW31Mr2lonUIJZmbh6oNTdq9bA6F1Fu5e30+o7WY0iy5nUXtUW+8rPQ4Hp
         4ESw==
X-Gm-Message-State: AAQBX9cNgbOOpKveYqQ6TLwovGSGkXpW99Xgl/7sj1uIc5fSJhDbQvg2
        cBD7oSe3yjiyB68Wc8fvDLwxcw==
X-Google-Smtp-Source: AKy350YShZBtCMG5ekAGUgObGr9dxFRnWKnKL297f45B26Q1p3rI5jB4y11Nm0V+T1UcMhryE+9FIQ==
X-Received: by 2002:a81:4854:0:b0:54e:fee6:3d79 with SMTP id v81-20020a814854000000b0054efee63d79mr1167960ywa.18.1681003564283;
        Sat, 08 Apr 2023 18:26:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b130-20020a811b88000000b0054c0b5e3ec1sm1965270ywb.109.2023.04.08.18.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 18:26:03 -0700 (PDT)
Date:   Sat, 8 Apr 2023 21:26:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com
Subject: Re: [Question] Can git cat-file have a type filtering option?
Message-ID: <ZDIUKqPatP+FX8dM@nand.local>
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1n3k63p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2023 at 09:30:18AM -0700, Junio C Hamano wrote:
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > all blobs, and then use `git cat-file --batch` to retrieve them. This
> > is not very elegant, or in other words, it might be better to have an
> > internal implementation of filtering within `git cat-file
> > --batch-all-objects`.
>
> It does sound prominently elegant to have each tool does one task
> and does it well, and being able to flexibly combine them to achieve
> a larger task.

Yeah, agreed. It may be *convenient* to have an easy-to-reach option in
cat-file like '--exclude-type=tree,commit,tag' or something. But the
argument falls on a pretty slippery slope, as I think you note below.

> Is the object type the only thing that people often would want to
> base their filtering decision on?  Will we then see somebody else
> request a "--size-filter", and then somebody else realizes that the
> filtering criteria based on size need to be different between blobs
> (most likely counted in bytes) and trees (it may be more convenient
> to count the tree entries, not byes)?  It sounds rather messy and
> we may be better off having such an extensible logic in one place.
>
> Like rev-list's object list filtering, that is.

Yes, exactly. This definitely feels like a "do one thing and do it
well". `rev-list` is the tool we have for listing revisions and objects,
and it can produce output that is compatible with the kind of input that
other tools (like `cat-file`) can interpret.

Thanks,
Taylor
