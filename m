Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9D0C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 20:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjBBUnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 15:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjBBUnk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 15:43:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F2AA24A
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 12:43:15 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j5so3016883pjn.5
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 12:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdXE2ImqxG63waGBHNih9+J5wJ7B7e9EZJi9670W4ts=;
        b=WFV+gOJn7aojTZMmjLv6LuL7I1+8oENoVJTiWygTh9v3w2IaEzi/EHPGXor7n85vWC
         9n3iRR57kq6Zt0ShyMn/xJVLb0OdVoSLGihEsbJsPXT7EQb+dCRRlZUpZp6J4cA8t7qZ
         s0urjWLD2aG3rM0WCAPl1bsWU+cig0skEOfkiOoqZD/7/eOW9++I4lPsuAobwY4MGNG+
         I585x2R2BcWvbJS1SAwpVE6hOpAClr6upZMMRnl22rxBjoVtkGjNWXGeLUWJ8jMjLlS2
         7+IEkzeu8CsMybr6UwdWduudpldyHRQTbBk9qCZjGZy+eQ/3BpvD8ThRkhCtPM6NoduF
         6UCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdXE2ImqxG63waGBHNih9+J5wJ7B7e9EZJi9670W4ts=;
        b=3Gj6pGQsND91ZfJUmXWBRHsut26bT0Lyr8tLPoz1AzUPjqRrkmcrcLfdOV0Ey+Rtiz
         sGPPfuzxrE947qDN73wwvgpfmoA8ivnFJhcI8xBSBgUPSrNwpb2jKfk0QndFGToqdFLG
         cfhpnxn6DSkjghVdXi1wRzeCNp4kFRbVA/YJcBu4XNPTrXwWk+btFiD0/Ps4Rzhbs02m
         klay76A7z7VQBvqFTKdTyH0ETEzErFqX7rKWpAhBya1pGNlrVl5c7uyd1Q1/87CFztKx
         wtJmUhDFYxYkv1VfDckMJpsSZBE+7Lkqv1aVwzXHEx4byyP/9qZo2zMXD31W7Y3iMenP
         nFkA==
X-Gm-Message-State: AO0yUKU9plo3Ec6vGNa9Hq556G4AIf60gcjdd2W6ib5eqgB5821tQeS9
        3bmms0O1gj+3A4mXZTlJcYo=
X-Google-Smtp-Source: AK7set8uhh0nRpN7a0xVEs9WtV5WKsn8cUYfwiP6uvZPqlvIIwnpgIgsuxxjgFfxwwpesTDnUk8aTQ==
X-Received: by 2002:a17:90b:4d87:b0:22c:169b:ec47 with SMTP id oj7-20020a17090b4d8700b0022c169bec47mr7994168pjb.41.1675370595156;
        Thu, 02 Feb 2023 12:43:15 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090acc0a00b00219186abd7csm301209pju.16.2023.02.02.12.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 12:43:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/6] imap-send: remove old --no-curl codepath
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-5.6-17c75e6381a-20230202T093706Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 12:43:14 -0800
In-Reply-To: <patch-v2-5.6-17c75e6381a-20230202T093706Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 10:44:16
        +0100")
Message-ID: <xmqqbkmbu7bx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> In the preceding the "--curl" codepath was made mandatory, so now we
> won't use the OpenSSL implementation codepaths in imap-send.c except
> for "imap.tunnel".
>
> So let's follow-up and delete the code on that path which was specific
> to the "imap.host" mode.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  imap-send.c | 127 +++++++---------------------------------------------
>  1 file changed, 16 insertions(+), 111 deletions(-)

Nice code reduction.
