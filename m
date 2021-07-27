Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203C6C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0873C6101C
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 16:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhG0QsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 12:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhG0QsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 12:48:04 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D458CC061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 09:48:03 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t128so59308oig.1
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=iEb2QkNgcGMtg30Af6KUBsZSidFDTp1vue5rrvySqt0=;
        b=tbZtvo0LdPeaJti9bkMlknfiy7HlAmiTfq5IiMk2zyf6krn0nVsAf/3ytApYfGmBke
         gufPIa+OmrAYvNuAV0MCby3jfmrAzw+Ho3BxkBsbrCW8s36tasClyNjvhlN4IZUB/k6G
         w3dW1KB+x4oF/O44iuN3+15O05hWUfi4fcDZI3hh+v1Hlz3tM0S/ffJ6FdyyV2vJ+v9q
         prtiLa65f+Iqc1P8H6oF2m8r4MIumovidvkjn0YCTCDT2PmjZU92pCopuuXXMBoThNZI
         i3IftnqDaP5lF68ZLyCcc8PYkxNWZ2pOUzRl47VM+B8i8bLx4WWVtCp8BIBe/QStD4Zf
         5PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=iEb2QkNgcGMtg30Af6KUBsZSidFDTp1vue5rrvySqt0=;
        b=Cy3KxZ712kIC/pK9WjE/1r6QpARGr1wt3nqRTCDTTCWxuqoZAYOI+jc/sstw2UeOyD
         kNaz3NO1/+XdYoWrFKoO3RQvZ1pdRsdNDoQYam2VFyk6GbXW+tmNOrEFMOIBis12LdOu
         3wMAR5qvhHuE70AZOaLKYn+Ht3EllX37lWkmNYwfA6SV6NnoXCkX7lJGHX1FU8K6b0UY
         FX/s6xqWWuV2zXnmocNvEQnCzFTWrCaQ8HWwXeWAAh0ki0CY+MAb2t9TiGd5LFgAm3qR
         b0cvun9kO3J7py+T+xyxXi6hqx6WDUIiD3ZqjQxdWgDAiGBB+HDgE7EQTYVgZAXE825C
         9lvg==
X-Gm-Message-State: AOAM533l6lSYLZPP8Uj++KplUtb7pLs0OEVfnZ4vC+jaYy9pthRQGPxT
        67W4Yu0whxrNLXq06wPoX6I=
X-Google-Smtp-Source: ABdhPJwk3mowMCbvZ7QqRzxe0fGpolAbA8s/FM7IV8DkiCKg85vy9j+gDQWfgYEgu4bLO7GQeqJ5Fw==
X-Received: by 2002:aca:3085:: with SMTP id w127mr3473450oiw.101.1627404482687;
        Tue, 27 Jul 2021 09:48:02 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id h2sm617278oti.24.2021.07.27.09.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:48:02 -0700 (PDT)
Date:   Tue, 27 Jul 2021 11:48:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git List Mailing <git@vger.kernel.org>
Message-ID: <610038c0e1056_8fd52084a@natae.notmuch>
In-Reply-To: <CAMMLpeQ-Qpct4TX__KVuCyjbgxtB49qTMRHYc9R9-o0cRu4MuA@mail.gmail.com>
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
 <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
 <xmqqeebregns.fsf@gitster.g>
 <CAMMLpeTL92cDmMHsE3iuhHQrVjwLFWHxE0CwD+uDBoPGAQCrkg@mail.gmail.com>
 <xmqqwnpcdu1w.fsf@gitster.g>
 <CAMMLpeQ-Qpct4TX__KVuCyjbgxtB49qTMRHYc9R9-o0cRu4MuA@mail.gmail.com>
Subject: Re: [PATCH v2] pull: introduce --merge option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Tue, Jul 27, 2021 at 2:45 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Alex Henrie <alexhenrie24@gmail.com> writes:
> >
> > > Junio, would you be willing to accept adding -m without adding --merge also?
> >
> > My gut feeling is that "-m" without "--merge" in the context of
> > "pull" is extremely unlikely to fly well.
> >
> > As "git pull" is a "git fetch" followed by a "git merge" (or "git
> > rebase"), it takes the union of common command line options from
> > both phases, and "git merge" takes "-m 'message'" which is an option
> > fairly familiar to users (since it comes from "git commit").  Even
> > if we are never going to pass "-m message" from "git pull" down to
> > underlying "git merge", squatting on short and common "-m" would be
> > a bad idea.
> 
> Thanks for the explanation. I forgot that "-m" usually means
> "message". That does seem like a good reason to not use "-m" for
> "merge".

It means --merge plenty of times:

 * git restore -m
 * git checkout -m
 * git rebase -m
 * git diff -m
 * git read-tree -m
 * git diff-tree -m

-- 
Felipe Contreras
