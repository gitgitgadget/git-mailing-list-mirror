Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E105A201A7
	for <e@80x24.org>; Fri, 12 May 2017 18:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755663AbdELSSK (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 14:18:10 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36038 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdELSSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 14:18:09 -0400
Received: by mail-io0-f196.google.com with SMTP id f102so6423358ioi.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eBzYGU8exjU9u4GfcaH7XbChRSh31LXrNx28ZDtQCRw=;
        b=ZWpsdS3W1NWjfkhHQ6DDVm1Aak+S2Lr9c46r8ZEBoN6YnKc9Mycrhl621kTaULYnSa
         Hq0DNHdH1HyN3l7pPFU2Mv32JHwITI6Kai/V028ZGIdG8F7AHPeY27gDMDN8uPCgML3i
         WGR30NO/ut3Xt8GDD2YVWknhp7qSJHWAkS7Ldcf0fLvsKVq2LN/MFw5iovtvkJdU58It
         S9uMEQ/iDAHaNkWWoVE1QAYsBEBTQ2pF4fRNjkrLq59RRSnjc02oR5L40+lzKQfK3rlS
         iKw84yp/q7QbGBq2a8jnNhWRk6XLJ2U1mm/rruBHYjJn1MNhKPfJ8HHaU31QsKmiWQUQ
         tXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eBzYGU8exjU9u4GfcaH7XbChRSh31LXrNx28ZDtQCRw=;
        b=de9vOrOozCDp7L8PtXVHuXwRYAsey5enEcqEU0PCuRYI3NldQFTIS4HU7MHdsjMi/v
         zvmZKOK1TxGl7XI3Q1D9iAjfwvM2Gzlya6UJ7w4ko0g4USroZIJCMpoZdxqCwKRepJQW
         4GO5KHz80edDTJ5ksYdb2k5rBFueVwbcfOiaDNXOldfvNdefqjKSeaR0EEbWSMoxsHmv
         TKLcBA271zQa7LYXynQ6kN+FTmHiMDhwALKEbrHtQnD9PQx0utXblCm+dcfuNXSgJ4BK
         SuUBzlkJS0xMQCt+Hjmw92xXntELWIsU7vVaf58IC8iKpK7333Zqpr3MRE1ks4fVURV/
         VdLw==
X-Gm-Message-State: AODbwcD9uE+GubkseJv4YWZDEGQytviL6e929iAy2Zl8wfkwfjP/gbA1
        2rWb4HfWcRlUHVLoE3hm86zN3ERyyg==
X-Received: by 10.107.201.131 with SMTP id z125mr5002084iof.160.1494613089105;
 Fri, 12 May 2017 11:18:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 12 May 2017 11:17:48 -0700 (PDT)
In-Reply-To: <20170512173527.GD98586@google.com>
References: <20170511170142.15934-1-avarab@gmail.com> <20170511170142.15934-2-avarab@gmail.com>
 <20170512173527.GD98586@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 12 May 2017 20:17:48 +0200
Message-ID: <CACBZZX7x=9Pvuhy7Q9=ecnhvVmjt664enZOjk4B8LXErVL4oEg@mail.gmail.com>
Subject: Re: [PATCH 1/7] grep: don't redundantly compile throwaway patterns
 under threading
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 7:35 PM, Brandon Williams <bmwill@google.com> wrote=
:
> On 05/11, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>> Change the pattern compilation logic under threading so that grep
>> doesn't compile a pattern it never ends up using on the non-threaded
>> code path, only to compile it again N times for N threads which will
>> each use their own copy, ignoring the initially compiled pattern.
>
> Is there a reason each thread needs to compile the patterns as opposed
> to them being compiled a single time and being copies N time for N
> threads?

Not really, just simplicity.

I'll amend the commit message to mention that I did this not as an
optimization, but just so the code is easier to reason about and
debug, when debugging this I found that there were two different
stacktraces to get to where I was compiling the pattern, and e.g.
"give each compilation/execution an id" for ad-hoc debugging would
always end up with one unused pattern, confusingly.

The reason it's like this is because it's a side-effect of duplicating
the whole grep_opt structure, which is not thread safe, writable, and
munged during execution, that's where the pattern is stored.

We could re-use the compiled regexp itself for POSIX, for PCRE you can
pre-JIT, post-JIT you can only partially do it, i.e. the pattern is
const, thread safe and can be shared, but you need to also marshal
around mutable per-thread for the JIT stack etc.

I looked into e.g. splitting the API into some "do & alloc threadsafe
stuff", "spawn thread", "do and alloc non-threadsafe stuff", but the
execution time of grep_opt_dup() & pattern compilation is trivial
compared to actually executing the grep, so there was no point. Even
with the more expensive JIT some of the most expensive PCRE patterns
take something like 0.0X milliseconds to compile at most[1].

1. http://sljit.sourceforge.net/pcre.html
