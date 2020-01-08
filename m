Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74464C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 23:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8EC206DB
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 23:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5WjLlrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgAHXjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:39:11 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39944 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgAHXjK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 18:39:10 -0500
Received: by mail-pj1-f68.google.com with SMTP id bg7so286318pjb.5
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 15:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i9GruypX54aAHIAn2zMxJjTm958JCEd+70mOrxF8wcc=;
        b=p5WjLlrxRbRaFx12/jqcxj6BJsL12QnTbI2AScl0ryp4oMJC6tz76mn5xCX3qe33Qs
         joKsmdwNFaQfpmjVoaMBQk6RqazEjxb8HXmqvLgSQA7N+8W3/80YQ0+610QLrxSOpK/S
         DNDgJxIOjOWFRb/dtrTKLA6E6+KEgYOR9g9fdBV/+tjPv9TC8d5bRHYVkBHVbbLNo3D5
         Dr+w5+hdlECpf32l5TJf/++fUa4uZ8IvWKEyh4UqARfFqA+MdGuk54oIDHb6n4U+ObaN
         uFw+R4h/6xRj5HLGaxSJ+U6AIk7I9g38nup29OiSyst6x2yghkvIrUBG3msaXJo13dUK
         esDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i9GruypX54aAHIAn2zMxJjTm958JCEd+70mOrxF8wcc=;
        b=oOcP8x84cJh40O4HgCuSzVlAcYHlQSX+j4WB2UdSratPTo3yU1cnIP106igvnY9MLK
         YvX8fi6QUj2ls5AgUG9YsBgBmncwgsimwBwROJ4wkNuCqmMJzLkzGzx9UdEZf9DHUW/o
         r8tZdyI1AtPZDvTZYGxsk0dWuSMbRLWNOW6XZMtiW4LxIT8rKrT95gZl13SYhaNmpZr3
         ltxb3VHFJ9IK86w2N7VIsZBdrV4wQoOk0obntBMh0m/CEnEVol7uJ7JLQz1uB6P88aIv
         iwvgrG7cdcvpJkTKL0OhfKJvaFr0rMdH02Sw0mglPseqgAKAh1pEnvcS96Lrx+uR2M18
         pnxA==
X-Gm-Message-State: APjAAAVgBAni0RTZGcf/IlbINfU9uvnJ/UtrNX9esQJxWMMLjYwVTcAH
        e0tuDnMCz7Crv2x5JJ3Q1gj57cnvqPU=
X-Google-Smtp-Source: APXvYqywNiAPk29ZKrT/1qo9eWhmX0euffajN+PYGVdivy3QMetKRPMvOM+RIfGMoDJ9h0VdG7mhlQ==
X-Received: by 2002:a17:902:247:: with SMTP id 65mr8221328plc.108.1578526749416;
        Wed, 08 Jan 2020 15:39:09 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id d24sm5039713pfq.75.2020.01.08.15.39.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 15:39:08 -0800 (PST)
Date:   Wed, 8 Jan 2020 15:39:05 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach --single-branch and --branch during
 --recurse
Message-ID: <20200108233905.GE181522@google.com>
References: <20200108231900.192476-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108231900.192476-1-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 08, 2020 at 03:19:00PM -0800, Emily Shaffer wrote:

Bah, in my attempt to keep the subject brief I was aiming to write
"--recursive" but instead just wrote "--recurse" which is wrong. I can
push another version with the fix if desired.

> Previously, performing "git clone --recurse-submodules --single-branch"
> resulted in submodules cloning all branches even though the superproject
> cloned only one branch. Pipe --single-branch and its friend, --branch,
> through the submodule helper framework to make it to 'clone' later on.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> Note that 'branch' was already in use in git-submodules.sh, so
> "submodule branch" aka 'sm_branch' was used to disambiguate the two.
> 
>  Documentation/git-submodule.txt    |  6 +++++-
>  builtin/clone.c                    |  6 ++++++
>  builtin/submodule--helper.c        | 28 +++++++++++++++++++++++++---
>  git-submodule.sh                   | 17 ++++++++++++++++-
>  t/t5617-clone-submodules-remote.sh | 26 ++++++++++++++++++++++++--
>  5 files changed, 76 insertions(+), 7 deletions(-)
