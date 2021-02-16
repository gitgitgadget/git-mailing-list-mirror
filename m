Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF14DC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 03:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD45C64DC3
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 03:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBPDQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 22:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBPDQh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 22:16:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049DC061756
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 19:15:56 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fa16so4862741pjb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 19:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OmWFC+CXhz9aj6XOt2xWdwHZM4DcM2V3m7gCWdgBxg4=;
        b=aA5IFBpdV+I4Lj4CS4csc/NuGufPb2fgFNNBoQCgkBbm3h2BmBuCTFZ1/5YxT7hMfN
         cPf93Y73oc2Or4Thw7MC1GgEd/dgf6Xo5ViQKhtyF86QQP6q1+BeRaUT6JknAA+H1UWo
         0cGUlr9ZtLBjaa3Xa7WGEOot0u0KHL4UpTpQntstqJzQmRpa5EjNGHnfYdGhPvU08irm
         gjSUtX920fqwAD9fMd9Loz4kxtxdPWytEzXCnSGEEk5QgP5shUhYJJKWODNkVYHqf+Q8
         jxRbgM9MVWxCXuEUqeTmOhOU43ezxvEDiKhXo57FSfxcq1MQD5x90QjQHTtqW6xLrSjL
         hKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OmWFC+CXhz9aj6XOt2xWdwHZM4DcM2V3m7gCWdgBxg4=;
        b=f94Pf/c68LrgkcaoIZi47XlMnexYg2P/LX73MlByGBcKoWOFid26J6oynGzr5EMAGv
         IcvyJsQV0ni/Sp6n96add3JXUJmohkGptHQ5WtW0jj43wQlBjOLMwjOEtoIFtk1+fIM4
         K00WtgJgt0uSI55Fhq3pxQwI+UXksuBLoQ1DuI1IEfhJptDha7WCa9WgAhldZvQQ7TPT
         OMmCh2kt6ojzKKd5GJmyI73L7OIE1rNxMPJcaTWFZWgw1p2iO5GQzrdsrqN3PJCDlloT
         Lq4sS1YyobPmFY+Qh1+US1HHciiZsFASc7GsWTAmzawN8X9bvUCNFhOO+sg2THymXmTG
         yXeQ==
X-Gm-Message-State: AOAM531R5ngCMoH/lJ34mfFFm0eybDDyD3DTY921N0bHGA5krrFKl+1f
        84CpoZFk1DyP0csr6qvZt9si8fX3ZPc=
X-Google-Smtp-Source: ABdhPJwgpFZj5BdFQmk0aCey8YXonk3y10++spoyqTrNZ+LaXgW6wOs6WAFNwo6OmHikewyw4/pKzA==
X-Received: by 2002:a17:902:9a46:b029:e2:f97b:47da with SMTP id x6-20020a1709029a46b02900e2f97b47damr17719652plv.77.1613445356522;
        Mon, 15 Feb 2021 19:15:56 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id m16sm20627186pfd.203.2021.02.15.19.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 19:15:55 -0800 (PST)
Date:   Mon, 15 Feb 2021 19:15:53 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 8/9] stash show: teach --include-untracked and
 --only-untracked
Message-ID: <YCs46VzamjuDrQR9@generichostname>
References: <cover.1612258145.git.liu.denton@gmail.com>
 <cover.1612855690.git.liu.denton@gmail.com>
 <88d47912595b5650fbca595a6dd5b7b943a93301.1612855690.git.liu.denton@gmail.com>
 <xmqqa6sc4avx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa6sc4avx.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Feb 09, 2021 at 11:53:06PM -0800, Junio C Hamano wrote:
> > Do this via something like
> >
> > 	GIT_INDEX_FILE=... git read-tree stash stash^3
> >
> > and diffing the resulting tree object against the stash base.
> 
> That explains the implementation, but does not make it clear what
> the implementation wants to achieve.  So we read the tree from stash
> (i.e. working tree) into a temporary index, and then overlay the
> tree of stash^3 (i.e. untracked) on top---which means the resulting
> "index" has the state of the working tree plus the untracked cruft
> in it.  And comparing that with "stash base" (by the way is that a
> term well understood?  I borrowed it for the above review comment,
> which shows that there certainly is need for such a term) would show

I'm not sure if it's a well-understood term but I can't think of any
other meanings for the term so it doesn't seem very ambiguous.

> the diff between the "HEAD" and the state that would have result if
> you were to do an "git add ." in the working tree.  OK.
> 
> > One improvement that this could use for the future is performing the
> > action without writing anything to disk as one would expect this to be a
> > read-only operation. This can be fixed in the future, however.
> 
> Is it so difficult that we have to delay the fix for "the future"?
> After reading two trees into an in-core index, without writing it
> out to any file, all that remains to be done is just a matter of
> running diff-lib.c::do_diff_cache(), no?  I must be missing something.q

No, I don't think it's difficult. It's just my inexperience with this
area of the code.

> > Another limitation of this is that it would be possible to manually
> > craft a stash entry where duplicate untracked files in the stash entry
> > will mask tracked files. This seems like an instance of "Doctor, it
> > hurts when I do this! So don't do that!" so this can be written off.
> 
> Well, when you read the second tree into the in-core index to
> overlay what you read from the working tree state, you can certainly
> report the collision and error it out.

I'll send out my revised patch later today and I was unable to figure
out an easy way of doing this.

Thanks,
Denton
