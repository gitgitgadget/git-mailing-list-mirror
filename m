Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D6C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 01:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF34650F3
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 01:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhCJB3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 20:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCJB3N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 20:29:13 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FC2C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 17:29:12 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j6so7651189plx.6
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 17:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EeUDPxjWTRcg/B6T4nDIwEiJ+0Ae6EgzRQJ14wnbBfs=;
        b=cZJ/0IVG1aI6Xngjx4nZxH+WhSy5YuNnZPhUJrccLZllUMRvQnsmVmQz2RXoT4zk9n
         /fA1NWieEc+tZTXHKDrGfbXkWXojVKB1ZFikhfB52LTq3xSqH+htXC3nhKDjSIKwx/Dx
         uXiAM+/080bxilzKJqL+yj/gtq1w/MklbPtAvM4O2GalonAtTCeh3aC0ri45tT7cSqgr
         XuiPD5n7t8GqnHKV87/cVSE7bzhI5pz1KpvKC00492WOvMJ4DhdPrC4+Tfw1PnVxaWyK
         ua9xDPaL/dBFlk0rGRfCHh9y7nDloqvdhPJoXcfaaqoD25ozNF2RfJ+U+ufHMOalqbK4
         qthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EeUDPxjWTRcg/B6T4nDIwEiJ+0Ae6EgzRQJ14wnbBfs=;
        b=UrtqpqOF+Xt+4SymKZSrApiO3fVle8a6H2c1Bcw2pu/dH3xWgwLNUU9UPasjg6aETu
         f5oweh3PLpAG97zAjLRAzN3fQOe+U7xdQJlMSnhBoHclzQgKJo9Z8LMYy9r0+0R5wWso
         ywbhjGh2o0XxY3plUUVJmD+sb3NeyS/7CypuWj3ypfE5eM6INcySuKdDzyh1WcgrJlqW
         UwSMeRSyr12oaBSvWNdVQtcZMGFMfXysML6iJt/iWtPOExf1ZJAwt25G/cbQYgiap+GP
         9k3kcb6yHbzKm0plivUZJwnly8FHV63Cv6miFlKBOZBxfoGvdto2t8DTv/hkVjaeoojO
         lZUA==
X-Gm-Message-State: AOAM530PFjO+WW6oQM+0OqDZQIWE2QJY1v8JKMGELloRWatuabukvgSw
        +UP31ed3wEBfJcMPQxyjK1gkhFkOopM=
X-Google-Smtp-Source: ABdhPJy3jZC4x+D/pBz3yTsHHPG8K5LCqx7rjCVoexvcLTK8ePQ8rdqLtik5Wui4EgG113c/AoqXqw==
X-Received: by 2002:a17:90a:d907:: with SMTP id c7mr763463pjv.45.1615339752371;
        Tue, 09 Mar 2021 17:29:12 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:357c:e8e3:4f20:9227])
        by smtp.gmail.com with ESMTPSA id ge16sm4121457pjb.43.2021.03.09.17.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 17:29:11 -0800 (PST)
Date:   Tue, 9 Mar 2021 17:29:09 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2021, #02; Mon, 8)
Message-ID: <YEgg5bWZ7WRC7KBu@google.com>
References: <xmqqft1542wu.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqft1542wu.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> The second release candidate Git v2.31.0-rc2 will be tagged tomorrow.

Is https://lore.kernel.org/git/YEbdj27CmjNKSWf4@google.com/ being
considered for -rc3?  If not, I think we should revert
sh/mergetool-hideresolved.  It's the kind of change that can undermine
users' trust in "git mergetool", so it's important to me that we don't
ship it enabled by default.

Thanks,
Jonathan
