Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC0CC433E1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272CE2250E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecWhOFl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgHER6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgHERzl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:55:41 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4D4C061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:55:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v15so20194380lfg.6
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IQXfEkScQe/hH7jg1HbjgZ1TqZrWsygEvI0vXfubQew=;
        b=ecWhOFl4OsqUSvtT+YLVGHLuJZVC8dpQ0Fy522S8YV+zyj6HD4PN7cWqkImXjaXazW
         BA0pJzH9udRKCXDAMmRoKHeXPQffWpoGUNUc6saD8Zt7Xm16wtEbwqVwYytMo0ZRNISW
         WTdA0dYZVyPtzP0tUAkVxtRZTVbq4pb3hxok19Wt4CgqFKrCVE+RARXD1sxh6dbi2X50
         V2So4aoCbeU9Ue57TnvKl4VeLwkRNQuc4PMjolpx6fix/Euxr2m+hazuf5JwmjPSi/Dg
         BRiLEud5lDNcx7y5bkqP706tCnIHw5FzCh+yObvWzAyxT/sPlEHGoGKeh8wasibbMlIm
         BnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=IQXfEkScQe/hH7jg1HbjgZ1TqZrWsygEvI0vXfubQew=;
        b=ZEaLdkoAvF8whNCRp/d2TSMSRwxqKhIQFi/r8EYJkkPI+roTq9SSGxW7COQRBoS1z3
         brUCYwfYLa6xannVL3FVU+8zFAM1eepfixK/W/z4XPLqy/ZQ3mDvAUoEHLYj+m166jCw
         4hN+Gzb+Bn9GHBqk5R9nJank3zPe4Tx6SMnw3zbLPonJrcu+lsGpXLswhdiozhi3e7KD
         vOGMHY1ve8QJ1ffQnX4s7RqnyFvXqn1KQ4wjrdCQftXHQy1rl/1+Qy2sHMB5C42gtcDq
         ufN3eh6dAwXUM1O2eqxWVOMpMF50AChHmMbghMWfo+zdDgtzbtaTYgF1ldZ2DbWPLBNi
         dyZg==
X-Gm-Message-State: AOAM5317sdEBLgXHuXIKJaC8BJHsYM/ZStZMPH8mlSio/drXsE7BTk2g
        P0rCRNm6Ru3DwHh0SbeZ6Ng=
X-Google-Smtp-Source: ABdhPJxVvldTFtivYeWQ6wEK6rAKSXkrJcrMFEr/2lzzwuFzuEJvkRBgIDoLvWCeUvErUvalqetShQ==
X-Received: by 2002:ac2:5338:: with SMTP id f24mr2134432lfh.5.1596650119649;
        Wed, 05 Aug 2020 10:55:19 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p1sm1179842lji.93.2020.08.05.10.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:55:18 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
        <87k0ydp0hc.fsf@osv.gnss.ru> <xmqqeeoloz74.fsf@gitster.c.googlers.com>
Date:   Wed, 05 Aug 2020 20:55:17 +0300
In-Reply-To: <xmqqeeoloz74.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 05 Aug 2020 09:05:35 -0700")
Message-ID: <87d045nfju.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>> ...
>> In this case your original test:
>>
>> git log --no-diff-merges -p --first-parent [--diff-merges=1: implied] master
>>
>> would fail, as implied --diff-merges=1 then wins.
>
> IMHO, I think this is an absolutely wrong thing to do.  At least to
> me (and I suspect it would be to many users), what "--first-parent
> implies 'when showing a diff, compare only with the first parent'"
> means is that it should do so unless told to do otherwise.
>
>     git log --no-diff-merges -p --first-parent
>
> explicitly tells the command that the user does not want to see
> patches for merge commits.  I do not see any reason why
> "--first-parent", which merely *implies* a specific diff generation
> preference for merges, countermand it.  IOW the implication is
> conditional.
>
> It is like saying
>
>     git log --first-parent
>
> should show patches because it *implies* comparing only with the
> first parent, but you can see why it is wrong.  It is because that
> implication is conditional---it kicks in only when the command is
> told to compare with any parent (i.e. "-p").  
>
> I.e. the implication is "compare only with the first parent if told
> to compare, and if not told what to compare with explicitly".

I believe my approach is more straightforward and is free from
interpretations.

To make my point let's get back to the subject (for a moment :-)).

To me "--first-parent implies -m" is simple and unambiguous:

(git log [*] --first-parent [*]) == (git log [*] --first-parent -m [*])

No further explanations are needed.

The consequence is that an option that is supposed to override -m must
follow -m, and thus --first-parent, not precede it, period.

Yes, we can invent the rule that implied options don't participate in
overriding of explicit options, or that explicit option always overrides
all the implicit, or some such, but I see absolutely no reason to
complicate the model.

Thanks,
-- Sergey
