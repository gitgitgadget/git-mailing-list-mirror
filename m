Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1476FC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D2E22C7B
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgLUFHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgLUFHn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 00:07:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD58C061285
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:07:03 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id x16so11678138ejj.7
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=i+M17SixtwqcX3+NotNCkSy7q+BGFNXpvV4jUxmRBM4=;
        b=ej+JVWGXIsX0ADtjCPl/DaLZtXZIJH7JZH1uqWWgotwVfZXaxBNDVAyBdebFTEAgnp
         cg/BoVnA/3Umu7cRvFhws8mqef0MQzdKoK0CBGYnfHUNbsPUWWkQ5S9dTohhK0rGSm+B
         Q92/St82h0uYGTmLV/DIiUveo8AEFvEoC73xr3gsuIHdafWBqd49zJz85sEn9vGHHfYG
         lBxjV35XxCVi9FKxZipET9qw3dt91FCLtipVHtfTS9FWQL0wdXBKt2IMfDvz0pFha3rB
         DHQBNy+u2D5FtwWYNROQe8PZ8qxm6oMNLod6SA5GPuat1Px/CvJt+YrEtQcEfY+mgxkD
         8Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=i+M17SixtwqcX3+NotNCkSy7q+BGFNXpvV4jUxmRBM4=;
        b=ip2fF8qkhPpDHtrZa027t62tTLtmuEvCiv3M8H9DMTxI6NtyXOonJ8o+A3YF9DTwJ6
         ZobTST6lTtGfJSY9EZ6d1uhcw7JL2zCVrNpvLZQqFt6G/QxYXzNp7mW5fx3KEb6UEgAR
         JrsTOZr/zBYwYfo4nOokXPxN+Dcodi+ycEhSI+wwgEYzqSV6Kt2LJdb4gOp/FPHuOSLg
         NRU7Kb36yyiDGJ3i3Y37IKyzb+LtFLI2iEjolUsCYb4JfDq9ooEBKkqrLOUdXfPPX1Mj
         cvFQ1m08N/uCwDNIQiWMTlLAISI5wWL0Y+5u+PZhUV9eyv6qNTUcrZynnxP3NU/4908Y
         gcAw==
X-Gm-Message-State: AOAM530xsltDxMZ7H88VajU9bunqERPW0wA7POVjFT6PDR2gbeHHGdGZ
        YX9/JLdw3YN6mUnk5TGZi39D7VLa99Y=
X-Google-Smtp-Source: ABdhPJzq9cEU09MaDrALaGKMbMwojT8RNoRrlE3elET1cJbbvJdgZCwkBwobAU0zbmSJbMYor9Mieg==
X-Received: by 2002:a05:6512:1090:: with SMTP id j16mr4927777lfg.641.1608491236262;
        Sun, 20 Dec 2020 11:07:16 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b7sm1884988ljf.76.2020.12.20.11.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 11:07:15 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 26/33] diff-merges: let new options enable diff
 without -p
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-27-sorganov@gmail.com>
        <CABPp-BHu2xLZLfwBg+hzNEKQ0K=EyT1HLqJO9=pNzBFf4MqR=A@mail.gmail.com>
        <87wnxfb2gt.fsf@osv.gnss.ru>
Date:   Sun, 20 Dec 2020 22:07:14 +0300
In-Reply-To: <87wnxfb2gt.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        18 Dec 2020 17:42:10 +0300")
Message-ID: <87k0tcthy5.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>>>

[...]

>>
>>>         else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
>>>                 set_first_parent(revs);
>>>         else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate"))
>>> @@ -64,6 +67,7 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
>>>                 set_dense_combined(revs);
>>>         else
>>>                 die(_("unknown value for --diff-merges: %s"), optarg);
>>> +       revs->merges_need_diff = 1;
>>
>> I'd put this above the if-else-else block, to make it clearer why you
>> are returning early for the "off"/"none" case.
>
> Yeah, makes sense, thanks!

In fact this can't be done as it changes the outcome, as set_xxx()
functions clear the flag.

I rather added clarification comments to the code.

Thanks,
-- Sergey
