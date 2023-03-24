Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903BFC77B60
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 15:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjCXPuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 11:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCXPuA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 11:50:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576AF469C
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 08:49:58 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ja10so2178211plb.5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679672998;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/j29rz0K6KU89S7fGmGteDPZEwxt9oBomtOHn8yWd2k=;
        b=plA3oubXfsoug/NcPHc8Y//NmQfyf4mvzErZk2+mHEDaTInx3nrPrKeR6TxfLXxLyR
         E6iUDIHJjOmidkxRTT6icnOyRJfasaKK0Zz6hkIKF/iXwGQ8H0uGX2EbOb4aOFbFuUSj
         fmoAFc2+gYNEilO6uHxzYxe9fnSNzc9R1bofuBat/hNG7QufWjDTH/gh8/Jsr34s675+
         fvl23XSbd95K/iBgb8hmIY7Xs7BHTv5+O+5awTZSSknQ1r0sS7a5Z+cruHWmA/mLYczs
         obotoHbXWpj4eek8yILzLnP6SijBYGIGpXQ9X1cjyiX/SG/lLZXazD0Dqjyql7tKgjol
         1DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672998;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/j29rz0K6KU89S7fGmGteDPZEwxt9oBomtOHn8yWd2k=;
        b=GlAGOud6w1wHOJA/RZ2hw+Wcyoi/oTtl5HyD0D2SCSGpwDXyUaqBZYqkbHdSGsawkp
         a4A9Jk/wS7NGkqVANydQO1ZVIucuBF07iAMzLSFGfl0HxB3zBBABObBKuUx3enCdyD6h
         v9i8AL7mmLjzs4FvoLASPPtAqnwNbMaqefuyuikCbWdtVPHErVMnDQdhBwvT5oiiJeOa
         uhclLNHg5SA8/fdsHqvYDA454c7QnMsufwDATcqyVwoysLJc3GhgjsCelmM+/esSqOa1
         pVz0vK/ougYN9ncW+a39KzEoV2PH1nO6EZMnzZzPwpnIBIRyzCO7PAs3pK3NpuHH8u0a
         vvtw==
X-Gm-Message-State: AAQBX9e7OEb7lZN6VD8vX03BVAt6ty61zRvIwooMHcmBJl9jF8k6qSBj
        0f0h0ZwdoP5WfZd8ECZUYrREniP977o=
X-Google-Smtp-Source: AKy350ansmoxWs316YbOhZ/J6gxbS95lXdIQ6BGqcNQPSeJt9fICmj+kZSAcNERWA1bW1Dm097Y0cw==
X-Received: by 2002:a17:902:f546:b0:1a0:6721:6cdb with SMTP id h6-20020a170902f54600b001a067216cdbmr3309565plf.40.1679672997830;
        Fri, 24 Mar 2023 08:49:57 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b0019e88453492sm14492916plb.4.2023.03.24.08.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:49:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>
Subject: Re: [PATCH] rebase -i: do not update "done" when rescheduling command
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <xmqq4jqfmi2k.fsf@gitster.g>
        <9e5093ab-2aa8-16e7-227a-f5c56983be9a@dunelm.org.uk>
Date:   Fri, 24 Mar 2023 08:49:57 -0700
In-Reply-To: <9e5093ab-2aa8-16e7-227a-f5c56983be9a@dunelm.org.uk> (Phillip
        Wood's message of "Fri, 24 Mar 2023 10:50:52 +0000")
Message-ID: <xmqqfs9u409m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> Note that the rescheduled command will still be appended to the "done"
>>> file again when it is successfully executed. Arguably it would be better
>>> not to do that but fixing it would be more involved.
>> And without quite understanding what "reschedule" refers to, it is
>> unclear why it is even arguable---it is perfectly sensible that a
>> command that is rescheduled (hence not yet done) would not be sent
>> to 'done'.  If a command that was once rescheduled (hence it wasn't
>> finished initially) gets finished now, shouldn't it be sent to
>> 'done'?  It is unclear why is it better not to.
>
> The command is only successfully executed once but may end up in
> 'done' multiple times. While that means we can see which commands
> ended up being rescheduled I'm not sure it is very useful and think
> really we're just cluttering the 'done' file with failed attempts.

Sorry, but you utterly confused me.  I thought the point of this
change was to avoid such a failed attempt to be recorded in "done",
and if that is the case, we (1) do not record any failing attempts,
(2) record the successful execution, and (3) will not re-attempt
once it is successful.  And if all of these three hold, we wont
clutter 'done' with failed attempts at all, no?

>>> @@ -4648,7 +4649,7 @@ static int pick_commits(struct repository *r,
>>>   		const char *arg = todo_item_get_arg(todo_list, item);
>>>   		int check_todo = 0;
>>>   -		if (save_todo(todo_list, opts))
>>> +		if (save_todo(todo_list, opts, 0))
>>>   			return -1;
>> I wonder why we pass a hardcoded 0 here---shouldn't the value match
>> the local variable 'reschedule'? here?
>> The same question for the other two callers, but I admit that when
>> the second one is called, the local variable "reschedule" is not
>> set...
>
> The rescheduling code is a bit of a mess as rescheduling commands that
> pick a commit does not use the "reschedule" variable and is handled
> separately to other commands like "reset", "merge" and "exec" which do
> use the "reschedule" varibale. I did try and add a preparatory step to
> fix that but failed to find a good way of doing so.

I see.  It may be a sign, taken together with the fact that I found
that it was very hard---even after reading the patch twice---to
understand the verb "reschedule" in the proposed commit log to
explain the change, that the concept of "reschedule" in this
codepath may not be clearly capturing what it is attempting to do in
the first place.

> The reason I went
> with hardcoded parameters is that for each call the purpose is fixed
> and as you noticed the "reschedule" variable is only used for
> rescheduling "reset", "merge" and "exec". I could expand the commit
> message or do you think a couple of code comments be more helpful?

Yeah, at least it sounds like the code deserves a "NEEDSWORK: this
is messy in such and such way and we need to clean it up to make it
understandable" comment somehow.

Thanks.
