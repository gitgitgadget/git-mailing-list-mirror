Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F896E81E1E
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 17:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjJFRSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 13:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJFRSU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 13:18:20 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4EEAD
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 10:18:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c012232792so29020091fa.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696612697; x=1697217497; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0b57ZukO1rZUBXYoJMN+rU7pm5QiCmzxm21V5ytH+oA=;
        b=bkvPcdlIyTJ5Fh4w4/PDyNRy9JZS7h3RxEVQilRGb7rhoDdKLXfQcii6gUE9JV/Tpy
         21CoWnKVHmcoKLc90nW0P39+hR7VnVvd8T6Rz3Z0wiZbHBQ0NV/RX7AUh5KUkQ9yB7rv
         C1w15IexwCOsD5Exx8f9pxr8JI+PKiDs9jE7WlcAW8j0jw8EcSzCN1WtUX3N90IuRJnq
         r9oDR1agEeM2csva3koUVJGbfow9hbBTkyIhCJAzI+dKj+cD0uMG0vCaoq+X44/VdBix
         kzru64Sh2V4Uj+UqI8ifT6bdPOjCVP543QQnaPHMZE1rPfA8lFwSMpOg+zeVprEFcy7T
         xUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696612697; x=1697217497;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b57ZukO1rZUBXYoJMN+rU7pm5QiCmzxm21V5ytH+oA=;
        b=bzAWE8iyIIDILjCA2zLB5ER8iHlrkZSM6rbwWrUVfxsVetbwWeN4BhRkHx7VdUJFfr
         AxUyyioPzwNfJZvuDgLIbBwYN74wX1JAzXJ+RC8GAji/lUxBOHsHZYk/bHNQNEXXvlfj
         rb53xhuEUz5F7zSoOovJy2IL5jakYd2Tr1HklHBoH9GE1kJ7R2/df32OqBTC4XZ5gAXp
         ej3YAaaasK9OhHY3iOcV1difIkMcXwgfpb81Tdc7vcwaK1IaNk/ey8748hZqDZJKaXxX
         h59cXLukqp8U2M9aokI1DKUB0ivGjyi3romoL8TQmFzwyck8O4+QRH0eCJnUpCIWYwM+
         ZXEA==
X-Gm-Message-State: AOJu0Yx16Dj6hLf7ng3l9VFcil1lBsAce2iHaYi5DjHQKX7gsZgoL1pI
        llWKhYCcZ3J7P6MpUFIkldj26/cbyDA=
X-Google-Smtp-Source: AGHT+IES1f1bPV9oq4QIsFGT8se7NLdrIJfdrwdZhXMcTSRarKgKvfVE3GcPJ40jQ0y5DLb9492xjQ==
X-Received: by 2002:ac2:4bcf:0:b0:502:cc8d:f206 with SMTP id o15-20020ac24bcf000000b00502cc8df206mr7666122lfq.23.1696612696763;
        Fri, 06 Oct 2023 10:18:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g2-20020a2e9cc2000000b002c00e475e23sm858897ljj.131.2023.10.06.10.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 10:18:16 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <xmqq34yog3ux.fsf@gitster.g>
Date:   Fri, 06 Oct 2023 20:18:15 +0300
In-Reply-To: <xmqq34yog3ux.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        05 Oct 2023 14:24:06 -0700")
Message-ID: <87mswvr7oo.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:

[...]

>>  --no-diff-merges::
>> +	Synonym for '--diff-merges=off'.
>> +
>> +--diff-merges=<format>::
>>  	Specify diff format to be used for merge commits. Default is
>> -	{diff-merges-default} unless `--first-parent` is in use, in which case
>> -	`first-parent` is the default.
>> +	{diff-merges-default} unless `--first-parent` is in use, in
>> +	which case `first-parent` is the default.
>
> This reads well.
>
> In the longer term, "--diff-merge=first-parent" that is used without
> first-parent traversal should be discouraged and be deprecated, I
> think, but that is a separate story [*].

I fail to see why useful harmless feature is to be deprecated. I believe
users are pretty capable to decide if they need it by themselves,
without our guidance.

Thanks,
-- Sergey Organov
