Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1392C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 18:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjAMSEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAMSC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 13:02:58 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4AE7EA5E
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:58:04 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id dw9so21726440pjb.5
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/ePJScGoXAN1ZeR6ZS2w3NIvUiFmmWA5HSleak7LCE=;
        b=PUwWSZYOikcYxGfU9zrC4nQScuZEuR6Dy+A9aeMfxC0sirsb3K2MF/V2I3uKCypZcb
         wMCwYj2cHjxKr2SKblgYA247ptdZbZBw2Y9ZvvJGD2dGi14d6q3+f4Myep1tDRSE9y7F
         RwBZ42DPjQEgkSunkNCn1lWiOgmvlgdOkhhrQf+M8ZUl0J5quYbOX1DQJvYBhlSilG9h
         Sw/2cQ7llFBkKEPqngaquwbPIGjtEgfJLUSh5jUnwEFQw1AaE1q21Tg4xDM2ZMW9lQz+
         QiVEGaMUy/A3XO2Gpt272fchyxJIaIJJyhLgbJIxy9YJwvS01pVZ2FYNJqafWI5SOvO1
         83uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/ePJScGoXAN1ZeR6ZS2w3NIvUiFmmWA5HSleak7LCE=;
        b=SmPEhH4a17gRtNetLwn/FYowHME2GHVk5E4t+Eeo/FhX0w8jPbEUV06mWrHOr9OJbR
         pLFpjhx+LUvAALxScQE5G+AEzs0bh8xJv/tmU6jJ6ynaFKTqSYqMj9OOtu43LwqWqR5a
         raQm14au9aO0PR0e/sE4FeucaBe1Qm53SWaZbhr1CjZtL8MPGkIVuZe0twMtU0YyhTWs
         v6RleDkp+fUp+PlBbKzS/PMjclk2ssBfNcSAzadJfUYinjPyr5p/VONUGJ5ZFV3BQ/Ic
         9bjZ8K+i9fdXRivQyWlxmTb64usdg5XrcutkGAnQdUmclsv5qMu2U4X/H73Hl/hcQ0t7
         98bQ==
X-Gm-Message-State: AFqh2kq8cRbJ7qll7kA5KgkUovSJ/E52vJ8g0G4o3fP9NYYpkWDcK5bO
        6vDM8JxumshpZQjzJZaFkj8=
X-Google-Smtp-Source: AMrXdXsqadScnKtgFtyx6q3pldcan8w0HgxRrAVmeFmx22YMH05NRgLSjXffp+KqX9bDwXi6i7wZgw==
X-Received: by 2002:a05:6a21:920b:b0:a5:7700:2a4a with SMTP id tl11-20020a056a21920b00b000a577002a4amr13175215pzb.51.1673632684420;
        Fri, 13 Jan 2023 09:58:04 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b0019334350ce6sm10328883pls.244.2023.01.13.09.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:58:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Yutaro Ohno via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Yutaro Ohno <yutaro.ono.418@gmail.com>
Subject: Re: [PATCH v2] doc: add "git switch -c" as another option on
 detached HEAD
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com>
        <pull.1422.v2.git.git.1673261237449.gitgitgadget@gmail.com>
        <CAPig+cTHMEeUw8PVg7nWU8+jdo=yN9nC+RRuaSiVg8D3Or-nNQ@mail.gmail.com>
Date:   Fri, 13 Jan 2023 09:58:03 -0800
In-Reply-To: <CAPig+cTHMEeUw8PVg7nWU8+jdo=yN9nC+RRuaSiVg8D3Or-nNQ@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 9 Jan 2023 14:53:13 -0500")
Message-ID: <xmqqfsce48r8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks. This version looks good to me and addresses reviewer comments[1,2,3].

Thanks, both.  Let's queue and merge it to 'next'.
