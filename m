Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E674C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 05:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBHFTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 00:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHFTg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 00:19:36 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440E029E17
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 21:19:35 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso1134734pjt.4
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 21:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z+FnOJJx6e/sxl0gHcRaaNUO9xaw3hbDhv7hZa5lpA=;
        b=KZsLzl/4VIso3usi8J4hB43SoLKHk8/PTejdI3p3oochSCLyKKVcMNcLkoRq2oLUW5
         F2c7xeV9AXHAp5LtNFAQEvahAdG6j37CWGD2c4TtV7OVrpBXreva8ziGW1cUUNKvb8Ny
         gvsafFJPLYdEp7AhhmrnJUYccPJbyhrvw9c0G33kR0NOUk4sa8+xawq+WZ0Yh2gRQ9u8
         TMFLzp1ZrPk4HGKFkoijQRPsRBWYsYQ2yTgiwzJUZIfxLXgaG7u1pb4t0wnFTyiEecz6
         lxVYJjIvwh3SROA3K+RXJxE50VVGoiXKRlNkHqf2WMpkpRyodc637YSV6SzvJmlTt1eE
         DE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z+FnOJJx6e/sxl0gHcRaaNUO9xaw3hbDhv7hZa5lpA=;
        b=7t1WiVE3wL8CDnXwH7q6u0rfdeEu5YPzerQWZKI31F1XqTTq47QGWTUcX1YP4VexZA
         J4R8iNsWikf83NSmcSYjLIrk26MY6P4HmHXcyRyui5RbxsxjoUPYX64uUkNzHQh+xgkY
         2JByAziUyD5Dt9BJ5f1PVocuilv8x3rbdWzVoRbFdSSa227c9tWeBQbfEhFwGDwWAfBO
         PjqNwSVgkFF5hWbUXlgLBYdRTgPPlttHJV21htEEN9rleWOyd6LFGNJY1KriDvxfI1c8
         YFK9v+fAU6JAvDkN8KivJrxshELKNTb4Tz0Or2UFiytOP2CdlG9vUi4M0g/UmQjrgOI+
         j8Lw==
X-Gm-Message-State: AO0yUKUkPkvLMXtVwcdvD3g3isTPuyUmaWwvO0wPwrFZC7IhWv2RHJiM
        yLLbjCNDPxaOyrknATkCicgXtOKdmNY=
X-Google-Smtp-Source: AK7set904wg5PlTMpn8O/OIWtPy7NUzeEHvd9ZIL64lmGwZWGuKIgv5smLEYHZtW2XQl1NX7rweOgw==
X-Received: by 2002:a17:902:c612:b0:196:3f29:779f with SMTP id r18-20020a170902c61200b001963f29779fmr4264563plr.6.1675833574518;
        Tue, 07 Feb 2023 21:19:34 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902d5cd00b00196025a34b9sm2333679plh.159.2023.02.07.21.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 21:19:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] rebase: refuse to switch to a branch already
 checked out elsewhere (test)
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
        <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
        <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
        <5b0d5b6e-5055-6323-1b6c-fe98137e81f6@gmail.com>
        <230206.86wn4u6859.gmgdl@evledraar.gmail.com>
        <4580b825-b117-4581-4ea2-ab30e350b6ad@gmail.com>
        <f4be3c97-eb15-790e-9746-96d0c9bbc5a7@dunelm.org.uk>
        <19e3e0d9-406e-ac2f-c43a-b4e994035529@gmail.com>
Date:   Tue, 07 Feb 2023 21:19:33 -0800
In-Reply-To: <19e3e0d9-406e-ac2f-c43a-b4e994035529@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Wed, 8 Feb 2023 01:43:45 +0100")
Message-ID: <xmqqk00svimy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> ...  If the tests fail, I think it will be easier and
> less confusing to reach the original commit where the implementation was
> done if we keep them separated, rather than combining all three commits.

No, if the test were in the same commit as the implementation, then
upon a future test breakage it is easier to see what code the test
was meant to protect, exactly because it is part of the same commit.

> I'm going to reorder the commits and change to use test_expect_failure().

Do not do that.  Adding a failing test and flipping the
expect_failure to expect_success is a sure way to make the series
harder to review.

