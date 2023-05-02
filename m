Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B2FC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 16:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjEBQud (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjEBQu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 12:50:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D5F1FFF
        for <git@vger.kernel.org>; Tue,  2 May 2023 09:50:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5286344e1d4so3681274a12.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683046226; x=1685638226;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2w4eav7oqAY+vhrqiNRt++j63AOxfyHWnkCyWRc3nUM=;
        b=ndII+ybQdDA5W2UrjJgL6iI7+/bRE8pI2OH3K9OAXeDZO4YKR/a417iGaIOuplZt3/
         mXxMmwzkRaxtOe2Fmnqulmad7FBGYmiQJ72mN8zPE65nmdiWlRTTS59kclrrlmp4NPO6
         xgFiLyajt9yEP14kIttJub5RQ9CIjWf+mpVBMlHG5smCxT8PnHluGt8P6I5PF3kOjq4H
         5ij1m7WmeaVBtEJd2bHnO1TsDAjyCgN0iBnEQvBSiINhXwO5YQnxjCH9zd5okEnM4haf
         W7ZQSbPT5fNLJkaWXliMxkDRKXEtcsnzDntwn9V0F2tukt8DMhKYPyG1rvK++qLpzfKg
         KPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683046226; x=1685638226;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2w4eav7oqAY+vhrqiNRt++j63AOxfyHWnkCyWRc3nUM=;
        b=eav5rB2U6SJVMON8gCD5FEcDdcV/UQ+rOf/XNyidMZC+3BF7DuSIDeDQBkivyWtGvS
         aBsKeNEAco4QX+WdyRuPQpZ5dOwH33AJS1IfTMbWiW00s6sSF1aXcJhCaE2Yf0MhBI3P
         /OGa0hSyLHuuz9xlg2UeFl/MDd1fKjuyPHbz7kXDCir1akTqkmNqMxN4VNdCSeEA8M52
         Fw0L+cXB+Ka1Oq4P7ZJyZF+gHU+ZlYxzr+DwYZv/2C6qgyFBa9gLeCItDpWCBEbwZH1p
         b3SyJQY9EZH60lYMYeQH61KZEEeYsNiiH+TdKUN6Z660HDpKseUPDBM9JD8kqCC7zvTi
         OHlg==
X-Gm-Message-State: AC+VfDxL9o6JCICRTjWCPnq0HyHkqBQ3E7SrC7jeI6G4LkT8ArK/Oh2X
        WoIMyeer0jlGzl2HWsSEM88=
X-Google-Smtp-Source: ACHHUZ4/6EvSCZ5UNzizVM2BAUYEzFbmkJDPvYr1mjCbEcVLleQXtZvDmGmSj9ufDu65KqjwFGg5Ag==
X-Received: by 2002:a17:903:18b:b0:1a5:167f:620f with SMTP id z11-20020a170903018b00b001a5167f620fmr17614386plg.15.1683046226087;
        Tue, 02 May 2023 09:50:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902740c00b001aaf6353736sm4007491pll.80.2023.05.02.09.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:50:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
        <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
Date:   Tue, 02 May 2023 09:50:25 -0700
Message-ID: <xmqq1qjy1xv2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> By the way, it was a problem that git-checkout wasn't updated to have
> the same safety that git-switch has.  We should fix that.  (It's on my
> todo list, along with adding other
> prevent-erroneous-command-while-in-middle-of-other-operation cases.)

Yes.

> I'm worried this is likely to lead us into confusing UI mismatches,
> and makes it harder to understand the appropriate rules of what can
> and cannot be done.  A very simple "no switching branches in the
> middle of operations" is a very simple rule, and saves users from lots
> of headaches.
>
> Granted, expert users may understand that with the commit being the
> same, there is no issue.  But expert users can use `git update-ref` to
> tweak HEAD, or edit .git/HEAD directly, and accept the consequences.
> Why do we need to confuse the UI for the sake of expert users who
> already have an escape hatch?
>
> More importantly, though...
>
>> Change the behavior of "git switch" and "git checkout" to no longer delete
>> merge metadata, nor prohibit the switch, if a merge is in progress and the
>> commit being switched to is the same commit the HEAD was previously set to.
>
> Even if there are conflicts?  For rebases, cherry-picks, ams, and
> reverts too?  (Does allowing this during rebases and whatnot mean that
> --abort becomes really funny?  Does it mean that some commits are
> applied to one branch, and all commits are applied to another?  What
> about autostashes?  Does it interact weirdly with --update-refs?
> etc.)
>
> I think this change is premature unless it discusses all these cases,

It is pretty much what I wanted to say about why we haven't done
this in <https://lore.kernel.org/git/xmqqpm7k6ojz.fsf@gitster.g/>,
so it makes two of us ;-).  I didn't look at Tao's RFC patch but if
the way it determines "we are in a middle of conflicted merge and
we'll allow switching to the same commit only in this case" were
"the index has an unmerged entry", then it is an overly broad test
and the consequences of allowing the switch for these other merge-y
operations that are ongoing must be evaluated.

Thanks.
