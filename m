Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC70C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 20:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346720AbjD1UqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345728AbjD1UqI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 16:46:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC901FF2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:46:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b8b19901fso540084b3a.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682714767; x=1685306767;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAU0cphfiWyKWQcdbPbM1r6b4+2DGLPBmt8iiSauM60=;
        b=dK/czhs6Orf74uK1IpNAEFUy6WkVsuc05+0Ar3d6TKXWbY7fgNHiaM864ALMRfjKH4
         pzVygmBo/IxfouAgxd7BpEKKT5ZFS0JjPcz737cjm5gFdbgrKMlIE6M8HEOhiKxaA9y3
         li36ykN/6PtDHzTq0UcC/4nseKjW8IqR867+f9XEf5rKqW0h9qx7EjjSYe/QfBW1ToFA
         TRKAnfKHC2GARM1nytuXlx5jPRXrkCvAhvF8yhFMG48bKGnLcEk+UTY97p+CjBTP9p35
         sUVrjkDRYbMynbe9iTBJfNyELDBEf+1l6pIYB+Y3SH7zQ6YwRC4vc9MNVc2KxWGfZ90k
         Rdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682714767; x=1685306767;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rAU0cphfiWyKWQcdbPbM1r6b4+2DGLPBmt8iiSauM60=;
        b=baervw72b00Tjeb7m6EiDSce16icFyFx2HB3LUI8KZZmmNkiDpAyLSHBU8bxseBIET
         1f1pJ+HXHfeypiESdqcbB38BnPf39kYeB5YBhKTZh6ATgwF+J8jFqWKKvssqND1g4L8Y
         DlTAkaSC7P+MLBv/EO4wPxM3VCSTtv+v5plMVHpz3x6RBqw3pwRExbLb8FMj70UY95mC
         tMKEd32Vn1Bt+IjqXdWg0tVkzHKtEVbGVBVtDITG6UYP6QZwrwQQLS9vVDFJ2VV0QfdS
         OMWkUNR0iCCpVk5EueIX9NngdrhpLnyK/tktc6pY/h7+ubtVw6btDNwjEjX2If2Pw8N2
         a4HA==
X-Gm-Message-State: AC+VfDw6Gy5M7mlAiBAN5sYsBUanL1m0FqjC8XDHjGp6DREy4ciaTr4T
        jgt9qM02Of63pU6c/zhaFMo=
X-Google-Smtp-Source: ACHHUZ5haKvQLyybtiFk97N/0f/rwMJG1OBOoVoM/BbvTYYEnvgQbmKx/9wrsEaeJu0n3h72+WmZXQ==
X-Received: by 2002:a05:6a00:ccc:b0:63f:125f:9595 with SMTP id b12-20020a056a000ccc00b0063f125f9595mr10041382pfv.9.1682714767452;
        Fri, 28 Apr 2023 13:46:07 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id i2-20020aa787c2000000b0063932e36437sm15579941pfo.134.2023.04.28.13.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 13:46:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 0/6] notes.c: introduce "--separator" option
References: <cover.1682429602.git.dyroneteng@gmail.com>
        <cover.1682671758.git.dyroneteng@gmail.com>
Date:   Fri, 28 Apr 2023 13:46:07 -0700
In-Reply-To: <cover.1682671758.git.dyroneteng@gmail.com> (Teng Long's message
        of "Fri, 28 Apr 2023 17:23:28 +0800")
Message-ID: <xmqqmt2rbur4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>

It may help newcomers to briefly mention what the purpose of this
series is here.  Not everybody necessarily has followed previous
iterations, especially when it comes to a series with this many
iterations.

> Thanks.
>
> Teng Long (6):
>   notes.c: cleanup 'strbuf_grow' call in 'append_edit'
>   notes.c: use designated initializers for clarity
>   t3321: add test cases about the notes stripspace behavior
>   notes.c: introduce '--separator=<paragraph-break>' option
>   notes.c: append separator instead of insert by pos
>   notes.c: introduce "--[no-]stripspace" option

Looks quite well done.  Will replace.

Thanks.
