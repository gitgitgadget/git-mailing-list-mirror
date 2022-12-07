Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA44FC4708D
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 23:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLGX12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLGX1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 18:27:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F08933A
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 15:27:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so2895915pjs.4
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 15:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIkKlFQDOhEj7oMj6XZ4xGq8mAGVrm24FEx0czLDzk8=;
        b=KhqnT29rqLheqYsK5tjTSmLosB9UJ9qK7XOohNTf7+LvvaUOO4uKOVhyEtQHjR5S91
         p3gX9EbK5HcBUSyeQuu+3Nz6/+qtSzPpFTx1IcFoM45e99i8KfDBU+qdQhkNUYHuFAs6
         lyizmZJoOt26duFNH/DD+XhNvu107obCFts/t5oHade/7JiPnNW+rC1PU4/3Av4R6YZQ
         LHMJDWEG9qHLy2xth453a9Xzw2sYbscE/lXwsVSWGBIr1K1sbtrBzOSzTzMFbBH+6viF
         ThAuUAv08ORPK7NscZlEGV+cJ+ktTDMT2j+sMiA1iqgyM0Jf+Mb8ZTrG9npcLLI3XBpN
         cHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qIkKlFQDOhEj7oMj6XZ4xGq8mAGVrm24FEx0czLDzk8=;
        b=v/OhZ1QX6LgCjpWMrSL+C6xBu761a5I+m0fqKpQ+rET7VEsjVHtemCHugTGC9xE4BO
         JXh5cKAJBjS9YriB3jgEpp9U0IZftPiWWDave+xVSUPOYfW+UrvLHqkr4iG49PAqMwAw
         LlJd7w7kMFh5rIqwMglrN6aecEHCNf349HtSR/cAU2Sy5IhASuzc+dPY+BRt1SyC+JzY
         HzPpWz8lB3YpFHz1MUM4JarwyVRzAiITYDqK23b/x0D+tlFq15XLzRFJTvIO/sLlb+5U
         rvzcFnCcMNLQtPLrnYhN0tKQF3i9ydoyMeWebWAcKxRjT7gNptoHKk66e1Lz0lqap1uO
         BrmQ==
X-Gm-Message-State: ANoB5plIQnLT7ztOLLsaTjfVHMBqy1j+BF2YRrw9F5nKqpjjQbMlAZ0T
        vFB4o6y/I/YzvEuGKSltfDk=
X-Google-Smtp-Source: AA0mqf68pQj5xsT3w7JG8nBHq8wZR975kAlhGcdUYpG61Rx/x1UC2zr6S/aGZ2ZlgJKMPlzbYpLeIg==
X-Received: by 2002:a17:902:eb83:b0:189:e909:32e3 with SMTP id q3-20020a170902eb8300b00189e90932e3mr1152995plg.40.1670455642743;
        Wed, 07 Dec 2022 15:27:22 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b001888cadf8f6sm15034628pln.49.2022.12.07.15.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:27:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] Optionally skip hashing index on write
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
Date:   Thu, 08 Dec 2022 08:27:22 +0900
In-Reply-To: <pull.1439.git.1670433958.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Wed, 07 Dec 2022 17:25:54 +0000")
Message-ID: <xmqqilim6bhh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Writing the index is a critical action that takes place in multiple Git
> commands. The recent performance improvements available with the sparse
> index show how often the I/O costs around the index can affect different Git
> commands, although reading the index takes place more often than a write.

The sparse-index work is great in that it offers correctness while
taking advantage of the knowledge of which part of the tree is
quiescent and unused to boost performance.  I am not sure a change
to reduce file safety can be compared with it, in that one is pure
improvement, while the other is trade-off.

As long as we will keep the "create into a new file, write it fully
and fsync + rename to the final" pattern, we do not need the trailing
checksum to protect us from a truncated output due to index-writing
process dying in the middle, so I do not mind that trade-off, though.

Protecting files from bit flipping filesystem corruption is a
different matter.  Folks at hosting sites like GitHub would know how
often they detect object corruption (I presume they do not have to
deal with the index file on the server end that often, but loose and
pack object files have the trailing checksums the same way) thanks
to the trailing checksum, and what the consequences are if we lost
that safety (I am guessing it would be minimum, though).

Thanks.
