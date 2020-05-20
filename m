Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029FCC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA50207F9
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b="W3ey9Fat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETOOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 10:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETOOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 10:14:54 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD1BC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 07:14:52 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id p5so805028vke.1
        for <git@vger.kernel.org>; Wed, 20 May 2020 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmiegCwMFNyDyKjNRVJWkgOSbuJZGO14DdPtnD4P4KU=;
        b=W3ey9Faton6l7LkkD2hFpkuRMcBGnbXFjDKFVl/LhSiLJg3qcaI00TeY0TLnu5hhz4
         4Au99pxRlhBcsx0bcrng8sAyWMOcnI3O+WOb4NLDShW/e0E7lrblnW2qeGB5rm9bcFM1
         23M2onTAbvfxj+WFD/5hHbBDzUk8n38fVfEdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmiegCwMFNyDyKjNRVJWkgOSbuJZGO14DdPtnD4P4KU=;
        b=kkKMbHeXMloNyHJqG80gcI5Yh6oIzgmhV/WcAHHj1s2nMgFOm0nGGaQ7+RnaTvIvlC
         UvhC2jpAVHDBWCJNrY85MCOKV2BQY3kwFyY0h4thGbl5sHkKtRLRHsz+yexy+yuhfHey
         +QbhUcvSs81CDu5BUvL5XMT7uWY6O1qzIWttsnTCT/4nyv2doGcZHOZVxYmRW+Fy+CWD
         WPF9nFfp7vX2doKiIci7fnEuFGwM40wE/RBjSPo8uzGrgcCrHVspRRi8HUd88zi2N0of
         gaQTNWneT9TqjnRizOUBVuFHvnPA3gnrLzhhNEghVAWL9iCR4AjZfr+4sVzzvPErxdni
         L0hQ==
X-Gm-Message-State: AOAM531nmTBImK/iaEFerI9rmJP7z5eZMA7j9kjuM0bAF10Xcuzjgb/9
        BjD46C3vsz4Nl0zHPs8BU+sZ5v4VpMYUNHPpoY01Kg==
X-Google-Smtp-Source: ABdhPJzCJgdy56e8UjS21WsNGf2pIZ/LHeNNh3MOYcbRQv21t8oWt2uet9lzOZj2V5GkPupn61GV1SRxO26wybf8Lqo=
X-Received: by 2002:a1f:254:: with SMTP id 81mr3835456vkc.47.1589984092092;
 Wed, 20 May 2020 07:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2punll7.fsf@gitster.c.googlers.com> <CA+kUOanbgUPgCer-sBjX6YROYvZAhzBTUtCnFvuYP1EWvo3VEA@mail.gmail.com>
 <xmqqwo57y0i5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo57y0i5.fsf@gitster.c.googlers.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Wed, 20 May 2020 15:14:17 +0100
Message-ID: <CA+kUOam31cLNftUx6rGz=bdpjo5Dqv_ahJ6jUnD8OGq6P6Ra3w@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.27.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 May 2020 at 00:21, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Dinwoodie <adam@dinwoodie.org> writes:
>
> >>       tests: when run in Bash, annotate test failures with file name/line number
> >
> > At least on Cygwin, this breaks the test output parsing of failures
> > when running with prove.
>
> We'll revert this problematic topic out (which hasn't happened yet),
> which I hopefully will be able to merge to 'master' before tagging
> the -rc1 release candidate.
>
> If possible, could you test the result of merging e31600b0 (Revert
> "tests: when run in Bash, annotate test failures with file name/line
> number", 2020-05-15) into 'master'?

I get a merge conflict due to 303775a25f ("t/test_lib: avoid naked
bash arrays in file_lineno", 2020-05-07), but resolving that in the
obvious fashion and the test summaries are working as expected again.
