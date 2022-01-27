Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB73C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 01:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiA0BxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 20:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiA0BxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 20:53:09 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD28C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 17:53:09 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 71so1351832qkf.4
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 17:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCPVHqnR1SauBpuyB8Bo7DF8Lfic4nRhq7LLpLl6wJQ=;
        b=ZnyXEWO/Lx3N/R412k0rU1xcrZZ9SAn32zjGADz2eUH84Of2vDnx77OC7TahxydizW
         PZRxg2i6Surg2f6S1YIZDO0cKsOi5td4szHViymo3kzHAM1g3IQXFHXpbvWBsyQY90OF
         d7+Y0rupaJylG8WX0Cjlq7C46KMqu81ZZCIpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCPVHqnR1SauBpuyB8Bo7DF8Lfic4nRhq7LLpLl6wJQ=;
        b=YL2koLotUx30B1CVAdSKDe8avZSZ71svejZxZBRarJKB3OTgeuMXyxb/Y7BVHqDUF5
         MN5lxaPGtGNhri1U700RY5h9MGQw+qSpbgK+r3xDtM9BOwanhb6brsJC6rWNO3QdwG+7
         G3Ns765yoFhLK/PF6O8XNq9GftuX8IccI0gC4DdnwXb/rkllClAhG7vc1s22JOGW/aMp
         XyqvNUJMSWe0dLS+uW/fIHjuFUqPjszJuRTGmOTTiyD4pJ3kH/gW7uBm29g6+0FwSSuu
         RE13aFlXSLH27lr/PgxzwuPUVmaY4RIBuJr6w/Ls9qTNAMYS60AGivVDX8YiSsi+3VNw
         SOzw==
X-Gm-Message-State: AOAM5334XqvON1jM/hwSHVoENYmNNlsMEqtWO0Q7y0fg8NAMIfkdK602
        IZS2qeD2kwq898yyD6Wlg+Mpjg==
X-Google-Smtp-Source: ABdhPJzm8pmXkuEqQZhb+5Oy1bKNgAB0vWQUuku914qx4oKq4JzqQ0D7NKjho6SMBitMK26M90YfpQ==
X-Received: by 2002:a05:620a:46a1:: with SMTP id bq33mr1246857qkb.92.1643248388266;
        Wed, 26 Jan 2022 17:53:08 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id bk32sm566981qkb.24.2022.01.26.17.53.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jan 2022 17:53:07 -0800 (PST)
From:   John Cai <jcai@gitlab.com>
To:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Yuri <yuri@rawbw.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push' isn't atomic when Ctrl-C is pressed
Date:   Wed, 26 Jan 2022 20:53:06 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <E6946EAC-4F4D-41CF-9D36-5D1E64D0FF09@gitlab.com>
In-Reply-To: <220126.864k5qdx66.gmgdl@evledraar.gmail.com>
References: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
 <220126.86bkzyfw3q.gmgdl@evledraar.gmail.com> <xmqqlez2qnfi.fsf@gitster.g>
 <220126.864k5qdx66.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26 Jan 2022, at 15:47, Ævar Arnfjörð Bjarmason wrote:

> On Wed, Jan 26 2022, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>> On Tue, Jan 25 2022, Yuri wrote:
>>>
>>>> Ctrl-C was pressed in the middle. git creates the stash record and
>>>> didn't update the files.
>>>>
>>>>
>>>> Expected behavior: Ctrl-C should cleanly roll back the operation.
>>>
>>> Yes, you're right. It really should be fixed.
>>>
>>> It's a known issue with builtin/stash.c being written in C, but really
>>> only still being a faithful conversion of the code we had in a
>>> git-stash.sh shellscript until relatively recently.
>>>
>>> (No fault of those doing the conversion, that's always the logical first
>>> step).
>>>
>>> So it modifies various refs, reflogs etc., but does so mostly via
>>> shelling out to other git commands, whereas it really should be moved to
>>> using the ref transaction API.
>>>
>>> Ig you or anyone else is interested in would be a most welcome project
>>> to work on...
>>
>> I must be missing something.
>>
>> If I understand the problem description correctly, the user does
>>
>> 	git stash push
>>
>> which
>>
>>  * bundles the local changes by recording a commit (with trees and
>>    blobs) that represents the new stash entry
>>
>>  * removes the local modification from the working tree files.
>>
>> And if the user kills the process while the second step is running,
>> there will be files that are restored to HEAD and other files that
>> are left unrestored, because the process was killed before it had a
>> chance to do so.  At that point, we probably do not even know which
>> ones have been restored to be "rolled back"---that knowledge is lost
>> when the process got killed.
>>
>> My take on it is that it is not something that we can call "_should_
>> be fixed".  It is in the same category as "yes, it would be nice if
>> the world worked that way, and it would be nice if we had moon,
>> too".
>>
>> And it has nothing to do with the command being written in C or
>> shell, and it does not have much to do with the existence of ref
>> transaction API.  If you want atomic working tree update, you'd need
>> to snapshot the working tree state, record the fact that you are
>> about to muck with the working tree in a secure place and make sure
>> that hits the disk platter, perform the "stash push" operation
>> including the working tree update, and then remove the record.  The
>> record will help you discover that your earlier attempt for doing so
>> failed for whatever reason (e.g. ^C, kill -9, power failure).  Then
>> you'd need to arrange that the state gets restored, and possibly
>> redo what you were doing.
>>
>> Which theoretically can be done.  But it would be not practically
>> cheap enough to use in a day-to-day operation.  It certainly would
>> be too much to expect a new person to be able to "work on".
>>
>> And the "theoretically" part is important, in that it draws the line
>> between what is realistic and unrealistic.  The thing written in C
>> or shell would not make much of a dent and the existence of ref
>> transaction API would not have much effect on partial working tree
>> updates not being restored.  They are red-herrings.
>
> I understood this problem as being one where we do the ref work first,
> which we could start a transaction for, the user then ctrl+c's after the
> ref work is done, but before the working tree is updated.
>
> Which, if we use the ref transaction API we could intercept with an
> atexit() hook that would inspect our state to see if we're done, and if
> not roll back the transaction. It wouldn't survive a kill -9, but would
> handle being interrupted.
>
> We'd then leave the working tree modifications in place, or not, and
> roll back our ref updates, or not, depending on where we were when we
> were ctrl+c'd.
>
> The reason it being a command that's recently converted to C (in terms
> of its API use) matters is because we don't have any sort of
> cross-command ref transaction mechanism, if the ref-modifying command
> we're invoking fails we don't know why exactly based on its exit code.
>
> So we're not prepared to roll it back, although that could theoretically
> be addressed it's easier just to move it all to in-process API use, and
> it also addresses the general TODO of reducing how much we shell out to
> ourselves over using internal APIs.
>
>> I suspect that the untold thinking behind your statement was that we
>> should try not to discourage new users from asking, and I agree with
>> the sentiment to a certain degree.  But at the same time, I think it
>> is simply irresponsible to do so without distinguising between
>> asking for something realistic and unrealistic.
>
> I must admit I'm not deeply familiar with builtin/stash.c in particular,
> but I've looked at e.g. the API use in builtin/branch.c that I
> referenced, and I think that (and converting to the transaction API in
> general) is a very suitable task for someone who's interested in
> contributing, but not deeply familiar with the codebase.

If folks think this would still be a useful change, then it sounds like a good
project to work on since it involves no changes in functionality and would help
to reduce the number of shell outs in the code. So though it doesn’t really address
the issue brought up, I’d be glad to make some improvements nevertheless :)
