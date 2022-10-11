Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37675C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 06:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJKGss (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 02:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJKGsm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 02:48:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51FD7697B
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 23:48:41 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r22so14357853ljn.10
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 23:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8neS0bH/Zo3SjFbekDUjn14sD/Md6AG9h1v1Xcl25Xk=;
        b=hUO7ZjtSspidE4MzM8JJH81Kl0RCVCPW6JEfbjCAu0zBG2LKEyzYmvJM6GzvRCzHJn
         QiM3eTxAZdwgyZEicy9KScGDLJ9RHg5wLHVhi0cgLCRfR+8OOATBVCtQJF19L/XNmMzA
         vxdsIgb1JS9Krs8lHuUPDnyVTPNqXZt+uMQERM/c0HNWfnsLp4uAi87/aVT3m+lra6ma
         FqzDQUWx5S1iZdMrfxxxfH3S66glDy8I6HUK+jgMzJOt4KJ/KhaIOe/pz0uGhvMhiJAN
         6/GCeE8e7TrPr8xTIumrf98fg1CQGkr3tCJzJVszDU8BU18nv/KDqXFg42AeUTJ2hee5
         244w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8neS0bH/Zo3SjFbekDUjn14sD/Md6AG9h1v1Xcl25Xk=;
        b=idYDc6abTy+/obHpYJERjqdVvY+qxPTVjj27UyhbZAvu8c0TIs5ImZ5XjMG1LIgby/
         oMjaqOgeD5G024yMIvICDUYGJ5D4QXDjTNbqyQj+8pMw5VjVkYAxSDXGRfpPb0SmP6Sj
         kVI9wq5CG6xS7FxDIMggkGQt8YMzV6X+H4FR8hSPPHrcx48MT50V4QoLIE3KSdvpQnuN
         G6vsfHuC/5i05fDIlCWwq/phUWx6WgKbFL5phoaQz4Oeh9CnnmBpX6rMqZSoccIfDdyU
         iCGF1wRKdSyjKkM45Chj1UIQS0+Jf+5VJGuITDw1cRsGZ2CZ5zy4zlb3m4p8gnXO9zo2
         zHzQ==
X-Gm-Message-State: ACrzQf3FqXfHJ6MX/kbE+Zn/RtA+3GwADZ7I/C/yxeOyEXWfz6j0Fujp
        wZrVypUXwBWWm/9oChqGahRtaolt4pMyLI2DJlo=
X-Google-Smtp-Source: AMsMyM6UbbHkmGI6/GRHCbmmwyMPVBzTOTdoe21D1uDwesaMp1mOtK3+oR4FEu+LZUwXVST5Nst4DTgk+nyWFbuILdw=
X-Received: by 2002:a05:651c:a0c:b0:26c:4f22:27ea with SMTP id
 k12-20020a05651c0a0c00b0026c4f2227eamr8336529ljq.281.1665470919682; Mon, 10
 Oct 2022 23:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
 <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
 <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
 <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
 <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com> <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
 <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com> <ae8a98d9-eec1-cdcd-67a3-695aaca7f5ae@github.com>
In-Reply-To: <ae8a98d9-eec1-cdcd-67a3-695aaca7f5ae@github.com>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Tue, 11 Oct 2022 09:48:28 +0300
Message-ID: <CA+PPyiFC0mjvY494AVZMB952Ux-TPyA-Uetu1xQ6FiHA_vaRaA@mail.gmail.com>
Subject: Re: [Outreachy] internship contribution
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Luna Jernberg <droidbittin@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simple steps that I followed on windows 10
-open the command line application with administrator rights
-run wsl --install.
- Restart the computer
-check installed distributions, wsl --list --online
-run ubuntu distribution, wsl -d ubuntu
-add username and password
After the above steps I was able to set up git on ubuntu
NB: to start wsl when you stopped, just type wsl -u "the username u
created" in the command line

On Mon, Oct 10, 2022 at 9:22 PM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 10/10/2022 2:17 PM, NSENGIYUMVA WILBERFORCE wrote:
> > thank you all for your suggestions, let me see what is easy for me
> >
> > On Mon, Oct 10, 2022 at 7:58 PM Luna Jernberg <droidbittin@gmail.com> wrote:
> >>
> >> Maybe WSL can be used?: https://learn.microsoft.com/en-us/windows/wsl/install
>
> If you do go the WSL route, then please share your learnings by updating the
> contributing doc either in git-for-windows/git [1] or here on the mailing list.
>
> [1] https://github.com/git-for-windows/git/blob/main/CONTRIBUTING.md
>
> Thanks,
> -Stolee
