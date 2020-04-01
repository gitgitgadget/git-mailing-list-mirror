Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649CEC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 14:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309522077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 14:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxtGcpNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbgDAOAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:00:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42073 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbgDAOAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 10:00:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so134042wrx.9
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SFzQlJyNRjNSChzKLTv+onlu7xNGW6cg5bcselec8Ho=;
        b=pxtGcpNaWLY30noGRRfwq1Qc4xxWSrDM2hEP24GInvPdwxcGTX0yZZSTnvQQzcoess
         FLq0DtRQ7B6ZbQk2cXRxwwj54fpjgh+pdzsKyS7XRmd85iyyNtUhRXoolMYVznT4ngni
         KQkVktTP7/DyYxvoT+0OyNgYnuPYCIkZd7Ra6rJ7m9vuIeT9jkWILUEDZ2FLebTgUtiM
         xnAHOKy5bD7ypIP/GiuyRS1shu/fhRUl5uMyZA812ujy7mPjmvoUsJLRzYWlDXothYVn
         EbUvMC77wtPp+Fe77GEr/gDyCmBgUSAdqg/hW3P0bu0luSTG1bSJxtNMc41pIkqGdp5+
         JfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SFzQlJyNRjNSChzKLTv+onlu7xNGW6cg5bcselec8Ho=;
        b=mu9E0EOLv48ivLgR08ZpB2NbKgY9HyjD4i01Z6onE5UA/GlXZwNQOL+TXQyRkrPqlf
         7W1qyn8MaDrZFy7HM5WPog68rNfHRxnkvIRg9nPP9quRsks4DawgzoEulIl0jKQFa5ZA
         EvrhYtvKNuZW0Dighltj1cGy+9hmKTkPQehVTHbTedY8InxyHtwvIBmlQu1KF/vpXO4s
         OBoJrKPTsABY9tJlgbox/RRlVlhIminbH667ob55ihI4sylgG8rPredVl7DHC3pZ6ENt
         ObDbUK+BJ1jTj40WvrZadCmjPMFIg8zPkYco59kveGzXRth3+vVXeahzpl5bcw7g6ChG
         86xQ==
X-Gm-Message-State: ANhLgQ1jCykUCP7HpoUtt5GTFpP4OxISkGL6Ekv0dKjvk7Zk6Ps7uldI
        KtyBMOFus+JdimWwJO2nEqVL3u/9
X-Google-Smtp-Source: ADFU+vuCeJ5ELZ3krO1jY8ny94IFSbg6YqDfoPZUXIdDd7Bx6ePaZJlyKZnVs6AK96g3ugFlyEX3Iw==
X-Received: by 2002:adf:f646:: with SMTP id x6mr26103094wrp.19.1585749621386;
        Wed, 01 Apr 2020 07:00:21 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id s2sm2612191wmh.37.2020.04.01.07.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 07:00:20 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Comparing rebase --am with --interactive via p3400
To:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet>
 <a00e1689-ec7c-4039-a2e9-f72d452ae4ff@gmail.com>
 <nycvar.QRO.7.76.6.2001312216410.46@tvgsbejvaqbjf.bet>
 <b380123e-dbcd-7e92-67ab-e6cbf0cec061@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a92f1028-d33b-bd7e-a4d5-f4884faedeed@gmail.com>
Date:   Wed, 1 Apr 2020 15:00:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b380123e-dbcd-7e92-67ab-e6cbf0cec061@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban and Johannes

On 01/04/2020 12:33, Alban Gruin wrote:
> Hi Johannes,
> 
> Sorry for the late answer, I was really busy for the last months.
> 
> Le 31/01/2020 à 22:23, Johannes Schindelin a écrit :
>> Hi Alban,
>>   -%<-
>>
>> Indeed. I offered these insights in #git-devel (slightly edited):
>>
>> This `discard_index()` is in an awfully central location. I am rather
>> certain that it would cause problems to just remove it.
>>
>> Looking at `do_merge()`: it explicitly discards and re-reads the index if
>> we had to spawn a `git merge` process (which we do if a strategy other
>> than `recursive` was specified, or if it is an octopus merge). But I am
>> wary of other code paths that might not be as careful.
>>
>> I see that `do_exec()` is similarly careful.
>>
> 
> I have to admit that the index is not my area of expertise in git, so
> sorry if my question is stupid: isn't there a less heavy way to find
> unstaged or uncommitted changes than discarding and then reloading the
> index?
> 
>> One thing I cannot fail to notice: we do not re-read a changed index
>> after running the `prepare-commit-msg` hook, or for that matter, any other
>> hook. That could even be an old regression from the conversion of the
>> interactive rebase to using the sequencer rather than a shell script.
>>
>> Further, `reset_merge()` seems to spawn `git reset --merge` without
>> bothering to re-read the possibly modified index. Its callees are
>> `rollback_single_pick()`, `skip_single_pick()` and `sequencer_rollback()`,
>> none of which seem to be careful, either, about checking whether the index
>> was modified in the meantime.
>>
>> Technically, the in-memory index should also be discarded
>> in `apply_autostash()`, but so far, we do not have any callers of that
>> function, I don't think, that wants to do anything but release resources
>> and exit.
>>
>> The `run_git_checkout()` function discards, as intended. I
>> am not quite sure whether it needs to, though, unless the `.git/index`
>> file _was_ modified (it _is_ possible, after all, to run `git rebase -i
>> HEAD`, and I do have a use case for that where one of my scripts generates
>> a todo script, sort of a `git cherry-pick --rebase-merges`, because
>> `cherry-pick` does not support that mode).

I'm not sure it is worth optimizing the case where .git/index is not 
changed as we only do this once per rebase. In any case I hope that one 
day we'll stop forking git checkout and use the code from 
builtin/rebase.c to do it

>> The `continue_single_pick()` function spawns a `git
>> commit` which could potentially modify the index through a hook, but the
>> first call site does not care and the second one guards against that
>> (erroring out...).
>>
>> My biggest concern is with the `run_git_commit()` function: it does not
>> re-read a potentially-modified index (think of hooks).

I agree that we should be re-reading the index after forking `git 
commit` and also `git merge`. Most of the time we commit without forking 
so that should not impact the performance too much

> Thank you for your analysis.
> 
>>
>> We will need to be very careful with this `discard_index()`, I think, and
>> in my opinion there is a great opportunity here for cleaning up a little:
>> rather than discarding and re-reading the in-memory index without seeing
>> whether the on-disk index has changed at all appears a bit wasteful to me.
>>
>> This could be refactored into a function that only discards and re-reads
>> the index if the mtime of `.git/index` changed. That function could then
>> also be taught to detect when the in-memory index has unwritten changes:
>> that would constitute a bug.
>>
> 
> Hmm, checking if the mtime of the index to see if it changed isn't racy?
>   Sub-second changes should happen, and to quote a comment in
> is_racy_stat(), "nanosecond timestamped files can also be racy" -- even
> if it should not really happen in the case of rebase…

I don't think relying on the index stat data is a good idea, git 
defaults to one second mtime resolution unless it is built with 
-DUSE_NSEC and we do way more than one commit a second. We tried to rely 
on stat data to determine when to re-read the todo list after an exec 
and it is broken (both in the design because it assumes ns mtime 
resolution and the implementation because we don't update the cached 
mtime after we rewrite the todo list). There are not that many places 
where we need to re-read the index so I think we should just have 
explicit re-reads where we need them. Hopefully over time we'll stop 
forking other processes and the problem will go away.

Best Wishes

Phillip

>> Ciao,
>> Dscho
>>
> 
> Alban
> 
