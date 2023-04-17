Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D222C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 21:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDQVhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 17:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjDQVhi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 17:37:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAF91BC2
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 14:37:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso28122862pjp.5
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 14:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681767457; x=1684359457;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrA4jwgOMcuBFpCzuzCMiSJZpHvT0RwJZ2I/3Hm0NOg=;
        b=aMbTTPUUOGhCoWb1yzqXq/WJrhMZ+LA0gQlrFwg9h2825rRIFAZm9hzVjOIv/EjG+d
         z5EHXwSXwvPEJtl8YUXIgs//k5ruUddqMpHC6G8H9deDCR7DyRjBzvrzPuN6/s250jOr
         PTR1xkh5vjNFNesyu+5zUbJDK6Nlkh7muNKfAGG7xNQ7ox2c/kBU3Tx3Gg9Wj2ArQ4yi
         zknwCU/b6OY1UY4Ta3dO0HPx17NBfbS6FFMPlpDXYcV5lXkYcQezO8sBtKkTva8Elniy
         0bYU7pSohIjSttsEiNgRuXgdc3wi0w4bOHBRJS5w07/vStj7POJFds05YFwOVqPCz3cP
         DBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681767457; x=1684359457;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KrA4jwgOMcuBFpCzuzCMiSJZpHvT0RwJZ2I/3Hm0NOg=;
        b=J5/3JEWaPULlmHcoUmHQJKd513Rf+MhLl0kmwbWe1PYtslX5aZTu/lup/zrkNM7p7W
         EbLeiDQmRMgSFeDwp1hW3fzQYz2sSKHTTEBZNmmKxfSu8SD4a+MELwJ0RBd3Cr0CnpQ0
         uqjF2C6/LvRVbKYwljpGKlhuT9LNK5UZ0RVl0bB6P6uxX2CDIO0464PPZKPnwqZMPY+Q
         mjXH722+VrheUSXUH9aHvkFnhEgbsqh5//ex92SxReBBGwdIXoMtftWBY6akorOUxtZ+
         GWuicuCKdz6ZkH8CqW9XfLeM92s5VZPDUMNPAY9gaxPCsOS6+VzfSt1LQdYKMuNTbWjH
         0iaw==
X-Gm-Message-State: AAQBX9fcng4QqWHn2jLdC3uVNhXRP6MxV8WCYcs5Qb/yANq/tICkxuhg
        AoKjmsBr14rq0GRZaMTbE+I=
X-Google-Smtp-Source: AKy350aL2gWmFxArbY2c1VHe+HLA91ePLg3625HFnvt690x5skZoLoL38AtudhfC6Jt1T45ZXJF01g==
X-Received: by 2002:a17:902:b60b:b0:1a6:a2df:4700 with SMTP id b11-20020a170902b60b00b001a6a2df4700mr285313pls.9.1681767457051;
        Mon, 17 Apr 2023 14:37:37 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b0019a5aa7eab0sm8137113plt.54.2023.04.17.14.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 14:37:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] git fsck: check pack rev-index files
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
Date:   Mon, 17 Apr 2023 14:37:36 -0700
In-Reply-To: <pull.1512.git.1681748502.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Mon, 17 Apr 2023 16:21:37 +0000")
Message-ID: <xmqqa5z6jilb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series is based on tb/pack-revindex-on-disk.
>
> The git fsck builtin does not look at the .rev files that pair with .pack
> and .idx files, but should.

Yes, it should.

> ... The fix is simple: delete the .rev file (and regenerate, if
> necessary), but detection is the first step.

> This series adds those checks. The initial check to verify the checksum is
> probably sufficient for most real-world scenarios, but going the extra mile
> to verify the rev-index contents against an in-memory rev-index helps us be
> sure that there isn't a bug in the rev-index writing code of Git (which
> would result in a valid checksum).

Good description.

> Much like other file formats, an invalid
> header needs to be handled separately as a malformed header may prevent the
> data structures from being initialized in the first place.

> This series does not validate a multi-pack-index-<hash>.rev file or the
> rev-index chunk of a multi-pack-index file. These could be fast-follows,
> except that there is no existing equivalent for an in-memory rev-index for
> easy comparison. The rev-index chunk (which is the most-common way for a
> multi-pack-index to have this information) is already covered by existing
> checksum validation, at least.

TIL what "fast-follow" means ;-)
