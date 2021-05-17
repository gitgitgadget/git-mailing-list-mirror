Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2C3C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 21:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DEF61244
	for <git@archiver.kernel.org>; Mon, 17 May 2021 21:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbhEQVBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 17:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244669AbhEQVBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 17:01:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5059C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 14:00:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w4so8906372ljw.9
        for <git@vger.kernel.org>; Mon, 17 May 2021 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oGVT/8g2oSLlTWeTWM5bGoQRLsPe9Q/ETtV2FG+bOqg=;
        b=cKNHN2qTmUyk0vwJgieYwruMBeCzeXVaHzV54Ld7q2F0xM80MSFAwpPPoSdleDFycU
         2nwhEmzIYLtrBH/PZmx3V7GFeZpU0Q7e3sOjaQ6LWEz5wYcpVpDddQED36Aj9h3mcGV7
         /XYRHyV/PQ2icgeoMr+nhkPDnI5QKb53pQKy6hLg2YLaZU402Xcfh0VrTu8LYXrHdWYP
         yN7xBOeJAYQlCI6uB6rYQt0xfjSnZ+RSjRKgeVEJlAuIJ/byTLmu36CQA7y6NtpBKc+r
         zP5cvfiU2Xiy7hByPEsGg0j9b0YFkaqwL9ZXKKwjimpkF78bRSY4V74fARJnLewPiTpT
         Ikrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=oGVT/8g2oSLlTWeTWM5bGoQRLsPe9Q/ETtV2FG+bOqg=;
        b=Hiv2zeeUDukGFvwHGhc23n7T0lV8FJTFwo+/Y3TAcRxlIOJyzaATCWAKKajCPPfec3
         3m31Oc9SR0n/zK6mY9AlabEmEfJJTRhM8TwTaA1kLyHfYgOX6N9O8uwTPWJcKXLzRVmX
         o8c7xIzxDK2tTyuqRD6AZMumG3yqdzcG+LEW1ih9Dj1KXflZwPAWgFb4Ayd5J/U3CFk8
         ZVlRBXnXXy8vWUBR+WmCZ/lrFku8/oCKgrX1rY4SX87Tjweb2wSxhaZ/E2R6qioy5omy
         dr3IKRDR6DSh2a6kgkzLfpE7CRh3vrdPacaFohf8rjsQ5qv38v2p1DJqtBKLU0/z774T
         WSlQ==
X-Gm-Message-State: AOAM533eNFJSJdTyKoxClNQxEe/JHGYbD63VJE7NmDzpSAbTmPcwByX1
        cvYG8FVhIjwN7nRX9AQsjrCayrla2A8=
X-Google-Smtp-Source: ABdhPJxbJ6l1nEwuhzRlqxgqUlTts1S/RYb9wWzk2FVitkF5ENdwt7rKuH4zBQEWiQ2CTb3siNj8QA==
X-Received: by 2002:a2e:a550:: with SMTP id e16mr1010476ljn.136.1621285216886;
        Mon, 17 May 2021 14:00:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l6sm632115lfk.49.2021.05.17.14.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 14:00:16 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 5/9] diff-merges: move specific diff-index "-m"
 handling to diff-index
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210517155818.32224-1-sorganov@gmail.com>
        <20210517155818.32224-6-sorganov@gmail.com>
        <xmqqv97h5ckn.fsf@gitster.g>
Date:   Tue, 18 May 2021 00:00:15 +0300
In-Reply-To: <xmqqv97h5ckn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        18 May 2021 05:29:12 +0900")
Message-ID: <87cztpyt28.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Move specific handling of "-m" for diff-index to diff-index.c, so
>> diff-merges is left to handle only diff for merges options.
>>
>> Being a better design by itself, this is especially essential in
>> preparation for letting -m imply -p, as "diff-index -m" obviously
>> should not imply -p, as it's entirely unrelated.
>>
>> To handle this, in addition to moving specific diff-index "-m" code
>> out of diff-merges, we introduce new
>>
>>   diff_merges_suppress_options_parsing()
>>
>> and call it before generic options processing in cmd_diff_index().
>
> This change has a small but obvious fallout.
>
>     $ git diff-index -c --cached HEAD^
>
> now starts failing loudly.  Earlier, it silently fell back to
> "combined" diff of one parent, which is "-p".
>
> I think the end result is good (and luckily, "DIFF FORMAT FOR
> MERGES" section explicitly limits "-c" and "--cc" to diff-tree,
> diff-files and diff (and by implication excludes diff-index) so I am
> sure there are small but non-zero number of people somewhere in the
> world who has "diff-index -c" in their scripts that suddenly starts
> failing with the version of Git with this change, but we can just
> say their use was broken ;-)
>
> Having said all that, I have to wonder if it still is needed to keep
> the "diff-index -m" working, or we would be better off breaking it
> to avoid a change like this that makes us bend over backwards to
> work around the command line parsing infrastructure.
>
> The only reason why "diff-index -m" exists is because it was part of
> the idea Linus had for the merge implementation that we ended up
> deciding not taking, where merges and possibly other bulk operations
> that would affect the working tree is done in a separate, temporary
> directory that is sparsely populated, the user is asked to edit away
> conflicts in the temporary directory and expected to monitor his or
> her own progress using "diff-index -m".  Our plan was to populate
> such a temporary directory with only paths that are involved in the
> operation in progress, without instantiating paths that are not
> touched, so "treat missing files as if they haven't been modified"
> was a handy ingredient for such a mode of operation.
>
> But we ended up going with a different design, in which the main
> working tree area is used to perform merges and to resolve
> conflicts, which made this "pretend missing files as unmodified"
> unnecessary feature.  In the end, we made a good move, as the
> current design allows users to verify their changes in the context
> of a full checkout (e.g. "make" would not have been a good way to
> validate the conflict resolution if it is done in a separate
> temporary directory that is sparsely populated with only the paths
> involved in the merge---you need all files for building, including
> the ones that are not modified, and "make" does not know to treat
> missing files as if they are unmodified).

This could be a good thing to do, but as I wrote in the description,
there are in fact other commands that don't need diff-merges options and
currently just eat them silently instead of bailing out.

It's likely that 90% of uses of setup_revisions() don't need
diff-merges, so a feature to exclude diff-merges parsing seems to be
useful by itself.

Thanks,

-- Sergey Organov
