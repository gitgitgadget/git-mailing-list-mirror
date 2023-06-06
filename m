Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65DAC7EE23
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 01:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjFFBFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 21:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjFFBF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 21:05:28 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30856EA
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 18:05:27 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-543a09ee32eso1452690a12.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 18:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686013526; x=1688605526;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/Z23G8awF8/R+pyHuRMBqjYUX3StsIWI1f9XpGwBZg=;
        b=L8LNw5BQ3QBsPRVrk1IecRmi6kk+yNvJkdWsi93ZT1FuN/5A91FJULae8KVrxZJmM2
         niz/bVUYZv+jliDnlhyKwWToSOV7DjVBj4CKf9hMvjqZrrii8oqywGVkXmsTROv9Sd8S
         rwqVMcoV93kmzbC/svZivVpDtDbGO7tx40M4Epvg36Ah95QCR9ZMvA4f1n/AUWl7qDpl
         A6MmBbF2szKsZVlQJxP+oKMZs4JeXYji+vGsRYV7xnIJGkCQCJHMQAgHAfDyV0kvUH4w
         XakpN+Mw6SuYCLFR6+8Z1UYKxF1eKv/TlOOtglKYJLPvKIaFK0wne5EE1jB8YzL1/b51
         7SHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686013526; x=1688605526;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+/Z23G8awF8/R+pyHuRMBqjYUX3StsIWI1f9XpGwBZg=;
        b=DlAi9Ir7xhqbg/WR5Vj7QBQuY4D16oxyYN1dUS/KLfKJYc6U7OL6FtO0oJqpplOEON
         NqUr1LEQZZySCCz5X5X0IWuH/SUk8dC4sOV2oDfNh39OOQCV3vveMQD2gXQ8d8hyHyak
         QQ7g/hvzmSpixY74CmM0TRaYa4j+BrXhH/ewevOy8ROf8s6wvXtOCBFIVESqM7FAYHps
         BYJ5pLlbuuGofxK2x8jYGerfN4t4HC/NATw3iVW6VghPUTX0Kw+3BCq49m0Pp3gM5UoM
         DTnomPsktp07vYiI4WGIFO5Rq1SOY8BernoANVglIvtpHoPj983Voef15viTbtmrc4ar
         tC7Q==
X-Gm-Message-State: AC+VfDyJTzzkvQmN0WDxcWBd9jX2RLGH/qh7sc4sdV45GSI+7WOiocBd
        HLzs4pzhu3sEtfe5rSffgdQ=
X-Google-Smtp-Source: ACHHUZ6WyxSigPP862R0FvN35nTQ0OQ07QlaQw0B07m97t//S6FjX9thxkg/5Q8m1HF1J35I2b8kzA==
X-Received: by 2002:a17:902:e74e:b0:1a9:6a10:70e9 with SMTP id p14-20020a170902e74e00b001a96a1070e9mr642336plf.33.1686013526541;
        Mon, 05 Jun 2023 18:05:26 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001afa7040a70sm7142189pls.276.2023.06.05.18.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:05:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] add: check color.ui for interactive add
References: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
        <xmqqsfb54d4u.fsf@gitster.g>
Date:   Tue, 06 Jun 2023 10:05:25 +0900
In-Reply-To: <xmqqsfb54d4u.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        06 Jun 2023 10:01:53 +0900")
Message-ID: <xmqqo7lt4cyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	test_decode_color <actual.raw >actual &&
>
> It is a minor thing, but for expected output that _wants_ to be
> indented in a non-standard way, it would be prudent to protect the
> lines from "git apply --whitespace=fix" and in-transit corruption,
> perhaps doing something like ...
>
>> +	cat >expect <<-\EOF &&
>> +	           staged     unstaged path
>> +	  1:        +3/-0        +2/-1 color-test
>> +
>> +	*** Commands ***
>
> ... this.
>
> 	sed -e "s/^|//" >expect <<-\EOF &&
> 	|           staged     unstaged path
> 	|  1:        +3/-0        +2/-1 color-test
> 	|
> 	|*** Commands ***
>
> Although this patch does not add such lines, the same principle
> applies to expected output lines that _wants_ to have trailing
> whitespaces.

Another thing.  We are interested in the configuration to disable
color, so instead of spelling out exact output we expect, which is
brittle when we anticipate that the contents used for the test may
change, wouldn't it work better to ensure that actual.raw and actual
are identical?
