Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D556C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 22:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjEAW32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 18:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEAW31 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 18:29:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5BB2123
        for <git@vger.kernel.org>; Mon,  1 May 2023 15:29:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b8b19901fso3598543b3a.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682980165; x=1685572165;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBIz7Zsz1dFZ4/nzkz5Slk6jxs4oCj7d7fGhCnW2niQ=;
        b=qZkK3gc8/MbVhLt6xD2eM26TRVOASMA3t0BLpEc48jmV4+qQs3U3FegH2qbJY/z8Xn
         5GboTRaiTZxsVswLW57DxyOwILAAF6Evx8sEmn4gu/Xr0dyDXOh+AtMEsJjrQnS5C1dO
         ZHNJ13fjmre9rgzq+4Sb0fdSKd79q5p9RsYEHt6vVCNsE2FgfQg5sztmc9t2qQLVfvVh
         MDpRrho+Lv9lYmlr6vKVX7u6iAz+cbt7hZRFWyET+9+vYYiFFp6O+FriR5O/8oN1Z5ZA
         3nIgiQTiVZDsKg7tTJqSodaGZoLjkbeEkpyxX6Mnh8TFsR+lVbUUGD3fTl1fWh1xjgL2
         MJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682980165; x=1685572165;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBIz7Zsz1dFZ4/nzkz5Slk6jxs4oCj7d7fGhCnW2niQ=;
        b=Q5V1+MmUzf3soUxmN0qlVkSXyYVVWJ3z9z+XRmy6GV4nvFoTo3wC2Mn86qIpFU1kBW
         h6iDcQDmvDLyGGe7a6OP3HiZhQ+Y3obn7zn7b0kFNjUXwT79hUL4t+vJixxir5z9aZSc
         GXZ9mIp08r1D04Evg79zr168QyYsmjUJCEL9BleGKTbnmuYtjk0ktQA+laJn4ps8l7bk
         WocU23jpj2J9kzXfTL+iP60YBMuCsTje0QStkTMYa1Y8rQKSLPMDfdqToQ7bN55JmfEq
         2WGdRJ6sX4Kn+Zm6bK1N26lIc/42HdUU/JF611pZag4JxpKs/KLxJbLfNutD8aAGfjtk
         Sxnw==
X-Gm-Message-State: AC+VfDyo6kPsRthihwMf1p3OsP2V/prYPUM01CuNxhlBXo7wIRWNDsqB
        SoaEf5efh4AUXd09QmFQC80=
X-Google-Smtp-Source: ACHHUZ4Vit5va3zrVf/y0mkm6adVk6PU18l1gt2euiNKqeFTGQGkIL7hEPEbyIVnYsz7WCn4grr7Sg==
X-Received: by 2002:a05:6a20:a10d:b0:f0:d50c:4ac5 with SMTP id q13-20020a056a20a10d00b000f0d50c4ac5mr19638162pzk.51.1682980165492;
        Mon, 01 May 2023 15:29:25 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id z20-20020a63e554000000b00502fd70b0bdsm17729412pgj.52.2023.05.01.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:29:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 0/6] notes.c: introduce "--separator" option
References: <cover.1682429602.git.dyroneteng@gmail.com>
        <cover.1682671758.git.dyroneteng@gmail.com>
Date:   Mon, 01 May 2023 15:29:24 -0700
In-Reply-To: <cover.1682671758.git.dyroneteng@gmail.com> (Teng Long's message
        of "Fri, 28 Apr 2023 17:23:28 +0800")
Message-ID: <xmqq4jov3cu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> Diff since v8:
>
> 1. test case: Uniform indent format, as recommended by Junio C Hamano.
>
> 2. [4/6] make the static var "separator" initialized as "\n", simplify
>    the code in "insert_separator(...)".
>
> 3. [4/6] I don't change the other parts about the "struct note_msg", the
>    stripspace way (Junio suggest to consider about the stripspace each messge
>    individually, but I found it will break the compatibility about "-C",
>    which can be found the case of 'reuse with "-C" and add note with "-m",
>    "-m" will stripspace all together').
> 4. [5/6] Optimized the commit message and replace "strbuf_insert*(...)" with
>    "strbuf_add*(...)".
>
> 5. [6/6] As Junio replied, I'm not sure whether the "-C" problem (When the
>    "-C" argument is used with "-m/-F", the order of "-C" in the options will
>    affect the result of stripspace differently,) is need to be fixed or keep
>    as is, I choose to do not break the old behaviour (In fact, I hope to fix
>    this issue in another patch, if at all, and let this long-tailed patchset
>    to mature faster, maybe).

I am inclined to say that we should declare victory and merge this
down to 'next' soonish, unless somebody spots a big hole in the
logic, or finds a nicer way to "solve" the "-C problem" (to which I
suspect there is no clean solution, as the original behaviour is
more or less inconsistent---that is probably because the feature was
designed assuming that nobody will combine -C with other options).

Thanks.
