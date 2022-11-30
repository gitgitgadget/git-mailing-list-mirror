Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C75C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 04:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiK3E2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 23:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiK3E2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 23:28:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A524B74D
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 20:28:21 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so781647pjp.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 20:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQnaZ5VKIeKq9TzkcZm10D0aet2TQXEy7v3ZqdMOrmE=;
        b=ALyT8f26xToYASGiS5wqFb1KV9vdFXOk35fEH/pk8x2KCLJPbdiKi5AS3AGdl7xiTL
         uTL9vUyBxzfTt02huTF7hGVDYkfz2G2uwDDVdb6zHMR+6bPq+CdktD5JA9KAKrAcSEZE
         pzyPdA8Z6pxRGkxd+qOmwumP6i7CcpJfecQKgEL/0cNas/ceh3bvRG7BAg8zt1dKBxTa
         hi5txKaBK2RzJD+wBFHbhUuL3L2OQG1SX47goCkjGVaCZ/Omye53jToTuYc39Txq7pS1
         NFQlwyQB8wh5h67wFRiU8T5V8qqspAx7rHM2DGSXSh25CtyRj2JIhajukYbEBkuZJbA3
         JuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQnaZ5VKIeKq9TzkcZm10D0aet2TQXEy7v3ZqdMOrmE=;
        b=Hy9YhJ+jOMiAA8KxgzFO3EFCorH2f5Y6LNEiaUH3UJRc/3UB+wtNGNKqlclv2w55Pz
         sj+47U+6QSmPijkpvR03FT+4izpXnQfxCML8VtSdW83KDYOnMoWoeKEXxfe9FZUvgOXE
         8qEexuKeydH35EVm9zHPFPhy8sfamfkvYfnDzCepI07BQE3kZH5vy3Kgx6ErGBxsTGu5
         K0Lo/2IFmy+P4WGokVD07iv6W6szmvrr/BwtEuvimKCHyeVb6+agCur5gXunQWevD9Yt
         KnL9NZcI2yNVyU3kbXvp/aQWORFGEWMmS+sXMuIYouKrMR3q5nLltHUprZo/rZvuhos5
         ZZkw==
X-Gm-Message-State: ANoB5pnPtePqwPCWVpy8FYVGX3nu0OYzKgxwIKNOATcIGAWDSnOhaHOX
        rvkw8sNp3Vyk8AiOLhbbM/YFv+CbDsC/lQ==
X-Google-Smtp-Source: AA0mqf4tDKt0V2k2SD4kBojlubgKdPOmJ9dxADGqHqCWxur5/SNXiXnDENzfLLIjsiBaUZkXeOVYzA==
X-Received: by 2002:a17:903:1cc:b0:185:5453:5e01 with SMTP id e12-20020a17090301cc00b0018554535e01mr39250584plh.113.1669782500493;
        Tue, 29 Nov 2022 20:28:20 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b00176a2d23d1asm174606pla.56.2022.11.29.20.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 20:28:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Paul Smith <psmith@gnu.org>
Subject: Re: [PATCH v2 3/4] Makefiles: change search through $(MAKEFLAGS)
 for GNU make 4.4
References: <20221127224251.2508200-1-psmith@gnu.org>
        <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
        <patch-v2-3.4-6db7dd74e52-20221129T140159Z-avarab@gmail.com>
Date:   Wed, 30 Nov 2022 13:28:19 +0900
In-Reply-To: <patch-v2-3.4-6db7dd74e52-20221129T140159Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 29 Nov
 2022 15:09:16
        +0100")
Message-ID: <xmqqk03dyskc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Since GNU make 4.4 the semantics of the $(MAKEFLAGS) variable has
> changed in a backward-incompatible way, as its "NEWS" file notes:
>
>   Previously only simple (one-letter) options were added to the MAKEFLAGS
>   variable that was visible while parsing makefiles.  Now, all options are
>   available in MAKEFLAGS.  If you want to check MAKEFLAGS for a one-letter
>   option, expanding "$(firstword -$(MAKEFLAGS))" is a reliable way to return
>   the set of one-letter options which can be examined via findstring, etc.

Wow.  That's a bold move for GNU make folks to make.

> This upstream change meant that e.g.:
>
> 	make man
>
> Would become very noisy, because in shared.mak we rely on extracting
> "s" from the $(MAKEFLAGS), which now contains long options like
> "--jobserver-auth=fifo:<path>", which we'll conflate with the "-s"
> option.

Do our uses of $(MAKEFLAGS) for the $(PRINT_DIR) and the $(QUIET)
macros that do not affect correctness?  $(QUIET) thing I suspect
will merely be annoyance, but $(PRINT_DIR) might affect correctness
depending on how $(MAKE) output is being used.

I have to wonder how many projects they have broken with this change
;-).

In any case, this seems like a good thing to do.  I am not sure if
this is so urgent to add in the -rc period, or can safely wait post
release.

Thanks.
