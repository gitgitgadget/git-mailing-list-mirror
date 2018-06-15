Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F90D1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 19:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966149AbeFOT6o (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 15:58:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36910 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966065AbeFOT6n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 15:58:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id r125-v6so5760097wmg.2
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=scWlmIeZ25mreeUJxZboH8V6oPEhir4dmV7lVj6kZ5s=;
        b=o1GuXHcLiDgTAXTTsdpMm2U7I1L4NNwT24ujpEegc8n7ylrOKx2qQl812jyJWaqGC0
         zIVqa2MR/Dow1Vr2AWPy2LNqcIQxO4C/zfFMNDKpbTwCVFMgzK29mGU9lCmxCXB5m6h1
         Qw2ueL2QDJA9IF52+ryZmfo779/VvHcltilVIETNRMz810pybkHymhJzuHxqBAWJiyJY
         XKt0Ra6Y9QKKXJj1q22NIwICJPa0okAsgKi1TYAAdZVNJkQQZ5Cq5jz0kcr4cdTb6xWO
         3VGO1hfJaTR/UB2VaWy0JzPsY9R9SloKxy5TyXl2AjusWJiMQYRaJabB8bFwdRD4aKDO
         DtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=scWlmIeZ25mreeUJxZboH8V6oPEhir4dmV7lVj6kZ5s=;
        b=DaTdSPtXLagvreA0Cstmv3ZUpNaxXoL6maZ1aio7y96iJg81/e9Mko37GKCSwWJUPR
         CgAezr6zlYqF3sU7NoWADKmaWWAf/E4hLp0Egr7Fgwqol+sGPuNS0iLVIb6TPs9kN6tw
         OA26J9A+9DEa5gjK2zmTRIYvX0J2YzzeWh+7eHsq9V7zrn8AFks/hSUD4/34gkjAvFDt
         OxsqzCcpVJUsltI0EHIFzMhi2eodwVqxLHvnehV9M0X+tVB3MFtT/60mOFTqRS5g9n66
         qzVXivs6G1qai0O63mTrU5M9Z+znPfgFT2S97rDZALUpSIbhYaKYobRa1ASkBGXA6ovV
         dpeA==
X-Gm-Message-State: APt69E35ZarBqA55wDir2PbaVQUZZLWD9pVpyr9TgRTpuo5lzyOOLvsL
        ynlullxL8ZJ7oGfHT2B7dQQ=
X-Google-Smtp-Source: ADUXVKIqzv3kxYBJ4ZnikKWCeDH8uTy8iFCvSjYcEy+Yt4K4Xk+W/K+EwcIhMIXkcwkTGBzrs+FR1A==
X-Received: by 2002:a1c:954d:: with SMTP id x74-v6mr2288944wmd.57.1529092722138;
        Fri, 15 Jun 2018 12:58:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u4-v6sm1734953wmc.1.2018.06.15.12.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 12:58:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] unpack-trees: do not fail reset because of unmerged skipped entry
References: <20180615044251.10597-1-max@max630.net>
Date:   Fri, 15 Jun 2018 12:58:40 -0700
In-Reply-To: <20180615044251.10597-1-max@max630.net> (Max Kirillov's message
        of "Fri, 15 Jun 2018 07:42:51 +0300")
Message-ID: <xmqqh8m3zurz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> After modify/delete merge conflict happens in a file skipped by sparse
> checkout, "git reset --merge", which implements the "--abort" actions, and
> "git reset --hard" fail with message "Entry * not uptodate. Cannot update
> sparse checkout." The reason is that the entry is verified in
> apply_sparse_checkout() for being up-to-date even when it has a conflict.
> Checking conflicted entry for being up-to-date is not performed in other
> cases. One obvious reason to not check it is that it is already modified
> by inserting conflict marks.
>
> Fix by not checking conflicted entries before performing reset.
> Also, add test case which verifies the issue is fixed.

I do not know offhand if "reset --merge" should force succeeding in
such a case, but I agree that it is criminal to stop "reset --hard"
with "not uptodate", as the whole point of "hard reset" is to get
rid of the 'not up-to-date' modification.

I guess not may people make serious use of sparsely checked-out
working tree and that is why such a failure is reported this late
after the feature was introduced?

> +test_expect_success 'reset --hard works after the conflict' '
> +	git reset --hard
> +'

Do we want to verify the state after the 'hard' reset succeeds as
well?  Things like 

 - all paths in the HEAD and all paths in the index are identical;

 - paths that do exist in the working tree are all identical to HEAD
   version; and

 - paths that do not exist in the working tree are missing due to
   the sparse checkout setting (iow, it is a bug if a path that is
   outside the "sparse" setting is missing from the working tree).

> +test_expect_success 'setup: conflict back' '
> +	! git merge theirs
> +'
> +
> +test_expect_success 'Merge abort works after the conflict' '
> +	git merge --abort
> +'

Likewise here.


> +test_done
> diff --git a/unpack-trees.c b/unpack-trees.c
> index e73745051e..65ae0721a6 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -468,7 +468,7 @@ static int apply_sparse_checkout(struct index_state *istate,
>  		 * also stat info may have lost after merged_entry() so calling
>  		 * verify_uptodate() again may fail
>  		 */
> -		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
> +		if (!(ce->ce_flags & CE_UPDATE) && !(ce->ce_flags & CE_CONFLICTED) && verify_uptodate_sparse(ce, o))
>  			return -1;
>  		ce->ce_flags |= CE_WT_REMOVE;
>  		ce->ce_flags &= ~CE_UPDATE;

Thanks.
