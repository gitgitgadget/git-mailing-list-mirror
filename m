Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F4CC38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 14:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F16821974
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 14:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ+8HAar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDSOR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSOR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 10:17:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC6C061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 07:17:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b8so3630657pfp.8
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VRn9EVyBLdZQ7Rc8pmmkR3KQ17cfyRAHIRfzJp6lohk=;
        b=nQ+8HAarXTrJoZ9HCC3bSpM6Eo554W73w8xBITbkFTs5iZ/pEmk2+g2eeW3MqOGapn
         chV6zpTBnpbhJd9oNi8IWGEk05nzRN6dp4nTbi2rOXfAhN8A6UBezUjOLn120tZn9/oi
         63Nzq5HwdBPsXt4VMlMoG1/kNqkPkyWQRYcB0jL8kO7LbvABCH8T66flrBeeku8tCdD5
         9UA6xCHZB2n2fFYjSj+v0x5+2WISogZK+psKJkVcpDlyTpnMwsrS7DFw3SItSjsffBPa
         Sd52rdcO5HalbgzXhIzkBBg+H8A6BxYI6nDMFdRWKN/p3Bnk3L7iKjlsJm/CqG8gNwbN
         p0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VRn9EVyBLdZQ7Rc8pmmkR3KQ17cfyRAHIRfzJp6lohk=;
        b=pu/6PdttfZajJyk/MxMuiL9wSgW/fCHN572a5YD0ME5MLQDJzXXR8+6nOaTJXk6iz3
         y0qG2BFvnTywg8AtZK90SMSGdl3kw3IJ5KRU3OOL3rYWgNknWXIzDhJOksxXj79GX5aq
         jKJox9QFR803FDAMHbmoHylLUAccyvIHhKIOpUi4KDoyFScIN1GGdvLgu6Fp4o8LHdNp
         2sStXx+CchSZkATjKLms+KFMxGI0D3NpXm2NVgJt2k59Ndoi0HfPYN54dgrD/zlm/TpA
         2N1qOBoGV+ZyiDsuGofpEO32nCkNtzFoRVRm7aIgrnIFn2kDpeYjEtqyb9oEKTELm/gC
         Y6MQ==
X-Gm-Message-State: AGi0Pub7ri1t+HSFcBb+J5iHhnfg5dalFFAlJIdrDrAn2xUX74GNhmPO
        6Waaof3bcMb0d/xFiJR8luioGHq7
X-Google-Smtp-Source: APiQypJnWrUsRdl3OVwZo1QtdfSfjlJLTftwhc6Wk+qp94FC9T8UBfF8B4WQnb70AizYICG+NGHmyQ==
X-Received: by 2002:a63:fd0c:: with SMTP id d12mr11795822pgh.41.1587305876379;
        Sun, 19 Apr 2020 07:17:56 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id b13sm15074809pfo.67.2020.04.19.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 07:17:55 -0700 (PDT)
Date:   Sun, 19 Apr 2020 21:17:54 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] t4254: merge 2 steps of a single test
Message-ID: <20200419141754.GB28207@danh.dev>
References: <20200418035449.9450-1-congdanhqx@gmail.com>
 <cover.1587289680.git.congdanhqx@gmail.com>
 <d1bc31e692d08d73bc577f737b0190e163440ee9.1587289680.git.congdanhqx@gmail.com>
 <CAN0heSqnKfepx1c-7Exy1bj3_p_JdAuBLyt5WtkwZCSkOuroMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqnKfepx1c-7Exy1bj3_p_JdAuBLyt5WtkwZCSkOuroMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-19 14:25:41+0200, Martin Ågren <martin.agren@gmail.com> wrote:
> On Sun, 19 Apr 2020 at 13:03, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> >  #   fatal: unable to write file '(null)' mode 100644: Bad address
> >  # Also, it had the unwanted side-effect of deleting f.
> 
> (This comment looks a bit unnecessary, but that's not new.)

I haven't looked very hard into this part, I guess I could take more
time to look at it and decide if we should remove it or not.

> >  test_expect_success 'try to apply corrupted patch' '
> > -       test_must_fail git -c advice.amWorkDir=false am bad-patch.diff 2>actual
> > -'
> > -
> > -test_expect_success 'compare diagnostic; ensure file is still here' '
> > +       test_when_finished "git am --abort" &&
> > +       test_must_fail git -c advice.amWorkDir=false am bad-patch.diff 2>actual &&
> >         echo "error: git diff header lacks filename information (line 4)" >expected &&
> >         test_path_is_file f &&
> >         test_i18ncmp expected actual
> 
> Makes sense. The first mini-test used to just set up "actual" and there
> was only one test using it, so it's hard to argue it was a "setup"
> phase. This looks better.

-- 
Danh
