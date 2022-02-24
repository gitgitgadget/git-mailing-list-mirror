Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BD2C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 14:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiBXOxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiBXOxp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 09:53:45 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CEF17DBAC
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:53:15 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a1so3932507qvl.6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=0tctd2xeR3EBx/7aYDzM42fSdY/TMq2DM1Wk5k5vK/E=;
        b=JS3DteUqTYsrx6dTHgyz1q1zzTeg0R45zER+CtQBbd31105ZF3NWiABgYfFy9oj078
         cB9di8Jv6/DZq6AAyzHN1DhEUn0BrAUiYT+wbeByXc+NH5d3ntpyMTfQwpLQKNZF7uSn
         ylGxWvEboW8vIYijviEOzy7SAh/Nd/ANK6HY4Rgaf5FZHy5MF6gLMK3tM6z22T46/uc/
         qPZCC4icDr809+Y2xqKKBGI+CyAogaX+eYCKxN3Xld4Gn7blpzl5r0BQkKAURn4shKJh
         mKKDEbmC6+3xZkibtY3xwwp6qnCBEfJdH9b9HPztwcgu9RHOI+1g9k/fJwra8Ut2q8vQ
         Qu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=0tctd2xeR3EBx/7aYDzM42fSdY/TMq2DM1Wk5k5vK/E=;
        b=gD1nif2W+tIBw3iAtrfORu4gYHsJjOSnvU3vYekg4EuGD023eDT0dPKFxzRloWAgxx
         FccSRAXiiGTNl5aEQOeCpfAh08ehatu982ZQY7zZYZqdzsDQXGvYaA1+ULYwfPuFtmQ1
         I4vhQF92STa2yXo23haUEBXJSTiFPJMyGkB75huYsFUoxhTfz/4vhzMf5ip6mULe1AnP
         ZLnZJe4JxjAO9hpwtNipl7B/s1qgsMWK9Qf9L8Y6mzxd3DKqjsbdZzIMFb302Q45b8Y4
         SD4RbLjUZn7hpr/zYdpX0Ll1dkngp9qwQDsl6rtJfEog0Oq2Mi8wbmsz60NegF4OiZPw
         VUIA==
X-Gm-Message-State: AOAM5310inHILQdZEiUnmpMNzFP62tubjfJybhfXhmKC95ycfce/GAdS
        T5SJX4AqcHoemY3RtaZfXsQ=
X-Google-Smtp-Source: ABdhPJx6ZUd5jZoWLGWq36QV8gXpEqOiiEePt/y6+EvJol+vvNv+9q6YaiOI38XGBL5x9a8//qQ62Q==
X-Received: by 2002:a05:622a:d1:b0:2d2:dc49:842 with SMTP id p17-20020a05622a00d100b002d2dc490842mr2664303qtw.89.1645714394325;
        Thu, 24 Feb 2022 06:53:14 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id a6sm1757162qta.91.2022.02.24.06.53.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:53:13 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite --updatref behavior
Date:   Thu, 24 Feb 2022 09:53:13 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <9AC71167-BED8-4003-A5B2-072B7913FA62@gmail.com>
In-Reply-To: <xmqqczjdp2g8.fsf@gitster.g>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
 <220223.864k4q6jpr.gmgdl@evledraar.gmail.com> <xmqqbkyxqjrq.fsf@gitster.g>
 <272D2409-1CAE-4203-96F7-9B104F7E5D4D@gmail.com> <xmqqczjdp2g8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 23 Feb 2022, at 18:50, Junio C Hamano wrote:

> John Cai <johncai86@gmail.com> writes:
>
>> Yes, this is true but that doesn't seem to test the --rewrite functionality.
>> I could be missing something, but it seems that the reflog --rewrite option
>> will write the LHS old oid value in the .git/logs/refs/stash file. When
>> --rewrite isn't used, the reflog delete still does the right thing to the
>> RHS entry.
>>
>> I couldn't find any way to check this LFS value other than reaching into the
>> actual file. If there is a way that would be preferable.
>
> Ah, that one.
>
> As 2b81fab2 (git-reflog: add option --rewrite to update reflog
> entries while expiring, 2008-02-22) says, the redundant half of the
> reflog entry only matters to "certain sanity checks" and would not
> be even visible to normal ref API users.  I wonder why we need to
> even say "--rewrite" in the first place.  Perhaps we should
> implicitly set it always and eventually deprecate that option.

Yeah, that makes sense. I had this thought as I was figuring out
how to test this. I can take care of this in a separate patch series
