Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901BCECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 16:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJ1QFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 12:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiJ1QFM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 12:05:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CA05140D
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 09:03:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d10so5134574pfh.6
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBdaSCBw+9IYi7Q31dFQNrFxCoDFwu7rEtEtkDntqrY=;
        b=MIzYHcRe6Ws9T9V7J0q6pNfAIYWyeOkwr0u7EbF56LOOwG4Xv7G5Kxo3KdS6a2NfHu
         yCWEq3hn7qb3+//b72Fr+2oosSfzUqZzs8WXeGuXie3KH/IflZ8a7FfjNOhhOyarWE4h
         IcuVXNayqVQdP1IZh06rwEeaTsu1AhyIGhqqN12em+f+oPBXFXrUrt/3kVdjk9L0jcqU
         tn5LQ5R9ASSpxeRJfgK7uuuQ0CymOtuN4WEr3EwjqFAjJ1ULoSh0jSHMU4DGNnDYn1HW
         YVeiGGCSL0WD2Z+NjtnJE3g5cA0ETqI62jH2Bh9Z8/sjEGbo03DBNAD2X9g9TdKU8uEe
         hFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NBdaSCBw+9IYi7Q31dFQNrFxCoDFwu7rEtEtkDntqrY=;
        b=fhytD7SvB+H+Pt9un8zlS3fcFyFA7yvOnuoyg4WDqqrOLUBde/51z/JVi1j/cl1Nvm
         LdAf3yB3tbxHXZUpLnxw4N9zY56J7XSSb4xvTplxT9OPdDoKwYM+cTogcXXtGGuKCta6
         mYq0CMy9AgDz9OSkeaEWtkN1JluPU7k7JwTzvC485Jcg933g8zecG1tz6XUFm073qpE9
         OVJ3cPqMaNo7oXhu536YMblapjQIvXE9wXFP3IUd1YyPo/eZJHRSbNxY1CyzZpIyg04y
         xB/3Y1PzOepBvF2LkfuUR90rOohHLVSN6gUb875hdbbecVzB98M3USP4txg7D1NuTnC5
         qC5g==
X-Gm-Message-State: ACrzQf1ua4ktuXLdgqfbbGAswy0auvcFGRbICAP8CiDfcnNl0xEu8IwV
        SYTj97BnnLCrSfKvkkns51KIgmb47G0=
X-Google-Smtp-Source: AMsMyM4xIO195I7hmmZD6pvwDu3J/heRPqkLSwLwBZ2vFMc7zD0QJkknsK6n/Xhd4k94npt5sq4k5w==
X-Received: by 2002:a63:ea48:0:b0:43c:69c4:68d4 with SMTP id l8-20020a63ea48000000b0043c69c468d4mr218901pgk.416.1666973031632;
        Fri, 28 Oct 2022 09:03:51 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b0018689e2c9dfsm3281329plh.153.2022.10.28.09.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:03:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kyle Zhao <kylezhao@tencent.com>
Subject: Re: [PATCH] merge-tree.c: add --merge-base=<commit> option
References: <pull.1397.git.1666872761355.gitgitgadget@gmail.com>
        <xmqqczadm93w.fsf@gitster.g>
        <CABPp-BHceBeo6Y8s00gET=4yqCMf3qqsiNMhqJ34HVf8r=bhnw@mail.gmail.com>
Date:   Fri, 28 Oct 2022 09:03:50 -0700
In-Reply-To: <CABPp-BHceBeo6Y8s00gET=4yqCMf3qqsiNMhqJ34HVf8r=bhnw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 28 Oct 2022 01:20:18 -0700")
Message-ID: <xmqqfsf8j5p5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Oct 27, 2022 at 11:09 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
> [...]
>> Wouldn't it be sufficient to update the UI to
>>
>>     git merge-tree [--write-tree] [<options>] [<base-commit>] <branch1> <branch2>
>>     git merge-tree [--trivial-merge] <base-commit> <branch1> <branch2>
>>
>> IOW, when you want to supply the base, you'd be explicit and ask for
>> the new "write-tree" mode, i.e.
>>
>>     $ git merge-tree --write-tree $(git merge-base branch^ branch) HEAD branch
>>
>> would be how you would use merge-tree to cherry-pick the commit at
>> the tip of the branch on top of the current commit.
>
> This was my thought too; but would we be painting ourselves into a
> corner if we ever want to make merge-tree support octopus merges?

True, the above suggestion was especially bad as it would not be
possible to extend to support multiple bases *and* octopus at the
same time.  Consider it scrapped.  Taking zero or more --base-commit
options explicitly from the command line would be a better
interface.

> Also, why did you write $(git merge-base branch^ branch) rather than
> just branch^ ?

Just to be explicit which one is doing what.

> Yeah, I don't think that'd be too hard...if we could rule out ever
> supporting octopus merges in merge-tree (which I'm not so sure is a
> good assumption).  Otherwise, we might need to figure out the
> appropriate backward-compatible input parsing (and output format
> changes?)

I'd prefer an approach to tackle one thing at a time while making
sure we leave the door open for the future ones.  I think the
backend interface from "merge" to external strategies use a
separator to signal the boundary between the heads being merged
(i.e. branchN above) and the bases being used, which is easy to
parse and support multiple bases and octopus at the same time.

As to making it easy to implement "cherry-pick", I do not think you
should dogmatically forbid it on the basis for merge-tree from the
command line is inherently one mergy operation per invocation.  You
will have the --stdin interface, and a way forward may be a notation
to refer to previous results in the --stdin input stream.  That way,
a single invocation of merge-tree "server" can be fed a sequence of
3-way merges that are actually steps of multi-commit cherry-pick,
that merge the differences of multiple commits on top of the
previous result, one step at a time.

IOW, as long as you make sure --stdin interface is rich enough to
allow you do what people would do a sequence of "git merge-tree"
single shot invocations (perhaps even driven by a script), you would
be OK, I would think.

