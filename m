Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE94BC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD07020707
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRuDvxR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKVSEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:04:37 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:40244 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKVSEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 13:04:37 -0500
Received: by mail-pf1-f180.google.com with SMTP id r4so3819828pfl.7
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 10:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WB452Kjlfol4AhG+9ZjrKqIKuiKnd+d2OHinTUSPReU=;
        b=tRuDvxR4Y9vOFZlzKDT1OKdBJwwNFLD/GXgmlYWZWbpZU2/3xiT48HICC8flj05Mlb
         Z9Xcht5YEIcLU0+aSy2PsHjU7Cev5g8bKJUgou2TeVk2ELbhf5TjD8DAdcWfnsiGygyg
         pLZIBuT0fZFnm2eX6WcPZqCD9a3+OCW8KStLkVuJhU/bm9+LEV6zVXKMn+caPVYvBytz
         wAVn6Hg+WG280b0UCStgj1mShWv0GqMmHmr4JL4x/uJ4SU0DGsLYur6Wq8jsDXbXrG7R
         Pz0akhwgg8PPtri4QZypxYlSLusCs5Z9w5ld7tclNc5e6gOIXeH9noQqVPvlrPgFFup7
         PhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WB452Kjlfol4AhG+9ZjrKqIKuiKnd+d2OHinTUSPReU=;
        b=UOEwx6tVU+Pafw2ivjJ4G04oGB9fNtj43suwZl1kqRmQSFyvB7KyGHW8hM8kvz8gv7
         ef6SYiSfRijbgJUptlARzQX+0KAfeCfHdsJQaLPn8mew9Jo2QdT7uY9zcO1JOx8XgCaJ
         bJrapBOFygN7IkXfk/Qj9jpPqCdwSggsx91QeiiPI61yJpu/3+H3vDZPytGW3N5JdPjr
         TjSyPsLXSnezL+jg9tQUl2Op18vAbVSoIQB2YHiRKMHcErlCjOzW+Cr0HimWlwT4s5Fy
         Cq4jrqovGJ8fXJW34+26E3wBI0urRaNORFKu5hvw6bIkbUXqRU8ykJFIGJ5azpFVosi8
         qjVg==
X-Gm-Message-State: APjAAAVbJYxKUzuGMqDDPBG3Pxo3Tvf3BniXW0qPV/byTI1zR3gVt9r1
        dBCSUy+Edk4ILIyqiFOC+QU=
X-Google-Smtp-Source: APXvYqyaK/5QT9fdkZM3DknSgs25A/RchNeRG6plF8inJKiD2qOvyFaGwQvef8t7mm1njN3U0PlSiQ==
X-Received: by 2002:aa7:90d0:: with SMTP id k16mr19350791pfk.131.1574445876352;
        Fri, 22 Nov 2019 10:04:36 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id u7sm8217031pfh.84.2019.11.22.10.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:04:35 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:04:33 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Craig H Maynard <chmaynard@me.com>
Cc:     git@vger.kernel.org
Subject: Re: Git CLI
Message-ID: <20191122180433.GA57478@generichostname>
References: <3AD06998-1729-46C2-8B60-BD405C365656@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AD06998-1729-46C2-8B60-BD405C365656@me.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Craig,

Thanks for the report.

On Fri, Nov 22, 2019 at 08:12:48AM -0500, Craig H Maynard wrote:
> Just noticed this:
> 
> $ git pull
> Already up to date.
> $ git push
> Everything up-to-date
> 
> The two messages covey the same information but use different punctuation and hyphenation. While not terribly important, this quirky inconsistency doesn't inspire confidence.

Unfortunately, this has been caught before but remains for legacy
reasons.

According to 7560f547e6 (treewide: correct several "up-to-date" to "up
to date", 2017-08-23), it explicitly mentions in the commit message,
"Don't change plumbing (specifically send-pack.c, but transport.c (git
push) also has the same string)."

So as a result, we can't change the `git push` string to match. I don't
think it would make too much sense to change the `git pull` string to
match either since that would intentionally introduce the "up-to-date"
error that the above commit fixed.

Thanks,

Denton

> 
> My environment:
> 
> git version 2.24.0
> hub version 2.13.0
> 
> --
> Craig H Maynard
> Rhode Island, USA
> 
