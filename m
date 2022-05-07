Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA5C433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 21:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387505AbiEGV0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 17:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiEGV0n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 17:26:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FED82606
        for <git@vger.kernel.org>; Sat,  7 May 2022 14:22:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d6so12215329ede.8
        for <git@vger.kernel.org>; Sat, 07 May 2022 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PjZ9bZ00KDR1ynYzHZA8Uhi/BN54/ex4yJLm1vKgHCQ=;
        b=n6/DBuK9IqfTIrHAstW18srpR0INnv66KzhKIxq/mZtLUby62Jcp52klZv/AOiNbgw
         uedkCeu55gB/SmsZrjKjRAd7erB/6Ll7UELK+pu/eKAKCDwZE+VBGW87cg/C4oMt5efX
         DOKCLuv29RIbw5dgwr567x9/SlXhEljfmBZj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PjZ9bZ00KDR1ynYzHZA8Uhi/BN54/ex4yJLm1vKgHCQ=;
        b=CP61Hg5yRSFYTpFB8BrgrrxdFeZc4RA/hzvNMIby/BhAa1+8FDYItcdf92lcgmTWwB
         2qvZ7ESq6vAk4k3rE0s72tsXAuZQr+LYHtMuli69KXaXthIdGkWoJImO+PoB4l5B4mnD
         v/wYsSLmAxkOWV8OQuGTkp5nUzbwk87teGiJjwpev5LjSmRbk2dB7zFucvzhbCGiOy+i
         X67/6VT1gxSaBo/L34sBlbzefSo7zqMUhPr66ZR5jSiBEKntkXsPjIC29WH1yHFQSN/I
         G+0nrzeYdJydYw5PgaXNTB1KDcI3nCNYv7ddQ734izN8fiSIuBlRrnyIhOlWqrMA6f2u
         OEYA==
X-Gm-Message-State: AOAM531LGm8DKm8t3EW7dUcoD8umja1Qb7P5gFIf7FFaKkU52B/bpVst
        a0J7iJyvKUbxvv1Vw6wn5iFc7aSU9Z2VEA==
X-Google-Smtp-Source: ABdhPJyTGJwV4DDZYpRCTsoOeingTOLvIpmmQGgzfNZLoN046DTJ63qzsiR+ktUXoyHJnhjpYQYRkQ==
X-Received: by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id b10-20020a056402084a00b00423fe998c53mr9968146edz.195.1651958573760;
        Sat, 07 May 2022 14:22:53 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:8c3])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090628c400b006f3ef214e07sm3336430ejd.109.2022.05.07.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 14:22:53 -0700 (PDT)
Date:   Sat, 7 May 2022 22:22:52 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] bisect: status improvements when bisect is not
 fully fleshed out
Message-ID: <YnbjLFJBp70eCngT@chrisdown.name>
References: <cover.1651796862.git.chris@chrisdown.name>
 <YnZQvuyeu/WZLhXH@chrisdown.name>
 <xmqqk0axgpxl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqk0axgpxl.fsf@gitster.g>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:
>Chris Down <chris@chrisdown.name> writes:
>
>> Thanks Junio and Taylor for reviewing. I have the following action
>> items for v3:
>>
>> # [1/3] bisect: lowercase "Bisect:" to "bisect:" prior to wider use
>>
>> - New patch
>
>My preference actually were to leave this change out of the topic.
>That is, instead of using "status:" in newer messages, have them use
>the same "Bisecting:", so that all the "where we are in the bisect
>session?" messages from the command use that same prefix.

Sure, that also works.

>I also wonder if the existing "Bisecting:" messages should also be
>sent as comment to the log file, using the same bisect_log_printf()
>helper (with the v2 patches, they are still using printf() and sent
>only to the standard output).
>
>But this, just like "status:" -> "Bisecting:" -> "bisecting:" you
>reacted to, is just "I wonder...", and is not a suggestion to make
>changes as part of this series.  Something to think about for a
>possible follow-up after we complete this topic.
>
>But I do not mind if you want to go the extra mile to do all of the
>above as part of the series.  It would make the series to require
>more reviews, which is why I generally recommend against extending
>the scope of the (initial) topic too much and instead leave as much
>additional changes to follow-up series after the initial series is
>done.

Sounds good then, I'll send another one after this goes in :-)

Thanks!
