Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D68EECAA24
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 16:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiHYQZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbiHYQZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 12:25:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F34457F
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:25:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g8so15063580plq.11
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=he7EnlwpXfSGQ9/+7D3bwIFgkqQLLFqvw5nQkdz2rvk=;
        b=a2YVVz2aHhOlcbPr63d5K5Qt8hDKLTdg3MWWSHOH0vGkPi8pMUYeJE6BQz+FZZCuLx
         /2bRSIwZRwyFK8GYU131LAUD3Ij5B6+dX4E9UkIXgdH2KH4DcglKUEoxh5leLIu+lEfE
         V26P5WXzMimgJkx0WU5ZQyRcXDLmAbsTH7zj4dcjlF3GjQEPsqSugDYl9gqmntjst6O/
         BuXtfB/ynRMrdc8yb+AqIDrvrXLxS0kexxF+3rJb39cwe2oh/k44/uykCFFyVSYsISis
         OtVCvRPRUiNdJGX7YCUUjctRjH5ipRQ+sjx00XSB15o1euXJO0Wyx0RrWJ4Ggou5NRkG
         s4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=he7EnlwpXfSGQ9/+7D3bwIFgkqQLLFqvw5nQkdz2rvk=;
        b=4vEi4GCgQ8WNTCb7ll2zioSvIWXo5CuF/Kj9v3viovlnwlkp9919dmEMWwsBJYwrzT
         6FxHtkdS6toR4mWnKEQakUC+Rt4QkbF13lnQjrkrbYUgJJjzSui+FokRyP9RtjXX2knN
         2orlYtQGJB0S4o16MUpjwJnz74+kGzI9g93WkFZBJCd8P0BKFmO5Y6Le/zb2ONCMAPFI
         qq6dE7s7gbMYaPQyGbk631O8NUiMPAYfvcVn+RtxRLq38n/T+ca+5gL+q5NxGA3TJigr
         1Q9Pu9wwhxGQJTg2qfnA2K6t4bTD9p9ZydXi+KCQ3AB6NLWvClK3Rjeu6vSTtxKcnYZ0
         HGPw==
X-Gm-Message-State: ACgBeo32tMniP1BjpUg5caw7UJrOfxzm3+mPNgYAYtptSOlI8czBcM3o
        Z4MAzjAV5f2KqGVTAtqpCJU=
X-Google-Smtp-Source: AA6agR5pFOEzQEzMIN1QMqwtTiXiTHvayD+OBxj4/81yaK7PiqGxylSrdTUBdK5L6kxGfmGKgY2Flg==
X-Received: by 2002:a17:90b:3b8d:b0:1fb:72f5:2d1e with SMTP id pc13-20020a17090b3b8d00b001fb72f52d1emr5348546pjb.135.1661444725953;
        Thu, 25 Aug 2022 09:25:25 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090aa61600b001f7a76d6f28sm3784949pjq.18.2022.08.25.09.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:25:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Arturo Seijas Fernandez <arturo.seijas@canonical.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git config --unset is not idempotent
References: <CAHckPJS6ibtxbU+VKwDaU6pFMtJ5SMcWnBi6D2pY+ekqpWsqXg@mail.gmail.com>
Date:   Thu, 25 Aug 2022 09:25:25 -0700
In-Reply-To: <CAHckPJS6ibtxbU+VKwDaU6pFMtJ5SMcWnBi6D2pY+ekqpWsqXg@mail.gmail.com>
        (Arturo Seijas Fernandez's message of "Thu, 25 Aug 2022 10:52:16
        +0200")
Message-ID: <xmqqk06w2sui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Arturo Seijas Fernandez <arturo.seijas@canonical.com> writes:

> The command "git config --unset [option]" is not idempotent. It is
> currently returning a success  code when the property had already been
> set and a 5 error code otherwise.

"rm" is not "idempotent", either.

    echo >file
    rm file ; echo $?
    rm file ; echo $?

The "git config --unset" command signals the inability to unset a
variable when the variable to be unset does not even exist.
