Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DADCC433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 00:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiEKA4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 20:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiEKA4u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 20:56:50 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C9337BD6
        for <git@vger.kernel.org>; Tue, 10 May 2022 17:56:49 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id e10so493566vsr.1
        for <git@vger.kernel.org>; Tue, 10 May 2022 17:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BVP017lF9TEBsw6OjwehK4+ecM6Cf54zyFCtVZGJ+Sk=;
        b=lc3gMVDJ2NUv9YU28Z8YsBzkJWHFceZObll4reMJcyEkFOjF6Z2KmvTy1Tr0M1jqyq
         UPQ8Sqt1Z/a8U/ovdkn+sQ/gufzy28xcWs5P/a8w41OHUZBNLgMVwPySGh3BWUZxQBQ7
         v/FFgFxRbIqUrPTiTRmc2V1AuEUPh64ubqtYcBsW5SyKHm5KPMgMu+rSj4F2Xf24QAMe
         w/bseJpT28bBJ9VgSrdfy89iAqQitaFe0HgAwcVb34o6vehNnF9lTTljxcIXzZSvPrZv
         j1N6ccRI8T11bU3AE6LXmGqJ9vBssLsGAvteJR9kCvDObBfLXNpIhM2XrkX1AFeRnyi4
         SCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVP017lF9TEBsw6OjwehK4+ecM6Cf54zyFCtVZGJ+Sk=;
        b=ESe5Wwy5Z1cXXhLD80Ui+U6+cmfUdf7XpDLrugXoLolWwrmoKelhkEppjVtZGrZ+X2
         ug3JHLB3B9270B16qblg0EIAX2DpxXg8I5c/qvfODgRSx9iHK8n1zVRbfPoDI5iQJFxo
         sfP6pVuxnQmrE4uZ+rdJYzw/XkVHrQHqn910SFHimQKWPi0DyZ+TWtRteFAKhDngvs/Z
         b2A64ND5a8yThPuC9Acb8ClmunJ7H7kvHLQw98R07S9RmHXt2dN4dSzNdPWKmU6YxTdC
         e4ub2vk8h87lB3fNvRog8jkGwF2FdcnoBVBtN5p4TpoUzTphm/ahZzAiFIGD74tlDTSi
         ckgQ==
X-Gm-Message-State: AOAM531tQcyNXiKHULFATtI01XCLOFvACwke0+0/HE4Ke35qdJJ/QzjY
        stx8UhG2djBfiyAj1dMDe/JT7pFmitg+BucLqNRD0j12
X-Google-Smtp-Source: ABdhPJzoaadU4+2lDQ+L8fMYEb0q/oNI24t3nNOzW9Ib9MnehW3zQagjvaZI6XGI7+5HyPI85h6GU75IaWs8OL4J1kw=
X-Received: by 2002:a67:d303:0:b0:32d:3d07:17c4 with SMTP id
 a3-20020a67d303000000b0032d3d0717c4mr12315732vsj.52.1652230608826; Tue, 10
 May 2022 17:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220507163508.78459-1-carenas@gmail.com> <20220510174616.18629-1-carenas@gmail.com>
 <20220510174616.18629-2-carenas@gmail.com> <xmqqczgl6nua.fsf@gitster.g>
 <CAPUEspgGZeF8LA5PZNF87=+zZLKvWLqWtpD5YUBUON4gq_TaDg@mail.gmail.com> <xmqqwnet3qcv.fsf@gitster.g>
In-Reply-To: <xmqqwnet3qcv.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 10 May 2022 17:56:37 -0700
Message-ID: <CAPUEspjppJh3+obLoNpP8ckHz=-0G=MEUUBHnrab6=Znv+RiUg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] t: regression git needs safe.directory when using sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2022 at 4:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
> >>
> >> Mental note.  We do not need root to be owned by 'root' with the
> >> tests we see here.  Perhaps we would add some that requires it in
> >> later patches.  We'll see.
> >
> > I am not good with subtle messages in a foreign language, but is this
> > a way to imply that I shouldn't need to chown and instead use the
> > GIT_TEST_PRETEND feature more?
>
> No.  I just said I made a mental note of the fact that the ownership
> of root/ directory (not root/r which is the other directory this
> test script creates in this step) does not matter at least in patch
> 1/3, but I cannot say, by that observation alone, that chown we saw
> earlier should be removed, because patches 2/3 and 3/3 might start
> requiring root/ to be owned by 'root'.  Hence "I made a mental note
> here.  We do not have anything that requires the above chown in this
> patch, but we might see something that makes it a good idea to keep
> the chown in later patches".

got it; we actually DO (or at least I intended to, but didn't because
of a bug and complicating the tests unnecessarily).but then as usual I
didn't document it well, apologize for that.

`root` is called that way because it was meant to be a ceiling of
sorts and used as a safetynet (like GIT_CEILING in the test suite) to
block the tests in this file for going up one more level and using the
default git repository from the suite by mistake.  That is also why it
is owned by root.

of course later I find out that for it to really stop the walking it
needed a .git on its own and to create one I needed to do it as root
which I didn't even attempt to do until patch 3 (at that time too, I
was thinking maybe I could get patch 1 and 2 ready first, so my name
wouldn't be on every git update and one of the reasons why nobody can
get anything merged into next)

one option would be to consolidate its use with the root repository
that gets created in patch 3, which I could have done originally
instead of just using the ones you provided almost AS-IS, or as you
pointed out we could remove the safety net since it is not needed and
it is buggy anyway.

will remove the chown in v5 otherwise but I think the plan above
shouldn't be that intrusive and might be better.

Carlo
