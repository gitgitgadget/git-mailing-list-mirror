Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBD5C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 17:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C3A2083B
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 17:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSm0U0Nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgI1RqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 13:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1RqY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 13:46:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF6C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 10:46:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so2016080wmb.4
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 10:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iJJHLJjcko2jC8/b6A6B9qw8Y8ekxE46EJ2HzJRVfF8=;
        b=RSm0U0NmAqRMfqdgwUISVym8JvSzmTml0rNKTCZDSPs9WBc8f/PRXyzMJJFHVhp4ol
         M7yOcfXDF1ej7mkVuViQ25ap1viVDUl0x8+uK3hiU6OcSne5YuEVHzzrLRBMwpwhKEXH
         Om3nj/IknrLlox4t+CGjPAReHd7FHjpPrg0gPbTeM1ZoL9FIuxLpHRjXeM3mNOCiFwV1
         JH9wN8fVGrHtXX7QEk2LfwRyL9iuW5m3H/KRUnrme8Q9csFM8ms/OTbA9cKT7+P3IvMl
         xjQYazXn3vKiPONXI4Ttfq14+9k40EwO4VLNBL2pr254h4qdxcUfJPeVw8qV2+sdKTCl
         YHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iJJHLJjcko2jC8/b6A6B9qw8Y8ekxE46EJ2HzJRVfF8=;
        b=eWDPwq+wSww9rIZaRXEbx/UQFbTlTMtqi7gVXZHVuKFsbiKM+xad/uh1542mTl5rsr
         1DYmOqcD6n8L9IztaJTPI6GkKeNvXyMBnbKy6BRDi8qjQIBx7tOqMVHDNyc4LuzwtooH
         rofo0W7LPeqBmtWsJSLuQHDZ5XSpU8KO+xnkoHtQAf4/pmZljbx8FH3LTaBFmJCHLchg
         ffs8ASXL0ulHbH1YAsgj924ISlO8UCQmJcixynVW/j8aWgRfaEZrEhqzwyaO4HC/lDGd
         BGQxDMsjw1fnecB2cgXf4lIYsY0OkHH4hZjOV4DAQYBm3QRyBYRvpcvgOOKv+caTt5ph
         U4sw==
X-Gm-Message-State: AOAM5320QFEM3Uu6h7HNlzkMtB/toVDYa13dk4B2MruSiVKzjNgBo1B/
        t2EG/IIZX32ewFDHc+3ZC8w=
X-Google-Smtp-Source: ABdhPJzos44ThfH/CNy5Vk3AYul/3GFHbxFjHz+Sr42wrq6WOzwbC88tWUfTFZPcw1F4sLnMeM1Lcw==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr290591wml.139.1601315182914;
        Mon, 28 Sep 2020 10:46:22 -0700 (PDT)
Received: from szeder.dev (94-21-58-130.pool.digikabel.hu. [94.21.58.130])
        by smtp.gmail.com with ESMTPSA id d2sm2233922wro.34.2020.09.28.10.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 10:46:22 -0700 (PDT)
Date:   Mon, 28 Sep 2020 19:46:19 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v8 0/3] push: add "--[no-]force-if-includes"
Message-ID: <20200928174619.GB24813@szeder.dev>
References: <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
 <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
 <xmqqtuvhn6yx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuvhn6yx.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 10:31:34AM -0700, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
> > Add a new option: "--force-if-includes" to "git-push" where forced
> > updates are allowed only if the tip of the remote-tracking ref has
> > been integrated locally, by verifying if the tip of the remote-tracking
> > ref -- on which a local branch has based on -- is reachable from at
> > least one of the "reflog" entries of the branch about to be updated
> > by force on the remote.
> 
> https://travis-ci.org/github/git/git/jobs/730962458 is a build of
> 'seen' with this topic, and the same 'seen' without this topic is
> https://travis-ci.org/github/git/git/builds/730857608 that passes
> all the jobs.  It is curious why one particular job fails while
> others in the same build is OK.

That build runs the test suite with a bunch of GIT_TEST_* knobs
enabled, and the last two tests added in this series fail when run as:

  GIT_TEST_COMMIT_GRAPH=1 ./t5533-push-cas.sh

> The failure in t5533-push-cas.sh is sort-of understandable as the
> topic directly touches the area of the code the failing test
> exercises, but the failure in t3701 is totally unexpected.

That's not a failure, but the fix of a known breakage: we expect
failure from the scripted 'git add -i' in two tests, but the builtin
'git add -i' fixes those issues, and those two tests succeed with
GIT_TEST_ADD_I_USE_BUILTIN=1.

