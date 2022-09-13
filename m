Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF0C54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 16:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIMQvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 12:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIMQu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 12:50:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0008585FDC
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 08:44:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso1555381pjq.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=2UxmIZ6akVjNZdYqY07OpiQMm42SVJMD/REH8+X250M=;
        b=d4Qsd2fm0WxrAa8dtRyhmutGs3PFDxtQN26B+e+fjmzoGQIL1ZdmMZF6q7fh2N/R/t
         xCaAAbjzadA4O9bX+iUHdPJElNekkiuNhx2GiD2SkWmErvw7w4feja8tIgrTVw8vdpj1
         qAgWW3kigyGxKrCX9fhScs7bZDaKQqqc3CzbH34kNGNZEiQogaSPq9aqKDQEyoV116+/
         YDvfDbgFomW4KCoM4brAu6RXtXAmOly6u1vauAp54d0uz9JkBFIw8EiMN981u5PJoL5s
         yIvsXAh5Pj84Cd+pYMBfCAabFtfUNlyhr8o3LgHC8CORY5A+gLaF28wUSL8fJXtMOAIE
         DVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=2UxmIZ6akVjNZdYqY07OpiQMm42SVJMD/REH8+X250M=;
        b=4ZCyumDe5LK/k1tLBenRrbRs+/SVDzIkEx/9UaDDvduieR5HiM5JEDGT0l0ZODJpIw
         xyuol+S7B/SpfEWVFYD1HrB4sDBdMnLNCa5nhLWCOjwlyVAe+xwMduAwVoHW7GSzYSt9
         /1SHrOomlVq4DKawPZsL6+LmLaAsD3kjEb/EsDvB28G68gTLcG8o/qPfiMpSL/MGtU9l
         JBvpo1WwnDmo+IVKm5XP3vR4mzbWxCaFAv6aJgUS3ahek78p/+CR94cY4dmz5gtfquzc
         gF4/tjIpF5ntkBk9ARLzoiM1L1YKra9FVjPp7FeLcOFMTuAE+/lqCMdrvO30vWzMOceY
         27WA==
X-Gm-Message-State: ACgBeo05PHp/AZKOvLPfrhBQ8CK0cN8jf/PZPWAMJx8Y5/NOJFRWowWf
        8KydDWL90UPppHmrL4mH3dg=
X-Google-Smtp-Source: AA6agR7SAVL3b0wkNlQy/xWfqbFAT3e1j59AT2VIt6ATY4auzjebiOzzmXGAiPMMLXTO3q4zvUkOpg==
X-Received: by 2002:a17:90a:3806:b0:202:880e:81d with SMTP id w6-20020a17090a380600b00202880e081dmr4546100pjb.161.1663083789048;
        Tue, 13 Sep 2022 08:43:09 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a1f4300b001f262f6f717sm7473669pjy.3.2022.09.13.08.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:43:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] refs: unify parse_worktree_ref() and ref_type()
References: <pull.1325.git.git.1663002096207.gitgitgadget@gmail.com>
        <xmqq1qsge71x.fsf@gitster.g> <xmqq35cwcpws.fsf@gitster.g>
Date:   Tue, 13 Sep 2022 08:43:07 -0700
In-Reply-To: <xmqq35cwcpws.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        12 Sep 2022 13:13:07 -0700")
Message-ID: <xmqqillrb7qs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Otherwise we fall through with worktree_ref that we have stripped
>> main-worktree/ prefix, which means the original input
>>
>> 	main-worktree/worktrees/foo/blah
>>
>> is now 
>>
>> 	worktrees/foo/blah
>>
>> and the next skip_prefix() will see that it begins with "worktrees/".
>> Of course, if the initial input were
>>
>> 	worktrees/foo/blah
>>
>> then we wouldn't have skipped main-worktree/ prefix from it, and go
>> to the next skip_prefix().  So from here on, we cannot tell which
>> case the original input was.
>>
>> But that is OK.  Asking "give me the ref 'blah' in the worktree 'foo'"
>> in the current worktree should yield the same answer to the question
>> "give me the ref 'blah' in the worktree 'foo', as if I asked you to
>> do so in the main worktree".
>
> This makes me wonder...
>
> I wonder if it makes the resulting code clearer to go fully
> recursive, unlike the posted code that says "if a recursive call
> says it is for current, that means it is for main worktree, and
> otherwise pretend as if the input did not have the prefix".
>
> That is, something like
> ...

The above may be a wrong suggestion, as it was solely guided by my
reading of the posted code that looked as if it wanted to support
something like "main-worktree/worktrees/foo/refs/heads/main".  If
that wasn't the intention, and we only want to support

  1. a ref spelled in the traditional way before multiple worktree feature,
  2. 1., with "main-worktree/" prefixed, or
  3. 1., with "worktrees/<worktreename>/" prefixed

then a better approach would be to have a small helper
parse_local_worktree_ref() and make the primary one into something
like

parse_worktree_ref()
{
        if (begins with "main-worktree/") {	
		strip main-worktree/ prefix;
		switch (parse_local_worktree_ref(input minus prefix)) {
		... the same switch to turn "ours" into "main's" ...
		... but we probably want to special case if we are ...
		... the main worktree ...
		}
	}
	else if (begins with "worktrees/") {
		strip worktrees/ prefix and learn worktree name;
		switch (parse_local_worktree_ref(input minus prefix)) {
		... the same switch to turn "ours" into "theirs" ...
		... but we probably want to special case if we are ...
		... the worktree in question ...
		}
	}
	return parse_local_worktree_ref(input);
}

and have parse_local_worktree_ref() handle psuedorefs,
per-worktree-refs.
