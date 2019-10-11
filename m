Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7651D1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 07:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfJKHuO (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 03:50:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41121 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJKHuO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 03:50:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id f20so7815261edv.8
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nrj4ynkTQkDYEFpD4w2Kbk8Ftzb46SKMoBgl17ANXlw=;
        b=j0IrV/Ip1gKivh3Zxx85s71BPkAfjTCQ0gsDDr7dqviTw4xgPfluKPVBfTEA81pT6K
         IjgC2+o5dDai/wjXjthIRWid7pBoH9r1sdF1khboKTIqlH7JXC8hAAVqVziKRikLUb5T
         6yRrbYDW39n3YAyoFdxCMzPpvIEJXYz80AsJ70aIGTzLR7nNhK9cfA5QdMeVlE59grdc
         1u5OHbr5TQlVpx4vgwAbr9im6lh4ZF9BV+cqRQvLjMDdfcRl3tTtlTNO1gGiqh+RPzUo
         eJkZ/dEuPaXNGmVMZm6Egv90Yh+ba34I0+XH2l7hx57vAeHecbE3RWqxshOeyb1bD5WW
         3p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nrj4ynkTQkDYEFpD4w2Kbk8Ftzb46SKMoBgl17ANXlw=;
        b=EaXXw0ktdCfbKplg+zO3H5fu93I5NuinAA63ftjzA5gWkuny1hkA3SISJMEvi52mcv
         HLDxZUtSpATqwltDaVBsVT+ff9x8gwA2KDRUnofTbSF2TGZNeqBZCoCKP7cxX8jVE3zu
         0a/ekay7dJakFVvdrNuzWtlAK5py1IuukE/Y9A1/6isn+MtsTZOZQ6lw4xdUzvcxZEkt
         jiSlJVNqtpUrPbjwv9RM15VFE0MW98qw+4LnMiKUhSXba1LQYvPb9KilO8W8j3/hwCy2
         b/QeGuMFjnq/h6cr90r+e1XLF76WredFdhJSIEx349NbK25OGesWR77cVlzDBVwdN7Em
         4vtw==
X-Gm-Message-State: APjAAAW5JyILK37vXu594BKwxbHfT6awWf8VDVI1egpO6aldN15t8rdR
        EU5wV8ksHuv1fJNL4uO1L/JAYSAIXIPa6mxvUkv0lI8c
X-Google-Smtp-Source: APXvYqy3ZflXZ750xQ8IsBSXFQYtPBbODvjZkNwh0jF1eOFiuNRYWNW/XNepEw72ym0txl6y+mqEMGmByJlCDLq9sQg=
X-Received: by 2002:a50:b5e3:: with SMTP id a90mr11940629ede.201.1570780212682;
 Fri, 11 Oct 2019 00:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190913130226.7449-6-chriscool@tuxfamily.org> <20191010234408.170356-1-jonathantanmy@google.com>
In-Reply-To: <20191010234408.170356-1-jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 11 Oct 2019 09:50:01 +0200
Message-ID: <CAP8UFD0mZgN5=Bva6drLoAusMTomTZ9X=jRCeGgrTBK-mxCBLw@mail.gmail.com>
Subject: Re: [RFC PATCH 05/10] pack-bitmap: don't rely on bitmap_git->reuse_objects
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 1:44 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > As we now allocate 2 more words than necessary for each
> > bitmap to serve as marks telling us that we can stop
> > iterating over the words, we don't need to rely on
> > bitmap_git->reuse_objects to stop iterating over the words.
>
> As Peff states [1], this justification is probably incorrect as well.
> The actual justification seems to be that we will no longer compute
> reuse_objects (in a future patch), so we cannot rely on it anymore to
> terminate the loop early; we have to iterate to the end.
>
> [1] https://public-inbox.org/git/20191002155721.GD6116@sigill.intra.peff.net/

Ok, thanks! I will change the description.
