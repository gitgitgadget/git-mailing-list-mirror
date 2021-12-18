Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF82C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 08:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhLRIYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 03:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhLRIYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 03:24:21 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454B9C061574
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 00:24:21 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u13so2210779lff.12
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 00:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OZUYOTnyfLbTU7nc7hH/ITDVSiywqNipWdPUxBgPgnk=;
        b=erUuO8HF58nSKNbvdoLzQlyeDO2/1IDRXHTKlneGdTQ+gpNAHq/s0dEnDSwGgEAy9z
         x4Hh0ugVItZP5CgxfCMY8Q1uNNI9hc8hobqrGch5qs/MSYXfRya29pWXfOT1TzbsRqbP
         w5cGQC7uRpESmMNHYuaJLingMSaA1oougTIVv104C9Pg2TSXgvlSAJztWp3mtGlw3EMx
         XqYGvfmWRn8M77rJ4LnSz/21JB54sL4ZhC/BoHQ6E9aviNYc+WtE5f5fSEiZ88ZBQHYE
         TOdbgyzJ4jkYCp/DtwvWtbxPi9RetNwLwNQsU3kU8UnSyYLTCvqA3H61XeFqB8M58SHJ
         l1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=OZUYOTnyfLbTU7nc7hH/ITDVSiywqNipWdPUxBgPgnk=;
        b=VEWuyJghRTLK0B7sTEtWIZUo4WGyQ+KYzMQVmG+7u/AXGEfDH33t9cvCEEYILA9RV7
         anWRYnpiMtxWhZOe3OIAUaI5LqSG7NsvFz26s3thCDSxWENKj8OsXD8BAoFWv2qj3hZW
         hBXQdfrg1LXWGv6d3Jm2C5a2nQKGVA4MjkqObJf6vZmG8qNAHdsiXrTf1TZOsg7yWT1R
         yf8mlPyYdQVwBjqhYiVJ40ouL5VvZOOznAP6JbTQXRvcCsrXpHUevflBtZnTZDeucot1
         xxKcFT3IjCM+AxmErgMdceF+LuqjUCzfp+gFRkrGjft8XhIGpUjDYk8BxvGmWkgb+8+u
         7x4g==
X-Gm-Message-State: AOAM5306V/BdfkFF/+yLH4P/1aWyWvYGOlnjtPeWYZE7FVrSnZt6sKSr
        FLbpK/I2RQz9hRcRDT5tJa/6YjYqC+Y=
X-Google-Smtp-Source: ABdhPJzBXskCqApdRXQa5d8L0LInXYNEIaooZMxApAq+G1oT5Qd36W/yZGOJRJV9cRYhdISKo1R8/g==
X-Received: by 2002:a05:6512:249:: with SMTP id b9mr6543426lfo.496.1639815859149;
        Sat, 18 Dec 2021 00:24:19 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u3sm1639936lfs.256.2021.12.18.00.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 00:24:18 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge: allow to pretend a merge into detached HEAD is
 made into a branch
References: <xmqqbl1ezq5j.fsf@gitster.g>
Date:   Sat, 18 Dec 2021 11:24:17 +0300
In-Reply-To: <xmqqbl1ezq5j.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        17 Dec 2021 16:56:56 -0800")
Message-ID: <87a6gyiamm.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

[...]

> Teach the "--detached-head-name=<branch>" option to "git merge" and
> its underlying "git fmt-merge-message", to pretend as if we were
> merging into <branch> (instead of HEAD) when they prepare the merge
> message.  The pretend name honors the usual "into <target>"
> suppression mechanism, which can be seen in the tests added here.

I think renaming destination branch in the commit message is useful in
general, and should not be limited to merging to detached head. Please
consider to introduce something like "--into-name=<name>" instead, that
will do this renaming unconditionally.

Also, being an advocate for eventual abandoning of "detached head" from
Git terminology, I'd prefer to see more neutral name for the option
anyway.

Thanks,
-- Sergey Organov
