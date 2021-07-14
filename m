Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA57C1B08C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B96613BA
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhGNTiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGNTiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 15:38:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6615FC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:35:09 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b10-20020a056a000ccab029032dc5f71f6aso2501784pfv.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kJxcyW1/nHDv0Mks44dBiSaq8zcAm+JB1McULdOekwE=;
        b=NsLlYMCXW7hPknfjJMrk2RgE7vJfEB+Ukz17motmmDEi47Ml+vWhPfSZkhgpEuSvTr
         QWhXope3k0gSZsMVAEt+uPSnSoxrUOCKe4XSX7pjpup9GA+lAiU/3Dhjhs/H6B8M+1Xv
         DZHaTs3MkswmS3Su8CD2nzEHff9NxvEoU6MubCfOpb3uUWaPqtPK4Pv/kXGcVTC2kzK8
         oJPyYGbvM0+fNbFN9yEFh9z/VQ/GkBRMq4ZYD3Zoowi90xZalr09Dg/h6jDUcBHedStL
         9M8B+vhO6bcXYwQykDy18ZMeGBmfxFT+ZoOqcXXAq12DmhLN/rIeywDBdfyJlbMUgRsx
         uIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kJxcyW1/nHDv0Mks44dBiSaq8zcAm+JB1McULdOekwE=;
        b=XvOmQjQqnVvcodwr98fakr7sj9GNQeDZM/V87xFilmtX+o77lY7hzW6RgeVWIsiQgX
         zyuhZE85qq28GXYQ05WzxttmjFeEShxK9rB5j7Ly/Suzm/rzROadgpWgLMvJOXxA8G9E
         di2g38+alheKB0dxI0yjAZuAdCaWpfXgoYwVjNKbGL70WeJbSwaaJGRmQfV16OsiGVAU
         ZOUwsck6ZXapg8S/wH5tMKJvXPg5U00UeNcMJ4UtlxQCsujnZqJzw90iZ+SjDEHu+9uC
         BPPpba8X1uvYbc6OJiooNt/qLYQKDERDhHJS8o+pnFQ3HkaloTLaYKBQCklR75/+Vjai
         Nvqg==
X-Gm-Message-State: AOAM532fjrOahagK0tbwx5g9TcI9XzDCilj1K19vHihVma/6lBR+OZC9
        H9sdcw7pMN+z2Z81pD3+4Gl94xal99QXY3wWjUPG
X-Google-Smtp-Source: ABdhPJwY9NBML5HSYndpssLtd0dSb9VwoLnqMgm/RJf8hy0+PtYcAFqPMQpaNgYNt3hxDW9FSANYu2tABpej/gFCwovv
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:2ac:b029:331:690d:7f26 with
 SMTP id q12-20020a056a0002acb0290331690d7f26mr4151745pfs.78.1626291308889;
 Wed, 14 Jul 2021 12:35:08 -0700 (PDT)
Date:   Wed, 14 Jul 2021 12:35:06 -0700
In-Reply-To: <878s293htx.fsf@evledraar.gmail.com>
Message-Id: <20210714193506.4084421-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <878s293htx.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: Re: [PATCH 3/3] fetch: die on invalid --negotiation-tip hash
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     emilyshaffer@google.com, jonathantanmy@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >> diff --git a/builtin/fetch.c b/builtin/fetch.c
> >> index 9191620e50..2c50465cff 100644
> >> --- a/builtin/fetch.c
> >> +++ b/builtin/fetch.c
> >> @@ -1428,7 +1428,9 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
> >>  		if (!has_glob_specials(s)) {
> >>  			struct object_id oid;
> >>  			if (get_oid(s, &oid))
> >> -				die("%s is not a valid object", s);
> >> +				die(_("%s is not a valid object"), s);
> >> +			if (!has_object(the_repository, &oid, 0))
> >> +				die(_("%s is not a valid object"), s);
> > Any reason not to consolidate these, e.g. if (get_oid || !has_object)?
> > Then we wouldn't dup the err string.
> 
> Generally I'd agree, but aren't we explicitly conflating cases where
> something is a valid way no name an object v.s. being certain that such
> an object does not exist? I.e. this should be something like:
> 
>     if can't get_get():
>         error "couldn't get the OID of revision '%s'"
>     if can't look up fully-qualified OID:
>         error "the OID '%s' does not exist"
> 
> Or something...

Good point. I'll use wording similar to yours.
