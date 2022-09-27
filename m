Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747E2C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 15:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiI0P3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiI0P3i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 11:29:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865661057F
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 08:29:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sb3so21436182ejb.9
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=FnCg9gdzea8pa8zu92/wUx0Qe/OwwQe8OgOH70L8KEU=;
        b=eDPs4mD71x8MH0vZR4d12+oo7DC4nZ6NIUtBIVwaAJVP5rJ1uGY6sG7VgAF1N3Qr1j
         LgqQb1r/rFocsbxGFlxzRi36NrbA3kc6YVYxmpdh7hEZAXUxm//FxrX0WO8GxPqfD+wr
         0SpE96hDhqP4EvTB3+0VE7cmtajMVDhplZqGc+Er/if/9z2XIA4tHf5YlvXVmWFlXObN
         ddMN2S+JnreKd8CRZuvVaogo064XB/3VSIfk2ju98HbjETGaXt0u3YO3a8ZF5xG9bUTb
         EtsBMOuR8YWXSJrCdm6fHiasCqUrcH43sJs9ACzInJ9Uq2mX5sB8/4383yH7HOYO7XyV
         90xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=FnCg9gdzea8pa8zu92/wUx0Qe/OwwQe8OgOH70L8KEU=;
        b=kdkHQ8NmvPnATX4VDjdnDb+W85NAgq1YWUv6YtpBl1UUmlaYBncO7sUTT2NA/VImSH
         YrUGfVhO92v89saav4KNhWz3+wEsHxnqnUKmkaE6f8S/XA8w4Oerd+iM6x7hm1gqgOBC
         bJgBl+mj3E4LoQbfYREE1/oPI4uVr9aSKaJK334q6jE/YKS0mI9HcrdVAGseKKN3jTnZ
         pJWtrv/fqSKeqFKUf8H9kaVJ8TZnJoVWAN+HsxQfl5nb8h7gCyFdf44sPaZNMG3Qg75Y
         3avavREkrl2VCwqAsBE5qYkKuV/u5rh7//sOFNhKObmK1BsPcz5zpFgo+FNjjXOKqnaj
         lc5w==
X-Gm-Message-State: ACrzQf1O9CrxjvkZPTYHwJmk17oJdXgzGvHI0hNt0vyYNh4elXsOor3U
        t/5VpqTQM7jRu2YpoPxUA3g=
X-Google-Smtp-Source: AMsMyM5rfBvZyDVn5E6s0thWOyTk8PbgJ/qfij3BnDTKUemzrwrxZqaLkYuu4sl4M6gY8rtsej/A1g==
X-Received: by 2002:a17:907:3fa9:b0:782:ed33:df8d with SMTP id hr41-20020a1709073fa900b00782ed33df8dmr15164395ejc.745.1664292574793;
        Tue, 27 Sep 2022 08:29:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7d9c2000000b00457c321454asm1129292eds.37.2022.09.27.08.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:29:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odCWb-000Qm8-1v;
        Tue, 27 Sep 2022 17:29:33 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>
Subject: Re: [PATCH 05/10] evolve: add the change-table structure
Date:   Tue, 27 Sep 2022 17:28:09 +0200
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2b3a00a6702eb8fb12e45b833ca74155939588ef.1663959325.git.gitgitgadget@gmail.com>
 <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
 <220927.865yh8zzux.gmgdl@evledraar.gmail.com>
 <ae031714-ba51-fe39-6351-ebd638840c32@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <ae031714-ba51-fe39-6351-ebd638840c32@dunelm.org.uk>
Message-ID: <220927.861qrwzvhe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 27 2022, Phillip Wood wrote:

> On 27/09/2022 14:50, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Sep 27 2022, Phillip Wood wrote:
>>=20
>>> On 23/09/2022 19:55, Stefan Xenos via GitGitGadget wrote:
>>>> From: Stefan Xenos <sxenos@google.com>
>>>> A change table stores a list of changes, and supports efficient
>>>> lookup
>>>> from a commit hash to the list of changes that reference that commit
>>>> directly.
>>>> It can be used to look up content commits or metacommits at the head
>>>> of a change, but does not support lookup of commits referenced as part
>>>> of the commit history.
>>>> Signed-off-by: Stefan Xenos <sxenos@google.com>
>>>> Signed-off-by: Chris Poucet <poucet@google.com>
>>>
>>>> diff --git a/change-table.h b/change-table.h
>>>> new file mode 100644
>>>> index 00000000000..166b5ed8073
>>>> --- /dev/null
>>>> +++ b/change-table.h
>>>> @@ -0,0 +1,132 @@
>>>> +#ifndef CHANGE_TABLE_H
>>>> +#define CHANGE_TABLE_H
>>>> +
>>>> +#include "oidmap.h"
>>>> +
>>>> +struct commit;
>>>> +struct ref_filter;
>>>> +
>>>> +/**
>>>
>>> We tend to just use '/*' rather than '/**'
>> No, we use both, and /** is correct here. It's an API-doc syntax,
>> see
>> e.g. strbuf.h.
>> It's explicitly meant for this sort of thing, i.e. comments on
>> public
>> structs in a header & the functions in a header (and struct members,
>> etc.).
>
> We don't do that consistently, we don't mention them in
> CodingGuidelines and we don't use anything that processes API-doc
> comments. It would be a lot simpler and it would be consistent with
> our coding guidelines just to use the same style everywhere. That
> would avoid problems where this series uses API-doc comments for
> in-code comments in .c files and where single line comments in header
> files do not use the API-doc syntax.

Yes, this isn't documented in CodingGuidelines (but FWIW is in various
commit messages).

I'm pointing out that this isn't a mistake, but the preferred style for
new API docs.

At least Emacs knows how to highlight these differently, which is the
main use I personally get out of them, I don't know what other use-cases
there are for them...

