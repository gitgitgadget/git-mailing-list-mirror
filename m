Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1FFEB64D7
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 00:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbjFNAkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 20:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFNAkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 20:40:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62591984
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 17:40:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b3c0c47675so26912905ad.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 17:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686703216; x=1689295216;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTVbOK7UImcf7+WHYY0i/ocFSLIFVf72jQD4Ha7mOBI=;
        b=hGx/v0DeZojWTWJEjx6FmnACU4FDXtI70ppwnw4+R+WF47aleuRWwgR1NxJXVrOtop
         q4mTUrNh6CkCoeZWRUC8/BqdzHrLnUv7poXjfJFmWqmNjjzr+EkyG4w8tCeuT4U00Fr3
         p15DM76jsd7/dir+ryATWWoukkHny26Trp/SFR3q57Gd7pagFLLnJowo9eyt1ilGqdO3
         IKIikQWZhjyw2okgEsFrm/wKufbBPTU3TVACkS1zeGvGO+B/xyo6SNVFKIx40zIrse/i
         RzK0Qv/iAuNw81npwpUsTIJ6G8HAEpR9doacjjxX0Xb1I4BPb2aIE2rJng6x/CsNzDYu
         NNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686703216; x=1689295216;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kTVbOK7UImcf7+WHYY0i/ocFSLIFVf72jQD4Ha7mOBI=;
        b=NHdolmh3cApOsAr6Ng/x/GtfHzepgG8+fS8Zf8a+rH7Nda8AcrndsfAYoZA9VSvTcr
         lWPoFXa9HRhqkY0QHWCJCn+JI8zdQ52ak82y9Mxor+hIhpBu9lXqhFfxrEnQQ75IFDqM
         FCbYRDU3LeXmcr3HXadamc4mr7BElSW3cpOv+dAhiE4nr28dtd0Ps9OwaEbDe+fwdZ/y
         kVhIGBKOGIzHtJ805u3yv/SQiPgSMaQp0pZVVOlGN12uckTDvD1K1PIZORsgNleUjdYq
         gX/iGmn79mslVnkl29fSGivkNfeI/PoO01e03LOUGRinun2tG8YUynofRx1y7G+KJr3H
         Mczg==
X-Gm-Message-State: AC+VfDyi0dMBi9n8au1v+MGrvMx1n1+0kTxmJ4J6Lgg3waziLjnBo6sG
        Hiw5yB0RtP1cn7mUrCRaw/k=
X-Google-Smtp-Source: ACHHUZ7+AE+3dnQ5bxK5ltCau6b7oT2TK9/O4ON0vqYeH+j7CrIeCm6HpRuDCBgI5jDo+4KTh120SQ==
X-Received: by 2002:a17:902:e5ca:b0:1b0:637e:e25a with SMTP id u10-20020a170902e5ca00b001b0637ee25amr13970409plf.67.1686703216274;
        Tue, 13 Jun 2023 17:40:16 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id s23-20020a170902b19700b001afd275e186sm10740131plr.286.2023.06.13.17.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 17:40:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 12/16] refs/packed-backend.c: ignore complicated
 hidden refs rules
References: <cover.1683581621.git.me@ttaylorr.com>
        <cover.1686134440.git.me@ttaylorr.com>
        <ca006b2c3f3474cdf7cfebbdb8575059e036d9cc.1686134440.git.me@ttaylorr.com>
Date:   Tue, 13 Jun 2023 17:40:15 -0700
In-Reply-To: <ca006b2c3f3474cdf7cfebbdb8575059e036d9cc.1686134440.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 7 Jun 2023 06:41:52 -0400")
Message-ID: <xmqqo7li27ww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In subsequent commits, we'll teach `receive-pack` and `upload-pack` to
> use the new skip-list feature in the packed-refs iterator by ignoring

"skip" -> "jump".

> references which are mentioned via its respective hideRefs lists.
>
> However, the packed-ref skip lists cannot handle un-hiding rules (that
> begin with '!'), or namespace comparisons (that begin with '^'). Detect
> and avoid these cases by falling back to the normal enumeration without
> a skip list when such patterns exist.

> +		 * We also can't feed any excludes from hidden refs
> +		 * config sections, since later rules may override
> +		 * previous ones. For example, with rules "refs/foo" and
> +		 * "!refs/foo/bar", we should show "refs/foo/bar" (and
> +		 * everything underneath it), but the earlier exclusion
> +		 * would cause us to skip all of "refs/foo".

Good observation.  The presence of !refs/foo/bar in hide list
forbids us from adding refs/foo to the jump list, and it is the
simplest to disable the whole jump list business when we have such a
feature in use.

Makes sense.  Thanks.
