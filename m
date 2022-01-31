Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7179AC433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 21:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiAaV4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiAaV4U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 16:56:20 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94311C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:56:19 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id c7so20851505ljr.13
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QyQ7u1ZAvciIdbrGIjIQVziQ7rDNmjMWd76G5bqPFjg=;
        b=NPdEDaspXf44KY1gIbiK1rDTxLBlp3vIcH4jO/+4pl7w1mIqW3TVVlMHojRXGs6tJr
         DjZtbQOAy5o6UX8EL1zHG5OUuCCJF12001vJUFIt+E+vV+ziFrcMRX48aJeVMlGs3zyB
         PwfL0uzKgzJG/vKPmbwrkWFlzoIFNk/RmI3wmmSIydP8dMMlzaubNPXqRQqVB/UTy+sW
         Um7ZTdlLyMMzU/JTBP1kWWZXM2eRkce6g5rnI6O/kQlpYnxkwRKl2ZAcjZ9+3dwBV1r+
         dPdvl/Q5Y2JQzvhT80MHqnTgcTgG0bKJClTfAo4U6xp0tecQ9chk5pF0vNY0ES3tRA14
         Tw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=QyQ7u1ZAvciIdbrGIjIQVziQ7rDNmjMWd76G5bqPFjg=;
        b=btg1iykowGV3mC48DwibbNPedVvlft+8c3R8hw+1jph5y/f26rFCsFdLLB63A+f8ZO
         SunLNWGfxQZx3mjV3wETUT1isBl+4pAmczbwXGxbj/iDHuuHGmP7EQ/A8shv8uMOB+xw
         Yoa0EyLOmHn3ac7taV7oCTXu9G/Bnau3F64NBmeDvGVa86qcMBdhm1/1tKngnLXH8al2
         IlmmsEnJ0nrbcV3B/cD8jKLPIvnYmqgmLPgfej2knubUp4ltmjharahASkEtPR4YghMo
         +j/EzeOUjR6zTTG8/x/6yIJKu44xLJdhTrwf0WtxjJMLzvki03791Z75DZYJs8YhrW66
         tYdw==
X-Gm-Message-State: AOAM533eZeRN/c81vG9z10xZv/Z4LQOowxPDBYvZOJyAppzh+DYZ+1qr
        BLi0EXWZuFjduWl7iQztEeqcgwOXQpU=
X-Google-Smtp-Source: ABdhPJzqdVpGKX2NGPNpyDjPPmTKaF8Mm9fgzX2n4pR7liYMdD/n+6r/UBigOIlkCN/iMozihqHWDA==
X-Received: by 2002:a2e:9f53:: with SMTP id v19mr14790977ljk.427.1643666177428;
        Mon, 31 Jan 2022 13:56:17 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z17sm2757004lfe.283.2022.01.31.13.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:56:17 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?Q?G=C3=A9ry?= Ogam <gery.ogam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Stage, test, and commit only some changes, then repeat
References: <37128901-233F-4428-8A52-470773A18AB0@gmail.com>
        <87bkzrvpjv.fsf@osv.gnss.ru>
        <49031AA3-CDC3-4CF6-A04B-E3533907FCA4@gmail.com>
Date:   Tue, 01 Feb 2022 00:56:16 +0300
In-Reply-To: <49031AA3-CDC3-4CF6-A04B-E3533907FCA4@gmail.com>
 (=?utf-8?Q?=22G=C3=A9ry?= Ogam"'s
        message of "Mon, 31 Jan 2022 22:33:39 +0100")
Message-ID: <87iltzpo1r.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Géry Ogam <gery.ogam@gmail.com> writes:

>> Le 31 janv. 2022 à 17:27, Sergey Organov <sorganov@gmail.com> a écrit :
>> 
>> Géry Ogam <gery.ogam@gmail.com> writes:
>> 
>>> Hello,
>>> 
>>> I would like to stage, test, and commit only *some* changes of the
>>> working tree, and then repeat this process with the remaining changes.
>>> 
>>> My current solution (published at
>>> https://stackoverflow.com/a/70914962/2326961):
>>> 
>>> 1. Stage some changes:
>>>   ```
>>>   git add -p file
>>>   ```
>>> 2. Save away the remaining changes:
>>>   ```
>>>   git diff >patch
>>>   git stash push -k
>>>   ```
>>> 3. Test the staged changes.
>>> 4. Commit the staged changes:
>>>   ```
>>>   git commit
>>>   ```
>>> 5. Restore the remaining changes:
>>>   ```
>>>   git apply patch
>>>   ```
>>> 6. Go to step 1.
>>> 
>>> It is not ideal because a) it uses a patch file for saving the
>>> remaining changes; b) it uses the stash only for setting the working
>>> tree to the index state.
>>> 
>>> It would be ideal if I could save *only* the remaining changes in the
>>> stash instead of resorting to a patch file. How to do it?
>> 
>> It looks like you don't need patch file for this workflow. What's wrong with:
>> 
>> git add...
>> git stash push --keep-index
>> ... check, git add fixes
>> git commit
>> git stash apply
>> 
>> ???
>> 
>> -- Sergey Organov
>
> Hello Sergey,
>
> `git stash` saves the transition from the HEAD state to the working
> tree state. It also sets the working tree to the *HEAD* state.
>
> `git stash --keep-index` saves the transition from the HEAD state to
> the working tree state. It also sets the working tree to the *index*
> state.
>
> `git stash pop` applies the last saved transition. So if the working
> tree was not in HEAD state (like after `git stash --keep-index`),
> there will be a conflict.

Did you actually try it and got conflict? I doubt there will be any if
you don't modify anything after "git stash --keep-index" during testing,
and if you do, than any method might bring conflicts.

In fact I just re-tested this to make sure, and got no conflicts.

-- Sergey Organov
