Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE193C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 09:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiK1Jqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 04:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK1Jqt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 04:46:49 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188A519034
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 01:46:49 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id e205so10943522oif.11
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 01:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OTB6fJZfaH6mClQyVickdw73O7AHJ6q1iemFd2LWk94=;
        b=UBJu+BnJ4CosQehJHeoDNNvdByBFRhDsX4CnQiqSkBrGisbM2sBYwXzul8GVp8uIjG
         AFrsMl/bRBQabPwJGC59gjGaLoCwuDre8itrlNw/9ekGG+fhAf8f1klGV8QARGAl+Uf7
         lBrEsUqVKEzDQm5V0ifnzIenD5JdVUyG7HydF+D+x15Z/MgCjvswcR6ubFdkeWLuy2AT
         PyXKGH0MsCk3S14ld5nZC1+97x82LSmjk7kJwmxCPGe0/KHCRjq5AKRwLR2NfzA+Zx0v
         Hfm5MhP4wUeiCdq8Z1pd+1HOWwmZTByyWYurv66D0Jt+jjKklWcb/sTCYKvuHCYKd6M5
         MWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTB6fJZfaH6mClQyVickdw73O7AHJ6q1iemFd2LWk94=;
        b=dbdV+WpvDXitpD1zUxz5u4Qkf/V29QBw0WlJNwAVAKM9XRsfhpSs2VcUxnZ7O8oSlg
         2okBDNkr7LTWMQtrhjqkRtkgGHcUH/8HUFvm8g7UY64r+BV+phqrMqEZinrpcfIHWUc+
         EgnIZ1WGh4+DkfF0loVec9BxMcgFYeUEY1ryJd2PoflIk7a1kX1ZSVzFObhE0Vt8/Jvi
         dC5/UFyAWg5Zb4XsgC5g8Mgzp+eLWC31/yQnorR53YzZVOSNxeLIaVsvR5TIbm4PhZg3
         kU16lrnzNoxdhA4rBvVb8W81VyIpaikK7qV8Q9Py5XhdfQrCRqEX8CuOK5Ypi4SPgpLm
         Xahw==
X-Gm-Message-State: ANoB5pmVBDqlpzbxMSTg9/49EIT+Lef0xpChZ/gQ+8H1CxTs4605gHf7
        qxRPfphydB9Zpv+fd1B7fb1kuCjmutYcIzto3kYRZDSb
X-Google-Smtp-Source: AA0mqf4YEuLOr/AGuHw/f+32N+wJinfijirnSVKskSB085ACv1xKRW/8qBk2fQt+IdvwqVrAxJkPMGlTuRp7E2STvIc=
X-Received: by 2002:aca:1004:0:b0:350:d543:7554 with SMTP id
 4-20020aca1004000000b00350d5437554mr26016436oiq.251.1669628808456; Mon, 28
 Nov 2022 01:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20221127145130.16155-1-worldhello.net@gmail.com>
 <20221127145130.16155-4-worldhello.net@gmail.com> <xmqqwn7f7ktb.fsf@gitster.g>
In-Reply-To: <xmqqwn7f7ktb.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 28 Nov 2022 17:46:37 +0800
Message-ID: <CANYiYbHtC57e4PpsxKRcfU9QVwjiy=__AnfgsUMzBeJr7LYaTw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] t1301: do not change $CWD in "shared=all" test case
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 12:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > In test case "shared=all", the working directory is permanently changed
> > to the "sub" directory. This leads to a strange behavior that the
> > temporary repositories created by subsequent test cases are all in this
> > "sub" directory, such as "sub/new", "sub/child.git". If we bypass this
> > test case, all subsequent test cases will have different working
> > directory.
> >
> > Since the test case "shared=all" and all subsequent will work properly
> > in the default test repository, we don't need to create and change to
> > the "sub" directory in the test case "shared=all".
>
> It is much worse than that.  If existing tests after this step were
> running destructive operations in their "..", because we have this
> extra "sub" directory and such a destructive test were running
> there, the damage would have been contained in $TRASH_DIRECTORY but
> with this change, it will touch t/ (or the parent directory of the
> $TRASH_DIRECTORY).  So, "will work properly" may not be sufficient;
> we need to audit the rest of the script and make sure there is no
> such funny "step outside the test enviromnent" happening before we
> are sure that this is a "safe" change.

No such funny operations in the follow test cases, but will add some
notes in commit log.

Thanks.

--
Jiang Xin

>
> It is the "right" thing to do, though.  I do not see any reason why
> we want to have an extra level "sub" directory there.
