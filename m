Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903FAC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA8E20717
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C963yuCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733247AbgKWXB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733016AbgKWXB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:01:28 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA1DC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:01:27 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id v14so3987148lfo.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8jfh5AO1EgVaO//gNsqJVHX3ZiIYYDh8ZpmG8dUXrLM=;
        b=C963yuCmCIHvis04QEbH8CthRDJhILIFdeEjcdd22sGQ2PR3Y1QdJQPuGDihJAElmg
         o/87YR8YEHuQxLvUmy86y5cG/Gd9bGCydA+vVW0g+qXXjMzx75rt7Ka6D8RK7QF05ZTQ
         A99rlyrT5hBp8rzhJMjBTf6wfg8k998mSB2pFcmgzvSph/+8AXQnRlQYHhuthAKWtHjs
         /BjpY1YDkohNMAj3dCTP2yLjxI9bAxuDfczajGaXobKbg0bLTHfq7i7SSJlrugIrIQos
         Tg872gqAwSmX00XdW4y7PjEs2lFTJIEm/Yi+1QwuEqpfbuc+Do3W/gLPb7TVXEhaVKkq
         HPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=8jfh5AO1EgVaO//gNsqJVHX3ZiIYYDh8ZpmG8dUXrLM=;
        b=OUBF+arSIFdThtDAXBGmFbj2NhLJOiGjPAEXUyTDQz6aKYkGCZKCzogkcWQxmv0jH9
         xQtJF/MKTuaMkcSpDMHs8cXmyBf4HjA3xtpJdJA6yrnZvNAUUkorRNIGN5ikInxvOVBU
         njEd7Rwp7x6x5q+osPQ0l1mMeWT9YUWyJsChhQ+bC1/ckb4/V021FidmmJb66Y4LW0PC
         XDhD5hTMpRLX8HDkq5ZgqNsMIQ4eRQJfsNf29gBjB1Tfw9kePUVL6JNMziReCgIHZNZK
         rTxpDK82jVOEIMiNECMnK1hWE+fxV3MJPWCQ4NmX76KALMgXeuY2ueAFi/K2BlBNYUm6
         Hueg==
X-Gm-Message-State: AOAM5312E0x8+0WWr2DZW483hE+FXqgZzcbQrrQ2zqPrRNo7SOCojGqQ
        3wARibYVDk6rdyKx/vYN0KaAWo2xqRg=
X-Google-Smtp-Source: ABdhPJwatWokMv0aufR8HwMPKhoaK+CnYcEXW+8+huIRc73SvRcSGeOfFGD/MTvyU9IFzkFwMWBO6Q==
X-Received: by 2002:a19:7717:: with SMTP id s23mr504697lfc.541.1606172485863;
        Mon, 23 Nov 2020 15:01:25 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c14sm1537318lfr.105.2020.11.23.15.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 15:01:25 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] glossary: improve "branch" definition
References: <87blfnhm8w.fsf@osv.gnss.ru>
        <xmqq7dqbn1nl.fsf@gitster.c.googlers.com>
Date:   Tue, 24 Nov 2020 02:01:24 +0300
In-Reply-To: <xmqq7dqbn1nl.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 23 Nov 2020 14:34:06 -0800")
Message-ID: <87im9vekzf.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> The old phrasing is at least questionable, if not wrong, as there are
>> a lot of branches out there that didn't see active development for
>> years, yet they are still branches, ready to become active again any
>> time.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/glossary-content.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
>> index 090c888335d3..8bf198e72771 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -18,7 +18,7 @@
>>  	Untyped <<def_object,object>>, e.g. the contents of a file.
>>  
>>  [[def_branch]]branch::
>> -	A "branch" is an active line of development.  The most recent
>> +	A "branch" is a separate line of development.  The most recent
>
> A dormant branch cannot be an "active" line of development, so in
> that sense, the original is wrong.  The description is better
> without the adjective "active".
>
> But do we need to say "a separate line of development", instead of
> just "a line of development"?  What is "a line of development" that
> is not separate?  What extra pieces of information are we trying to
> convey by having the word "separate" there?

I think it tries to convey a notion that 2 branches represent separate
lines of development. I.e., that the whole purpose of branching is to
provide support for independent, or parallel, or /separate/ lines of
development.

I'm not going to insist on the exact wording though, -- just wanted to
bring attention to the issue, and "separate" was somehow the first word
that came to mind when I edited the text.

As an after-thought, I'd probably add that branch in Git is represented
by a chain of commits, and then I'd refer to most recent commit of the
chain, instead of most recent commit on the branch. That'd make
definition more formal and precise. Makes sense?

-- Sergey Organov
