Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02C4C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 21:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLFVJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 16:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLFVJL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 16:09:11 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068232BAB
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 13:09:09 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id t17so9463211eju.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 13:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKwLoYgfxQWkNR6ZaLTRsX6NtB8fbSGO0a+AsikCUJY=;
        b=cVJIEHLVc/67m92Fg8W4Oxs/ihWCzAILU+HSyYVUgWOs1qAt/MwjyAMsyjx4JzAaji
         gaxLbPmHb7vuHrjDX43PQoge0HLUTvipiz9l2wgD8D2YieeXnzczgmdJ9xPTzux+W/QY
         Ad8jdwJlcTNGIPFaJkOfiMJJAhQxOZrt2nT9Afi4YhdzSRA+HzTLB/qgLGy06qUK73kL
         BOPS705cOHmrcffYgnpBTg2q0rbZpvx+lwVbUenaHicMqU+kr1FWoM/kLNPlrC4PLmIZ
         H4toID5NffL028hR4JGs/P4uNw0JB+ARCA/u7FLNexgp2GHhxYWh+dXaLXEFEzNdo15d
         DgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKwLoYgfxQWkNR6ZaLTRsX6NtB8fbSGO0a+AsikCUJY=;
        b=pJp+fwJfLNPDsOnf7GRSt5khbMkPzOtxrVdJFmOCSEI/lwYAyb5vVJ8FvruF1299xT
         JpiDtqOCyo9azkHC7Hm4eVhJHcTDjrYtXjXN2BL5UzZfebsxDm2XjTcvNMxNZN0xZOmt
         Ci0VUOfA57ujStjzrpnJSdI6Eqy4W5AzhGGuX71RLi+XgsNZNEXa5jLYBvK+MG50GWjs
         mSyNCob5HMksTilgP7VGQ7qKlWjnwEgM7HSoB1+aZZ+iwL850SOZNiOCXMkvlIlcyKz7
         gp+Lcm0j6sP8BdStkuzMD6Oy2ovVzMRskkK5/pUDPHniZHZsIr531bYXJRdqQ4DWYRp2
         6VNg==
X-Gm-Message-State: ANoB5pkJm02hdH1vDkX+U7tBptVR6mC98Xac0eCkUr75N+0bA+Vn3DZK
        EDCOdkNv7pMw5YN42eA9OEc=
X-Google-Smtp-Source: AA0mqf6TlQ+KeIOSy3Dcn7ZQVN4u3VutpVyf/16nbOzz5HCNZQOb9A6HLuqg0ej9Wm+eoPaloSLUNg==
X-Received: by 2002:a17:906:fa98:b0:7c0:a8ff:3380 with SMTP id lt24-20020a170906fa9800b007c0a8ff3380mr22417624ejb.92.1670360948408;
        Tue, 06 Dec 2022 13:09:08 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906a10100b0078d3f96d293sm1036758ejy.30.2022.12.06.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:09:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2fBb-0046oH-1n;
        Tue, 06 Dec 2022 22:09:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] CI: migrate away from deprecated "set-output" syntax
Date:   Tue, 06 Dec 2022 22:08:36 +0100
References: <patch-1.1-deb65805345-20221206T195811Z-avarab@gmail.com>
 <3859f3a7-ade8-4778-be15-b393694435e3@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <3859f3a7-ade8-4778-be15-b393694435e3@github.com>
Message-ID: <221206.86fsdsb5os.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> [...]
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>=20
>> Along with my just-sent
>> https://lore.kernel.org/git/patch-1.1-4c1dcc89e7a-20221206T195552Z-avara=
b@gmail.com/
>> and Junio's https://lore.kernel.org/git/xmqq1qpd9bys.fsf@gitster.g/
>> this should make our CI warning free.
>>=20
>>  .github/workflows/main.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Should this also be updated for 'l10n.yml'? There are two usages of
> '::set-output' there as well.

Yes, I just missed that one. I'll fix that, but will wait a bit to see
if there's any other comments first. Thanks!
