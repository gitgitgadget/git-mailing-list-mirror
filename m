Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C234C433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 23:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C20120784
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 23:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbhACXcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 18:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhACXcF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 18:32:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DB4C061574
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 15:31:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r3so30114153wrt.2
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 15:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vs8S807IOtk0FaDHBtuw8J81qkH3DD5/N9fhbzq74t0=;
        b=HH+MVlBW2kcVDCIulBIOdTwSUU0wWb6PAuwpKGTx7O7FKAbhKJFyS2uP0rzggSuTxm
         uubxWQ7MsdM1VtoLMjNge8i0H72pp7NUIZs4p+1XtCNzkdiCs885UOO3F937uaeNQAbt
         3xdyftFYTeCM4DVJJ6oeT95tGNciXU+QCu/9Zt+EkwcLcs53KlljAHj1W7gMCP7yN1qO
         KsCZymG6OeVAbTxADE+FBQ1bUkpfKPs6ocRYJGH+kgngI7WH0PmKoKxYfuGxidrVXjDh
         PNK+dJZvOQc0bnmIhDi2kW/5gS9LVX635tHCn+SPoNyBMer9RXoLL1HmOMYvZ+aj4sfK
         Tsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vs8S807IOtk0FaDHBtuw8J81qkH3DD5/N9fhbzq74t0=;
        b=fO9TwVuruubMP8sefZ8WU3aDfWxhMlQc+UkfBFcsbLk1+WWyL+FYb/25Y2yrAtIYzb
         hGwDPx9PJM4P3GtZ8WUHlshGMvRg7mi7xg65A8LuqwY820LzAelX8PInx8tqxbUos7tB
         ZTAcMWCsR0a0fzO7Jh3OQLBcHH2vjAOZ32xDEOqqA5c9zDqNELwSmBNPIGW+YO0rn/Tu
         wp/y99xUWGcD9CJR0qI+TjfjJWH9e+TKD5gtAkbft7DizKP70nAEho26Kgz6zMIHpGN2
         XRSLoUEVrzLQr6o4jTAqpBVfK9DvpuFb+M4XQf2LIgdJ+ymys9Rw41WzTYQfYV/gnSqQ
         p8Ug==
X-Gm-Message-State: AOAM532bIfbKpIfJUq6oY5N4iymoLfOAPaHl3sVwKHnYv6YfxC3/74XF
        1wYJ1V98RhAgYd31EqxJYXE=
X-Google-Smtp-Source: ABdhPJxNo9ZEV7nmV9T+5f9rQhEjWDCUb4s1wufDucA1qZqZPE5Z+lMyjIBlneOrUgDwUOwggOs28A==
X-Received: by 2002:adf:f88d:: with SMTP id u13mr79818623wrp.161.1609716684068;
        Sun, 03 Jan 2021 15:31:24 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-424-100.w2-6.abo.wanadoo.fr. [2.6.87.100])
        by smtp.gmail.com with ESMTPSA id d187sm30334399wmd.8.2021.01.03.15.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 15:31:23 -0800 (PST)
Subject: Re: [PATCH 01/12] merge-index: drop index compatibility macros
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
 <68d88b651c74659eb171e88d701b89d11e7f5f24.1609506428.git.gitgitgadget@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <f3d0ef14-c753-c107-4693-67cec504964a@gmail.com>
Date:   Mon, 4 Jan 2021 00:31:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <68d88b651c74659eb171e88d701b89d11e7f5f24.1609506428.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

Le 01/01/2021 à 14:06, Derrick Stolee via GitGitGadget a écrit :
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Replace uses of the old macros for the_index and instead pass around a
> 'struct index_state' pointer. This allows dropping the compatibility
> flag.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

I already libified builtin/merge-index.c in ag/merge-strategies-in-c,
and such dropped the_index.  I modified merge_entry(), merge_one_path()
and merge_all() to take a callback, itself taking a repository.  As
such, in my series, these functions take a `struct repository *' instead
of an index state.

I'm not sure how we should proceed with our respective patches.

Cheers,
Alban

