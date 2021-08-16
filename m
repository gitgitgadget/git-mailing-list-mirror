Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A6FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1906113A
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhHPJKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbhHPJKS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 05:10:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C77C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:09:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p38so33167018lfa.0
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UBG2T830jfwGPvCAzIZHtbthINiBUXrK1guZoTgYzuI=;
        b=HB2GdqewrDEtgdxv3hcyqsiMHpIpi1HlFA07upK/5obH76599JDR3i/KypXrfPl3xm
         3LIa5k9vYu0yZcU9KwfIOl+2d3K0ewfX4KJp3EdsM2gNvO0YGJ7bGtr4bH5YkkKkfPoP
         BUFUmJ8GSgHlD8JXD06tGjfa/9EdPsZKGFcwq99HQ1KKaqtZNZShr/zH9CYZAVzWew8R
         tqT/4NgOyYpQxngNoiWr+NE4zgUl2KnNr6U3h+tBDwHU1Kuys6JuX2IHoAXE+pya4I9X
         Ek4ZWLGMfII2bP9vcIBLMxIDv6j7/dLY+t4pk/Ez3bizsmzmvThf4eCeKmUzJ+wkO0bD
         dbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=UBG2T830jfwGPvCAzIZHtbthINiBUXrK1guZoTgYzuI=;
        b=jo8TKBE/56gZX853DM8VmYBwDch7d387n6cpKuWuDEuRSFjQHh5p2Ysbh4DrXAq/Kq
         iAoUO8JRcogJVrItuIQD5kjbmA88lIF7hkqqDyg3MPLqve1YyaZntFTD8ey1euH3579x
         l+06Bdqq6QC3mFlOy2UpdqhcDlF3YliqOcrfAbpEuHj8ecpSBIXTsEiaea8OP6JglULr
         FMiNcQQO2oSCPWfHVcJho8Ei3rqIJ/GnUYLd30RDEDap/rp/tjf5+X+GLNARNMakvFRy
         IYvvSSv63F+R5FDlzJk2iznilBsMzrhbKt8aYy+R1d+BsURH/NTI2ttlbhJlIE0WxYzE
         9P0w==
X-Gm-Message-State: AOAM530XKWoziF13AgyVJGA9J/XEM1Qj9GciCKy4wUoz+Qg5MCo5mWO2
        nIdXjGsKseEEZRp84/g/3Fo=
X-Google-Smtp-Source: ABdhPJzrGn9Z9p4EEVymY524dZvKwyC58uw86ZEkAM3p4xIQeqEkp/9iCMLkE2JqxWV7XPUiWXImgg==
X-Received: by 2002:ac2:596b:: with SMTP id h11mr10809004lfp.558.1629104984933;
        Mon, 16 Aug 2021 02:09:44 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b19sm482569lff.121.2021.08.16.02.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:09:44 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>, Taylor Yu <tlyu@mit.edu>
Subject: Re: [PATCH v3 10/10] diff-merges: let "-m" imply "-p"
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com>
Date:   Mon, 16 Aug 2021 12:09:42 +0300
In-Reply-To: <YQtYEftByY8cNMml@google.com> (Jonathan Nieder's message of "Wed,
        4 Aug 2021 20:16:33 -0700")
Message-ID: <87wnolah7t.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Sergey,
>
> Sergey Organov wrote:
>
>> Fix long standing inconsistency between -c/--cc that do imply -p on
>> one side, and -m that did not imply -p on the other side.
>
> As I mentioned before, I quite like this change for interactive use.
>
> But:
>
> [...]
>> It's also worth to be noticed that exact historical semantics of -m is
>> still provided by --diff-merges=separate.
>
> Is that true?  When I try it locally, -m shows no diff by default,
> whereas --diff-merges=separate shows a diff for merges.

You are right, it's not true that --diff-merges=separate behaves exactly
like -m did before this commit.

Actually, I think this notice was meant to be referring to the

"It gets even more useful if one sets "log.diffMerges" configuration
 variable to "first-parent" to force -m produce usual diff with respect
 to first parent only."

part of the message when I wrote it, but it ends up being confusing and
thus wrong, sorry.

Thanks,
-- Sergey Organov
