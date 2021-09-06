Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475F7C4332F
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37103600CC
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 13:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhIFNcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241526AbhIFNcB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 09:32:01 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C25AC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 06:30:56 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w7so6508335ilj.12
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 06:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tm8yFZUSdTnqIjKGZ6VZglkuTBXRVbKsUQ1CjpbZbZY=;
        b=aHnWkzAehb2qHWD3WROay627D0OsXBtSAXMLpgbBS56+ml3xs/j7yPL5u68LAUvf9y
         4kVmmfTdQTwB00zQyrSAVIv4OUYjJjR00U3RbVMRaHua6TQ0OMSCYlWj0KBPTYHnkEmV
         7ljZpxYA80/nEGDsC62SmjQw2YdD6ej8VRkwZX4WLOSxl6osCq8IPSjI2Bx4AqoDtF0g
         GYBWZiOS8HpjEewfZjmSBpQeQdCZIXIMbnunqMxZKZnsOKlQn4Ddgx63/90ylrVdHLxg
         hYBL8FNqhXUvyrkDg9rmqFyGZhVjCkCr817+am2pzRfjLETD4WTnlStxpD0xMvePvY1b
         oguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tm8yFZUSdTnqIjKGZ6VZglkuTBXRVbKsUQ1CjpbZbZY=;
        b=DQ/oh/5FAh2BpzhWzIHZO+F3xnHHAhGj1zzl4iiKBh93JLWlIa+4Lw9MDen2LY/Sq+
         OUXrwpxedi210t2oLoe8hux2gkNXuGensN2PD3PljaK/eYbdlGp2MroNQtVGvGM6q0u2
         rPECwn9+MC++SYBa1iTE3nej8Q0zfHfaOacuJ2iE0vjM08n+wUYHK7ycApdHbVlW1Nxq
         obQP9GGJneB+Su6z/m0avTXcstlKQiSVV9+qRUi1iBTIsC+5OWg4WBZYZedvUVn29Tom
         yvPRfHoEKYVQex9nX20iRBsvThwQxIYKfkDWIiP5x2ZNBI1njEg35Vqur+5q1pP6zThc
         O78Q==
X-Gm-Message-State: AOAM533HfXFPenRM4Z4uGJXuBPDyEBQBMRhrN1hPt6bQ9fOweQFmz7TP
        cDXJ/SROANDZ6p2fltgQWezvoigUU4pMyUzS6uWD1tbryrQvqjWgkvc=
X-Google-Smtp-Source: ABdhPJxnzlTZ++6VdEamfDyUJ3WWiNxqPKsB5bp4n4tnddV0FuEGpK2mu0hwjpMQdh37ghptk63LbExeYEDWNzTVV4U=
X-Received: by 2002:a92:c68a:: with SMTP id o10mr8543614ilg.163.1630935056017;
 Mon, 06 Sep 2021 06:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net> <CAOLTT8RzHb5zWUm1psZRTP=iST-jP4DBmG2Zh1UPdo6z+QyHcg@mail.gmail.com>
 <YTS8yiYwR+eeZf4+@coredump.intra.peff.net>
In-Reply-To: <YTS8yiYwR+eeZf4+@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 6 Sep 2021 21:30:45 +0800
Message-ID: <CAOLTT8SYx4f8x-0zjXLJVOpW4-Mj34mjsfwr6tWo0PbZAV9B0w@mail.gmail.com>
Subject: Re: [hacky PATCH 0/2] speeding up trivial for-each-ref invocations
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=885=E6=97=A5=E5=91=
=A8=E6=97=A5 =E4=B8=8B=E5=8D=888:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Sep 05, 2021 at 04:19:53PM +0800, ZheNing Hu wrote:
>
> > > In this version there are 2 patches, tested against 'git for-each-ref
> > > --format=3D"%(objectname) %(refname)"' on a fully packed repo with 50=
0k
> > > refs:
> > >
> >
> > Regarding this 500k refs, is there any way I can reproduce it?
>
> Try this in a clone of linux.git (or any other repo):
>
>   git rev-list HEAD |
>   head -500000 |
>   perl -lne 'print "create refs/foo/$. $_"' |
>   git update-ref --stdin
>
>   git pack-refs --all --prune
>

Sorry, It seems that the above command is difficult to complete on my
machine (it took more than ten minutes). It may be stuck on git update-ref.
So I tried to reproduce it in a repo which containing 76K refs:

Benchmark #1: jk-for-each-ref-speedup~2: git for-each-ref
--format=3D'%(refname) %(objectname)'
 Time (mean =C2=B1 =CF=83):     108.0 ms =C2=B1   1.9 ms    [User: 55.2 ms,=
 System: 52.1 ms]
 Range (min =E2=80=A6 max):   105.7 ms =E2=80=A6 112.4 ms    26 runs

Benchmark #2: jk-for-each-ref-speedup~1: git for-each-ref
--format=3D'%(refname) %(objectname)'
 Time (mean =C2=B1 =CF=83):      88.2 ms =C2=B1   1.7 ms    [User: 44.8 ms,=
 System: 43.1 ms]
 Range (min =E2=80=A6 max):    85.8 ms =E2=80=A6  93.2 ms    32 runs

Benchmark #3:jk-for-each-ref-speedup: git for-each-ref
--format=3D'%(refname) %(objectname)'
  Time (mean =C2=B1 =CF=83):      69.0 ms =C2=B1   2.0 ms    [User: 22.7 ms=
, System: 46.1 ms]
 Range (min =E2=80=A6 max):    66.2 ms =E2=80=A6  74.1 ms    41 runs

For %(refname) and %(objectname), this performance optimization is
indeed amazing.

> Though I actually think for these tests that it is not important that
> each ref point to a unique commit (we are not opening up the objects at
> all, and just treating the oids as strings).
>
> -Peff

Thanks.
--
ZheNing Hu
