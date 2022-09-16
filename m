Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E4ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 16:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIPQ2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 12:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIPQ2d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 12:28:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663028E98C
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 09:28:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so36455257lfr.2
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=4aXNX2yN2w9NbbfqIsJDKBb2anGdG6vy+2q6+ewXf0Y=;
        b=TdZ/lHdRmkktq038bYBGWQaestQD6V4TyYZ+YVHlEY74is2p1g0D6afHmm5pOIlrq6
         GiAKvcs61xwT+HRnrDmItDY2vu1pTqSt48K/TCKPeQid+VJ2XQX/TT0HeOd4L9IsenNK
         7mNIsUkA0KcLryvYW/N3fxRZph+1to9htH4DQDGSkXIax4FPn11FKM/8D+PwDu5dbkku
         8IFvKJwW1qw4aF+QMDVhbky4o+U+xgZSHS2jWJ9kYWyEUHsIH3Pt4UYjh48zb85ElOeT
         VVaeUt3Sczv+pysv8wf0YY4zngiQp3XiEiYzYd6FvBJzNsCJUt0lHk2ZBGpwrETWuVO/
         YHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4aXNX2yN2w9NbbfqIsJDKBb2anGdG6vy+2q6+ewXf0Y=;
        b=M2pzduTPunG1JCiDulsX1wYOeTpSePfldnlJRxLGgDM2vFgGDwgrB50/Ew1i7JRyn7
         tOMNYLfFdpsJS72hwRK2l19Yyi6hLG+y6rtlDqObSvQqfCF5bKXDxK4SJEtqYkNJd64f
         6GJ8fpeC1QIOhyiQMm+ulzYBHrdhgxhVlcZL95XE5u8y4lgAMX+4F1gsETsGWW1p7xAF
         lW4K2Ir1iWk9vKXThHiEyolqGCalQ5MH3UIGwR27IZ5sctIMx6DqTh7SIoTQdOeHw1sr
         WlFMxb7JsPGTWvDkkiMl6VNTlC6Wm4Vm8AJ5dk0WZVNPwpUPswTWHlYExgSZ8/6e3Jo7
         Qmdg==
X-Gm-Message-State: ACrzQf1fOS5AV1VY9vCTx72/1s7r7lo45K2G7pt3HnjU03ZXKsIZDX+0
        g9+v4qtZvI42xJVaMQ9FFR/rsuUrWok=
X-Google-Smtp-Source: AMsMyM4yQ3c/zw0I9HYZFEpAsMpZBx3SRcmR3Wtu+KpdVA4OkgK3QBnjYUqPKIjIHk3coIRIMNPhMw==
X-Received: by 2002:a05:6512:a8a:b0:49b:24a:f0cc with SMTP id m10-20020a0565120a8a00b0049b024af0ccmr2060488lfu.431.1663345710149;
        Fri, 16 Sep 2022 09:28:30 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n26-20020a056512311a00b00492ce573726sm3567698lfb.47.2022.09.16.09.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 09:28:29 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] diff-merges: cleanup func_by_opt()
References: <20220914193102.5275-1-sorganov@gmail.com>
        <20220914193102.5275-2-sorganov@gmail.com>
        <xmqqfsgsmq4j.fsf@gitster.g> <87wna3jwx8.fsf@osv.gnss.ru>
        <xmqqy1uji9dz.fsf@gitster.g>
Date:   Fri, 16 Sep 2022 19:28:27 +0300
In-Reply-To: <xmqqy1uji9dz.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        16 Sep 2022 09:14:48 -0700")
Message-ID: <875yhnjnbo.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Sergey Organov <sorganov@gmail.com> writes:
>>>
>>>> Get rid of unneeded "else" statements in func_by_opt().
>>>
>>> While it is true that loss of "else" will not change what the code
>>> means, this change feels subjective and I'd say it falls into "once
>>> committed, it is not worth the patch noise to go in and change"
>>> category, not a "clean-up we should do".
>>
>> I agree the "else" vs "no else" is subjective, but the problem in fact
>> is that the first "if", unlike the rest of them, already had no "else",
>> making the code inconsistent.
>
> This is a static helper function about a single "optarg" string that
> wanted to say "switch(optarg) { case "off": ... }" but couldn't in
> C, and I happen to view if strcmp else if strcmp ... sequence on the
> same string a poor-man's substitute for such a construct.  So my
> take of it is to call the second "if" not being "else if" a problem,
> not the rest of it.  If we add a new condition on a different input,
> making it "if (x) ...; switch(optarg) { ... }" that talks about
> something other than optarg, then writing it all with "if" without
> "else if" would make it harder to see the pattern, but I do not care
> too deeply either way, because this is unlikely to gain any logic
> more involved than "switch(optarg) { ... }".

Well, I even tend to write this switch(optarg) as:

if (0) ;
else if(...) {
  ...
}
else if(...) { 
  ...
}

to make the first actual "case" look the same way as the rest, and then
through suitable defines it finally looks like:

IF_SWITCH
IF_CASE(...) {
  ...
}
IF_CASE(...) {
  ...
}

making the intent explicit.

Just saying.

Thanks,
-- Sergey Organov
