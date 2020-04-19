Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC16C38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 14:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF97321841
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGqh3tWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDSOY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSOY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 10:24:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723B3C061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 07:24:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b12so658187pff.4
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nHiFsFYqOjnu4E2WkzBcmdEt+GRXx8KNvu7mxiZKtDI=;
        b=CGqh3tWihvHc5JNubEpLT81ZqRH2NqWcHnNCrylPQdEzvhd0/GqJJzr8MPmOZYFEY0
         gVUAIWuRJsXInURQNzCFOuwOPcUv1ieLMhK7XFqeyzVV5p2O42jzk8pDRsZ6EHCoIKZb
         7KXU/Kpdme0Tc7mOkCgEu35a5nUEddm5wJlQ+QlKUQr0BxbTxA1jK+S6mLhO/okVjUt7
         GrCMu0kfQq2rCVDuVqJrPUuROM914M/GiB9gJ8d0muONwMTQCEklPp7XLV7Rs2SPHTzm
         d255QwPLoIe1p4kj7CaVsY3hxzOzasuIdlbZO/idS0MWbesoVR6Mdn/Q0kBAhzoWFRI5
         STkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nHiFsFYqOjnu4E2WkzBcmdEt+GRXx8KNvu7mxiZKtDI=;
        b=Czskpvyo0oomdNGUkMzYF9o0Yw0CXV323Fcki8jnjJ+Ak/glSZ7qz8LVOMGtxX5mhf
         9xPpZ61tAb/4vMczv4Ac18VgnvlF5GwpJPUsldMOJTTyZzjTGGOQw9KwSr/O55Jg9/e6
         dWqO05jBS/KJvXSd/mAYpJAeABcYspngpHX9K2NM2SRKICb+Ch/gQEh40Pj5opVMRqh5
         IWkNnovk02f9uCwAjY5GKDE3upjLMJKixCa/CPTkrTVBPA5nz6O05zS+87gHf2eoJNWd
         GND+ypT6TXEQuWDiJzTg8d7fsv+hebh0JaazY+oMOupXiMhgjCtVGXqPXkHm+wXpyNAL
         xM3A==
X-Gm-Message-State: AGi0PubrZHxLovSEb6ZXldi7NKU8uJpPFWXUfiYGYhzhOTMdrt7tSxU2
        +bFqmi5+byJc3jmdG2KLMV+8EXEa
X-Google-Smtp-Source: APiQypL7oxg+5aL6Der1zv3cvSKyyUo7FdWXIn747+2rG1enJSSjrCsT95BTZZMxxWnkJXvWCSeWBQ==
X-Received: by 2002:aa7:82d8:: with SMTP id f24mr12178070pfn.51.1587306265926;
        Sun, 19 Apr 2020 07:24:25 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id y25sm624776pgc.36.2020.04.19.07.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 07:24:25 -0700 (PDT)
Date:   Sun, 19 Apr 2020 21:24:23 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] mailinfo: disallow NUL character in mail's header
Message-ID: <20200419142423.GC28207@danh.dev>
References: <20200418035449.9450-1-congdanhqx@gmail.com>
 <cover.1587289680.git.congdanhqx@gmail.com>
 <cb96947b36b8ab314f5692daee6f627273ca66d3.1587289680.git.congdanhqx@gmail.com>
 <CAN0heSpZR6HtntK80DhQxtRQZo21GBd3uAKrsJxz_opyun8n4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpZR6HtntK80DhQxtRQZo21GBd3uAKrsJxz_opyun8n4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-19 14:30:19+0200, Martin Ågren <martin.agren@gmail.com> wrote:
> On Sun, 19 Apr 2020 at 13:05, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> > --- a/t/t4254-am-corrupt.sh
> > +++ b/t/t4254-am-corrupt.sh
> > @@ -69,9 +69,11 @@ test_expect_success "NUL in commit message's body" '
> >         grep "a NUL byte in commit log message not allowed" err
> >  '
> >
> > -test_expect_failure "NUL in commit message's header" '
> > +test_expect_success "NUL in commit message's header" '
> >         test_when_finished "git am --abort" &&
> >         write_nul_patch subject >subject.patch &&
> > +       test_must_fail git mailinfo msg patch <subject.patch 2>err &&
> > +       grep "a NUL byte in Subject is not allowed" err &&
> >         test_must_fail git am subject.patch 2>err &&
> >         grep "a NUL byte in Subject is not allowed" err
> >  '
> 
> We used to fail for some reason and it's sort of clear from the size
> of the test what that reason is. Now that we flip "failure" to "success"
> we can add some more stuff here that works. Makes sense. Of course,
> somewhere is a line for stuffing too much into the test, i.e., you'll
> reach a point where you should have separate tests, but I think this is
> ok.

I'm not really keen to check the "git-mailinfo" failure here.
Since, another developer may come and decide that we should keep the
mailinfo as is, i.e. keep NUL character in Subject, Author, Email,
etc... And let's git-commit complains instead.

Adding a check for git-mailinfo here may limit future development.
Other's feedback is welcomed.

-- 
Danh
