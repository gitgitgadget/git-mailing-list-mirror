Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF229C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC8822BED
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX5Az1Y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgHDWGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgHDWGz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:06:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC15C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 15:06:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so10883054ljk.6
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ji7dqSdmA4+CDCk59d9Z5HakuIfp7tVP/203ZIlS3Z0=;
        b=EX5Az1Y8s+Pd3JpKkI7jX58FBGT1AapqOOfzK3u750XLZBh9pTBGTal8/Tr7KgTbls
         R9BefqYtcYeP/4YUcWV5XNoD+PFFPo31CNbA7zZ08FlG/KT3bGNu85D4vU/Q5wqa05Il
         cHaqh/RNQtNSuQQsx2HUyrhXp/7Z/pFcMEjFYdC0wHObf+pccjqd1nJm9pVGRI/bm9Lc
         6VggLXlIhQqgsu3rmS7so8UXamZAKgKS2sFW4PmZEblUT7qtqN5PP46F2HG1CNWs2cE0
         dZ2oMnvjTw1RciV/0KZEX1PJBQkMyCdAbQIPP3f3XTrzf52Hcj/HEz6N8RnPABY8yzQY
         cCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Ji7dqSdmA4+CDCk59d9Z5HakuIfp7tVP/203ZIlS3Z0=;
        b=UQn+sd6x2P7mkmoaGujUEGiTSiQl4oRZ+dbMhDlyoSy4d64dLPf6lV6mjr2OjGD+EJ
         tDkoEXx4EFvp9/oG4vBHaxlq/7HgtNhBKw/K6aGr0HQ3DZN/jd3YYfpIKKf6fjidAfzH
         v54SPdjg77Z5zEvgUabk4iXyaxRhFZbZN5hEWBOS2JUWY0EXKKTPNIABi7VXU4CPA3l7
         5s+JcS8IE5TYHx0MSDhGL3iBHnko303QJHKmjzgXQZlns0URffbA4iL+gN9JquWktJRq
         YM4eswVev4Zj1dJbvoYdEg1bgTlT7AkfAjJXRYWg/rM8ZeC2zCNiXa8O6phWXuA+tSB7
         nfVA==
X-Gm-Message-State: AOAM532sDUEi+GeB9wBkBz1wWYBoQ1Yx5SNFNF5e6JfttgDgafzcEOc2
        zipPHOhGovermvQNtBflOu4=
X-Google-Smtp-Source: ABdhPJzTe5UH5Doka8le/5LrciXfny5T9oD2EZg3W9s0X3P3fkvLRHhb9CCsbfwe9qmhfUZmbQD84Q==
X-Received: by 2002:a2e:96d9:: with SMTP id d25mr5711442ljj.376.1596578813130;
        Tue, 04 Aug 2020 15:06:53 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z15sm129168lfg.81.2020.08.04.15.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 15:06:52 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com>
Date:   Wed, 05 Aug 2020 01:06:51 +0300
In-Reply-To: <xmqq3652rs84.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 04 Aug 2020 14:55:39 -0700")
Message-ID: <878seuxdz8.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Tue, Aug 04, 2020 at 11:55:19PM +0300, Sergey Organov wrote:
>>
>>> I only don't like --diff-merges=none (even though it sounds great for
>>> --diff-parents=none) and used --diff-merges=off instead. It's not a
>>> strong feeling though, and I'm fine with whatever we decide.
>>
>> I think that is fine. I took "none" to be "diff against none of the
>> parents", which is the opposite of "all". But "off" conveys that, too.
>
> For now, "off" is OK, but then we'll regret when "all" comes,
> because "off" would not exactly sit opposite to "all".

IMHO, "off" does not need to be opposite for "all", as it suppresses
diff output altogether. I read --diff-merge=off as "turn /off/ diff
output for merge commits".

Besides, "all", that I don't like either, is among "c" and "cc", all 3
being different versions of diffs against all the parents, no?

> On the other hand, "none" would: Compare with all parents? Compare
> with none of the parents?

I think "none" would have been appropriate for --diff-parents indeed,
but not for --diff-merges.

Thanks,
-- Sergey
