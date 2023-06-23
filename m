Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F423AEB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 21:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjFWVCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 17:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjFWVCV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 17:02:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698352135
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 14:02:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc7267224adso2898637276.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687554139; x=1690146139;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zaphtW0FkSw8RBHqaGz6lKb42L40idXEcieOipG7ZfU=;
        b=VNNQRKHWPl0g8nL/JR6D4K2ZEpsXDltqjaeK6k5LoTQL7bKXpCCY3Z4mSpc381JNjr
         Dhnhnm0qrjP0n+AHbXhtk6PcOlJI7pCUT1NwFoeYV8ztqLfZT+OQN8+SMpimvd2xn6xa
         tV13yfrmKw3NNFtkcCZzAqVrnAkN4zf/Gbyi7u1DSPDHR0dvWWjstjV/Xnhc7G9W/M3n
         jHXHSu7Zz2pubfty6u8DDW3e/aUHTKIDsVk/VJXEdaZ6OO+7EpfBhj8sKZJY8fi/Bx6i
         vXFhxRumwXu3i0K3P0SzYt7Jcf3d91IPO0ZbBjhbn4OY6pD6BdYrLTSwsjrY0L+gu34I
         l0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687554139; x=1690146139;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zaphtW0FkSw8RBHqaGz6lKb42L40idXEcieOipG7ZfU=;
        b=hE1mvs+n2xBrhj1xIzDfEiDxShGo51eSbzfnts8JQqcloD2ieaAA/x+gXgUWXJXqcA
         Npz9Dgs43EIYvjF5xb5VtTrAgmK4iNL3Cn9whMcpyQKKU0wmcU4tDbarZ9zwuUV6gmFv
         HqhDd+l4mo2kZsCMs1r+ItT2Mrs9iV1Qsn7LcMh6Xkn8bhNEogSS71ARiQZI05zIzTSk
         85nkcUgMVv+1eZq+sSAu3jbbwu/Ajbe0mOBEpsw9dJBswRjbm15ZNv5njAc22CKwMfcG
         Nk/b0GoMNhZqbgOqyLKcY2Tk7HdERe7d08CYvtTCmchn4W/RA2G64pXNVbbV/4+/adwx
         X2Xg==
X-Gm-Message-State: AC+VfDxBjZuoL1Tv3AQ5io6/IA4fOzt6F2GaVd7wz97GI/mtJw1lpu2D
        Xxmc9/V4AsOJZ/IGT6i5w7/SFWCQlWVF9NRIvlGY
X-Google-Smtp-Source: ACHHUZ7HyGHaFBt9xRMK28yw42hNMFkyNk3ECe139VBll8F1PKRNiP6MM8ZLmSpUD2y8GJFA0Jjvel9ty1/HSkfQRO5N
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:7ab2:ee09:eab1:38cc])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2691:0:b0:ba8:1646:c15d with
 SMTP id m139-20020a252691000000b00ba81646c15dmr9697954ybm.1.1687554139665;
 Fri, 23 Jun 2023 14:02:19 -0700 (PDT)
Date:   Fri, 23 Jun 2023 14:02:17 -0700
In-Reply-To: <kl6lh6r0qut8.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230623210217.3259337-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 00/12] config: remove global state from config iteration
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I've reviewed them in its current shape, but it seems to cause too
> > many conflicts even when merged to 'next', let alone 'seen', with
> > interactions with topics in flight:
> >
> >  * ds/add-i-color-configuration-fix (easy)
> >  * ps/fetch-cleanups (easy but messy)
> >  * vd/worktree-config-is-per-repository (moderately messy)
> 
> Ah, sorry. I ran some trial merges against these before I sent out v3,
> but I forgot as I sent this out. Not queueing this version sounds fine.
> 
> > some of which may have graduated to 'master' in the meantime, so it
> > might not be a bad idea to rebase on a more recent 'master' after
> > you collect and adjust for review comments on v3.
> 
> Sounds good. I suppose it would also be worthwhile to base it on
> conflicting topics queued for 'next'.

Glen, if you can, rebase the patches *before* updating them based on my
comments so that it's easier for reviewers to see if my comments have
been addressed. (My comments are minor, so they should still be relevant
even after rebasing.)

Overall the patch set looks good aside from some minor comments that
I've given as replies to the patches.
