Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1D3C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 17:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333FF61A58
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 17:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhKRRy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 12:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbhKRRy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 12:54:56 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419CDC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 09:51:56 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id l7-20020a622507000000b00494608c84a4so4091534pfl.6
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 09:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y/B8HIgCblgtg1YGsTJ1kiIN2nOWZMuYlVqQ1qNY0hQ=;
        b=aJRUKjuK4AWe9SI7B20fALVDwA82EqcVVZraQc7+Txo49YT3haDoX+7eYTxYevpReX
         gh5PXPoivVIzfWjmWT+po80IxocK4iHbQy5ROyrjY2/lTcdh5tx6NdCMqne1WNsB5GPB
         MRycS0HXDwASojz49wBRr0dd2A4M8ZNgelIHQMatA7UivChaBn9M2Z7oTVxkbauSYX60
         yYcGlFE6Y1g+8BRKzBnphha4zZwmlKf5ZnvjzlG/Ke59905t7LEZKuvWmryBlNPfaWcr
         72UIKkBCCet3oJbf4IpTdKefnjeSsjbJvqGL3wbC3+b3PAzMuX3GpyTk6dHCxgWXCqPd
         lcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y/B8HIgCblgtg1YGsTJ1kiIN2nOWZMuYlVqQ1qNY0hQ=;
        b=JNcVtG4kwp3dtGtrrQcY0qJ4zGGZSGoc9ELFgt01/EG/Pg8JJW9WguQBOgVh0haWZK
         vieAJWMytQEXLPw4vRhW3s13Sbm/5yo8jvYI6LJ8f9Xm8TcZh8spMoJjoJeTjiL48cit
         TIHwSbNLkCtAGb9pnSdM+t8byKTKqMtutcfmf3PrISGIpJAF2csG388weAGv7AKKybxW
         vv1iERrNKTw2DOALLU753Rd/br8xuF5aaqPwv36/d7oQ4HeKXISwDi+K9g8OFSgCG9mb
         GOio4ObKAfDgZLTWhoBEelgy+lfzbjLfAuE3H9usOhMiL4TIRHEVgRAnfuojmF2y7k16
         QFKA==
X-Gm-Message-State: AOAM531RJhRWooDHMy9d6VA3US0gHUNxiiCPcgVu9FWfbOJs5pHZFaw6
        7p69XJeuIm+fNHC6EmTibx66pbjzWkuMEoNYay++
X-Google-Smtp-Source: ABdhPJwx1OiVOlKMKjhs4N2Nc7hmvqR5I2WVIhapro4kKkk2yN9z2XXWgnocp5g2aAEXLPon/GV6VbH9b95raoRrQIwG
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:2306:b0:142:123a:24ec with
 SMTP id d6-20020a170903230600b00142123a24ecmr67796770plh.21.1637257915688;
 Thu, 18 Nov 2021 09:51:55 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:51:52 -0800
In-Reply-To: <20211118005325.64971-1-chooglen@google.com>
Message-Id: <20211118175152.2716229-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211118005325.64971-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: Re: [PATCH v5 0/5] remote: replace static variables with struct remote_state
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> This series aims to make the remotes subsystem work with non-the_repository,
> which will allow submodule remotes to be accessed in-process, rather than
> through child processes. This is accomplished by creating a struct remote_state
> and adding it to struct repository.
> 
> Thanks for the kind review, Jonathan. I've incorporated most of the feedback
> from v4, except squashing patches 2-4. My reasoning is that those changes are
> mechanical and keeping them separate makes it more obvious whether or not each
> step has been done correctly. However, I agree that they are just intermediate
> steps that touch the same lines, so I am happy to squash them if other reviewers
> prefer that.

Thanks. This patch series looks good to me.
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
