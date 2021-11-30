Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7207CC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 03:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhK3D1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 22:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbhK3D1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 22:27:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C2BC061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 19:23:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z7so15713680lfi.11
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 19:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIW3mZCZOAer/KsKD669LFokJhbnb9WO2yBui55ztnE=;
        b=iRYL6eFE1ElcKQC3KjhkDsmS/RQ5PoJubrrtdIiF+DD2tQmF6m5A1dpZyGk3sqmdYl
         yzhS9EX8GYNnCqW2JNAXml+0ERudIV1FvZE9EsXykfIIjLQpCI5uKggRNuQMFXJcvTa3
         cvEG7F4WEiGXVfeG9mtcdXHSE0x1pJmXt6q2XjsIt/9IqSggROTuzPL0z+y+sR8V3cLR
         HP9KDuht9jkBPInvLvw/II3GvDVDXZG949AX0bdPkRDpYK2L7T7CZTcmEF8eczFkdPX2
         DAxqKRr5Mf0k7YnsP10rax5XYsCK4hpAa0/Yc+6ctUdroB3IVRu20d2tPSrWCInPBpS5
         Dm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIW3mZCZOAer/KsKD669LFokJhbnb9WO2yBui55ztnE=;
        b=zxoHic++hv7GOP5w4DTYJn43wNI8O6CEpDgM9XSY5fAlPdqf16w5Cy1Qx96HSIuB/f
         sgIkxK+mGTv+5gg4SvOq48MPBL9il/0Hf7vsKAMYNX5HdlWp3WncGKYv8OloThTfbWzG
         AGj0zWrf8ljvqWqXiH8kNI56AoIVATKoA9T4U7qIvY2zFf8BmtAldCB6Mq93LxCf42Zs
         8YEVa83sC8qmt80QEVbKblMagEt2eb5ijkYdRfNpz4CL9HZKh5BCVv20nuZuLvpzMGls
         onlfH1DAZIlyMxQnJSXTQzvFj6BConSTyPnMIj1LqEDzjXMc3BrN1KRQWczROVoZN4de
         CDkA==
X-Gm-Message-State: AOAM530pkKWboWymsw5HKdm8CC0+L19jSuz7kTtPcyMzgPT0VDrt5Q/R
        LjjqCBoy8xq8+kP3pMfdZMGq1UaVxliQynffo8s=
X-Google-Smtp-Source: ABdhPJyZdkdfEgYG67X/a5bUbrgE0Ry2tmbVRksJlEml3lPGYwrpr2WL+1S1HgUlg8rjHVR27ivRgbg/yaoBeU4owG8=
X-Received: by 2002:a05:6512:ace:: with SMTP id n14mr23066341lfu.53.1638242621304;
 Mon, 29 Nov 2021 19:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <20211122033220.32883-3-chiyutianyi@gmail.com>
 <47b3e2ad-4fa1-040a-24c1-6da0445bd1a5@gmail.com> <xmqqsfve669w.fsf@gitster.g> <2271576b-79d3-7983-d3df-5548e0a12e85@gmail.com>
In-Reply-To: <2271576b-79d3-7983-d3df-5548e0a12e85@gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 30 Nov 2021 11:23:29 +0800
Message-ID: <CAO0brD1U+zbqBGjOV+Vc5+AQAdrG5ULp_0=PMYeUQSxqvWQ65w@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] object-file.c: handle undetermined oid in write_loose_object()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 6:18 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/29/2021 3:44 PM, Junio C Hamano wrote:
> > Derrick Stolee <stolee@gmail.com> writes:
> >
> >> My first reaction is to not write into .git/objects/ directly, but
> >> instead make a .git/objects/tmp/ directory and write within that
> >> directory. The idea is to prevent leaving stale files in the
> >> .git/objects/ directory if the process terminates strangely (say,
> >> a power outage or segfault).
> >
> > Even if we know the name of the object we are writing beforehand, I
> > do not think it is a good idea to open-write-close the final object
> > file.  The approach we already use everywhere is to write into a
> > tmpfile/lockfile and rename it to the final name
> >
> > object-file.c::write_loose_object() uses create_tmpfile() to prepare
> > a temporary file whose name begins with "tmp_obj_", so that "gc" can
> > recognize stale ones and remove them.
>
> The only difference is that the tmp_obj_* file would go into the
> loose object directory corresponding to the first two hex characters
> of the OID, but that no longer happens now.
>

At the beginning of this patch, I did save the temporary object in a
two hex characters directory of "null_oid", but this is also a very
strange behavior. "Gc" will indeed clean up these tmp_obj_* files, no
matter if they are in .git/objects/ or .git/objects/xx.

Thanks,
-Han Xin
