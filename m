Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E7C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A2823406
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbhAHHjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 02:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAHHjG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 02:39:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE3C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 23:38:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cm17so10267307edb.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 23:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=dDiuitppWAjBXKKS2YB7MnpsViGdIpW3M+Zaz5tFaqk=;
        b=QrQmKfErziXhkGj5DhV//RwQrea70rAhUYvNbBxRz8mZBnk0iPVwFq+sUyM4dydRqC
         LcKMpzrStPFGRwQogFadN4a+mewhHA3fVuL88WBtMm3kk6RofVK68oQYAoLwIcKwNoGJ
         AO9tKqkdZPfeM1o/T04ClVMibv/sybKGxcz9Tcn6BNMjm1+IAqxisbTlV+nHZzYbBZA/
         36lLltu21FUSWQIznwZPPdfErU03WXFofHzHx2z1KZhiAXYrxU5g2xXvWTE2FPCYTi8F
         zxH04UebkrHpO02k3OmLaXtxFWENWPt54iRo7vcT79vElzb0QCQ38i/IutqKG4EONFKY
         bM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=dDiuitppWAjBXKKS2YB7MnpsViGdIpW3M+Zaz5tFaqk=;
        b=lB5MMN6XLmfzUEvt7yM1HX4NZ9bqZIhr6gzjXLPQX4YPY+XLfOPfkQiKberkoWoMmL
         R9NyuVzT039PSJjKURCuJ/hY1TtKPv+utkdgvyGZlX6IL379k27y7vgEzyHFtdEJ0aoz
         KyjEyOb5B0aFpFy9ERTXXG4Pjh+jBR36Mv/gM4WcQ0V8kQva6OsB3XJwl0zWH/MHJfjp
         eo6ec+m/Car8xzE36mfA+xfT+0HmcdZRZbQbTXk2W3RbjsqByW4UmV+YM+O9vVkr2GfZ
         IC6pg+1L+0rth6tLkZRXJKWuMYC6BN0KVGIU9jQ6DD2R6oDOtThpAg9nJuY3k3R2tisE
         sGwQ==
X-Gm-Message-State: AOAM530hX38etARc8ZAX/Hr0ugmGbqStmlQC1RzdBbViacYGtJw4GBdh
        srGWV/iTq/yMOp2eZH9A5dpS1WFOjAKrQg==
X-Google-Smtp-Source: ABdhPJzsHAhNzWyNyImvWlhBquxWYZ4gzytU0K5DM2M3YxIg+mNiPdKrSgnjXcGsFrps8Mb4k8NZyA==
X-Received: by 2002:a50:fc13:: with SMTP id i19mr4524722edr.281.1610091503930;
        Thu, 07 Jan 2021 23:38:23 -0800 (PST)
Received: from cpm12071.local ([212.86.35.64])
        by smtp.gmail.com with ESMTPSA id d22sm3241050eja.72.2021.01.07.23.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 23:38:23 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <CAPig+cSMA0J9fBvG=L0ojWvd5ePwxb6ya67umX1HdOy4LEiZpg@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/7] teach `worktree list` verbose mode and prunable
 annotations
Message-ID: <gohp6kpn2gsepd.fsf@gmail.com>
In-reply-to: <CAPig+cSMA0J9fBvG=L0ojWvd5ePwxb6ya67umX1HdOy4LEiZpg@mail.gmail.com>
Date:   Fri, 08 Jan 2021 08:38:22 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> In c57b3367be (worktree: teach `list` to annotate locked worktree,
>> 2020-10-11) we taught `git worktree list` to annotate working tree that
>> is locked by appending "locked" text in order to signalize to the user
>> that a working tree is locked.  During the review, there was some
>> discussion about additional annotations and information that `list`
>> command could provide to the user that has long been envisioned and
>> mentioned in [2], [3] and [4].
>>
>> This patch series address some of these changes by teaching
>> `worktree list` to show "prunable" annotation, adding verbose mode and
>> extending the --porcelain format with prunable and locked annotation as
>> follow up from [1]. Additionally, it address one shortcoming for porcelain
>> format to escape any newline characters (LF and CRLF) for the lock reason
>> to prevent breaking format mentioned in [4] and [1] during the review
>> cycle.
>
> Thank you for working on this. I'm happy to see these long-envisioned
> enhancements finally taking shape. Before even reviewing the patches,
> I decided to apply them and play with the new features, and I'm very
> pleased to see that they behave exactly as I had envisioned all those
> years ago.
>
> Very nicely done.

Thank you. I'm glad to hear the patches are aligned with what you
envisioned.

> I'll review the patches when I finish responding to this cover letter.
>

Thank you for reviewing and applying the patches, really appreciate it.

>> The fifth patch adds worktree_escape_reason() that accepts a (char *)
>> text and returned the text with any LF or CRLF escaped. The caller is
>> responsible to freeing the escaped text. This is used by the locked
>> annotation in porcelain format. Currently, this is defined within
>> builtin/worktree.c as I was not sure whether libfying the function as
>> part of this series is a good idea. At this time it seems more sensible
>> to leave the code internally and libfying later once we are confident
>> about the implementation and whether it can be used in other part of the
>> code base but I'm open for suggestion.
>
> Perhaps I misunderstand, but I had envisioned employing one of the
> codebase's existing quoting/escaping functions rather than crafting a
> new one from scratch. However, I'll reserve judgment until I actually
> read the patch.

Agreed. It make sense to reuse one of the already implemented functions
from the code base. for some reason I was not able to find it. I believe
this was cleared out in one of the patches replies by you and Phillip Wood.

I will remove this and reuse one of the existing function on the next
revision.

-- 
Thanks
Rafael
