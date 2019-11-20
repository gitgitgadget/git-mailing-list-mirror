Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28F5C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 23:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FEC20715
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 23:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqi+3kPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKTXcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 18:32:18 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:44848 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKTXcS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 18:32:18 -0500
Received: by mail-pf1-f175.google.com with SMTP id q26so571716pfn.11
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 15:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ro92D2yXscipbTDNAnlQVp+k/k2Ca9bTEfKQ3hWPGlU=;
        b=Qqi+3kPxseTPU/VRp/Vzg9kjnzGwvJ241VjpwCpZznryqDDPy0Bkpox7T+ssk62iVA
         B6iQFZf5HgdASBt0FwTjJuu+kHSUakOVel+bhx8S8sRCkJQqsBV47iXLdktsyUUxfFqb
         j4boMrk2PxeAZ4xYtnUtgOp3JGTVrsVLRTmXFvCZ9Uaxbo3kkRHCxKa393YPaE4Guzg6
         TUsZ8+nc5ETb/iiVE9DVL7ke/mqAIOElM8JRd8myAbD/0Al6/mDGt7Wn4wExssau/1/j
         F8FCF+4YAR0CgD7eKbyL5nPXy0E1XZ6C/zPImbIIp69hc3L10Cb/cpS3IOdZqNcUQaad
         knMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ro92D2yXscipbTDNAnlQVp+k/k2Ca9bTEfKQ3hWPGlU=;
        b=PK6Z4tKspRg07TvKVfpHHujzaE+6DVb6/pwKGKlXk6qhz5Swpczt2AafhQkNK0RNH4
         YCe8tCxo0Jbk7U3bLQqAY7riYYF80ivlJqzVEdh0NgBeDcELQQBOYK5H3gW6K8nqyu5c
         6qu8oERIqYOwO4YeES02hYTV2AnxBsCoP/74oGTb7GfN14aHu6yBAb/w2FMu0tAy8quU
         tzvqT7SJkCFUw6MdFuN9ZKAcjUUyeSsO3QLSUiA+JSnLtwY0t/DH7Wtre0+6Bvy/8ABt
         QRp/rK9XGwlfsZ8sMCsvkuvPKG9pRiu7zq9kPMA55+wH53BtwBjopJvtGvg1rHqH9gD2
         3zQw==
X-Gm-Message-State: APjAAAWYDB98oGVtneXDSGiL1QTT32M1oNXerC9Yluuix3M3T6PasaDb
        JplNqCASyFjele4fBnndEJqmobwF
X-Google-Smtp-Source: APXvYqxUK2nr8ajLDE/ezDpW6kd9Vt2pF+P4JBEM3wmWWolY0kVgNyEBlYZ+ze35Q0HS6AdT88nHxA==
X-Received: by 2002:a63:5848:: with SMTP id i8mr5988347pgm.217.1574292737374;
        Wed, 20 Nov 2019 15:32:17 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id m14sm314646pgn.41.2019.11.20.15.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 15:32:16 -0800 (PST)
Date:   Wed, 20 Nov 2019 15:32:14 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2019, #03; Tue, 19)
Message-ID: <20191120233214.GA17235@generichostname>
References: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Nov 19, 2019 at 04:05:48PM +0900, Junio C Hamano wrote:

[...]

> * dl/pretty-reference (2019-11-19) 11 commits
>  - squash! pretty: implement 'reference' format
>  - SubmittingPatches: use `--pretty=reference`
>  - pretty: implement 'reference' format
>  - pretty: provide short date format
>  - t4205: cover `git log --reflog -z` blindspot
>  - pretty.c: inline initalize format_context
>  - revision: make get_revision_mark() return const pointer
>  - completion: complete `tformat:` pretty format
>  - SubmittingPatches: remove dq from commit reference
>  - pretty-formats.txt: use generic terms for hash
>  - SubmittingPatches: use generic terms for hash
> 
>  "git log" family learned "--pretty=ref" that gives the name of a

Since this will be used for release notes, could we use the full name of
the pretty format (i.e. "--pretty=reference")?

(Also, TIL that --pretty can match incomplete prefixes!)

>  commit in the format that is often used to refer to it in log
>  messages.
> 
>  Expecting finishing touches to the data handling.
>  Other than that, this is reasonably well done, I think.

[...]

> * dl/t5520-cleanup (2019-11-19) 14 commits
>  - t5520: replace `! git` with `test_must_fail git`
>  - t5520: remove redundant lines in test cases
>  - t5520: replace $(cat ...) comparison with test_cmp
>  - t5520: don't put git in upstream of pipe
>  - t5520: test single-line files by git with test_cmp
>  - t5520: use test_cmp_rev where possible
>  - t5520: replace test -{n,z} with test-lib functions
>  - t5520: use test_line_count where possible
>  - t5520: remove spaces after redirect operator
>  - t5520: replace test -f with test-lib functions
>  - t5520: let sed open its own input
>  - t5520: use sq for test case names
>  - t5520: improve test style
>  - t: teach test_cmp_rev to accept ! for not-equals
> 
>  Test cleanup.
> 
>  Will merge to 'next'.

Any chance that we can queue this patch[1] either as a separate series
or as a precursor to the above?

Thanks,

Denton

[1]: https://public-inbox.org/git/20191114005215.GA24527@generichostname
