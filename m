Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49081C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CE160E74
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhJOURI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 16:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbhJOURH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 16:17:07 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45C8C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:15:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g36so29614336lfv.3
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0L8LNdN81S5/8BIhq+XV4CDMWR6ffw3xzcS+G6k73CM=;
        b=PInItc/K7qWBwr2TehYJrRivfYkqXv10cHuMvJU7dDT+fmUdicRzjzCs3HvpcjbqWE
         BxJxnuMRGOLS1Kbft+hxSoV20SKMrdgfwvn4nmGE8ERlCeOpfDp4f8diQSxmfwnL3tNS
         CDAc3gZkXiozRR+pv7mWe07uEBMajUQNV2KgRuuGcPLquJHWuRdm7FZjuz7u9Y9D80nM
         HyyQNrX1H6dmlx9VHC9OYFx774WI6qMLMv83aq6XoqEorCv6ZOpI/zxD+HOi5XhKevTk
         RLXM9Z1zXchU1CR1+8lJ/kLI9nMRXZM4WMG7Yvz3fyIgPHdIeDI47rRB31wnDg8Xb42C
         sqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=0L8LNdN81S5/8BIhq+XV4CDMWR6ffw3xzcS+G6k73CM=;
        b=F2I4DGZdhK902q2u4lowD0AEpBBBllDUFLwiMS0ocRgnIWmtgmxaMMleeiMuN0o5ES
         9WAiJ1Cfh1GtLAOnZLj3Pj5ONNYlEzQPzX53yaHqq9hyxnTJKAB+bkFgMyS6FnLLqsmj
         IpEDDPqxgYGbmLoY2NGVKPLIXlPdSBFvHB8dxMqh/MEK/BOvFkXxS/pGPlZ8IhrMbf/U
         Y4gmxzPHl+h36Bo6aKjhbgW7pYIZMQlO3BOVqfgkvEpjC55dobeR+NS+xd5tfyYMM2OL
         2iQ/YuWOGfR071Eir9nysngfuVuoeFx+aUIwpWfurGwSvfNN39qBFeMHyTqwfy4RDC+d
         8Dsw==
X-Gm-Message-State: AOAM532Q0pkYomJP0sa5osBTOrU3YWkIxtApYe0r2vnB9Eh0VxliCtZS
        dNJdnOZhE7QPsQp+VGnBFnTgko2WlIU=
X-Google-Smtp-Source: ABdhPJzlVvRN5EX6t883FXzhydzVbtg/bc/yr9w1BXcYgtrY8tHSrxgB/0rgwkh72ry5l6e4l/hGow==
X-Received: by 2002:a05:651c:490:: with SMTP id s16mr14729989ljc.423.1634328899117;
        Fri, 15 Oct 2021 13:14:59 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x30sm652276ljd.76.2021.10.15.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 13:14:58 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] stash: implement '--staged' option for 'push' and
 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <87fst2gwia.fsf_-_@osv.gnss.ru> <xmqq5yty6uh1.fsf@gitster.g>
        <87pms6cdnk.fsf@osv.gnss.ru> <xmqqsfx25c09.fsf@gitster.g>
Date:   Fri, 15 Oct 2021 23:14:57 +0300
In-Reply-To: <xmqqsfx25c09.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        15 Oct 2021 12:22:30 -0700")
Message-ID: <87lf2uavum.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> but
>>> unlike the "stash -p" that goes interactive to let the user pick
>>> hunks, in which context "oh, no, you did not SELECT anything" makes
>>> perfect sense as an error message, this message would be confusing
>>> to users who weren't offered a chance to select.
>>
>> It seems to me that it makes sense to leave this warning as is, in case
>> the user invoked "stash --staged" without anything staged. I'm OK to
>> change this if you have something better in mind.
>
> I am not questioning the presense of the warning.  It is just the
> phrasing of the warning---"You have nothing staged" would make a
> good message, but "You didn't select anything", when we do not offer
> them a chance to select in the first place, would not work well.

Ah, I agree, your phrasing is much better, -- will fix.

Thanks,
-- Sergey Organov
