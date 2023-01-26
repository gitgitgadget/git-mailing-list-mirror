Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766C7C27C76
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 02:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjAZCS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 21:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAZCS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 21:18:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C0536452
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 18:18:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j17so270853wms.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 18:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9QBjLD47R1Ih7yIAV4DgUA9VqupoB6W/cIytCRUG5E=;
        b=Geo59Luxx4UUX3O5xLZJbL1REoqyxDSnrb0DQJ7y5ORYYJX5yF71gjZSyD1RCfeRY9
         IFVYQOufqXFe//1BmkQQBhQir8mM25jWcFq9/bAW943eU5TuhEoVqjZ4gGx/JKW68JX9
         N0x9K/G1K88YG+FB5K501CnsY/STGtUejHd4OBdWWGCScozdMNClJxgPM6SbyrM0fLPD
         iL35f0s8cRzHqeeEGiDEj+qoJKWjfaSFN44nsaqWV7x2BtSblbQWjTtKNzZWfvWD/+TY
         ttfkUGsqgni35+uVn/vcmUpZk9LT+DsGkRRmiy1P6tTPCVccpxyfKzs1MLDocHa7Ee0a
         O2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9QBjLD47R1Ih7yIAV4DgUA9VqupoB6W/cIytCRUG5E=;
        b=B2/xVjJ4TeeEF367qH6y/teysEDG45+1CYgrgmam/+QiDzJHDZTylVdKVpSN2peAAw
         lmfI/zgG4Icl04JyADGssVrFfcY+Tbf6rht8yvtTDBw+GCqdGl41NItUL3O9NuZeW4fP
         7yDUX559VhwjChDf+Y2AIcqVA5d1BSIlVLq6/rkIPpA6xQOfqiB9EU4mJNyLBMM+3Od8
         FM0dLCNdUFIPBV+rBGH8uO56MaZTFqm2ugK9qPq7Lxa189nVX2Kvqbq3PVr+lsAF5jQe
         JTu+DlAb39joz/H1MToPPTaabqN7p2/p4mjVOoRaYFv/18wI+Dvn26ago/iuI1XSYM57
         nOgg==
X-Gm-Message-State: AFqh2kowf6beeLRVqUihdctEVoUctw8yMJ8FtRFVDKnx6d+YriNWsogw
        6+/c5Be424L7SFOkDIb65kA=
X-Google-Smtp-Source: AMrXdXsOb12BfcBuDFpQo83a+AYUgTs342NnIT4h80DgDT4VdQPfru3Tgj1OeztKHEr7yOBsBdXPLA==
X-Received: by 2002:a05:600c:4256:b0:3da:2a78:d7a3 with SMTP id r22-20020a05600c425600b003da2a78d7a3mr32206796wmm.33.1674699504673;
        Wed, 25 Jan 2023 18:18:24 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id c3-20020a1c3503000000b003dc1d668866sm3054976wma.10.2023.01.25.18.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 18:18:24 -0800 (PST)
Subject: Re: [PATCH] bisect: fix "reset" when branch is checked out elsewhere
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
 <xmqqo7qqovp1.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <0d04f8ed-6933-9354-1f64-24d827424c71@gmail.com>
Date:   Thu, 26 Jan 2023 03:18:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqo7qqovp1.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22-ene-2023 18:01:46, Junio C Hamano wrote:

> Rubén Justo <rjusto@gmail.com> writes:
> 
> > Since 1d0fa89 (checkout: add --ignore-other-wortrees, 2015-01-03) we
> > have a safety valve in checkout/switch to prevent the same branch from
> > being checked out simultaneously in multiple worktrees.
> >
> > If a branch is bisected in a worktree while also being checked out in
> > another worktree; when the bisection is finished, checking out the
> > branch back in the current worktree may fail.
> 
> True.  But we should explain why failing is a bad thing here.  After
> all, "git checkout foo" to check out a branch 'foo' that is being
> used in a different worktree linked to the same repository fails,
> and that is a GOOD thing.  Is the logic behind your "may fail and
> that is a bad thing" something like this?
> 
>     When "git bisect reset" goes back to the branch, it used to error
>     out if the same branch is checked out in a different worktree.
>     Since this can happen only after the end-user deliberately checked
>     out the branch twice, erroring out does not contribute to any
>     safety.
> 
> Having said that...
> 
> > @@ -245,7 +245,8 @@ static int bisect_reset(const char *commit)
> >  		struct child_process cmd = CHILD_PROCESS_INIT;
> >  
> >  		cmd.git_cmd = 1;
> > -		strvec_pushl(&cmd.args, "checkout", branch.buf, "--", NULL);
> > +		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees",
> > +				branch.buf, "--", NULL);
> 
> "git bisect reset" does take an arbitrary commit or branch name,
> which may not be the original branch the user was on.  If the
> user did not have any branch checked out twice, can they do
> something like
> 
>     $ git checkout foo
>     $ git bisect start HEAD HEAD~20
>     ... bisect session finds the first bad commit ...
>     $ git bisect reset bar
> 
> where 'foo' is checked out only in this worktree?  What happens if
> 'bar' has been checked out in a different worktree linked to the
> same repository while this bisect was going on?  The current code
> may fail due to the safety "checkout" has, but isn't that exactly
> what we want?  I.e. prevent 'bar' from being checked out twice by
> mistake?  Giving 'bar' on the command line of "bisect reset" is
> likely because the user wants to start working on that branch,
> without necessarily knowing that they already have a worktree that
> checked out the branch elsewhere---in other words, isn't that a lazy
> folks' shorthand for "git bisect reset && git checkout bar"?
> 
> If we loosen the safety only when bisect_reset() receives NULL to
> its commit parameter, i.e. we are going back to the original branch,
> the damage might be limited to narrower use cases, but I still am
> not sure if the loosening is worth it.
> 
> IIUC, the scenario that may be helped would go like this:
> 
>     ... another worktree has 'foo' checked out ...
>     $ git checkout --ignore-other-worktrees foo
>     $ git bisect start HEAD HEAD~20
>     ... bisect session finds the first bad commit ...
>     $ git bisect reset
> 
> The last step wants to go back to 'foo', and it may be more
> convenient if it did not fail to go back to the risky state the user
> originally created.  But doesn't the error message already tell us
> how to go back after this step refuses to recreate such a risky
> state?  It sugests "git bisect reset <commit>" to switch to a
> detached HEAD, so presumably, after seeing the above fail and
> reading the error message, the user could do
> 
>     $ git bisect reset foo^{commit}
> 
> to finish the bisect session and detach the head at 'foo', and then
> the "usual" mantra to recreate the risky state that 'foo' is checked
> out twice can be done, i.e.
> 
>     $ git checkout --ignore-other-worktrees foo
> 
> So, I am not sure if this is a good idea in general.
> 
> Or do I misunderstand why you think "checking out may fail" is a bad
> thing?

Maybe we make it fail for no reason.  Thank you for thinking about this with
depth.

I know you are aware, but for other readers;  In another thread, a bug-fix is
being reviewed that, if accepted, will affect "bisect".  With that fix, the
phrase "checking out may fail" will become "checking out will fail".  But does
it need to fail?

As you said, we want to reject normal check outs of a branch when that
branch is already checked out in other worktrees.  Because of this, sounds
reasonable to leave the implicit 'checkout' in 'bisect reset' to fail in those
cases, and just add some tests to notice if this changes in the future.

But, and this is what makes me think that "checking out will fail" is the wrong
choice for "bisect", while bisecting, with the worktree in a detached HEAD
state, the branch to which "bisect reset" will check out back (BISECT_START),
is still considered checked out in the working tree:

	$ git checkout -b work
	$ git bisect start HEAD HEAD~3
	... bisect detaches the current worktree ...
	$ git worktree add work
	Preparing worktree (checkout out 'work')
	fatal: 'work' is already checked out at ...

So, checking out back to the implicitly checked out branch sounds like it
should not fail.  And should be pretty secure (under the risk accepted by the
user) because we do not allow to normally check out the branch in another
worktree.  We even reject the checkout in the current worktree while bisecting,
but let's leave that for another time.

Note that due to the bug, what we are changing here is the reset on "second
worktrees".  That means, "bisect reset" on the main worktree has been allowed
for some time, we are just making it official.

And this is the less disrupting change in the usage.  Which does not justify
the change but does support it.

This is the reasoning I had and what makes me think that "checking out may
fail" is an inconvenience for the user, without any gain.

Now, if these arguments are reasonable, the next issue is what and how to
allow.  I chose at least strict, but maybe we can do something more
elaborate... just NULL sounds good.
