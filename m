Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE17EC636D7
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 17:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjBHRsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 12:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjBHRrx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 12:47:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915965FE3
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 09:47:03 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so3077306pjb.5
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 09:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAhVeSycQ3apIDQHmvxT4vaHv348ntv3koMA+er0G0I=;
        b=FOKXPfpLIsg2xMSz0u/K7zgXAyPvhM2pSfLSydumB6BHmpYNSEUwWm08YLbmDJdlVE
         Ibo3IE591+7/evN3V2F14YVRCj7YI9h0MdNGRfG6GbXm2IOIPIWs96O5SvShJWwi9pjv
         g9SW7MLPKb+lhLThKnZ0Uwh08FuljBGnN3KfQYHj8WriNpM5cn49696DdPQuyKBf9LSW
         Kq9Iw9eN7d9xMseCti4ghr5iqDiCbWnJA/T3GSb2ByPRw/ZQi31iSLI55RiLi4r2bxdl
         p73A4n/z0QiEBVDW1hA6Krh7/MAteLyW79HJcfuwMMj5ncZsa1x3bwY09/KuhsX5/GtD
         FOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vAhVeSycQ3apIDQHmvxT4vaHv348ntv3koMA+er0G0I=;
        b=a9oTbOcVDGq7gzVySRfDtQAjpzxqFirea6rmxM4VbuQ+L2UPB/agGs0feiAwD34Xc0
         P2z3KeQrXc/CmxFW+a1Q59rndquj7qJd35UDKFIHcKYmTJVXSkMZnQeYMdrSD1tjRlCi
         RwU19FGZxZ+wlGyX+TkI8UYbm6QYzaP+SpRqjl/BGQGKYh2CB/QiEYFbPrt7vm1bJ1yW
         SMGJ1q8IWGfqw//gRHtrZW8b/C1L2bC9jK/KAN2Hplpr8Q8pMplif3A9K3Ls6zFyT3SG
         GjaLRksTRe9bDo2Lb17fBamaQfIG+Fu2r9VfgLvL0iKSoDOe2gk2m43ZwlybBs4JxwTG
         yKJQ==
X-Gm-Message-State: AO0yUKXLgRQyEK3QgejSC79ye5YhNtDHe0zfXdi805coSe4buziC+SEQ
        fEKRwo6AbviqxZ0gIonAU1Q=
X-Google-Smtp-Source: AK7set/f6pFfPOiN75UmiCjhgJGYQlDufaT3xwz4Ksui2ejyJ2YSem3tCHRjqLLP9ouWuuXdw2eeLw==
X-Received: by 2002:a17:902:c111:b0:194:91eb:5b84 with SMTP id 17-20020a170902c11100b0019491eb5b84mr7073747pli.22.1675878421082;
        Wed, 08 Feb 2023 09:47:01 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b00186b7443082sm11318962pli.195.2023.02.08.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:47:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     William Blevins <wblevins001@gmail.com>, git@vger.kernel.org
Subject: Re: Unexpected (bug-like) behavior in `git ls-remote` matching.
References: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
        <xmqqedr0vd1l.fsf@gitster.g>
        <CALJHx12DetwZ=+aMEG6Ss4P3fMTeLN2styXuPw93C5N6yg98NA@mail.gmail.com>
        <Y+POCxHMzrZj2bwz@coredump.intra.peff.net>
        <Y+POvZLrtfm/qQwp@coredump.intra.peff.net>
Date:   Wed, 08 Feb 2023 09:46:59 -0800
In-Reply-To: <Y+POvZLrtfm/qQwp@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Feb 2023 11:33:01 -0500")
Message-ID: <xmqqv8kcrqwc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Oh, and I forgot to mention: the documentation for ls-remote is quite
> weak here, and simply says "matching" without defining it. So the most
> obvious improvement is fixing that documentation to describe the current
> rules (which AFAIK is basically matching the pattern as a glob, but with
> an implicit "/" anchor, but somebody should double check the code before
> writing a documentation patch).

Very much.  

On the pattern side we add */ in front of the given pattern (so,
'master' becomes "*/master", and 'refs/heads/master' becomes
'*/refs/heads/master), and run wildmatch() against refs prefixed
with '/' (so 'refs/heads/master' becomes '/refs/heads/master' and
matches '*/master', and it also matches '*/refs/heads/master').

THanks.


