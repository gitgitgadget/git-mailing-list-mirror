Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F32C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbhLFRmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbhLFRmw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 12:42:52 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3581EC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 09:39:23 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 71so11189599pgb.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 09:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2rqM5Q93w8mJEn7ul4XEBcORQO44GAvidzl7mytHCM0=;
        b=k0XUiZhrmGuJqqXG7615sdK1zxTVd3WtzMJnXHuZf9GztP4fM+jf1RHt5vXJWb51HQ
         bR9zTYx1yf3srlaC23EbNoGuC1xyllx26uIfGVecM98XOJzUxbcaz8HtQDIQ9GMFq7qp
         Z8b2WDLVSu9t4RvVKHTjpIaaKofBCVfYMJYweJ8fjVEYQ8XWA8QSApk5r/LIJOTdw/GO
         JS9MsSoJCD2PFokGw7JG9aTCHPK2EfuK78Kbhi/tA/U9UJVcNA5QQn6eoOO3RBAqvWGo
         RHmA+s7YTNE1YCaElORSPO8/OVu6mYGON9xCdosaSIc5M+V/GxagTIdx+2YwG0zrq6Bh
         kkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2rqM5Q93w8mJEn7ul4XEBcORQO44GAvidzl7mytHCM0=;
        b=jCFHU7zn/F4cUlfNfKtuFxbIhx7NPI7xO17p8dyvZ/WBiCuej9tBXbtoNa99LL8bOS
         Cv7gAFzwtGV0SpojOXrOGn3nJ9r8tEAgELSsUuBXpx3y9W5IoQ1xobzSrZNTQL/fzB23
         G5GbLB9r8P6jWPb6KHH3QlfIk9XcmpnGWYf/EQrNSesSyOJDgtKF4E2XGXjDp0CPhN7J
         Y9sDWrb4aN+whE/otOp7C1v0smC8TQvejriBWstJEqIZuv7d+XSOF23hqRH2rXp0R2vq
         KtHUyDuDoEvcVvebhEZaKURLFDFdJwSRuFz7UNxpWEhDY3PVBAnTjYZkdkRc3v6wEl/t
         U+ww==
X-Gm-Message-State: AOAM530dbAdkxhy3YqTuNfQvC4FhKwMGAs9cWqjtXHKvuygi+HX6imQ6
        HrxlHeZJH/DxE9orI8gsL9My6TCpquw=
X-Google-Smtp-Source: ABdhPJzJBPNqbLjtAUngyS26nIEVI60TxUuZETU9hl93Y6P/xMkEvdidT8RIrQZ3Bcb7BaYwnjbqnw==
X-Received: by 2002:a63:5f14:: with SMTP id t20mr11375327pgb.382.1638812362597;
        Mon, 06 Dec 2021 09:39:22 -0800 (PST)
Received: from localhost ([2620:15c:289:200:9206:9546:da97:4e9c])
        by smtp.gmail.com with ESMTPSA id f19sm13162844pfv.76.2021.12.06.09.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:39:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 1/2] tmp-objdir: new API for creating temporary
 writable databases
References: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
        <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com>
        <36c00613d9a6ad4fc768e15b9ec23f9af520338a.1638750965.git.gitgitgadget@gmail.com>
        <xmqq4k7mi3g4.fsf@gitster.g>
        <20211206085300.GA26699@neerajsi-x1.localdomain>
Date:   Mon, 06 Dec 2021 09:39:21 -0800
In-Reply-To: <20211206085300.GA26699@neerajsi-x1.localdomain> (Neeraj Singh's
        message of "Mon, 6 Dec 2021 00:53:00 -0800")
Message-ID: <xmqqr1aphbue.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

>> > +	if (tmp_objdir)
>> > +		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
>> >  	free(path);
>> >  }
>> 
>> This is called during set_git_dir(), which happens fairly early in
>> the set-up sequence.  I wonder if there is a real use case that
>> creates a tmp-objdir that early in the process to require this
>> unapply-reapply sequence.
>> 
>
> The lack of this code was causing a failure, I believe in
> t2107-update-index-basic.sh: "--refresh triggers late setup_work_tree".
>
> This problem came up after applying: https://lore.kernel.org/git/4a40fd4a29a468b9ce320bc7b22f19e5a526fad6.1637020263.git.gitgitgadget@gmail.com/
>
> I thought it would be best to fix this in the tmp-objdir code so that
> callers could plug/unplug bulk checkin without any subtle surprises.

OK, I think that is fine.

As a slightly-related tangent that is outside the topic, I think we
should revisit "update-index", which is one of the oldest plumbing
commands with its own quirks.  I do not offhand see why it needs to
sprinkle this many setup_work_tree() calls everywhere.  Having an
index to work on means we must have a working tree to update and/or
refresh from.  We should be able to get away with the NEED_WORK_TREE
bit in the git.c::commands[] table for this command.  If this were a
more recent command, I may suspect that there were valid reasons
like "in this particular mode, update-index must work inside a bare
repository" to force us to take this unusual program structure, but
because this is probably a lot older than NEED_WORK_TREE bit, I
would not be surprised if the answer were "nobody noticed the
ugliness so far".

> Given that this patch series introduces functions with no users, are you
> going to hold off on putting this into 'next' until another next-worthy
> patch series is ready?

Even without any existing callers, as long as we see Reviewed-by: by
Elijah, who we know will have to build on top of this series, I
think this can and should go to 'next'.

Thanks.

