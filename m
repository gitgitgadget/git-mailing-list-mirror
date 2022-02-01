Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A19C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 08:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiBAIhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 03:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiBAIha (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 03:37:30 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7EBC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 00:37:30 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id z19so32145900lfq.13
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 00:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QT24RDq6FLDW6uGQeTjL+Y6zBCe+w5pGj8BJHNMUV8Y=;
        b=BW4h0+gyHPfnO2qrIPOmMkrzcB6wCrXrlEbCLYCW8hobCEeLU2qSEuiSRZZz93kZU/
         zJeW0e3zMInV9RKFfVY+Y1AHonTp4xZtOYpHAUZ6rfM0ZG6LdlAcP3/bc+hLwAM4cTIB
         zdduXhnHyNhWDD8wxclRgVbOJKv9VCDU9CWM+uDt118wmGK5w/gdi5VpZTvWbgbfdQv0
         uuiqddiojodPwHSekF64cgqdH7px0nLQyMx/pbUV5GW6Gt97pdoC5tuV+WPP1NnkbDmv
         ZW5EnlfPYSr8VjkfrnjINp+fxbY8T0ZA9+T5/jWvZXvHqF2OOR8w3XPm3eZKu7BtKmPm
         2Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=QT24RDq6FLDW6uGQeTjL+Y6zBCe+w5pGj8BJHNMUV8Y=;
        b=NBttcN5NSRJhYmK6C2niOcpQw7GJwzd97mWdD3bpTIXw+txdqDi96gsbrPx1MJbl4L
         1aXInGrOxiAHHQyjLdhPobshFsb/lqGwEOGEGvGPjZhI65riuLfFBxVZug050u4PpYwn
         KDGQ0/zhadfFU4uEcr/A5N47x7JKkw1+SeKs76rki/++yFrn0vHiwTD6Gw1Bms7lYtem
         HgZAcF1mTPFtdzv5HYiW3tZQMj4XHFWC4i5irm0YnLws/4/BcFJ5VgeXIcUFcE/skLmY
         conE/M6RWdgz7surJl5Rl+iY+ppaKfZL+4aEQccMnWJpTEZ2ZMcqn6emoKTvb2jjrZeF
         X8TA==
X-Gm-Message-State: AOAM531CWEdyIyW2q4Cf+ujuJo2emqMnv4F+wMYyzbLrVFJ4Oc0EC4MK
        Rh29YZTz0wKXklRp70pRdQjx1/MPbo8=
X-Google-Smtp-Source: ABdhPJw6HrXoW2XLVyIOWiBzLbzOREEe1BCvchwDwLSFOK7TGjR93mwCA4HqCPCem1pMPh2mu6SM/A==
X-Received: by 2002:a05:6512:c13:: with SMTP id z19mr13376245lfu.309.1643704647932;
        Tue, 01 Feb 2022 00:37:27 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u12sm3450636lfl.188.2022.02.01.00.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:37:27 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?Q?G=C3=A9ry?= Ogam <gery.ogam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Stage, test, and commit only some changes, then repeat
References: <37128901-233F-4428-8A52-470773A18AB0@gmail.com>
        <87bkzrvpjv.fsf@osv.gnss.ru>
        <49031AA3-CDC3-4CF6-A04B-E3533907FCA4@gmail.com>
        <87iltzpo1r.fsf@osv.gnss.ru>
        <0558E792-899A-4B08-B0A1-4844E5D1EFF2@gmail.com>
Date:   Tue, 01 Feb 2022 11:37:26 +0300
In-Reply-To: <0558E792-899A-4B08-B0A1-4844E5D1EFF2@gmail.com>
 (=?utf-8?Q?=22G=C3=A9ry?= Ogam"'s
        message of "Mon, 31 Jan 2022 23:22:10 +0100")
Message-ID: <87fsp3nfsp.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Géry Ogam <gery.ogam@gmail.com> writes:

>> Le 31 janv. 2022 à 22:56, Sergey Organov <sorganov@gmail.com> a écrit :
>> 
>> Géry Ogam <gery.ogam@gmail.com> writes:
>> 
>>>> Le 31 janv. 2022 à 17:27, Sergey Organov <sorganov@gmail.com> a écrit :
>>>> 
>>>> Géry Ogam <gery.ogam@gmail.com> writes:
>>>> 
>>>>> Hello,
>>>>> 
>>>>> I would like to stage, test, and commit only *some* changes of the
>>>>> working tree, and then repeat this process with the remaining changes.
>>>>> 
>>>>> My current solution (published at
>>>>> https://stackoverflow.com/a/70914962/2326961):
>>>>> 
>>>>> 1. Stage some changes:
>>>>>  ```
>>>>>  git add -p file
>>>>>  ```
>>>>> 2. Save away the remaining changes:
>>>>>  ```
>>>>>  git diff >patch
>>>>>  git stash push -k
>>>>>  ```
>>>>> 3. Test the staged changes.
>>>>> 4. Commit the staged changes:
>>>>>  ```
>>>>>  git commit
>>>>>  ```
>>>>> 5. Restore the remaining changes:
>>>>>  ```
>>>>>  git apply patch
>>>>>  ```
>>>>> 6. Go to step 1.
>>>>> 
>>>>> It is not ideal because a) it uses a patch file for saving the
>>>>> remaining changes; b) it uses the stash only for setting the working
>>>>> tree to the index state.
>>>>> 
>>>>> It would be ideal if I could save *only* the remaining changes in the
>>>>> stash instead of resorting to a patch file. How to do it?
>>>> 
>>>> It looks like you don't need patch file for this workflow. What's
>>>> wrong with:
>>>> 
>>>> git add...
>>>> git stash push --keep-index
>>>> ... check, git add fixes
>>>> git commit
>>>> git stash apply
>>>> 
>>>> ???
>>>> 
>>>> -- Sergey Organov
>>> 
>>> Hello Sergey,
>>> 
>>> `git stash` saves the transition from the HEAD state to the working
>>> tree state. It also sets the working tree to the *HEAD* state.
>>> 
>>> `git stash --keep-index` saves the transition from the HEAD state to
>>> the working tree state. It also sets the working tree to the *index*
>>> state.
>>> 
>>> `git stash pop` applies the last saved transition. So if the working
>>> tree was not in HEAD state (like after `git stash --keep-index`),
>>> there will be a conflict.
>> 
>> Did you actually try it and got conflict? I doubt there will be any if
>> you don't modify anything after "git stash --keep-index" during testing,
>> and if you do, than any method might bring conflicts.
>> 
>> In fact I just re-tested this to make sure, and got no conflicts.
>> 
>> -- Sergey Organov
>
> git init
> touch file
> git add file
> git commit
> echo one >>file
> git add file
> echo two >>file
> git stash push --keep-index
> git stash pop

Yep, if you have overlapping changes in work-tree and in the index, it
will happen indeed. I've rather tested handling of non-overlapping
changes in the same file that occurs much more often in practice, at
least for me.

BTW, for reference, Emacs's magit, that is essentially alternate Git
porcelain, has support for all 4 possible modes of stashing:

z Save                  Z Snapshot          
i Save index            I Snapshot index    
w Save worktree         W Snapshot worktree 
x Save keeping index    r Snapshot to wipref

For Git itself I've recently added --staged/-S, so the only mode that is
still missing is --worktree indeed.

-- Sergey Organov
