Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A952DC433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 19:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384998AbiEETXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 15:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384991AbiEETXe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 15:23:34 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE9B50449
        for <git@vger.kernel.org>; Thu,  5 May 2022 12:19:54 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id q8so5318945oif.13
        for <git@vger.kernel.org>; Thu, 05 May 2022 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VC5EpU/uMOx1Ig5fulRvnaA8eu4ouIKnYOLhX4ZBGAA=;
        b=r3jes6lA1vgeH7HAFI7+mcMU4N5KR2sqGkiDe0Rcebe/L68eIckPHSGozVvZ6u+4Q0
         VMMxqrnSwPOrcGRReKEkxMSyp0YMnXyZB0nk/4alnsGjg4ascC7DFzrOF9u62nlkyGZI
         KOzQ7+kKMEdu1iOWnHJW1wzh/jBY+gCB5lOgLnHNffn2Q3Gpqoo0So/0fBHFYQxbfaJ8
         v9DnmFoKi6Z+EzT2R7w+5ssWU4+yiS1a3HnztiBcT4QGg+MrEBjQaMUqM7nId+BbeG41
         FQFUFNuJYhQIubm7Hq5HvkEt/ssvNViWhZpqHfksDCETVEPP6lIPqeU9QbIlnl1Ou1mZ
         rFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VC5EpU/uMOx1Ig5fulRvnaA8eu4ouIKnYOLhX4ZBGAA=;
        b=VwH2uastKnVp+GaiguhxP1CJCCodu6Uy2I+9o1O6tvKmAVBBor3vX2K0RuZNATS3jV
         mAxX2sGiZWfNuqSnGNkLLjr16wfMduZ9JHoissrrbJAwnM3Jfg4tQhF1SzSLL7ZMqgbY
         yok4vyu2f/BQv1HVKwaVXBBT++D1H6OJVM7oD35VGIYgeYLV+xT+V9g4YIOMG3IstEnW
         HMvEABhkwXeCOgeuB72k7NhbtfH3CgAzMT6pzLRWOqDAyJSdVi7ptk21vQ3f7MxYp42V
         QdIB4CCP+EkqsLOjWkqqkurZVQPLd5J2OTs16DHtCkcXIXd2eCm5+FtsnLNqm+6oD7Yt
         zOjA==
X-Gm-Message-State: AOAM530wUu0w/jiHvvlRNjaXUYtMX3Rvhp1EQYqvf4aOfUgZ52GEZLN5
        hpv9fciVzXMXenk7VDYDI1fVSDvNHj9JwwMpBbssuA==
X-Google-Smtp-Source: ABdhPJxQ9OGipMfvwVwyJaXtt06IxuJC5ZwS3EBdgkpE8CU8L8oBs1mZspFS1ci5ANLaHzcmBw0bU3zLbuRRdxDW4+8=
X-Received: by 2002:a05:6808:1387:b0:325:93d:eb4b with SMTP id
 c7-20020a056808138700b00325093deb4bmr3285043oiw.213.1651778393588; Thu, 05
 May 2022 12:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220502170904.2770649-9-calvinwan@google.com>
 <20220504212738.162853-1-jonathantanmy@google.com> <CAFySSZCL-ccVK+ZOU5=X4fB3-eu=Cmu-MGpT1cMW+bqmdRcF9w@mail.gmail.com>
 <xmqqbkwbes4d.fsf@gitster.g> <xmqq1qx7eqyk.fsf@gitster.g>
In-Reply-To: <xmqq1qx7eqyk.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 5 May 2022 12:19:42 -0700
Message-ID: <CAFySSZDA-j1m3OQRRmXAj-0EP4UcZmExuoJUCpjhCtTUBsLNyg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] cat-file: add --batch-command remote-object-info command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ah, that is in the batch mode, and you were syaing that "one request
> with multiple objects" would allow multiple object-info requests to
> be hanled efficiently even in non-batch mode.  If that was what you
> were talking about, I think that does make sense.  Thanks.

Correct, also I think you mean "buffer" mode rather than "batch" mode.

On Thu, May 5, 2022 at 12:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I would have expected to see something like
> >
> >       start batch
> >       request 1
> >       request 2
> >       ...
> >       request 2000
> >       flush batch
> >
> > during which the other side patiently listens to our requests.  They
> > (meaning the local process that reads the above and talks to a
> > remote as needed) can coalesce the requests of the same kind
> > (e.g. going to the same remote) while buffering and optimize their
> > operation without having the caller of them to worry about it that
> > way, no?
>
> Ah, that is in the batch mode, and you were syaing that "one request
> with multiple objects" would allow multiple object-info requests to
> be hanled efficiently even in non-batch mode.  If that was what you
> were talking about, I think that does make sense.  Thanks.
>
