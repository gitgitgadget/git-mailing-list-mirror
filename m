Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7075DC433E6
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A39A64EB7
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhBSGLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 01:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBSGLa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 01:11:30 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02945C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:10:48 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id h17so4799641oih.5
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdvrZZWGxWvbcr2QSxVhCjJqfUvZGoojqlZYKucVMrA=;
        b=olsZcct7RQn02MkHJQIjUkxhbKwzyYIg9EyEMcJTj19N8PqaiJv2gMTEXMR+ZLDSsW
         E+XEJVqUsAevRkkyB8FVLo0EJKCUVmQHAuCqHfogDN6zL86/8aO1USPif/7RhgJOoi5P
         ZDQEjOqyD6r8HXbIniyEyrkiYc9ZSPUNouci9W/dbiGX0JDSZUfZopwFOteIGY0S3EZv
         VPho94YB24nLinjt1OPek9MgB5qgh6xC2oj57vAF3nnet5JibVjeZ1PZQjcE6rA/1d/K
         nCgYcSVvhXImtBg7zAN6aOYTOA/rSKSlLM+hqgSrAGTFDDmm2SgcMnEn5VyVJyPfp6NN
         j8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdvrZZWGxWvbcr2QSxVhCjJqfUvZGoojqlZYKucVMrA=;
        b=GZSN2ODTRblh/pG1XyQiO4vDTlqLWgD8xY4xV6cdVq+IkGA1XSND0emIlrUKCQ/GH+
         H+cLZG+WYYYkv983hQ0FeoJVAs017iY6BDRXJbFimcNoYKNj4GQz626P5MvFqGxCQg29
         mIvZMN08/6vlnb8U0z/bOJ7buO2Nw5z4oI2g/eVaVL4WFJ6+8evfsjruGuf6HcjNVyIT
         tFyUf4mDu4y7/Uyxhr948ogrCELU0ggg2MoNk6aXIVt6vmod1QpR9yaP2Y+/BhXwUvXN
         37xTtf8PwUGKCeHOEKKkD8OsxzwCIIo6y7PsAWxQie/UH0OjF3X92hGRI5q1oy544pqF
         /yOQ==
X-Gm-Message-State: AOAM530jv/ZG/Tm1Rp/DfF/FyluKAo/1E7Yrt93EPVgwik5cHKJZXbow
        ZjetQhUVS1nHNwzmT0Vo4wnw544928MFjF4jhEY=
X-Google-Smtp-Source: ABdhPJztlCe7k1NqWlMi4qmLX/dVFl1OSuMl0zLDMOv/0hwt/b/6wiHpCrSnaAy5hYcidtUd58JVEp+jyPMY84JiwvE=
X-Received: by 2002:a05:6808:8c1:: with SMTP id k1mr5523733oij.48.1613715047422;
 Thu, 18 Feb 2021 22:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210217073725.16656-1-charvi077@gmail.com>
 <20210217073725.16656-4-charvi077@gmail.com> <xmqqsg5ujwi2.fsf@gitster.g>
 <CAPSFM5cjJ_b510wx+RtVkyxHk-aFDpOHaFRWqQuMuDf=73nBiA@mail.gmail.com> <xmqqh7m9fa8e.fsf@gitster.g>
In-Reply-To: <xmqqh7m9fa8e.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 19 Feb 2021 11:40:36 +0530
Message-ID: <CAPSFM5c_qDs3jrQaHOsLpVgFGTa_96bOooVOfjwWW4Zrc-QzEg@mail.gmail.com>
Subject: Re: [PATCH 4/6] t7500: add tests for --fixup[amend|reword] options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Feb 2021 at 00:56, Junio C Hamano <gitster@pobox.com> wrote:
>
[...]
> Hmph, I was actually imagining the opposite---a context that does
> not want to take -c/-C/-F would not want to take -m, either.
>
> Why is -m so special, and a lot more importantly, what would a user
> want to achieve by using "-m more-text" combined with this
> "--fixup=reword:<commit>" or "--fixup=amend:<commit>" feature?

If we run without '-m' option like below:
$ git commit --fixup=reword:<commit>

Then it pops the editor with default "amend!" commit's message i.e:

amend! subject of <commit> we are fixing.

commit log message of <commit> we are fixing.

(Here the end-user is free to edit the above message body of "amend!" commit )

On the other hand, if used with -m option like below:
$ git commit --fixup=reword:<commit> -m "edited <commit> message"

Then it will not pop the editor and the prepared "amend!" commit is :

amend! subject of <commit> we are fixing.

edited <commit> message.

So, with the "-m" option users can do it with the command line only.
And in both the cases upon `git rebase --autosquash` the commit log
message of <commit> we are fixing, will automatically be replaced by
the commit message body of "amend!" commit.

Hope that explains the working and I also wonder if we can improve it
to make it more user friendly ?

Thanks and Regards,
Charvi
