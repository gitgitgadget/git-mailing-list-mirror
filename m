Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4BC1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 20:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeGCUHi (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 16:07:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38772 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeGCUFo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 16:05:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so3478726wmf.3
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=U/9yE0xJs8Rirm8aeH6i54Ipyh2R8Hk5lJQSN1hOcPU=;
        b=nVMqCIywoJ9ROjkMCbG9xYcZCKLpz6swVb6r3/rdyQYQC+Z/SjuRLFLj1FPmmb2+ph
         ibCFhTKy4UFpMk3yQsXQM+MA8511XxQcyRmHYvrJXYZtFsywT+zC11I/y+5bzemIRh54
         YYPgOM9EHMDy5oamK59RZNzGQ/jsTR2VRVXmwguTUXtN/QuUgNzo8dptMf1zbTOyjVDj
         15ohSxWtLcP8CHQdIyOzBp44okNSCUwRvQaTcxSXQ7LYuedxWyhMlw4NofbRGQ17KAF4
         xel6M1dhUMD+mArq4jm+rpq8iNVZLTn5/K2JdfBW8DeB6wFclTL6anhneVwixuA6fusA
         4CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=U/9yE0xJs8Rirm8aeH6i54Ipyh2R8Hk5lJQSN1hOcPU=;
        b=tv6k7YPY9fEfwNU45x/5NaHmRRo2mTuusyWsrYCQ3UGh/UwnIfIUM4sA8ejrPfeN1u
         06ghXK/OgE+Ct3JqPW87lfH1kxWgZXNzlkrL0iI8MXhPDwosce3kux+75X9UC2Ljghqo
         PKFLzoyv2u1pA2scpaW+hJBlgsscQ6wdUXaBeD6CwrJa/kEgdCs6gRZrwc+4YQpFNiPb
         f+CXhz4NHwO71YC9L2xCT0EpPYPKcmr/pzfOrwajYwuVsoJB7ovpnQjSAyzRhxOCk0Va
         K38ngCGpCktTPL2PygoE4lWi1iETncZfRoAZ9uuUdY1tpmPEm7A+pWJ4XorxTYvmE3wY
         5iqA==
X-Gm-Message-State: APt69E2WSPwFmeQ3W/3jbtVeuwLL1l8hbXYOf8SMsgSoENYfunQAQAc6
        tt3As0Ppc0sHR4KnQsdHEBUouIzt
X-Google-Smtp-Source: AAOMgpfF6FO61D/0RFy3g9y4FiwFVsErYndisAiaMfXHdlw8DWMa03Y4IafS2NQgrHzJUzYvQsB0IA==
X-Received: by 2002:a1c:8952:: with SMTP id l79-v6mr9322088wmd.7.1530648342668;
        Tue, 03 Jul 2018 13:05:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 189-v6sm4583938wmy.25.2018.07.03.13.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 13:05:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2 8/9] merge-recursive: enforce rule that index matches head before merging
References: <20180603065810.23841-1-newren@gmail.com>
        <20180701012503.14382-1-newren@gmail.com>
        <20180701012503.14382-9-newren@gmail.com>
Date:   Tue, 03 Jul 2018 13:05:41 -0700
In-Reply-To: <20180701012503.14382-9-newren@gmail.com> (Elijah Newren's
        message of "Sat, 30 Jun 2018 18:25:02 -0700")
Message-ID: <xmqqwoucozje.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>     ...[merge will] abort if there are any changes registered in the index
>     relative to the `HEAD` commit.  (One exception is when the changed index
>     entries are in the state that would result from the merge already.)
>
> While this high-level description does describe conditions under which it
> would be safe to allow the index to diverge from HEAD, it does not match
> what is actually implemented.  In particular, unpack-trees.c has no
> knowledge of renames, and these two exceptions were written assuming that
> no renames take place.

I think the above analysis is quite correct (I even suspect that the
rule was outlined long before any renaming merge was designed).

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 855ca39ca..8f7a8e828 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3257,6 +3257,13 @@ int merge_trees(struct merge_options *o,
>  		struct tree **result)
>  {
>  	int code, clean;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (!o->call_depth && index_has_changes(&the_index, head, &sb)) {
> +		err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> +		    sb.buf);
> +		return -1;
> +	}

This change to ensure the index is pristine upfront makes sense,
too.
