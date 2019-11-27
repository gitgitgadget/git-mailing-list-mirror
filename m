Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF05C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 08:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3042070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 08:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5l/Y2uN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfK0IqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:46:05 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:43398 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfK0IqE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 03:46:04 -0500
Received: by mail-pg1-f175.google.com with SMTP id b1so10445983pgq.10
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 00:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yl+Qj2PxA3FSdnQZA1B0F87Y00sClFwBWEbxjrish4g=;
        b=t5l/Y2uNadP3paeb0kgxZoKJ7NDHjUopeW/0kieRf6BJ/TG8KJvVJ2K3elfY/1nnBv
         LOsEmkCZsM1oyATMbdv1LJNbm8EN8+Isl8R2iaV9TWXNqYu3FtB5jWF+9EaDhNOduL/z
         rK+VcbNEdmIAtIaqWNhV6Dk6KjQCXqjsdEm2zBk4HN9sQ3ihQnZXle+M48inCscAkU56
         4uDJVk7JD9F9g2h9fJu2d39RYmzl/4cv8hIF5h1utI+ssKGf+5EmXwDafZdCg3sRHwjM
         f8RR9MmxkVU7zmVij9aRdajGW1Ed3aD+oXaC4B/7Kfwd9FcZAIX4ZQYk3Sz6LrCBc8xJ
         NufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yl+Qj2PxA3FSdnQZA1B0F87Y00sClFwBWEbxjrish4g=;
        b=PlnTm77Xk6Bjs4JVyCMLMm9dts/PJjxhoJsVPPewesm78ZTqN+TOsocquX0p5Tb2YK
         6sXuJez7rcflxrvUyC+fGdO7cD6WeQAK+Aksr3Ohx6YdILjDxHViLikHK4Q226TGVVqv
         QmID6f38hkII5rEgtS8vxJ6LB39cmjJOTukokv5uxEWuVrqFgwPsod4j2P2YWsW53BOo
         6VzHGoDqd6VOcKckG/XtOgSQdts3HWUU3WOy4TqRBAyrLB9L+owQKyuPcUVnkrAxJmP/
         oG4bUtPZCHzuZuMIU9SXQgrwUH0EXwJWuCUscRejSJMd7kFZSmC37O/lw2WGbLQbB3yO
         Wvhg==
X-Gm-Message-State: APjAAAUlH7J1H7rz9SICAHAnkBJz5fwUVlF9v/fKlM4mJpEmrBDpY0+J
        fpUWBD0wcnvwRu6JUbW4CKo=
X-Google-Smtp-Source: APXvYqxHtzmSGa38Bvlt6yZUVP74tAyMV6e2oSJ2BWttgzUwZx+coSbbzQtVANpEX3IsenzBGbh27Q==
X-Received: by 2002:a63:4948:: with SMTP id y8mr3661807pgk.333.1574844363728;
        Wed, 27 Nov 2019 00:46:03 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id i22sm5885474pjx.1.2019.11.27.00.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 00:46:02 -0800 (PST)
Date:   Wed, 27 Nov 2019 00:46:01 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     John Ferreira <jferreira@nvidia.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git diff --no-index" Implies "--exit-code"
Message-ID: <20191127084601.GA47023@generichostname>
References: <MN2PR12MB289677B16DBF67772627B595DE440@MN2PR12MB2896.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB289677B16DBF67772627B595DE440@MN2PR12MB2896.namprd12.prod.outlook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

On Wed, Nov 27, 2019 at 04:03:48AM +0000, John Ferreira wrote:
> I suspect this may be a bug:
> Because I am not specifying the "--exit-code" flag,  I expect "git diff --no-index" to have the same exit code style as git diff.
> But it does not.  
> See comment in source linked below.  
> Or, if this is intended, this side effect should be noted in the documentation for --no-index.
> 
> https://git-scm.com/docs/git-diff
> --exit-code
> Make the program exit with codes similar to diff(1). That is, it exits with 1 if there were differences and 0 means no differences.
> 
> git diff [<options>] --no-index [--] <path> <path>
> This form is to compare the given two paths on the filesystem. You can omit the --no-index option when running the command in a working tree controlled by Git and at least one of the paths points outside the working tree, or when running the command outside a working tree controlled by Git.
> 
> 
> https://github.com/git/git/blob/83232e38648b51abbcbdb56c94632b6906cc85a6/diff-no-index.c#L307
> /*
>  * The return code for --no-index imitates diff(1):
>  * 0 = no changes, 1 = changes, else error
> */

This is a documentation bug. It's already a known issue and there's a
fix for it already queued up in next[1].

Thanks,

Denton

[1]: https://github.com/gitster/git/commit/0115e5d929d06ad41eff83742a3e6a1e91ecc0c4
