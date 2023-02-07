Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5C3C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 21:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBGV0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 16:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjBGV0U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 16:26:20 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AA8E3BE
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 13:26:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id mi9so16338262pjb.4
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 13:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68LiSwFKXTV1P7SV5YBTOKBFr/v7CTlA7fAU1BHDd3c=;
        b=YIX5J+J7WPn9UhXXb2hEbYzAi/S2Y1ZSs4sJicgg4E/t5r/UlyiGD2hHu4Ml0Fk/oz
         wvLQZdrPnDI+F5ZlQvA3AVxaFb/PT0g8ON5Ru9W21ABru0QpLvM6zWSmxDqx7E1SOQ+D
         7179B/qyjaJrzvBfR6L+Rqe2PxXo4+TumtFZi6O37hW1vds4b1jO22Hd8NFmIiJmqWXO
         bYMNhcIaHgFsxLInsywFvdwoovMg7NEmDU5CedvvVk3JjMjvwexCFmZhF64Hyd6QRJwy
         CKJ7A1Iz2Ivuf/dmRgf5ZGYVAMpMwMSLh5fE20JR5FTyC6TycYhguibnSm5vJG/mod5D
         dKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68LiSwFKXTV1P7SV5YBTOKBFr/v7CTlA7fAU1BHDd3c=;
        b=T281T/usHCotW4YEk3x56eIg8rcgu9mXBYNR0fb/PKNUnMoNPbE0jISMhlkCXpPER+
         fYMkhh8d9KIi0epeO6twbpp6ieHywZ40l64HPKddj4c/5LfXvqAzn42GtCTZDbNaUTaa
         yhzuwbaDdz8Eg43K236AZ45FU7GCCEhK/rKyrqiX66XsUQbAp5J1Wve9BhLoWaI7OynD
         AVZnh9jyl3BE2tmkzKlH+t5OVS8XdTEFTAGm+/EE2xDJ78dDITahnCjSsRtXjGvbdy3l
         wWqTIKVD9I2PQq+goFq3sNB8mdAgCfRCTPiDF/S/bmaJ2Cn0S5fO2MDfzDaAdpCkCouS
         M4xA==
X-Gm-Message-State: AO0yUKVtNwaKbvi1jlJEGJpwlNDyX++I8eimDq2iZZiTaEsAQvXYBj2F
        gd1w+Fm59/NeWggkEdZcG0A=
X-Google-Smtp-Source: AK7set9edVALXUsipnpjsKUS4ddXjd/XDx0wJmUPTG5XCSwE7aTRHKCQudmR2fz8VbRK6tM2CZNzXA==
X-Received: by 2002:a05:6a20:6906:b0:be:22c5:92df with SMTP id q6-20020a056a20690600b000be22c592dfmr5545646pzj.16.1675805171673;
        Tue, 07 Feb 2023 13:26:11 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b004fb26a80875sm313627pgg.22.2023.02.07.13.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:26:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
        <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
        <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
        <Y94866yd3adoC1o9@coredump.intra.peff.net>
        <230205.86ilgf7osb.gmgdl@evledraar.gmail.com>
        <Y+KYwsBjty0aaLes@coredump.intra.peff.net>
        <230207.86fsbh2nqo.gmgdl@evledraar.gmail.com>
Date:   Tue, 07 Feb 2023 13:26:10 -0800
In-Reply-To: <230207.86fsbh2nqo.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 07 Feb 2023 21:39:48 +0100")
Message-ID: <xmqq8rh9yxot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I think you might be right that people might rely on this after having
> discovered this undocumented interaction by accident.
>
> But I also think that the lack of questions about how to get imap-send's
> tunnel mode to work with auth helpers (at least I couldn't find any
> on-list), which is what you'd run into if you went by the documentation
> & were trying to get htat ot work, is a pretty good sign that this may
> be either entirely unused by anyone, or at best very obscure.

I actually think the misconfiguration (from documentation's point of
view) Peff is taking advantage of is a behaviour you would naturally
expect, if you do not read the documentation but are merely aware of
the presence of .host and .tunnel and guess what these do.  And
those who felt it was a natural design would probably not have asked
any question about it.  Documenting the current behaviour better
would not hurt.  Updating the behaviour and documenting the new
behaviour would not help anybody.


