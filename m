Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51035C2D0B1
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 06:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244BD2082E
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 06:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpmY7cEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgBGGnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:43:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39404 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGGnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 01:43:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id m13so1237903edb.6
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 22:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwWb+yr/cTWRYhIBFFNRoNuglqOjram2x+ZvEiwYjMI=;
        b=SpmY7cEBRDUh5XC84rU08nyvxXS5H/IkZE1Wi267IS+qc4LmNP6O8yTlKHDcoSiFoP
         8QQKcPlks/tsqGGL/uizWlxQ4IyqwDmK2F+J3JynM6K1YBLPmawcKRF817hasnm7zicn
         lRMDyiCKIo4+0POCskvcgCFM8cNSug0Vx3zCiDFl8lT2v3pQ8rMpviYvlajWr8SuWAa0
         sB2Gy0t//2sxyfyHJDlsvmmrfwVTtPnkCVSvk+G4IoIcJckQZGpJUfSAmsi9iM2iRc1j
         pE00Yh0UGs4iCljBtDXS7QbuiguIqlpzrV9Vq5nthPQ3gI0DrBaboJXRXhVtDGfa0pOk
         Vprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwWb+yr/cTWRYhIBFFNRoNuglqOjram2x+ZvEiwYjMI=;
        b=GoFamtUP2B3FUd5YX4msjbh04hBb8d1DnfNY4eWu2EeliKT4twBOrTRlvE6t8g298G
         mLbK+8aebSH3t6XdaJ7MTq5VDcrc285f9FoYykS5+0xpTHrl6Q6HIzkJ/XgOfD1x1bfR
         /uU48DCYelZL2l/yRtmD8cGYIEHg/ruNlwcbw1raUoPTUsFJAtcf9NKk5qeOF187W8IW
         qPhB+dfl644K8A+XB0jFo7tpsxGxtJkg36VB2tWxsxcZxoFmo2LvQ0e3gXIVPww6bRnN
         ffeXdrOrDM/IOT9sVEoA2teskmKomY9SHk8uE5BJs4IGaUZ5NpQm/zaRs9Cs2Hm4D3a/
         24Fw==
X-Gm-Message-State: APjAAAW71GSncMzZQPIxUQcRbQo1+NnfQR+N7C4qDUqEjOS4P0IHiax4
        SwOJAM6CqgapVmfFX7CxBr1YfOk5CuAQL6CnsStFIcNg50M=
X-Google-Smtp-Source: APXvYqyvb0Pey+6vV/Skx9Ws376qI4GUKJg88N6qZNWQmNLlDH2jIb6pFaFF9GZs0Xqso5vBNPc46yxk0qChqmr94dw=
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr6501668edv.273.1581057783720;
 Thu, 06 Feb 2020 22:43:03 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 7 Feb 2020 07:42:52 +0100
Message-ID: <CAP8UFD1ascbutL5RGSGC1-eWvOJDpbcZ=edSG+WCd7aAkCmn8Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #01; Wed, 5)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 6, 2020 at 12:36 AM Junio C Hamano <gitster@pobox.com> wrote:

> * jk/packfile-reuse-cleanup (2020-01-23) 12 commits
>  - pack-bitmap: don't rely on bitmap_git->reuse_objects
>  - pack-objects: add checks for duplicate objects
>  - pack-objects: improve partial packfile reuse
>  - builtin/pack-objects: introduce obj_is_packed()
>  - pack-objects: introduce pack.allowPackReuse
>  - csum-file: introduce hashfile_total()
>  - pack-bitmap: simplify bitmap_has_oid_in_uninteresting()
>  - pack-bitmap: uninteresting oid can be outside bitmapped packfile
>  - pack-bitmap: introduce bitmap_walk_contains()
>  - ewah/bitmap: introduce bitmap_word_alloc()
>  - packfile: expose get_delta_base()
>  - builtin/pack-objects: report reused packfile objects
>
>  The way "git pack-objects" reuses objects stored in existing pack
>  to generate its result has been improved.
>
>  Will merge to 'next'?

I think that it would be indeed ok to merge to next if no one comments
further following the v4 [1] and my last reply to Peff [2]

[1] https://lore.kernel.org/git/20191218112547.4974-1-chriscool@tuxfamily.org/
[2] https://lore.kernel.org/git/CAP8UFD0h1TFVNqH7g823psaQzmEmzoz200CkZuDOV8GqNV7mrQ@mail.gmail.com/

According to Peff the code in this patch series has been running by
GitHub for years. This patch series is also now used in a custom Git
that has been running on gitlab.com for a few days. This custom Git is
planned to be part of the GitLab 12.8 release later this month.

Thanks,
Christian.
