Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F4EC77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 19:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjDYTJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 15:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjDYTJb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 15:09:31 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E58146C8
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 12:09:25 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-74e1745356dso305636385a.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682449764; x=1685041764;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NdliijG1gj8AKiY5FHQeQM3o9vaRtcO0YTpbd3RGQhM=;
        b=kskaQjv0/Dx8jTKeO/aAr0DhDvmN2lxTfDjkb4Je0dAG1bCb8KM2tK69zPO9xIM9x2
         l2GF759KQ6Ny9tTXkOqna9jyzjv80CFdLl9t9qMuNYgztxvelxz21SQFth6pgbCThoZN
         PIRM1Lg5bq42wVHdzmSfDChEzYo9y/Pu9UU9NvX7VMxtT5EnNHPoraEEOxfjeewUYGcW
         t0yYKGM0jIiAvb8avbhq6owAsYcDc9JWrJKdjZf0Jzi/D7wUcGGgUZGNGIBU6ADC7qRp
         4AogvqbZoZ0zHmRX66YMc8D+TKx3GOhNTUYpTrdbSFGukcTnoz5MBR7Z2QkqozBNbSaT
         /7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449764; x=1685041764;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdliijG1gj8AKiY5FHQeQM3o9vaRtcO0YTpbd3RGQhM=;
        b=h1gdrhq+3wtMuIKtcKKHaciReITcv378PUtxfqxqaGeONFfZi3XaN09NTF1/W2RJjQ
         M4U0sYe8BQm6qCdFgq11BMO0mUrT9NZfbApvD9VwnYgaTPDcWyiBQdLjMjzasbdwivo0
         c+QhZl+brZhHe4Mv5bvEVu8e0eLW+llgdo/Ed7c6sENhaapAZszz15IsCS+0E5uSqdck
         l8AlFJ0Z84fRgYb8br4j9kKDGIqK7P6ZpQZMhSBZYGDcZmspdivvryRCWhfD1jAAhKjy
         dhBQxytpdOkvT1Ki/oiTCvCAYxeFvnC2M18WwuAHPlkP6we1sVsQVUBW9ydz32gULDkt
         l4Fg==
X-Gm-Message-State: AAQBX9eZewy8iojKEPuIWIWj3nFCSZiegzWEkT9zSKuCI9abO70/VeOj
        Y8iJQ1p+PxfF/6AyI0MUviY=
X-Google-Smtp-Source: AKy350ak3F8wjd+6XdITZUaB1YEhFgCKAjqxqIvIHLH/3ElVIDR5rUoeIfvLVXlVoLAFnwpgW0BMiA==
X-Received: by 2002:a05:622a:490:b0:3b6:2c3b:8c00 with SMTP id p16-20020a05622a049000b003b62c3b8c00mr27916951qtx.66.1682449764534;
        Tue, 25 Apr 2023 12:09:24 -0700 (PDT)
Received: from hurd ([2607:fad8:4:3::1003])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a081000b007441b675e81sm4561477qks.22.2023.04.25.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 12:09:24 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/2] send-email: extract execute_cmd from recipients_cmd
References: <xmqqh6t57x0y.fsf@gitster.g>
        <20230425162631.13684-1-maxim.cournoyer@gmail.com>
        <20230425162631.13684-2-maxim.cournoyer@gmail.com>
        <CAPig+cQ+6m35cTXr20-BNyHRsQQq2nTNERCH8N9NMsUP8Ct7mA@mail.gmail.com>
Date:   Tue, 25 Apr 2023 15:09:22 -0400
In-Reply-To: <CAPig+cQ+6m35cTXr20-BNyHRsQQq2nTNERCH8N9NMsUP8Ct7mA@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 25 Apr 2023 13:04:50 -0400")
Message-ID: <87h6t3pyn1.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Apr 25, 2023 at 12:46=E2=80=AFPM Maxim Cournoyer
> <maxim.cournoyer@gmail.com> wrote:
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> @@ -2,6 +2,7 @@
>>  # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
>>  # Copyright 2005 Ryan Anderson <ryan@michonline.com>
>> +# Copyright 2023 Maxim Cournoyer <maxim.cournoyer@gmail.com>
>
> Let's avoid this change, please. Many people have worked on this file
> over the years -- often making changes far more substantial than those
> made by this patch series -- who have not staked such a claim.

I don't mind to drop this hunk if it's unwelcome/not current practice.
I didn't mean to try to steal anyone's spotlight :-).  I know this
contribution is tiny; I barely write Perl (it's still enough of a change
to be protected by copyright though, but I don't mind too much).

Cheers,

--=20
Maxim
