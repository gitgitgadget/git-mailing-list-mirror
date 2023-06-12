Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF998C7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 20:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjFLUqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjFLUqI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 16:46:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B63E1BDC
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 13:45:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b3a82c8887so22470205ad.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686602748; x=1689194748;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaVe7Rh6M8aw38eYAXKWX5k1aW/5M3zArjQ28aoCtkE=;
        b=cRiwE/5ffwnYi8Q7vVJAXD0V3+Zq2mLXv0BBoXRmz7lxI9/A1jF+/vp4/KhP9atQfg
         1LpxC0N4R/3D6QI2YXCjfb95YbLWi8rrxHnIZDg4zOg5SbcPdlDRUBwNUMH2GQnl0NvD
         ieZwj/gheJMp4Ecd/oMHBcS4RxmrKdmoMuCSHrjeC37WYmc8JonjjSO4SzAik3c7nyhB
         H0pE/lyPxCmdKkPn8bTnf+1qaFXncdZh/t5TtBbyZgz1yPDGyfV/+6cuV7hCFVCxVVdU
         TrCVsyVcY4ALjC0j1DMH/v+Ot18gVtJhJu4cXkbjzThL88hcqFd+CGLyn/NkpJT2RFau
         LzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602748; x=1689194748;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MaVe7Rh6M8aw38eYAXKWX5k1aW/5M3zArjQ28aoCtkE=;
        b=LPJSPjvbatLyJMaFYVbKn85VIl086wPVEVuQeidCnYdM+ZFN/Iyx735+wOv5Ps1eYG
         CM3uFPK4xxfhsnnqgnShN4K+O2G5frvu9sNGtzdSzdTp6eKg2UyJk+vXg4un/Pjlh5XV
         cX8m7aBWM9bwFuOEKBBLatsBxFeOGLiRslOur2uWWoQXFIjiydlYr+TRnuUOpWSXA/NE
         leFUd/1c7zUkU/HzZSbsL106zlhn4OeJFZAg//S1/vDUHWEcoTQ6E0NqYL+aJEIwRZyN
         YRJ4kUCDukpHN8oIOvHShn8XapxFACLcx7VhKEXudqyEiARvWvZ3Gl90G1Irs1gMA5p6
         3/1Q==
X-Gm-Message-State: AC+VfDwAk7GwdRbi1cSrixqSzlhWM6w93VrkjMIwJwk+8IolZJcq97hg
        ahJw4f5vH/bGqF9e0LA1UJs=
X-Google-Smtp-Source: ACHHUZ4J8ZHBwc18/HNYT68fEbHv6nwNijVWBgbRYgSol0nHkcCgHARGk5+NBAmRDPgOMUMij6YoVQ==
X-Received: by 2002:a17:903:41ce:b0:1ac:5b6b:df4c with SMTP id u14-20020a17090341ce00b001ac5b6bdf4cmr8710726ple.69.1686602748072;
        Mon, 12 Jun 2023 13:45:48 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id bc1-20020a170902930100b001b392bf9192sm5673929plb.145.2023.06.12.13.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:45:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        newren@gmail.com, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/3] Create stronger guard rails on replace refs
References: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
        <pull.1537.v3.git.1686057877.gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 13:45:47 -0700
In-Reply-To: <pull.1537.v3.git.1686057877.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 06 Jun 2023 13:24:34
        +0000")
Message-ID: <xmqqedmg9zpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Updates in v3
> =============
>
> Thanks for the review on v2!
>
>  * The removal of the global from environment.c is delayed to patch 3
>    because config.c still assigns the value in patch 2.
>  * The comment for the member in the repo_settings struct is modified for
>    better grammar.

Thanks.  Will queue.  Let's merge it down to 'next'.
