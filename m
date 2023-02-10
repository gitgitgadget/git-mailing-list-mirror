Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31998C636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 19:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjBJTNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 14:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBJTNG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 14:13:06 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D8078D5B
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:13:02 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w5so7448427plg.8
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+XpL8fP7q2tOYwTnPrrfALidE2wD64oLyfN2G+dA04=;
        b=PVIjySHHfqa+kWipY0P841DsmrXN1x15cKYYFjBxcb+NWExIS2qbKyuUOJ3ldoNuVh
         1r6YcLIAAvyM595MW8YX0AJ7pCzDPEtXet+bClL/nNeniJi2JzVPYXcfDVKvbZYkm/rM
         bkNByCWrnmW0DBNn91fy8D2zb7Mj5d0fJLx6k2kIqPpcw7I7GzKCDqFzm0l20jt+fYwT
         dTVrkQQ8yKrqluKRQg80l4Ulcu+sSBMM2jfQcgx63QkFbNmYmk3+cojvytg+bBJo1fr+
         9beBfsShyS8N+hhgU7VSwD4xjid9zW1ZyD5pWuR0fSkh4uQ4f6BTgeeVtbou2h3PG5UO
         pIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+XpL8fP7q2tOYwTnPrrfALidE2wD64oLyfN2G+dA04=;
        b=kyurPfBYKFwiUUqeJScUfmmh7HvY3S5LIEVgTxOh1izaKb5thEqC06N5Oz+smaalSY
         Gxdkgs+t5kkqV/N+HfJRBe0McqRUiAruKmMLQjdVi0xVa/Ympx/fBuTbBgnczmTtCkIa
         L4xhbNiCcE7RCEMTmGpRvKYJYxSbIXbiiMviBtC2wqJNO0KpBL+WN+U3WLsjYob6xs6f
         3sxrw1UFFImtsQTm/gy3XWrpkMpgMAtX9pcdp+xTd6KuCOz/RNQG8BbPDNn43Y/IypCt
         v49+9WzoPnXWWgH4OwW7wVj+TV5H5MUJPSK4xKrBFVdtyqEgy+2SyaTtwvfDAFlDAoMb
         TdoA==
X-Gm-Message-State: AO0yUKX06nrzyCH5c2Wb0N7wrg9ULODuShNGUGm4LdZd4yQ/GozZvfeb
        w2w/WCERXrEpiJPs/ZDF7CU=
X-Google-Smtp-Source: AK7set868C5szQMDuc5o4469RdzWzYsVAD5VkQnrwNLjTrLs+AzIzw88S+1WXWHaTuoZKhbIUFPGow==
X-Received: by 2002:a17:90b:1811:b0:230:dd10:b2ca with SMTP id lw17-20020a17090b181100b00230dd10b2camr17810030pjb.32.1676056381674;
        Fri, 10 Feb 2023 11:13:01 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id fv15-20020a17090b0e8f00b0022c9eddaf9dsm3434699pjb.0.2023.02.10.11.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 11:13:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/6] remove USE_THE_INDEX_COMPATIBILITY_MACROS
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
Date:   Fri, 10 Feb 2023 11:12:59 -0800
In-Reply-To: <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Feb
 2023 11:28:33
        +0100")
Message-ID: <xmqqk00pibb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Most of our use of these compatibility macros went away with
> 041df69edd3 (Merge branch 'ab/fewer-the-index-macros', 2022-11-28) ,
> which was part of v2.39.0.
>
> That topic left out these stragglers, as some of this would have
> conflicted with in-flight topics, and I'd skipped the cache-tree.h
> cases altogether.
>
> The update in v2 is trivial, just to rebase the series for changes on
> "master". There are no semantic or textual conflicts with "seen"
> either, so finishing this migration before we get another user of them
> would be nice.

Yay.

Thanks.
