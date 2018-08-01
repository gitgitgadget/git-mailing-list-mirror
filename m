Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4C21F597
	for <e@80x24.org>; Wed,  1 Aug 2018 00:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbeHACPd (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 22:15:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36677 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732804AbeHACPd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 22:15:33 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so3547678wmc.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 17:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=za9/88p8O0EcTR65zdMl/4kHkNTyG2Bh1u5/SJkrFcQ=;
        b=aAocvOmSTgDVoZ8mLgEwMAn3ncSYxebmFB2CwJWj9txOJ0052qiCojd4zKxAb0iWup
         APvXE2F3le3sdwfaqAM+sYJeFRk6KHWBzO0b8kmzgDhStrG2Kb5pGoLVsyymIwZp8g17
         6j7Mkp9jJlQCVgtck73w5FNP3rjOKAzkWxTU44+A7iwdTpbbldzJ4DKhUoWd+hZq2Gd1
         hjktSRUtILSlyW28IZN9qdHKcvhDY2bqvCUXe+4c9r7y9gl7zoiIKutPERKA7jHNsIZr
         gP7ZcRZV3s3n+d9PskwtM4+OSqN0bJ0hEjSD2lU2K7c+BMtswp4742i1EODn+qaGb9qC
         YUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=za9/88p8O0EcTR65zdMl/4kHkNTyG2Bh1u5/SJkrFcQ=;
        b=F13Y28JjGa6va9O5RrtLH4fwOyEuzuwiPjHox/XXiDH9Dyhcg7IupUNWua7KFKlTv2
         lrmeeCRhpghfA0pqAOlqEfa1c7XNCrrQJ7J3SOXONxRzarEnBKRtU3BwSonGnR4UX3Gh
         s8Q6YlfuyLfW5dhptgtfDTl7ro5SWIpqQurqtuxX0MiQ0Bynj4Pjiop6d2TilTcFdTcq
         hz+R7KF47y3173njNJmgylNct9k870p+ZP9ydak58Rm8KtKDLy9RpBm/ynrvpvyKXQlC
         w2vgyrYnfqXYFCV49pxhFQaXIqqHEh8KS49DMFEXxmUKMS2oFxQmqt1kKPqprRbIQQ8W
         IaWQ==
X-Gm-Message-State: AOUpUlFmuZ02AEXvdlcHCI1lFWbWwyHwDYDlRflPuPuNVasu2U96iixl
        sNNtpxusclr151JQ3EUgY2PMYhKC
X-Google-Smtp-Source: AAOMgpfjo5EzviwwN2gglVnQZBtoFpg3DRJPM8Dq4Sba1PvsaQUEw1zWM8RmW4ErR8OTdtrz7rFOow==
X-Received: by 2002:a1c:168a:: with SMTP id 132-v6mr1232959wmw.13.1533083560426;
        Tue, 31 Jul 2018 17:32:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v14-v6sm2309587wmh.41.2018.07.31.17.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 17:32:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote: prefer exact matches when using refspecs
References: <xmqq1sbj9h08.fsf@gitster-ct.c.googlers.com>
        <20180731233332.187328-1-jonathantanmy@google.com>
Date:   Tue, 31 Jul 2018 17:32:39 -0700
In-Reply-To: <20180731233332.187328-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 31 Jul 2018 16:33:32 -0700")
Message-ID: <xmqqr2jj7wpk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This looks good to me. I've checked that refname_match (and
> branch_merge_matches(), which returns the result of refname_match()
> directly) is only used in "if" contexts, so making it return a value
> other than 1 is fine.

Yes, the log message should say that existing callers only care if
the returned value is 0 or not (i.e. if we have any match).

> I would initialize best_score to INT_MAX to avoid needing the
> "best_score < 0" comparison, but don't feel strongly about it.

If we want to lose that "have we seen any possible result?" check, I
think defining (ARRAY_SIZE(ref_rev_parse_rules) - p) as the score,
so that the "full path" gets score 6 (or whatever) and "some remote
tracking name" (like "origin->refs/remotes/origin/HEAD") gets score
of 1 (smallest but true) may make more sense.  Then, start the best
score at 0 and every time we get a score strictly better than the
best so far, we overwrite the best.  That way, we can even lose the
"did we get any positive score?" check, too, and making the
condition in the inner loop quite simple, i.e.

	int best_score = 0;
	...
	for (ref = refs; ref; ref = ref->next) {
		int score = refname_match(name, ref->name);

		if (best_score < score) {
			best_match = ref;
			best_score = score;
		}
	}

We need a commit log message (hopefully we can lift most parts from
your patch in this thread) and a test update to ensure that the same
precedence order used as ref resolution (i.e. tags get higher prio
over branches, etc.) in addition to the test you had in your patch.

Thanks.
