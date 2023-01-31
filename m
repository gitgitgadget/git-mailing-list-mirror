Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32B6C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 16:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjAaQ5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjAaQ5V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 11:57:21 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158FC13DF0
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 08:57:21 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z1so7664191pfg.12
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 08:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSL9VG9rDCEEIgwqnVApP7B9HIthHbwcfHSG7MerRfI=;
        b=N2nQZqdmTaWbWTn8nA/c5DM9jAAABlWtNlxquu/3ngZJ8am0dmcK4lUaRbNVPxG+zu
         g/4C76uFY4P3nB3RUKtKMnI+5/hZaRTo+zWn5/RhxQVKDckdaK6BTt3MdkdkwTD+0FqK
         6f3GBJLT4jjKa3cAvamtrGiUxY0WrqV4RJN1tG9bzMq3nM2bCgqnRpa7fxqmYQeUKROh
         R8B8x3A0HcSSOJL8kq1+dpDL9knw6vVrcP5ltze1E2iuie0N991w5ugCTY2Fs1LkITxq
         J2kMcMwxjj83xEqhRK0bcqyFnhaHFctX2Z+vyFlthGGGCOYew/J6TYkOqu2EtiMBygCi
         Lymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hSL9VG9rDCEEIgwqnVApP7B9HIthHbwcfHSG7MerRfI=;
        b=yxSxQIT8xeEE25PRAnYpZQMnyTDF3yVxZZ+1rz6sGz/62Zd+gJLcCFHdEB8Oe2ED+N
         W+dbmd6ZieBnLWMNZhdAA19Xpq03XtOEgZqzp2TWSwmpGSYiWsa91bUi+XQU/SnLO6up
         P9fROfXKH4TbBwD0uKAEHa6fKJiO/8COsiCVg5XULuJWgAruNoAoqohet0k6zALvq6Zl
         Sn1Q47jhR1NS0S6CwnCWDR3NeIRIFN3jNhM+VdrhiuAJpeGAFBgklKZmWVFZiLWGVGOQ
         s/+/AGBZwnbHIirc2V7XutP2WprOeYWbu3VToJ7ISXMFoS75RrSNO6mB8y7y+ye8muPs
         hkSw==
X-Gm-Message-State: AO0yUKVyOt0uI6Kj5n7rNzu/6EdmfTphn0/j8x8mQxKBEMNSTHXmejhD
        CI2RalcjEnx/ePzNlZhhptc=
X-Google-Smtp-Source: AK7set8tNQKb6By+JZRh2rlURBQfepcK6J8mb0JZbFt/eQ2SYQ09oyZ9OtsqGVRwMdUf+CBfmRqtdA==
X-Received: by 2002:aa7:8493:0:b0:593:b538:760a with SMTP id u19-20020aa78493000000b00593b538760amr8296725pfn.5.1675184240415;
        Tue, 31 Jan 2023 08:57:20 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id m9-20020a62f209000000b00592eb6f239fsm7984555pfh.40.2023.01.31.08.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 08:57:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Florian Bezdeka <florian.bezdeka@siemens.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "greg.pflaum@pnp-hcl.com" <greg.pflaum@pnp-hcl.com>,
        "peff@peff.net" <peff@peff.net>
Subject: Re: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
References: <4831bbeb0ec29ec84f92e0badfc0d628ecc6921d.camel@siemens.com>
        <Y9j1RxKhNq2TnL4U@tapette.crustytoothpaste.net>
        <339359ee8a228ea108109cf852bcb7e145807dcf.camel@siemens.com>
Date:   Tue, 31 Jan 2023 08:57:19 -0800
In-Reply-To: <339359ee8a228ea108109cf852bcb7e145807dcf.camel@siemens.com>
        (Florian Bezdeka's message of "Tue, 31 Jan 2023 13:08:40 +0100")
Message-ID: <xmqqilgmzlow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> I guess proxy support was forgotten when the referenced change was
> made. Any chance we can avoid closing stdout when running "in proxy
> mode" to restore backward compatibility?

See the last paragraph of
https://lore.kernel.org/git/YS1Bni+QuZBOgkUI@coredump.intra.peff.net/

Nobody brought anything new to the table since then (the original
discussion was from Aug 2021) to change the conclusion that socat
was not doing the right thing in its default form.

Thanks.

