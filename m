Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A24C2D0DE
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 07:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C873206DB
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 07:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+Lq0Cto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgAAHsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 02:48:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46127 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAHsj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 02:48:39 -0500
Received: by mail-qk1-f196.google.com with SMTP id r14so29431108qke.13
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 23:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dAoiM0UgEnfho/0EZtf12i+iuK53ixQnJ/Lr3/YBpSw=;
        b=n+Lq0Cto7Lx2tjKBN2zOrtu1EplW7OcjkkhufB6bi5/FnCZBPNqirApy0VFk/D4Tdj
         6uuClNz05wAozoXmCzVV9f/lz3q16yqNkw1XJq2omP2yfk+emonE93vdDwa4iddOVdkC
         0CMIrm+m7g8mSTQecMmiyZ6Yr5/VqhKh1+8dj7PDIYIiGlKquU+B9MsAQFAcJhactXY7
         W/7OlAETCRqVHhwwNHLE0e4byp9tA7WyPm+QfURGdhbGBf0oqa2OSF6FoqF/2fyezLpv
         Xrd7dqt8lN1GODixBcvu2Ocm1scHSsS+8TEf9n7A6ekbm92ER0CbZj5axg4CuwYEJweZ
         /3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dAoiM0UgEnfho/0EZtf12i+iuK53ixQnJ/Lr3/YBpSw=;
        b=ifVrpDDG0rKd895vKzg39CwNWQgQshveIZ0qMy9/vCoaw60NK7K/7VZF85r2TqmTWO
         GDEFImoOiBzYqddB01H7NcOYomtSQwQ/zsqfBM4fR+/qtjJBSiVk/1jIHsxwrcgFNZAa
         xSC0skv3+lMPjllEIcjU12PndnB8vEXMus2l9i+9ehPQlYxosigSa/7PKSAO+3jZrKKm
         i03WbKHeha2hRiYuKGeMZFjMlLAXsbKH/LV+VRUILDpp4kAEJCshf7wkHMHtpNUPuxlN
         NSdoz50/eCsIoXrOZT8a5nhXBEfM3gvikbEHuDoUqOYHQOLvIxgs9ik/a6bWxbooxnJL
         H28w==
X-Gm-Message-State: APjAAAWxkLnyZFN1YKuprEFEf7awJW73XPFRjrzWcf9m51+YHtmsXvFc
        Xg1bTvQV2XnQPO/Vps9uW5A=
X-Google-Smtp-Source: APXvYqztuCoAwtlyEQjGN0FAjFNDlBzxTPUDGk6HTOvJujvymJwkdIrRRVRKcu28i8GIZ/PX9Wr29A==
X-Received: by 2002:a05:620a:4db:: with SMTP id 27mr64181849qks.146.1577864918733;
        Tue, 31 Dec 2019 23:48:38 -0800 (PST)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id i16sm14125105qkh.120.2019.12.31.23.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 23:48:37 -0800 (PST)
Date:   Wed, 1 Jan 2020 02:48:35 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 00/17] merge: learn --autostash
Message-ID: <20200101074835.GA5152@generichostname>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <cover.1577185374.git.liu.denton@gmail.com>
 <xmqqo8vpfpri.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8vpfpri.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Dec 30, 2019 at 01:49:05PM -0800, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Alban reported[1] that he expected merge to have an --autostash option,
> > just like rebase. Since there's not really any reason why merge can't
> > have it, let's implement it in this patchset.
> 
> Sigh.  
> 
> I would actually have preferred to remove the autostash from rebase
> if the goal is to have a consistent behaviour between the two,
> though ;-)
> 
> But it is OK as long as it does not degrade the codepath with
> changes that wouldn't have been necessary if this weren't added.
> 
> Let's see how it goes.  Queued.

Sorry for the radio silence for the past week. I've been offline trying
to recover from a particularly bad flu. Anyway, I have a reroll of this
topic planned with the `flags` change you suggested and addressing
Philip's concerns about --no-commit.

Since this is a new topic that definitely won't be accepted for v2.25.0,
I'll probably be taking my time with this ;)

Thanks,

Denton
