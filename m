Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF92C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 05:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiLNF1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 00:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNF1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 00:27:16 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3453824BED
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 21:27:16 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id js9so5758497pjb.2
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 21:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTs1ad4ZX0pUTDotOuocwwaJu2JC1CVZFM0+N1R3qKA=;
        b=lx28bq3yuT0Bc6CW+QxwpZXloggmQhzhsVNcSVgeUQRDOybVPnxHDcYpa0h/JonJ//
         PqaD0yX5j4GfRYG1sdrArIqezc9IJbgjEr8o0dawIxqEbTnfkrNZ1V2LK29ibongpL9O
         DDGL/4pnjD3/dsuoXghANT1FzF7D4KGrFqzQBbVEMCHxH7BJg/qD2ryITaqUH80iDSC9
         WgIul4z+OYIxXaI/JXvb6H54Rf28sAfdyb+Gl1wWJwU1DV+ULyWRPCOjX7g8rhdk0SZ3
         dOl2yuHtFd49ENHpIU7/1u/+D5+ZjZlWuRnrzZELJMG2LstKkqFj3D67yW9j4fAJi3sG
         mHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OTs1ad4ZX0pUTDotOuocwwaJu2JC1CVZFM0+N1R3qKA=;
        b=uPfhGUXS2hFfeN9Rkf45eCTbR6Vsm+pExIJElMepXVdaDeqd6JiUcVkTbF6pJHOGd1
         p1xOlVESC44dwlKBS2r5PW7fBKN6fd7Nou2rirfIR1Zdu1Uki8GWo6pvM+TYQF4vZlz3
         ezIXHRAoFI4ofz2m/Hi4EhMwGxF4QfDtkz0MeUb5B9Y3+8hr+ox/WZEQteYAnuokhZHa
         4FnfDIA7L8Fh9j6WoGy7uRoheEz0Mj5o85aJGDRW3LblAXG6Kq3S4XN+xmk81K8OMrHS
         ammn7LcdDco5a/Iy8WgrMTOQggdYhLvVLjRU0xnqu6M8Ps3+RwdqFxr1Y+pe2foSw/uI
         N+Xw==
X-Gm-Message-State: ANoB5pnHSNzWVvPR7S5yn7OMGE5nN1/ffS7meAOsJ4ozYe/diZd2h2dE
        1jHV4net4S187cFLP3+D13c=
X-Google-Smtp-Source: AA0mqf6cjWSrVxAZ8MD74unlmrx5UCTgCiE6hE0RMQCn3nYPDAUq865H7deOdNw+AYQ8imJtkdoTIg==
X-Received: by 2002:a17:90a:8a8a:b0:219:dc24:7595 with SMTP id x10-20020a17090a8a8a00b00219dc247595mr23297538pjn.19.1670995635627;
        Tue, 13 Dec 2022 21:27:15 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090aa10700b00213202d77d9sm428267pjp.43.2022.12.13.21.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 21:27:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: [RFC PATCH 6/6] ls-tree: introduce '--pattern' option
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
        <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
        <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr>
        <xmqqtu20qinx.fsf@gitster.g>
Date:   Wed, 14 Dec 2022 14:27:14 +0900
In-Reply-To: <xmqqtu20qinx.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        13 Dec 2022 08:57:54 +0900")
Message-ID: <xmqqbko6y2q5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> The hard-coded object IDs break the `linux-sha256` job, as pointed out in
>> https://github.com/git/git/blob/6ab7651d8669/whats-cooking.txt#L522-L537.
>>
>> Please squash this in to address this (Junio, please feel free to
>> cherry-pick this on top of `tl/ls-tree--pattern` to reduce the number of
>> CI failures):

After re-reading the patches, I am very much inclined to drop this
topic, which does not add much value to the system and adds an odd
corner case in the UI.

Who needs "git ls-tree --pattern='blob 486' HEAD" that is a synonym
to "git ls-tree HEAD | grep 'blob 486'"?  Should we end up adding
the same option to "git ls-files", "git status", "git ls-remote",
"git remote", "git branch --list", etc. for consistency?

This is simply insane and goes directly against the "one tool does
one job well, and can be combined with other such tools via pipe",
which is a key to scale the usability of a set of tools.
