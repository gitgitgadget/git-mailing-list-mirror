Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B1CC6FA89
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiILUNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 16:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiILUNK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 16:13:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9819A26AEB
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 13:13:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v1so9634129plo.9
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=K0fcOKEIlGFsvCGNiusBMG+p2z6Wgw53g4cp7OaDHNU=;
        b=QyABtmMmpzGOods0vbmFYuQdqyYPkGsajwUDG7125t2hAC8JdMl1N/FsgfElulsCPo
         eRzrmqoa9bCN2zTrz77lV46/gz73KSCPQ+VFrzk0S8gpEb9rp9sTiakNfEar4aWGc1zC
         J8LBn3p+ptBc7502M5kbCPjiqJofYAshnZJMwMR4yIFBI4Ke8850aCubTuS7kvw3yXUx
         aCw/r8frMvQcK3CiGW00WD4DzVHxVRG+LesxURjfxUxAvbu7SxJ3aadluE44xu7vDLuP
         IBZT87lSigFv3TagKHmbHkIEsgvIjGEmJ7SGTcYAm5ScQPMncUzJYyEmBd6tu++ZIw8f
         C9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=K0fcOKEIlGFsvCGNiusBMG+p2z6Wgw53g4cp7OaDHNU=;
        b=uu6Jqh7MHMUVzWDxSumR641UY9ztzf+ey/JhMboicBtELI6+oEXy1EpNXNJ84OoZcW
         nQwpEc6aoqgpZA2TYFuEfE/Dd+eda41wGzE8lChsF5QlV6icraZT6Uw4rDqUtzRnoU9L
         +1Cma47pv1bMAxUAuKyeL/sZ8wq3ymEf3g2MZd+hwY/4TD/pCdKMmyJjZN3F5t9yfzyK
         KjRz+jo4D/+dLECxcNOSvkoIzB/G7GCeAJdKG254AAwFqhg7Es0tzJmjuMqUjrhSKeb4
         z0dNsu+oL345mHVA8CXOx9xnaE243+UmirWJCz7Ym1mpMNZdPs8wP7peCJKg4XzLDEWv
         p1Cg==
X-Gm-Message-State: ACgBeo2tmRnb85EWVUktHJ7f5HJ1MkmbNS92ANhHLxqFNO91cadj39Pg
        zdwynXUbH3szk1YfNG4WxD4=
X-Google-Smtp-Source: AA6agR5ld5ESy9KrMsA1H7cZOJsGkelQxqzjssnYj6ZuuMTpYyoHRVDgmoLrc10QhUyfH1+Ls2NbkQ==
X-Received: by 2002:a17:902:ab94:b0:176:a025:b139 with SMTP id f20-20020a170902ab9400b00176a025b139mr27730544plr.126.1663013587964;
        Mon, 12 Sep 2022 13:13:07 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k12-20020a65434c000000b00438e0db80dasm3588647pgq.65.2022.09.12.13.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 13:13:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] refs: unify parse_worktree_ref() and ref_type()
References: <pull.1325.git.git.1663002096207.gitgitgadget@gmail.com>
        <xmqq1qsge71x.fsf@gitster.g>
Date:   Mon, 12 Sep 2022 13:13:07 -0700
In-Reply-To: <xmqq1qsge71x.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        12 Sep 2022 12:17:30 -0700")
Message-ID: <xmqq35cwcpws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Otherwise we fall through with worktree_ref that we have stripped
> main-worktree/ prefix, which means the original input
>
> 	main-worktree/worktrees/foo/blah
>
> is now 
>
> 	worktrees/foo/blah
>
> and the next skip_prefix() will see that it begins with "worktrees/".
> Of course, if the initial input were
>
> 	worktrees/foo/blah
>
> then we wouldn't have skipped main-worktree/ prefix from it, and go
> to the next skip_prefix().  So from here on, we cannot tell which
> case the original input was.
>
> But that is OK.  Asking "give me the ref 'blah' in the worktree 'foo'"
> in the current worktree should yield the same answer to the question
> "give me the ref 'blah' in the worktree 'foo', as if I asked you to
> do so in the main worktree".

This makes me wonder...

I wonder if it makes the resulting code clearer to go fully
recursive, unlike the posted code that says "if a recursive call
says it is for current, that means it is for main worktree, and
otherwise pretend as if the input did not have the prefix".

That is, something like

parse_worktree_ref(...) {

	... prepare name, name_len and ref ...

	if (skip_prefix(worktree_ref, "main-worktree/", &worktree_ref)) {
		parsed = parse_worktree_ref(worktree_ref, name, name_len, ref);
        	switch (parsed) {
		case REF_WORKTREE_CURRENT:
                case REF_WORKTREE_MAIN:
			return REF_WORKTREE_MAIN;
		case REF_WORKTREE_OTHER:
		case REF_WORKTREE_SHARED:
			return parsed;
		}
	}

	if (skip_prefix(worktree_ref, "worktrees/", &worktree_ref)) {
		slash = strchr(worktree_ref, '/');

		parsed = parse_worktree_ref(slash + 1, name, name_len, ref);
        	switch (parsed) {
		case REF_WORKTREE_CURRENT:
			return WORKTREE_OTHER; /* iffy */
                case REF_WORKTREE_MAIN:
			return REF_WORKTREE_MAIN;
		case REF_WORKTREE_OTHER:
		case REF_WORKTREE_SHARED:
			return parsed;
		}
	}

	/* Otherwise the input is like HEAD, MERGE_HEAD, refs/$BLAH */
	... do whatever for these trivial cases ...

}

And while composing this follow-up, I found another thing that is
iffy.  When you ask for "worktrees/foo/refs/bisect/good", the
recursive call in "worktrees/foo" for the remainder says "current",
and the posted patch and the above pseudocode would take CURRENT to
mean "that other worktree's", and turns it into OTHER i.e. "not
ours".  But the code does so without even checking what our worktree
is called.  What happens if we are the owner of the "worktrees/foo"
namespace?  The same thing for "The main worktree says the given ref
is 'current', so we can turn that into 'main'"---if our worktree is
'main', it is also 'current' and does not have to be turned into
'main' (even though it does not hurt).
