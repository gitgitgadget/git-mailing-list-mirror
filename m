Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B400C77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 17:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbjDZRZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 13:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjDZRZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 13:25:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87DC6A60
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:25:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b50a02bffso6093231b3a.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682529894; x=1685121894;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+7j2QEjsV53u7cJNcIQy2wsifOCFBRLNZNWVDyJ6vs=;
        b=cRLQhDfKyIsAwdabgtGPM04h/c+uvkd2epsjLoDQknka+ejnI0Q0tBtIUyFxFHTNaJ
         79El8pwCbU0LI/mDjaABiAqGLno+BvkhE8Q5LMdvWJI66dgonKaoxx7DrDL0YqLZwD6W
         wER1NkG009bRoCDzopa2zON27c4D3dYNFtf9kfi4ePH13VVrCS91wsVeoGra0VxR9jNU
         Z1t86Ismsqbfl5NJZF2QYpcRvcxwDCRnhXokZow8D03BKOnx8ItVDRkxQfQk+15FgoAT
         1/x0/ov2t+zbT8OQ8OHH7ZiWzMmsncuLMlcQxYVnLgLO/iPOJNSWHGpqFx6+i1AfqMM5
         lZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682529894; x=1685121894;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7+7j2QEjsV53u7cJNcIQy2wsifOCFBRLNZNWVDyJ6vs=;
        b=Y2+YK1eD6QqDHvNYeyVE5cyApfFU9YxlHjb46Q3hRCIXxeggIyemWL952bkf9I3bh6
         vz0AOspw11nLlarkWPsddoIXN1IM1ekl/hUp6IxzA+lRW/v0tWIVpoXJIuiW67v5lqet
         OSzU1t22M6tPfYf97is46BGgMBWZ0lAR3xIl5QI14exclb+zwfBs35I2cjGS8+sB3PS1
         S40qvlsLG9b/5K4rLHV2g0LI6r5sdLcp8E6aBScw1EHhkIH0K31dIeLwuzqgyo8I/DFB
         c4tVc4aoWz89IXXrpFa/0C5EjIkZo4bwTPJFVMH0AxNuq+r4SDjacrJqLj5MydH5U6AM
         1igA==
X-Gm-Message-State: AAQBX9dx+R4ydjcad7UhSBHGw9zZ0ean6KXt6hNN3hxxqZ1RJ2KMP/m7
        xeHFWDRqWSSDl2bKKoBC648=
X-Google-Smtp-Source: AKy350ZdGS37uLnz7w1tNUYsQX+KpQyPU5jMlMqDT1VI4PUq1uITGYaRmx6FcX5zIxzFvQ+1iWIbXA==
X-Received: by 2002:a05:6a00:21d0:b0:62a:4503:53b8 with SMTP id t16-20020a056a0021d000b0062a450353b8mr28704497pfj.1.1682529893841;
        Wed, 26 Apr 2023 10:24:53 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id p8-20020a62ab08000000b0062e0010c6c1sm11496593pff.164.2023.04.26.10.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 10:24:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t/lib-rebase: (mostly) cosmetic improvements to
 set_fake_editor()
References: <20230323162234.995450-1-oswald.buddenhagen@gmx.de>
        <ZElHNTiFCblfIDEe@ugly>
Date:   Wed, 26 Apr 2023 10:24:53 -0700
In-Reply-To: <ZElHNTiFCblfIDEe@ugly> (Oswald Buddenhagen's message of "Wed, 26
        Apr 2023 17:45:57 +0200")
Message-ID: <xmqq7ctytv2y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> ping!
>
> (also on three other unanswered patches from the same day.)

I would be a wrong person to ping.  

    $ git shortlog -n -s --since=18.months --no-merges master -- t/lib-rebase.sh
         2	Phillip Wood
         1	Derrick Stolee

Running "git blame" on the lines the patch touched may give you
folks who may know better than these two but those who made
contributions long time ago whose contributions still survive to
this day may no longer be around in the project, so your mileage may
vary.  

"git blame" for the line that uses "action=\&" finds 5dcdd740
(t/lib-rebase: prepare for testing `git rebase --rebase-merges`,
2019-07-31) and explains why "pick" was changed to "\&", so adding
the author of that patch to the list of people you ask reviews for
may also be a good idea.

HTH for you to find appropriate reviewers better next time.

Thanks.
