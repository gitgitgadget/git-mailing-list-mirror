Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36948C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6EF206E9
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkedOTKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442209AbgDOUyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442190AbgDOUyp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 16:54:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DFC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 13:54:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c23so525557pgj.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OLlcjELylE4bqHVBcX3wTn4SoVKCnXIVvCbFPGBxDc0=;
        b=dkedOTKLzAhzcEQ7eupadvDdigZSsHtO1omyqSLzrK/o+z1dw+fe8SbuRLy9pdoI7X
         Mn2h8cZsjTb66SiX7JGt9kugjct1Y4IJpak7ut8CGdaOeyNRZ//dM99tA4YioaA0yeVQ
         OS6u+qmZtSD3mxiMSIevjQw8k0XdJxViyFXE+Sdsky+2ro6Ocuiplh5F4142hh0ZgFeM
         y5o9pkj8shwDmQUqN/SrE/CB6Easlq0JVK6ue224A1OftOA6ZjlE1YDSKMrW/AbOGznR
         /vljQnuLT4aqBPn+bg9XWfB882e0XZFOCtfSA8g/SKLDmG90O+VMFu3x3KPvTqdwdodE
         Qwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OLlcjELylE4bqHVBcX3wTn4SoVKCnXIVvCbFPGBxDc0=;
        b=lOIRumlPY04YFOYbLS2A23IfUanWS1fkdPCHSzF9H79SObf/EnndNcc7wk6X0osts6
         6WzFsaJ/rSR9fqslNZnzs5zBs1j18dFdvWeuEEsyKmHlUBOPwKIlZ/1sKGATO+fhMm5w
         yzDobOg4GhHY0EC3et9SLhM4/d26pB6e3ZLGlBhR0Xs3Yh0NdGtacB1vEZ2VMKCMcBzF
         mnwotGyvIltqz+7kub7GGcasKkWYQQB/5KX8ikZrFk56/SOqT62suTyJckIMl9TaL7wi
         6xcaOk0/29OY1KOSSfL+8C7wlug6TQvVQjLEI3ojRVA3GN5evIBO66oNxO5OpiWH5XKe
         TtNg==
X-Gm-Message-State: AGi0Pua2W6CJ1PR5RlGjx21JVZstU826IUIk3UwdEI5zkgIn+eInjCuk
        a5HIUamVsNMQLFF79+BREvWE7B5m
X-Google-Smtp-Source: APiQypJofbpwBjNHsIna1E74RahyQ625qYReybYPKf0kBxZjkq27OZK+xkjb786eg8JeB+joAoLJ2A==
X-Received: by 2002:aa7:842b:: with SMTP id q11mr9001917pfn.302.1586984084817;
        Wed, 15 Apr 2020 13:54:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b8sm9554465pft.11.2020.04.15.13.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:54:44 -0700 (PDT)
Date:   Wed, 15 Apr 2020 13:54:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Is fetch.writeCommitGraph (and thus features.experimental) meant
 to work in the presence of shallow clones?
Message-ID: <20200415205442.GC216285@google.com>
References: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:

> I was building a version of git for internal use, and thought I'd try
> turning on features.experimental to get more testing of it.  The
> following test error in the testsuite scared me, though:
>
> t5537.9 (fetch --update-shallow):
>
> ...
> + git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
> remote: Enumerating objects: 18, done.
> remote: Counting objects: 100% (18/18), done.
> remote: Compressing objects: 100% (6/6), done.
> remote: Total 16 (delta 0), reused 6 (delta 0), pack-reused 0
> Unpacking objects: 100% (16/16), 1.16 KiB | 1.17 MiB/s, done.
> From ../shallow/
>  * [new branch]      master     -> shallow/master
>  * [new tag]         heavy-tag  -> heavy-tag
>  * [new tag]         light-tag  -> light-tag
> error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> fatal: unable to parse commit ac67d3021b4319951fb176469d7732e6914530c5
>
> Passing -c fetch.writeCommitGraph=false to the fetch command in that
> test makes it pass.

Oh!  Thanks for checking this.  At $DAYJOB this was the week we were
going to roll out features.experimental.  Time to roll that back...

How did you go about the experiment?  Does Taylor's patch make it pass?

(I'm thinking it would be nice to have a
GIT_TEST_EXPERIMENTAL_FEATURES setting that uses test_config_global at
test init time.)

Thanks,
Jonathan
